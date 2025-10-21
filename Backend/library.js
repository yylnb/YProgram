const express = require('express');

/**
 * 学习资源（library）路由模块
 * @param {import('mysql2/promise').Pool} pool - MySQL 连接池
 * @param {Function} authMiddleware - 用户认证中间件
 */

function safeParseJSON(str) {
  try {
    return JSON.parse(str);
  } catch {
    return null;
  }
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

      // 列表
      const pageSql = `
        SELECT id, lang, lb_id, difficulty, page, title, tags, summary
        FROM library
        ${whereSQL}
        ORDER BY id DESC
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

  // ---------- LIBRARY detail ----------
  router.get('/:id', async (req, res) => {
    const id = Number(req.params.id);
    if (!id) return res.status(400).json({ error: 'invalid id' });

    try {
      const [rows] = await pool.query(
        `SELECT id, lang, lb_id, title, tags, summary, content, eg_in, eg_out, difficulty, page
         FROM library
         WHERE id = ? LIMIT 1`,
        [id]
      );
      if (!rows || !rows.length) return res.status(404).json({ error: 'not found' });

      const r = rows[0];
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
        page: r.page
      });
    } catch (err) {
      console.error('GET /library/:id error:', err);
      res.status(500).json({ error: 'Server error' });
    }
  });

  return router;
};