// user.js
/**
 * User / Auth / Energy 模块
 * module.exports = (pool, authMiddleware, opts) => router
 *
 * opts 可选字段：
 *  - JWT_SECRET, JWT_EXPIRES_IN
 *  - REFRESH_JWT_SECRET, REFRESH_EXPIRES_IN
 *  - signToken(payload) (可选)
 *  - signRefreshTokenStateless(payload) (可选)
 *  - setRefreshTokenCookie(res, token) (可选)
 *  - toISO(date) (可选)
 */
const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

module.exports = (pool, authMiddleware, opts = {}) => {
  const router = express.Router();

  // ----- 配置与默认实现 -----
  const JWT_SECRET = opts.JWT_SECRET || process.env.JWT_SECRET || 'dev_jwt_secret';
  const JWT_EXPIRES_IN = opts.JWT_EXPIRES_IN || process.env.JWT_EXPIRES_IN || '7d';
  const REFRESH_JWT_SECRET = opts.REFRESH_JWT_SECRET || process.env.REFRESH_JWT_SECRET || JWT_SECRET;
  const REFRESH_EXPIRES_IN = opts.REFRESH_EXPIRES_IN || process.env.REFRESH_EXPIRES_IN || '30d';

  // energy config
  const MAX_ENERGY = process.env.ENERGY_MAX
    ? parseInt(process.env.ENERGY_MAX, 10)
    : (process.env.MAX_ENERGY ? parseInt(process.env.MAX_ENERGY, 10) : 30);
  const RECOVER_INTERVAL_MINUTES = process.env.RECOVER_INTERVAL_MINUTES ? parseInt(process.env.RECOVER_INTERVAL_MINUTES, 10) : 10;
  const RECOVER_INTERVAL_MS = RECOVER_INTERVAL_MINUTES * 60 * 1000;

  // default toISO
  const toISO = typeof opts.toISO === 'function' ? opts.toISO : (d => (d ? new Date(d).toISOString() : null));

  // default signToken / refresh token
  const signToken = typeof opts.signToken === 'function'
    ? opts.signToken
    : (payload => jwt.sign(payload, JWT_SECRET, { expiresIn: JWT_EXPIRES_IN }));

  const signRefreshTokenStateless = typeof opts.signRefreshTokenStateless === 'function'
    ? opts.signRefreshTokenStateless
    : (payload => jwt.sign(payload, REFRESH_JWT_SECRET, { expiresIn: REFRESH_EXPIRES_IN }));

  const setRefreshTokenCookie = typeof opts.setRefreshTokenCookie === 'function'
    ? opts.setRefreshTokenCookie
    : ((res, token) => {
      // 默认 cookie：httpOnly, sameSite lax, maxAge ~ 30d
      const maxAgeMs = (() => {
        // parse REFRESH_EXPIRES_IN if it's like '30d'
        if (REFRESH_EXPIRES_IN && typeof REFRESH_EXPIRES_IN === 'string' && REFRESH_EXPIRES_IN.endsWith('d')) {
          const days = parseInt(REFRESH_EXPIRES_IN.slice(0, -1), 10);
          if (!isNaN(days)) return days * 24 * 60 * 60 * 1000;
        }
        // fallback 30 days
        return 30 * 24 * 60 * 60 * 1000;
      })();
      try {
        res.cookie('refreshToken', token, { httpOnly: true, sameSite: 'lax', maxAge: maxAgeMs });
      } catch (e) {
        // If res.cookie not available (should be), set header as fallback
      }
      res.setHeader('x-refresh-token', token);
    });

  // helper: format SQL DATETIME (YYYY-MM-DD hh:mm:ss) (UTC)
  function toSQLDateTime(d) {
    const pad = (n) => String(n).padStart(2, '0');
    const dt = (d instanceof Date) ? d : new Date(d);
    return `${dt.getUTCFullYear()}-${pad(dt.getUTCMonth() + 1)}-${pad(dt.getUTCDate())} ${pad(dt.getUTCHours())}:${pad(dt.getUTCMinutes())}:${pad(dt.getUTCSeconds())}`;
  }

  const util = require('util'); // 文件顶部确保有这行
  // ... 其它 require（bcrypt, pool, signToken, setRefreshTokenCookie 等）...

  // helper: safe parse for lang field
  function parseLangField(raw) {
    if (raw == null) return [];
    if (Array.isArray(raw)) return raw;
    if (typeof raw === 'object') {
      try { return Array.isArray(raw) ? raw : [String(raw)]; } catch (e) { return []; }
    }
    const s = String(raw).trim();
    if (!s) return [];
    try {
      const parsed = JSON.parse(s);
      if (Array.isArray(parsed)) return parsed;
      if (typeof parsed === 'string') return [parsed];
      return [String(parsed)];
    } catch (e) {
      return [s];
    }
  }

  // -------------------------
  // POST /register
  // -------------------------
  router.post('/register', async (req, res) => {
    const { username, password } = req.body || {};
    if (!username || !password) return res.status(400).json({ error: 'username and password required' });

    try {
      // 检查用户名是否存在
      const [rows] = await pool.query('SELECT id FROM users WHERE username = ? LIMIT 1', [username]);
      if (rows && rows.length) return res.status(409).json({ error: 'username exists' });

      const hashed = await bcrypt.hash(password, 10);

      const insertSQL = `
        INSERT INTO users (
          username, password,
          user_color, user_emoji,
          checkin_days, max_streak_days,
          lang, energy, last_energy_update, created_at
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())
      `;

      const defaultColor = '#2563eb';
      const defaultEmoji = '🙂';
      const defaultCheckin = 0;
      const defaultStreak = 0;
      const defaultLang = JSON.stringify(['python']); // 存入 JSON 字符串

      const [r] = await pool.query(insertSQL, [
        username,
        hashed,
        defaultColor,
        defaultEmoji,
        defaultCheckin,
        defaultStreak,
        defaultLang,
        30
      ]);

      const userId = r.insertId;

      const token = signToken({ id: userId, username });
      const refreshToken = signRefreshTokenStateless({ id: userId, username });
      setRefreshTokenCookie(res, refreshToken);

      // 返回给前端：lang 始终以数组形式
      res.json({
        success: true,
        token,
        refreshToken,
        user: {
          id: userId,
          username,
          user_color: defaultColor,
          user_emoji: defaultEmoji,
          checkin_days: defaultCheckin,
          max_streak_days: defaultStreak,
          lang: ['python'],
          energy: 30,
          membership: null
        }
      });
    } catch (err) {
      console.error('register error:', err && err.stack ? err.stack : err);
      res.status(500).json({ error: err?.message || 'register failed' });
    }
  });

  // -------------------------
  // POST /login
  // -------------------------
  router.post('/login', async (req, res) => {
    const { username, password } = req.body || {};
    if (!username || !password) return res.status(400).json({ error: 'username and password required' });

    try {
      const [rows] = await pool.query(
        `SELECT 
          id, username, password AS password_hash,
          user_color, user_emoji,
          checkin_days, max_streak_days,
          lang,
          energy, last_energy_update, created_at
        FROM users WHERE username = ? LIMIT 1`,
        [username]
      );

      if (!rows || !rows.length) return res.status(401).json({ error: 'invalid credentials' });

      const user = rows[0];

      const ok = await bcrypt.compare(password, user.password_hash || user.password);
      if (!ok) return res.status(401).json({ error: 'invalid credentials' });

      // membership lookup (best-effort)
      let membership = null;
      try {
        const [mRows] = await pool.query(
          `SELECT start_at, end_at, source
          FROM memberships
          WHERE user_id = ?
          ORDER BY end_at DESC LIMIT 1`,
          [user.id]
        );
        if (mRows?.[0]) {
          membership = {
            start_at: toISO(mRows[0].start_at),
            end_at: toISO(mRows[0].end_at),
            source: mRows[0].source || null
          };
        }
      } catch (e) {
        membership = null;
      }

      const token = signToken({ id: user.id, username: user.username });
      const refreshToken = signRefreshTokenStateless({ id: user.id, username: user.username });
      setRefreshTokenCookie(res, refreshToken);

      // 稳健解析 lang 字段，确保返回给前端始终为数组
      const langArray = parseLangField(user.lang);

      res.json({
        success: true,
        token,
        refreshToken,
        user: {
          id: user.id,
          username: user.username,
          user_color: user.user_color,
          user_emoji: user.user_emoji,
          checkin_days: user.checkin_days,
          max_streak_days: user.max_streak_days,
          lang: langArray,
          energy: user.energy,
          membership
        }
      });
    } catch (err) {
      console.error('login error:', err && err.stack ? err.stack : err);
      res.status(500).json({ error: err?.message || 'login failed' });
    }
  });


  // -------------------------
  // POST /logout
  // -------------------------
  router.post('/logout', async (req, res) => {
    try {
      // clear cookie and header
      try { res.clearCookie && res.clearCookie('refreshToken'); } catch (e) {}
      res.setHeader('x-refresh-token', '');
      res.json({ success: true });
    } catch (err) {
      console.error('/logout error:', err);
      res.status(500).json({ error: 'logout failed' });
    }
  });

  // -------------------------
  // POST /invite  (auth required)
  // -------------------------
  router.post('/invite', authMiddleware, async (req, res) => {
    const referrer = (req.body && req.body.referrer || '').trim();
    if (!referrer) return res.status(400).json({ error: 'referrer required' });

    try {
      const [rows] = await pool.query('SELECT id FROM users WHERE username = ? LIMIT 1', [referrer]);
      if (!rows.length) return res.status(404).json({ error: 'referrer not found' });

      const referrerId = rows[0].id;
      const [mRows] = await pool.query('SELECT end_at FROM memberships WHERE user_id = ? ORDER BY end_at DESC LIMIT 1', [referrerId]);
      const existingEnd = (mRows && mRows[0] && mRows[0].end_at) ? new Date(mRows[0].end_at) : null;

      let startAt = new Date();
      if (existingEnd && existingEnd > startAt) startAt = existingEnd;
      const endAt = new Date(startAt);
      endAt.setMonth(endAt.getMonth() + 1);

      await pool.query('INSERT INTO memberships (user_id, start_at, end_at, source) VALUES (?, ?, ?, ?)', [
        referrerId, toSQLDateTime(startAt), toSQLDateTime(endAt), 'invite_bonus'
      ]);

      return res.json({ success: true, grantedTo: referrer, start_at: toISO(startAt), end_at: toISO(endAt) });
    } catch (err) {
      console.error('POST /invite error:', err);
      return res.status(500).json({ error: 'server error' });
    }
  });

  // -------------------------
  // GET /me
  // -------------------------
  router.get('/me', authMiddleware, async (req, res) => {
    const userId = req.user && req.user.id;
    if (!userId) return res.status(401).json({ error: 'unauthorized' });

    try {
      const [rows] = await pool.query('SELECT id, username, created_at FROM users WHERE id = ? LIMIT 1', [userId]);
      if (!rows.length) return res.status(404).json({ error: 'user not found' });

      let membership = null;
      try {
        const [mRows] = await pool.query('SELECT start_at, end_at, source FROM memberships WHERE user_id = ? ORDER BY end_at DESC LIMIT 1', [userId]);
        if (mRows && mRows[0]) membership = { start_at: toISO(mRows[0].start_at), end_at: toISO(mRows[0].end_at), source: mRows[0].source || null };
      } catch (e) {
        membership = null;
      }

      res.json({ id: rows[0].id, username: rows[0].username, created_at: toISO(rows[0].created_at), membership });
    } catch (err) {
      console.error('/me error:', err);
      res.status(500).json({ error: 'server error' });
    }
  });

  // -------------------------
  // GET /membership
  // -------------------------
  router.get('/membership', authMiddleware, async (req, res) => {
    try {
      const [rows] = await pool.query(
        `SELECT start_at, end_at, source FROM memberships WHERE user_id=? ORDER BY end_at DESC LIMIT 1`,
        [req.user.id]
      );
      if (rows.length === 0) return res.json({});
      res.json({ start_at: toISO(rows[0].start_at), end_at: toISO(rows[0].end_at), source: rows[0].source });
    } catch (e) {
      console.error('/membership error:', e);
      res.status(500).json({ error: '获取会员信息失败' });
    }
  });

  // GET /api/user/memberships?ids=1,2,3
  router.get('/memberships', authMiddleware, async (req, res) => {
    try {
      const idsRaw = (req.query.ids || '').toString().trim();
      if (!idsRaw) {
        return res.status(400).json({ error: '请提供 ids 查询参数，例如 ?ids=1,2,3' });
      }

      // 解析并只保留数字 id，防止注入
      const ids = idsRaw.split(',')
        .map(s => s.trim())
        .filter(s => s !== '' && /^[0-9]+$/.test(s))
        .map(s => Number(s));

      if (ids.length === 0) {
        return res.status(400).json({ error: '提供的 ids 无效' });
      }

      // 限制一次请求最多处理的 id 数量，防止滥用（可根据业务调整）
      const MAX_IDS = 200;
      if (ids.length > MAX_IDS) {
        return res.status(400).json({ error: `一次最多查询 ${MAX_IDS} 个 id` });
      }

      // 构建占位符列表用于 IN (...)
      const placeholders = ids.map(() => '?').join(',');

      // 我们想取每个 user_id 最新的 end_at 对应的那一条记录
      // 先用子查询取每个 user_id 的 max(end_at)，再 join 回 memberships 取得完整记录
      const sql = `
        SELECT m.user_id, m.start_at, m.end_at, m.source
        FROM memberships m
        JOIN (
          SELECT user_id, MAX(end_at) AS max_end
          FROM memberships
          WHERE user_id IN (${placeholders})
          GROUP BY user_id
        ) t ON m.user_id = t.user_id AND m.end_at = t.max_end
      `;

      // 执行查询
      const [rows] = await pool.query(sql, ids);

      // rows 可能包含多行（每个 user_id 一行），构造 map 返回
      const result = {};
      for (const r of rows) {
        // toISO 函数假设在项目中存在（与你现有的 /membership 路由一致）
        result[String(r.user_id)] = {
          start_at: r.start_at ? toISO(r.start_at) : null,
          end_at: r.end_at ? toISO(r.end_at) : null,
          source: r.source || null
        };
      }

      return res.json(result);
    } catch (e) {
      console.error('/memberships error:', e);
      return res.status(500).json({ error: '批量获取会员信息失败' });
    }
  });

  // -------------------------
  // ENERGY helpers & endpoints
  // -------------------------
  async function refreshUserEnergy(userId) {
    const [rows] = await pool.query('SELECT energy, last_energy_update FROM users WHERE id = ? LIMIT 1', [userId]);
    if (!rows || rows.length === 0) throw new Error('User not found');

    let energy = Number(rows[0].energy || 0);
    const lastStr = rows[0].last_energy_update;
    let lastDate = lastStr ? new Date(lastStr + 'Z') : new Date();
    if (isNaN(lastDate.getTime())) lastDate = new Date();

    const now = new Date();
    const nowMs = now.getTime();
    let lastMs = lastDate.getTime();

    const diffMs = nowMs - lastMs;
    const recovered = Math.floor(diffMs / RECOVER_INTERVAL_MS);

    if (recovered > 0 && energy < MAX_ENERGY) {
      const newEnergy = Math.min(MAX_ENERGY, energy + recovered);
      const appliedLastMs = lastMs + recovered * RECOVER_INTERVAL_MS;
      const appliedLastSQL = toSQLDateTime(new Date(appliedLastMs));

      if (newEnergy !== energy) {
        await pool.query('UPDATE users SET energy = ?, last_energy_update = ? WHERE id = ?', [newEnergy, appliedLastSQL, userId]);
        energy = newEnergy;
        lastMs = appliedLastMs;
      }
    }

    let secondsToNext = null;
    if (energy < MAX_ENERGY) {
      const elapsedSinceLast = nowMs - lastMs;
      const remainMs = Math.max(0, RECOVER_INTERVAL_MS - elapsedSinceLast);
      secondsToNext = Math.ceil(remainMs / 1000);
    } else {
      secondsToNext = 0;
    }

    return {
      energy,
      maxEnergy: MAX_ENERGY,
      last_energy_update: new Date(lastMs).toISOString(),
      secondsToNext
    };
  }

  // GET /energy
  router.get('/energy', authMiddleware, async (req, res) => {
    try {
      const userId = req.user.id;
      const payload = await refreshUserEnergy(userId);
      return res.json(payload);
    } catch (err) {
      console.error('GET /energy error', err);
      return res.status(500).json({ error: '无法获取能量' });
    }
  });

  // POST /use-energy
  router.post('/use-energy', authMiddleware, async (req, res) => {
    const amount = parseInt(req.body && req.body.amount, 10) || 1;
    if (amount <= 0) return res.status(400).json({ error: 'amount 必须为正数' });

    const CHECKIN_THRESHOLD = 20; // daily checkin threshold

    let conn;
    try {
      conn = await pool.getConnection();
      await conn.beginTransaction();

      // lock user row
      const [userRows] = await conn.query('SELECT energy, last_energy_update FROM users WHERE id = ? FOR UPDATE', [req.user.id]);
      if (!userRows || userRows.length === 0) {
        await conn.rollback();
        return res.status(404).json({ error: '用户未找到' });
      }

      // check vip
      const [mbRows] = await conn.query('SELECT 1 FROM memberships WHERE user_id = ? AND end_at > NOW() LIMIT 1', [req.user.id]);
      const isVip = (mbRows && mbRows.length > 0);

      let energyAfter = Number(userRows[0].energy || 0);
      const MAX_ENERGY_CONST = MAX_ENERGY;

      if (!isVip) {
        let lastStr = userRows[0].last_energy_update;
        let lastDate = lastStr ? new Date(lastStr + 'Z') : new Date();
        if (isNaN(lastDate.getTime())) lastDate = new Date();

        const now = new Date();
        const nowMs = now.getTime();
        let lastMs = lastDate.getTime();

        const diffMs = nowMs - lastMs;
        const recovered = Math.floor(diffMs / RECOVER_INTERVAL_MS);
        if (recovered > 0 && energyAfter < MAX_ENERGY_CONST) {
          energyAfter = Math.min(MAX_ENERGY_CONST, energyAfter + recovered);
          lastMs = lastMs + recovered * RECOVER_INTERVAL_MS;
        }

        if (energyAfter < amount) {
          await conn.rollback();
          return res.status(400).json({ error: '能量不足', energy: energyAfter, maxEnergy: MAX_ENERGY_CONST });
        }

        const energyBeforeDeduction = energyAfter;
        energyAfter = energyAfter - amount;

        let lastToWriteMs;
        if (energyBeforeDeduction >= MAX_ENERGY_CONST) {
          lastToWriteMs = nowMs;
        } else {
          lastToWriteMs = lastMs;
        }
        const lastSQL = (new Date(lastToWriteMs)).toISOString().slice(0, 19).replace('T', ' ');
        await conn.query('UPDATE users SET energy = ?, last_energy_update = ? WHERE id = ?', [energyAfter, lastSQL, req.user.id]);
      } else {
        // VIP: do not deduct stored energy; keep stored value
        energyAfter = Number(userRows[0].energy || 0);
      }

      // update energy_daily
      await conn.query(
        `INSERT INTO energy_daily (user_id, cost_today, last_update)
         VALUES (?, ?, CURDATE())
         ON DUPLICATE KEY UPDATE
           cost_today = cost_today + VALUES(cost_today),
           last_update = CURDATE()`,
        [req.user.id, amount]
      );

      const [edRowsAfter] = await conn.query('SELECT cost_today FROM energy_daily WHERE user_id = ? LIMIT 1', [req.user.id]);
      const costToday = (edRowsAfter && edRowsAfter[0]) ? Number(edRowsAfter[0].cost_today || 0) : amount;

      if (costToday >= CHECKIN_THRESHOLD) {
        await conn.query(
          `INSERT IGNORE INTO checkin_records (user_id, date)
           VALUES (?, CURDATE())`,
          [req.user.id]
        );
      }

      await conn.commit();

      return res.json({
        energy: isVip ? energyAfter : energyAfter,
        maxEnergy: MAX_ENERGY_CONST,
        cost_today: costToday,
        threshold: CHECKIN_THRESHOLD,
        isVip: !!isVip
      });
    } catch (err) {
      if (conn) try { await conn.rollback(); } catch (e) {}
      console.error('POST /use-energy error', err);
      return res.status(500).json({ error: '扣减能量失败' });
    } finally {
      if (conn) conn && conn.release && conn.release();
    }
  });

  // export router
  return router;
};