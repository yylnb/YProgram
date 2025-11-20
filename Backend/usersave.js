  // -------------------------
  // POST /register
  // -------------------------
  router.post('/register', async (req, res) => {
    const { username, password } = req.body || {};
    if (!username || !password) return res.status(400).json({ error: 'username and password required' });

    try {
      const [rows] = await pool.query('SELECT id FROM users WHERE username = ? LIMIT 1', [username]);
      if (rows && rows.length) return res.status(409).json({ error: 'username exists' });

      const hashed = await bcrypt.hash(password, 10);
      const [r] = await pool.query('INSERT INTO users (username, password) VALUES (?, ?)', [username, hashed]);
      const userId = r.insertId;

      const token = signToken({ id: userId, username });
      const refreshToken = signRefreshTokenStateless({ id: userId, username });
      setRefreshTokenCookie(res, refreshToken);

      res.json({ success: true, token, refreshToken, user: { id: userId, username } });
    } catch (err) {
      console.error('register error:', err);
      res.status(500).json({ error: err && err.message ? err.message : 'register failed' });
    }
  });

  // -------------------------
  // POST /login
  // -------------------------
  router.post('/login', async (req, res) => {
    const { username, password } = req.body || {};
    if (!username || !password) return res.status(400).json({ error: 'username and password required' });

    try {
      const [rows] = await pool.query('SELECT id, username, password AS password_hash FROM users WHERE username = ? LIMIT 1', [username]);
      if (!rows || !rows.length) return res.status(401).json({ error: 'invalid credentials' });

      const user = rows[0];
      const ok = await bcrypt.compare(password, user.password_hash || user.password);
      if (!ok) return res.status(401).json({ error: 'invalid credentials' });

      // membership lookup (best-effort)
      let membership = null;
      try {
        const [mRows] = await pool.query('SELECT start_at, end_at, source FROM memberships WHERE user_id = ? ORDER BY end_at DESC LIMIT 1', [user.id]);
        if (mRows && mRows[0]) {
          membership = {
            start_at: toISO(mRows[0].start_at),
            end_at: toISO(mRows[0].end_at),
            source: mRows[0].source || null
          };
        }
      } catch (e) {
        console.error('membership lookup error:', e);
        membership = null;
      }

      const token = signToken({ id: user.id, username: user.username });
      const refreshToken = signRefreshTokenStateless({ id: user.id, username: user.username });
      setRefreshTokenCookie(res, refreshToken);

      res.json({ success: true, token, refreshToken, user: { id: user.id, username: user.username, membership } });
    } catch (err) {
      console.error('login error:', err);
      res.status(500).json({ error: err && err.message ? err.message : 'login failed' });
    }
  });