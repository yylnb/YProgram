const express = require('express')

/**
 * 导出一个函数，接收 pool（mysql2/promise pool）和 authMiddleware（你已有的 JWT 中间件）
 * 返回一个 express.Router()
 */
module.exports = function (pool, authMiddleware) {
  const router = express.Router()

  // 每日达标阈值（如需修改改这里）
  const CHECKIN_THRESHOLD = 20

  // 辅助：将 Date/SQL date 转成 YYYY-MM-DD 字符串（只用于把 DB 返回的值格式化）
  function toYMD(d) {
    if (!d) return null
    if (d instanceof Date) return d.toISOString().split('T')[0]
    if (typeof d === 'string') return d.split('T')[0].split(' ')[0]
    return String(d)
  }

  /**
   * GET /api/calendar/energy
   * 返回当前用户的 energy_daily 状态（cost_today, last_update, reached）
   *
   * 关键点：直接让数据库判断“是不是今天”（用 CURDATE()），避免时区不一致。
   */
  router.get('/energy', authMiddleware, async (req, res) => {
    const userId = req.user.id
    try {
      // 尝试直接读取“今天”的记录（如果你的表是单行 per user + last_update，
      // 也可以用 WHERE user_id = ? AND last_update = CURDATE()）
      const [rows] = await pool.query(
        "SELECT cost_today, DATE_FORMAT(last_update, '%Y-%m-%d') AS last_update_str FROM energy_daily WHERE user_id = ? AND DATE(last_update) = CURDATE() LIMIT 1",
        [userId]
      )
      if (rows && rows.length > 0) {
        const r = rows[0]
        return res.json({
          cost_today: Number(r.cost_today || 0),
          last_update: r.last_update_str,   // 'YYYY-MM-DD' 字符串
          reached: Number(r.cost_today || 0) >= CHECKIN_THRESHOLD,
          threshold: CHECKIN_THRESHOLD
        })
      }
      return res.json({ cost_today: 0, last_update: null, reached: false, threshold: CHECKIN_THRESHOLD })
    } catch (err) {
      console.error('GET /api/calendar/energy error', err)
      return res.status(500).json({ error: 'internal error' })
    }
  })

  /**
   * POST /api/calendar/use-energy
   * body: { amount: number }
   *
   * 改动点：
   *  - 使用 INSERT ... ON DUPLICATE KEY UPDATE cost_today = cost_today + VALUES(cost_today), last_update = CURDATE()
   *  - 在事务内读取更新后的 cost_today（用 SELECT ... FOR UPDATE / 或 SELECT 紧跟 INSERT）
   *  - 插入 checkin_records 使用 INSERT IGNORE (并确保 checkin_records 有 UNIQUE(user_id,date))
   *
   * 注意：此实现依赖表结构的唯一键：
   *   - 如果你的 energy_daily 是“每用户一行”模式（user_id 唯一），sql 仍然有效（每次 ON DUPLICATE 会累加 cost_today）
   *   - 如果你采用“每天一行”的设计，请保证 UNIQUE(user_id, last_update) 或使用独立的 date 列并对 (user_id,date) 建 UNIQUE
   */
  router.post('/use-energy', authMiddleware, async (req, res) => {
    const userId = req.user.id
    const amount = Number(req.body && req.body.amount) || 0
    if (amount <= 0) return res.status(400).json({ error: 'amount must be positive' })

    let conn
    try {
      conn = await pool.getConnection()
      await conn.beginTransaction()

      // 原子插入/累加：把“今天”的 cost_today += amount（数据库使用 CURDATE()）
      // 这里假设 energy_daily 有 UNIQUE(user_id)（单行模式）或 UNIQUE(user_id, last_update)（按日期模式）
      // 如果你的表列名不是 last_update 而是 date，请改成 VALUES(date) / SELECT date accordingly.
      await conn.query(
        `INSERT INTO energy_daily (user_id, cost_today, last_update)
         VALUES (?, ?, CURDATE())
         ON DUPLICATE KEY UPDATE
           cost_today = cost_today + VALUES(cost_today),
           last_update = CURDATE()`,
        [userId, amount]
      )

      // 读取更新后的 cost_today（在同一事务内保证一致）
      const [rowsAfter] = await conn.query(
        'SELECT cost_today FROM energy_daily WHERE user_id = ? AND DATE(last_update) = CURDATE() LIMIT 1',
        [userId]
      )

      const costToday = (rowsAfter && rowsAfter.length > 0) ? Number(rowsAfter[0].cost_today || 0) : amount

      // 达标则插入 checkin_records（使用 CURDATE()，并用 INSERT IGNORE 防止重复）
      let createdCheckin = false
      if (costToday >= CHECKIN_THRESHOLD) {
        // 这里假设 checkin_records 有 UNIQUE(user_id,date)
        await conn.query(
          `INSERT IGNORE INTO checkin_records (user_id, date)
           VALUES (?, CURDATE())`,
          [userId]
        )
        // 如果想判断是否真的插入了，可以检查 affectedRows，不过 INSERT IGNORE 在已存在时 affectedRows=0
        const [chk] = await conn.query('SELECT 1 FROM checkin_records WHERE user_id = ? AND date = CURDATE() LIMIT 1', [userId])
        createdCheckin = !!(chk && chk.length > 0)
      }

      await conn.commit()
      return res.json({ cost_today: costToday, reached: costToday >= CHECKIN_THRESHOLD, created_checkin: createdCheckin })
    } catch (err) {
      if (conn) try { await conn.rollback() } catch (e) {}
      console.error('POST /api/calendar/use-energy error', err)
      return res.status(500).json({ error: 'internal error' })
    } finally {
      if (conn) conn.release && conn.release()
    }
  })

  /**
   * POST /api/calendar/checkin/manual
   * body: {
   *   date?: 'YYYY-MM-DD',   // 可选
   *   color?: '#ffffff'      // 可选，文本
   * }
   */
  router.post('/checkin/manual', authMiddleware, async (req, res) => {
    const userId = req.user.id
    const dateFromBody = req.body && req.body.date ? String(req.body.date) : null
    const colorFromBody = req.body && req.body.color ? String(req.body.color) : null

    let conn
    try {
      conn = await pool.getConnection()
      await conn.beginTransaction()

      if (dateFromBody) {
        // ---------- 使用客户端传入日期 ----------
        const [exist] = await conn.query(
          'SELECT id FROM checkin_records WHERE user_id = ? AND date = ? LIMIT 1',
          [userId, dateFromBody]
        )

        if (exist && exist.length > 0) {
          await conn.commit()
          return res.json({ ok: true, message: '已打卡', created: false })
        }

        await conn.query(
          'INSERT INTO checkin_records (user_id, date, color) VALUES (?, ?, ?)',
          [userId, dateFromBody, colorFromBody]
        )

        await conn.commit()
        return res.json({ ok: true, message: '打卡成功', created: true })
      } else {
        // ---------- 使用数据库 CURDATE() ----------
        const [exist] = await conn.query(
          'SELECT id FROM checkin_records WHERE user_id = ? AND date = CURDATE() LIMIT 1',
          [userId]
        )

        if (exist && exist.length > 0) {
          await conn.commit()
          return res.json({ ok: true, message: '已打卡', created: false })
        }

        await conn.query(
          'INSERT INTO checkin_records (user_id, date, color) VALUES (?, CURDATE(), ?)',
          [userId, colorFromBody]
        )

        await conn.commit()
        return res.json({ ok: true, message: '打卡成功', created: true })
      }
    } catch (err) {
      if (conn) try { await conn.rollback() } catch (e) {}
      console.error('POST /api/calendar/checkin/manual error', err)
      return res.status(500).json({ ok: false, message: 'internal error' })
    } finally {
      if (conn) conn.release && conn.release()
    }
  })


  /**
   * GET /api/calendar/checkins/:year/:month
   * 返回该用户在指定年月的打卡日期数组 ['YYYY-MM-DD', ...]
   */
  // router.get('/checkins/:year/:month', authMiddleware, async (req, res) => {
  //   const userId = req.user.id
  //   const year = Number(req.params.year)
  //   const month = Number(req.params.month)
  //   if (!year || !month || month < 1 || month > 12) return res.status(400).json({ error: 'invalid year/month' })

  //   try {
  //     const [rows] = await pool.query(
  //       "SELECT DATE_FORMAT(`date`, '%Y-%m-%d') AS date_str FROM checkin_records WHERE user_id = ? AND YEAR(`date`) = ? AND MONTH(`date`) = ? ORDER BY `date`",
  //       [userId, year, month]
  //     )
  //     const dates = (rows || []).map(r => r.date_str)  // 直接是 'YYYY-MM-DD' 字符串
  //     return res.json(dates)
  //   } catch (err) {
  //     console.error('GET /api/calendar/checkins error', err)
  //     return res.status(500).json({ error: 'internal error' })
  //   }
  // })

  router.get('/checkins/:year/:month', authMiddleware, async (req, res) => {
  const userId = req.user.id
  const year = Number(req.params.year)
  const month = Number(req.params.month)

  if (!year || !month || month < 1 || month > 12) {
    return res.status(400).json({ error: 'invalid year/month' })
  }

  try {
    const [rows] = await pool.query(
      `
      SELECT
        DATE_FORMAT(\`date\`, '%Y-%m-%d') AS date,
        \`color\`
      FROM checkin_records
      WHERE user_id = ?
        AND YEAR(\`date\`) = ?
        AND MONTH(\`date\`) = ?
      ORDER BY \`date\`
      `,
      [userId, year, month]
    )

    const records = (rows || []).map(r => ({
      date: r.date,
      color: r.color
    }))

    return res.json(records)
  } catch (err) {
    console.error('GET /api/calendar/checkins error', err)
    return res.status(500).json({ error: 'internal error' })
  }
})

  /**
   * GET /api/calendar/checkins/today
   * return: { checked: boolean, color?: string }
   */
  router.get('/checkins/today', authMiddleware, async (req, res) => {
    const userId = req.user.id
    try {
      const [rows] = await pool.query(
        'SELECT color FROM checkin_records WHERE user_id = ? AND date = CURDATE() LIMIT 1',
        [userId]
      )

      if (rows && rows.length > 0) {
        return res.json({
          checked: true,
          color: rows[0].color || null
        })
      }

      return res.json({ checked: false })
    } catch (err) {
      console.error('GET /api/calendar/checkins/today error', err)
      return res.status(500).json({ error: 'internal error' })
    }
  })


  return router
}