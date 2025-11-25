// favorites.js
const express = require('express');

module.exports = (pool, authMiddleware) => {
  const router = express.Router();

  // 语言到短码映射（必要时扩展）
  const LANG_CODE = {
    python: 'py',
    javascript: 'js',
    js: 'js',
    cpp: 'cpp',
    c: 'c',
    java: 'java',
    // add more mappings if needed
  };

  // 解析 course 字符串（严格要求 "python_1" 形式）
  // 返回 null 或 { base: 'python', idx: '1', code: 'py', suffix: '_py_1', questionsTable, favoritesTable }
  function getTablesForCourse(course) {
    if (!course || typeof course !== 'string') return null;
    const s = course.trim().toLowerCase();
    const m = s.match(/^([a-z]+)_(\d+)$/i);
    if (!m) return null;
    const base = m[1];
    const idx = m[2];
    const code = LANG_CODE[base];
    if (!code) return null;
    const suffix = `_${code}_${idx}`; // e.g. _py_1
    const questionsTable = `questions${suffix}`; // e.g. questions_py_1
    const favoritesTable = `que_fav${suffix}`;   // e.g. que_fav_py_1
    return { base, idx, code, suffix, questionsTable, favoritesTable };
  }

  // normalize q_id param (keep number if purely digits, else string)
  function normalizeQid(q) {
    const s = String(q).trim();
    return (/^\d+$/.test(s) ? Number(s) : s);
  }

  // ================
  // POST /api/favorites
  // body: { q_id, course, unit_id?, title? }
  // ================
  router.post('/', authMiddleware, async (req, res) => {
    const userId = req.user && req.user.id;
    if (!userId) return res.status(401).json({ error: '未登录' });

    let { q_id, course, unit_id, title } = req.body || {};
    if (!q_id) return res.status(400).json({ error: 'q_id required' });
    if (!course) return res.status(400).json({ error: 'course required (e.g. python_1)' });

    const t = getTablesForCourse(String(course));
    if (!t) return res.status(400).json({ error: 'unsupported course format or language' });

    const qidParam = normalizeQid(q_id);
    const unitIdParam = (unit_id != null && !isNaN(Number(unit_id))) ? Number(unit_id) : null;
    const titleParam = (typeof title === 'string' && title.trim()) ? title.trim() : null;

    let conn;
    try {
      conn = await pool.getConnection();
      await conn.beginTransaction();

      // verify q_id exists in questions table (no exec table usage)
      const questionsTable = t.questionsTable;
      let found = false;
      try {
        const [rowsQ] = await conn.query(`SELECT 1 FROM \`${questionsTable}\` WHERE q_id = ? LIMIT 1`, [qidParam]);
        if (Array.isArray(rowsQ) && rowsQ.length > 0) found = true;
      } catch (e) {
        // table may not exist or other error -> treat as not found
      }

      if (!found) {
        await conn.rollback().catch(()=>{});
        return res.status(400).json({ error: `q_id not found in questions for course=${course}` });
      }

      // Insert or update favorite (requires UNIQUE(user_id, q_id) on favorite table)
      const sql = `
        INSERT INTO \`${t.favoritesTable}\` (user_id, q_id, unit_id, title, created_at)
        VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)
        ON DUPLICATE KEY UPDATE
          unit_id = VALUES(unit_id),
          title = COALESCE(VALUES(title), title),
          created_at = CURRENT_TIMESTAMP
      `;
      await conn.query(sql, [userId, qidParam, unitIdParam, titleParam]);

      await conn.commit();
      return res.json({ success: true });
    } catch (err) {
      if (conn) await conn.rollback().catch(()=>{});
      console.error('POST /favorites error:', err && (err.message || err));
      return res.status(500).json({ error: err && err.message ? err.message : '收藏失败' });
    } finally {
      if (conn) conn.release();
    }
  });

  /**
   * GET /api/favorites
   * query: ?course=python_1&page=1&pageSize=5
   */
  router.get('/', authMiddleware, async (req, res) => {
    const userId = req.user && req.user.id;
    if (!userId) return res.status(401).json({ error: '未登录' });

    const course = (req.query.course || '').toString().trim().toLowerCase();
    const page = Math.max(1, parseInt(req.query.page, 10) || 1);
    const pageSize = Math.max(1, Math.min(100, parseInt(req.query.pageSize, 10) || 5));

    if (!course) return res.status(400).json({ error: 'Missing course parameter' });

    const t = getTablesForCourse(course);
    if (!t) return res.status(400).json({ error: 'unsupported course' });

    try {
      // total count
      const [countRows] = await pool.query(
        `SELECT COUNT(*) AS cnt FROM \`${t.favoritesTable}\` WHERE user_id = ?`,
        [userId]
      );
      const total = countRows && countRows[0] ? Number(countRows[0].cnt || 0) : 0;
      const totalPages = Math.max(1, Math.ceil(total / pageSize));

      const offset = (page - 1) * pageSize;

      const [rows] = await pool.query(
        `SELECT id, q_id, unit_id, title, created_at
         FROM \`${t.favoritesTable}\`
         WHERE user_id = ?
         ORDER BY created_at DESC
         LIMIT ? OFFSET ?`,
        [userId, pageSize, offset]
      );

      const favorites = (rows || []).map(r => ({
        id: r.id,
        q_id: r.q_id,
        unit_id: r.unit_id,
        title: r.title,
        created_at: r.created_at
      }));

      return res.json({ favorites, totalPages, currentPage: page, total });
    } catch (err) {
      console.error('GET /favorites error:', err && (err.message || err));
      return res.status(500).json({ error: '服务器错误' });
    }
  });

  // DELETE /api/favorites/:identifier
  // identifier may be q_id (string/number)
  // query param course=python_1 is required
  router.delete('/:identifier', authMiddleware, async (req, res) => {
    const userId = req.user && req.user.id;
    if (!userId) return res.status(401).json({ error: '未登录' });

    const identifier = req.params.identifier;
    if (!identifier) return res.status(400).json({ error: 'identifier required' });

    const courseParam = (typeof req.query.course === 'string' && req.query.course.trim()) ? req.query.course.trim().toLowerCase() : null;
    if (!courseParam) return res.status(400).json({ error: 'course query parameter required (e.g. course=python_1)' });

    const t = getTablesForCourse(courseParam);
    if (!t) return res.status(400).json({ error: 'unsupported course' });

    const idStr = String(identifier).trim();
    const idNum = (/^\d+$/.test(idStr) ? Number(idStr) : null);
    const idParam = (idNum !== null) ? idNum : idStr;

    let conn;
    try {
      conn = await pool.getConnection();
      await conn.beginTransaction();

      await conn.query(`DELETE FROM \`${t.favoritesTable}\` WHERE user_id = ? AND q_id = ?`, [userId, idParam]);

      await conn.commit();
      return res.json({ success: true });
    } catch (err) {
      if (conn) await conn.rollback().catch(()=>{});
      console.error('DELETE /favorites/:identifier error:', err && (err.message || err));
      return res.status(500).json({ error: err && err.message ? err.message : '删除收藏失败' });
    } finally {
      if (conn) conn.release();
    }
  });

  return router;
};