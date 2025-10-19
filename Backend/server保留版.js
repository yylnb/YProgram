// ---------- ENERGY ----------
const MAX_ENERGY = process.env.ENERGY_MAX
  ? parseInt(process.env.ENERGY_MAX, 10)
  : (process.env.MAX_ENERGY ? parseInt(process.env.MAX_ENERGY, 10) : 30);
const RECOVER_INTERVAL_MINUTES = process.env.RECOVER_INTERVAL_MINUTES ? parseInt(process.env.RECOVER_INTERVAL_MINUTES, 10) : 10;
const RECOVER_INTERVAL_MS = RECOVER_INTERVAL_MINUTES * 60 * 1000;

function toSQLDateTime(d) {
  const pad = (n) => String(n).padStart(2, '0');
  return `${d.getUTCFullYear()}-${pad(d.getUTCMonth()+1)}-${pad(d.getUTCDate())} ${pad(d.getUTCHours())}:${pad(d.getUTCMinutes())}:${pad(d.getUTCSeconds())}`;
}

// refreshUserEnergy: 读取 DB，按间隔恢复能量，如果恢复了则更新 DB，返回最新信息
async function refreshUserEnergy(userId, pool) {
  const [rows] = await pool.query('SELECT energy, last_energy_update FROM users WHERE id = ?', [userId]);
  if (!rows || rows.length === 0) throw new Error('User not found');

  let energy = Number(rows[0].energy || 0);
  let lastStr = rows[0].last_energy_update;
  // 如果数据库中没有 last_energy_update，就把它视为现在（避免异常）
  let lastDate = lastStr ? new Date(lastStr) : new Date();
  if (isNaN(lastDate.getTime())) lastDate = new Date();

  const now = new Date();
  const nowMs = now.getTime();
  let lastMs = lastDate.getTime();

  // 计算已恢复点数
  const diffMs = nowMs - lastMs;
  const recovered = Math.floor(diffMs / RECOVER_INTERVAL_MS);

  if (recovered > 0 && energy < MAX_ENERGY) {
    energy = Math.min(MAX_ENERGY, energy + recovered);
    // 更新 last_energy_update 到已计算的“最新 tick 时间”
    lastMs = lastMs + recovered * RECOVER_INTERVAL_MS;
    const lastSQL = toSQLDateTime(new Date(lastMs));
    await pool.query('UPDATE users SET energy = ?, last_energy_update = ? WHERE id = ?', [energy, lastSQL, userId]);
  }

  // 计算到下一点剩余秒数（如果未满）
  let secondsToNext = null;
  if (energy < MAX_ENERGY) {
    const elapsedSinceLast = nowMs - lastMs; // 0 .. RECOVER_INTERVAL_MS-1
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

// GET: /api/user/energy
// 返回：{ energy, maxEnergy, last_energy_update, secondsToNext }
app.get('/api/user/energy', authMiddleware, async (req, res) => {
  try {
    const userId = req.user.id;
    const payload = await refreshUserEnergy(userId, pool);
    return res.json(payload);
  } catch (err) {
    console.error('GET /api/user/energy error', err);
    return res.status(500).json({ error: '无法获取能量' });
  }
});

// POST: /api/user/use-energy
// body: { amount?: number }  默认 amount = 1
// 原子性操作：事务 + SELECT ... FOR UPDATE
// POST: /api/user/use-energy
app.post('/api/user/use-energy', authMiddleware, async (req, res) => {
  const amount = parseInt(req.body && req.body.amount, 10) || 1;
  if (amount <= 0) return res.status(400).json({ error: 'amount 必须为正数' });

  let conn;
  try {
    conn = await pool.getConnection();
    await conn.beginTransaction();

    // 锁行
    const [rows] = await conn.query(
      'SELECT energy, last_energy_update FROM users WHERE id = ? FOR UPDATE',
      [req.user.id]
    );
    if (!rows || rows.length === 0) {
      await conn.rollback();
      return res.status(404).json({ error: '用户未找到' });
    }

    let energy = Number(rows[0].energy || 0);
    let lastStr = rows[0].last_energy_update;
    let lastDate = lastStr ? new Date(lastStr) : new Date();
    if (isNaN(lastDate.getTime())) lastDate = new Date();

    const now = new Date();
    const nowMs = now.getTime();
    let lastMs = lastDate.getTime();

    // 先按恢复规则补充能量
    const diffMs = nowMs - lastMs;
    const recovered = Math.floor(diffMs / RECOVER_INTERVAL_MS);
    if (recovered > 0 && energy < MAX_ENERGY) {
      energy = Math.min(MAX_ENERGY, energy + recovered);
      lastMs = lastMs + recovered * RECOVER_INTERVAL_MS;
    }

    // 检查是否有足够能量
    if (energy < amount) {
      await conn.rollback();
      return res.status(400).json({ error: '能量不足', energy, maxEnergy: MAX_ENERGY });
    }

    // 扣除能量
    energy = energy - amount;

    // 🔑 修改这里：只有满能量时才把 last_energy_update 设为 now
    let newLastMs = lastMs;
    if (energy === MAX_ENERGY - amount) {
      // 说明之前是满能量，现在被扣了
      newLastMs = nowMs;
    }

    const newLastSQL = toSQLDateTime(new Date(newLastMs));
    await conn.query(
      'UPDATE users SET energy = ?, last_energy_update = ? WHERE id = ?',
      [energy, newLastSQL, req.user.id]
    );

    await conn.commit();
    return res.json({ energy, maxEnergy: MAX_ENERGY });
  } catch (err) {
    if (conn) try { await conn.rollback(); } catch (e) {}
    console.error('POST /api/user/use-energy error', err);
    return res.status(500).json({ error: '扣减能量失败' });
  } finally {
    if (conn) conn.release();
  }
});