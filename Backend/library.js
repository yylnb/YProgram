const express = require('express');

function safeParseJSON(val) {
  if (val == null) return null;
  if (typeof val === 'object') return val;
  try { return JSON.parse(val) } catch (e) { return null }
}

module.exports = function (pool, authMiddleware) {
  const router = express.Router();
  const ALLOWED_DIFFICULTIES = new Set(['beginner', 'intermediate', 'advanced']);

  // ---------- LIBRARY (list with pagination, search, filter) ----------
  router.get('/', async (req, res) => {
    try {
      const lang = (req.query.lang || '').trim();
      const pageNum = Math.max(1, parseInt(req.query.page || '1', 10));
      const pageSize = Math.min(200, Math.max(1, parseInt(req.query.pageSize || '24', 10)));
      const q = (req.query.q || '').trim();
      const filter = (req.query.filter || '').trim().toLowerCase(); // beginner|intermediate|advanced|all
      const offset = (pageNum - 1) * pageSize;

      const where = [];
      const params = [];

      if (lang) {
        where.push('lang = ?');
        params.push(lang);
      }

      if (filter && filter !== 'all' && ALLOWED_DIFFICULTIES.has(filter)) {
        where.push('difficulty = ?');
        params.push(filter);
      }

      if (q) {
        // 在 title / summary / tags(JSON array) 中搜索
        where.push('(title LIKE ? OR summary LIKE ? OR JSON_SEARCH(tags, "one", ?) IS NOT NULL)');
        const like = `%${q}%`;
        params.push(like, like, q);
      }

      const whereSQL = where.length ? ('WHERE ' + where.join(' AND ')) : '';

      // 总数
      const [countRows] = await pool.query(`SELECT COUNT(1) AS total FROM library ${whereSQL}`, params);
      const total = (countRows && countRows[0] && countRows[0].total) ? Number(countRows[0].total) : 0;

      // 列表 — **改为升序，避免“漏掉最小 id” 的分页现象**
      const pageSql = `
        SELECT id, lang, lb_id, difficulty, page, title, tags, summary
        FROM library
        ${whereSQL}
        ORDER BY id ASC
        LIMIT ? OFFSET ?`;
      const pageParams = params.concat([pageSize, offset]);
      const [rows] = await pool.query(pageSql, pageParams);

      const items = rows.map(r => ({
        id: r.id,
        lang: r.lang,
        lb_id: r.lb_id,
        difficulty: r.difficulty,
        page: r.page,
        title: r.title,
        tags: safeParseJSON(r.tags) || [],
        summary: r.summary
      }));

      res.json({
        items,
        hasMore: offset + rows.length < total,
        total
      });
    } catch (err) {
      console.error('GET /library error:', err);
      res.status(500).json({ error: 'Server error' });
    }
  });

  // ---------- LIBRARY favorites ----------
  router.get('/favorites', authMiddleware, async (req, res) => {
    const userId = req.user && req.user.id;
    if (!userId) return res.status(401).json({ error: '未登录' });

    try {
      const [rows] = await pool.query(
        `SELECT l.id AS id, l.lang AS lang, l.lb_id AS lb_id, l.title AS title, l.summary AS summary, l.difficulty AS difficulty, f.created_at AS favorited_at
         FROM library_favorites f
         JOIN library l ON f.lang = l.lang AND f.lb_id = l.lb_id
         WHERE f.user_id = ?
         ORDER BY f.created_at DESC`,
        [userId]
      );

      const out = rows.map(r => ({
        id: r.id,
        lang: r.lang,
        lb_id: r.lb_id,
        title: r.title,
        summary: r.summary,
        difficulty: r.difficulty,
        favorited_at: r.favorited_at
      }));

      res.json(out);
    } catch (err) {
      console.error('GET /library/favorites error:', err);
      res.status(500).json({ error: '获取收藏失败' });
    }
  });

  // ---------- add/update favorite ----------
  router.post('/favorite', authMiddleware, async (req, res) => {
    const userId = req.user && req.user.id;
    if (!userId) return res.status(401).json({ error: '未登录' });

    try {
      let libRow = null;
      if (req.body && req.body.id) {
        const lid = Number(req.body.id);
        if (!lid) return res.status(400).json({ error: '非法的 id' });
        const [r] = await pool.query('SELECT id, lang, lb_id, title, page FROM library WHERE id = ? LIMIT 1', [lid]);
        if (!r || !r.length) return res.status(404).json({ error: 'topic not found' });
        libRow = r[0];
      } else if (req.body && req.body.lang && (req.body.lb_id !== undefined)) {
        const lang = String(req.body.lang);
        const lbid = Number(req.body.lb_id);
        if (!lang || !lbid) return res.status(400).json({ error: '非法的 lang 或 lb_id' });
        const [r] = await pool.query('SELECT id, lang, lb_id, title, page FROM library WHERE lang = ? AND lb_id = ? LIMIT 1', [lang, lbid]);
        if (!r || !r.length) return res.status(404).json({ error: 'topic not found' });
        libRow = r[0];
      } else {
        return res.status(400).json({ error: '需要提供 id 或 (lang + lb_id)' });
      }

      const { lang, lb_id, title, page: libPage } = libRow;

      const [exists] = await pool.query('SELECT id FROM library_favorites WHERE user_id = ? AND lang = ? AND lb_id = ? LIMIT 1', [userId, lang, lb_id]);
      if (exists && exists.length) {
        await pool.query('UPDATE library_favorites SET created_at = CURRENT_TIMESTAMP, title = ?, page = ? WHERE id = ?', [title, libPage, exists[0].id]);
      } else {
        await pool.query('INSERT INTO library_favorites (user_id, lang, lb_id, title, page) VALUES (?, ?, ?, ?, ?)', [userId, lang, lb_id, title, libPage]);
      }

      res.json({ success: true });
    } catch (err) {
      console.error('POST /library/favorite error:', err);
      res.status(500).json({ error: '添加收藏失败' });
    }
  });

  // ---------- delete favorite ----------
  router.delete('/favorite/:id', authMiddleware, async (req, res) => {
    const userId = req.user && req.user.id;
    if (!userId) return res.status(401).json({ error: '未登录' });

    const libraryId = Number(req.params.id);
    if (!libraryId) return res.status(400).json({ error: '非法 id' });

    try {
      const [r] = await pool.query('SELECT lang, lb_id FROM library WHERE id = ? LIMIT 1', [libraryId]);
      if (!r || !r.length) return res.status(404).json({ error: 'topic not found' });
      const { lang, lb_id } = r[0];

      await pool.query('DELETE FROM library_favorites WHERE user_id = ? AND lang = ? AND lb_id = ?', [userId, lang, lb_id]);
      res.json({ success: true });
    } catch (err) {
      console.error('DELETE /library/favorite/:id error:', err);
      res.status(500).json({ error: '删除收藏失败' });
    }
  });

    // GET /api/library/favorites/page?page=1&pageSize=5&lang=python
  router.get('/favorites/page', authMiddleware, async (req, res) => {
    const userId = req.user && req.user.id;
    if (!userId) return res.status(401).json({ error: '未登录' });

    const rawPage = Number(req.query.page || 1);
    const rawPageSize = Number(req.query.pageSize || 5);
    const rawLang = req.query.lang ? String(req.query.lang).trim() : null;

    const page = Number.isFinite(rawPage) && rawPage > 0 ? Math.floor(rawPage) : 1;
    const MAX_PAGE_SIZE = 100;
    const pageSize = Number.isFinite(rawPageSize) && rawPageSize > 0 ? Math.min(Math.floor(rawPageSize), MAX_PAGE_SIZE) : 10;
    const offset = (page - 1) * pageSize;

    try {
      // 1) 可选的总数统计（按 lang 过滤或不过滤）
      let countSql = `
        SELECT COUNT(*) AS cnt
        FROM library_favorites f
        JOIN library l ON f.lang = l.lang AND f.lb_id = l.lb_id
        WHERE f.user_id = ?
      `;
      const countParams = [userId];
      if (rawLang) {
        countSql += ` AND l.lang = ?`;
        countParams.push(rawLang);
      }
      const [[countRow]] = await pool.query(countSql, countParams);
      const total = Number(countRow?.cnt || 0);

      // 2) 获取当前页的数据（按 created_at 倒序）
      let dataSql = `
        SELECT l.id AS id,
              l.lang AS lang,
              l.lb_id AS lb_id,
              l.title AS title,
              l.summary AS summary,
              l.difficulty AS difficulty,
              f.created_at AS favorited_at
        FROM library_favorites f
        JOIN library l ON f.lang = l.lang AND f.lb_id = l.lb_id
        WHERE f.user_id = ?
      `;
      const dataParams = [userId];
      if (rawLang) {
        dataSql += ` AND l.lang = ?`;
        dataParams.push(rawLang);
      }
      dataSql += ` ORDER BY f.created_at DESC LIMIT ? OFFSET ?`;
      dataParams.push(pageSize, offset);

      const [rows] = await pool.query(dataSql, dataParams);

      const favorites = rows.map(r => ({
        id: r.id,
        lang: r.lang,
        lb_id: r.lb_id,
        title: r.title,
        summary: r.summary,
        difficulty: r.difficulty,
        favorited_at: r.favorited_at
      }));

      // 3) 同时查询该用户现有收藏中出现过的语言列表（用于前端只显示用户已有的语言选项）
      //    我把这个查询做成不受 `lang` 过滤影响（始终返回用户全部收藏的语言），
      //    这样前端可以用它来渲染“只显示用户已有的语言”下拉。
      const [langRows] = await pool.query(`
        SELECT DISTINCT l.lang AS lang
        FROM library_favorites f
        JOIN library l ON f.lang = l.lang AND f.lb_id = l.lb_id
        WHERE f.user_id = ?
        ORDER BY l.lang
      `, [userId]);
      const availableLangs = (langRows || []).map(r => String(r.lang));

      // 4) 计算分页元信息：当 total 为 0 时 totalPages 为 0
      const totalPages = total > 0 ? Math.max(1, Math.ceil(total / pageSize)) : 0;

      res.json({
        favorites,
        total,
        totalPages,
        currentPage: page,
        pageSize,
        availableLangs
      });
    } catch (err) {
      console.error('GET /library/favorites/page error:', err);
      res.status(500).json({ error: '获取收藏失败' });
    }
  });

  // ---------- LIBRARY detail by lang + lb_id ----------
  // GET /api/library/:lang/:id
  // 示例： GET /api/library/python/3
  router.get('/:lang/:id', async (req, res) => {
    try {
      const rawLang = (req.params.lang || '').trim()
      const rawId = (req.params.id || '').trim()

      if (!rawLang || !rawId) {
        return res.status(400).json({ error: 'invalid params: require lang and id' })
      }

      const lang = rawLang
      const lb_id = rawId

      const [rows] = await pool.query(
        `SELECT id, lang, lb_id, title, tags, summary, content,
                eg_in, eg_out, difficulty, page, created_at
        FROM library
        WHERE lang = ? AND lb_id = ?
        LIMIT 1`,
        [lang, lb_id]
      )

      if (!rows || !rows.length) {
        return res.status(404).json({ error: 'not found' })
      }

      const r = rows[0]
      res.json({
        id: r.id,
        lang: r.lang,
        lb_id: r.lb_id,
        title: r.title,
        tags: safeParseJSON(r.tags) || [],
        summary: r.summary,
        content: r.content,
        eg_in: safeParseJSON(r.eg_in) || [],
        eg_out: safeParseJSON(r.eg_out) || [],
        difficulty: r.difficulty,
        page: r.page,
        created_at: r.created_at,
        updated_at: r.created_at
      })
    } catch (err) {
      console.error('GET /api/library/:lang/:id error:', err)
      res.status(500).json({ error: 'Server error' })
    }
  })



  return router;
};