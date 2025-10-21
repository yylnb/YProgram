const express = require('express');

/**
 * 收藏（Favorites）模块（按语言拆表）
 * @param {import('mysql2/promise').Pool} pool
 * @param {Function} authMiddleware
 */


module.exports = (pool, authMiddleware) => {
  const router = express.Router();

  // ==========================
  // 内部语言映射（如需同步项目其它地方，请保持一致）
  // ==========================
  const LANG_SUFFIX = {
    python: '_py',
    javascript: '_js',
    cpp: '_cpp',
    // add more langs if needed
  };

  function getTablesForLang(lang) {
    if (!lang || typeof lang !== 'string') return null;
    lang = lang.toLowerCase();
    const suffix = LANG_SUFFIX[lang];
    if (!suffix) return null;
    return {
      lang,
      questionsTable: `questions${suffix}`,       // e.g. questions_py
      favoritesTable: `favorites${suffix}`,       // e.g. favorites_py
    };
  }

  // helper: compute page_id from 1-based index
  function computePageIdFromIndex(idx) {
    return Math.max(1, Math.ceil(idx / 5));
  }

  // helper: normalize q_id param (keep numeric if pure digits)
  function normalizeQid(q) {
    const s = String(q).trim();
    return (/^\d+$/.test(s) ? Number(s) : s);
  }

  // ================
  // POST /api/favorites
  // body: { q_id, lang, unit_id, page_id? }
  // ================
  router.post('/', authMiddleware, async (req, res) => {
    const userId = req.user && req.user.id;
    if (!userId) return res.status(401).json({ error: '未登录' });

    let { q_id, lang, unit_id, page_id } = req.body || {};

    if (!q_id) return res.status(400).json({ error: 'q_id required' });
    if (!lang) return res.status(400).json({ error: 'lang required' });

    lang = String(lang).toLowerCase();
    const t = getTablesForLang(lang);
    if (!t) return res.status(400).json({ error: 'unsupported lang' });

    const qidParam = normalizeQid(q_id);

    const conn = await pool.getConnection();
    try {
      await conn.beginTransaction();

      // verify q_id exists in questions table or questions_exec table
      const questionsTable = t.questionsTable;
      const execTable = `${questionsTable}_exec`;

      let found = false;
      try {
        const [rowsQ] = await conn.query(`SELECT 1 FROM \`${questionsTable}\` WHERE q_id = ? LIMIT 1`, [qidParam]);
        if (Array.isArray(rowsQ) && rowsQ.length > 0) found = true;
      } catch (e) {
        // ignore: table may not exist
      }

      if (!found) {
        try {
          const [rowsE] = await conn.query(`SELECT 1 FROM \`${execTable}\` WHERE q_id = ? LIMIT 1`, [qidParam]);
          if (Array.isArray(rowsE) && rowsE.length > 0) found = true;
        } catch (e) {
          // ignore
        }
      }

      if (!found) {
        await conn.rollback().catch(()=>{});
        return res.status(400).json({ error: `q_id not found in questions for lang=${lang}` });
      }

      // determine final page_id
      let finalPageId = null;
      if (page_id != null) {
        finalPageId = Number(page_id) || 1;
      } else {
        const [cntRows] = await conn.query(`SELECT COUNT(*) AS cnt FROM \`${t.favoritesTable}\` WHERE user_id = ?`, [userId]);
        const cnt = (cntRows && cntRows[0] && cntRows[0].cnt) ? Number(cntRows[0].cnt) : 0;
        const nextIndex = cnt + 1;
        finalPageId = computePageIdFromIndex(nextIndex);
      }

      const unitIdParam = (unit_id != null && !isNaN(Number(unit_id))) ? Number(unit_id) : null;

      // Upsert (requires UNIQUE(user_id, q_id) on favorites table)
      await conn.query(
        `INSERT INTO \`${t.favoritesTable}\` (user_id, q_id, unit_id, page_id, created_at)
         VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)
         ON DUPLICATE KEY UPDATE
           page_id = VALUES(page_id),
           unit_id = VALUES(unit_id),
           created_at = CURRENT_TIMESTAMP`,
        [userId, qidParam, unitIdParam, finalPageId]
      );

      await conn.commit();
      return res.json({ success: true, page_id: finalPageId });
    } catch (err) {
      await conn.rollback().catch(()=>{});
      console.error('POST /favorites error:', err && (err.message || err));
      return res.status(500).json({ error: err && err.message ? err.message : '收藏失败' });
    } finally {
      conn.release();
    }
  });

  /**
   * GET /api/favorites
   * query: ?lang=python&page=1
   * 返回：favorites 数组，支持从 questions table 与 exec table 中取题目文本（兼容两类题）
   */
  router.get('/', authMiddleware, async (req, res) => {
    const userId = req.user && req.user.id;
    if (!userId) return res.status(401).json({ error: '未登录' });

    const lang = (req.query.lang || '').toLowerCase();
    const page = Math.max(1, parseInt(req.query.page, 10) || 1);

    const t = getTablesForLang(lang);
    if (!t) return res.status(400).json({ error: 'unsupported lang' });

    try {
      const [countRows] = await pool.query(
        `SELECT COUNT(*) AS cnt FROM \`${t.favoritesTable}\` WHERE user_id = ?`,
        [userId]
      );
      const total = countRows && countRows[0] ? Number(countRows[0].cnt || 0) : 0;
      const totalPages = Math.max(1, Math.ceil(total / 5));

      const offset = (page - 1) * 5;
      const questionsTable = t.questionsTable;
      const execTable = `${questionsTable}_exec`;

      const [rows] = await pool.query(
        `SELECT
           f.q_id,
           f.unit_id,
           f.page_id,
           f.created_at,
           COALESCE(q.question_text, q.title, e.question_text, e.title, '') AS question_text,
           q.options AS options_json,
           e.link AS exec_link,
           q.energy AS energy,
           e.energy AS exec_energy
         FROM \`${t.favoritesTable}\` f
         LEFT JOIN \`${questionsTable}\` q ON f.q_id = q.q_id
         LEFT JOIN \`${execTable}\` e ON f.q_id = e.q_id
         WHERE f.user_id = ?
         ORDER BY f.created_at ASC
         LIMIT 5 OFFSET ?`,
        [userId, offset]
      );

      const favorites = (rows || []).map(r => ({
        q_id: r.q_id,
        unit_id: r.unit_id,
        page_id: r.page_id,
        created_at: r.created_at,
        question_text: r.question_text || '',
        options: r.options_json ? r.options_json : null,
        link: r.exec_link || null,
        energy: (r.energy != null ? r.energy : (r.exec_energy != null ? r.exec_energy : null))
      }));

      res.json({ favorites, totalPages, currentPage: page });
    } catch (err) {
      console.error('GET /favorites error:', err && (err.message || err));
      res.status(500).json({ error: '服务器错误' });
    }
  });

  // DELETE /api/favorites/:identifier
  // identifier may be q_id (string) — we attempt to delete that q_id in the given lang or across all langs
  router.delete('/:identifier', authMiddleware, async (req, res) => {
    const userId = req.user && req.user.id;
    if (!userId) return res.status(401).json({ error: '未登录' });

    const identifier = req.params.identifier;
    const langParam = (typeof req.query.lang === 'string' && req.query.lang.trim()) ? req.query.lang.trim().toLowerCase() : null;

    if (!identifier) return res.status(400).json({ error: 'identifier required' });

    // languages to process
    const langsToProcess = langParam ? [langParam] : Object.keys(LANG_SUFFIX);

    try {
      for (const l of langsToProcess) {
        const t = getTablesForLang(l);
        if (!t) continue;

        const conn = await pool.getConnection();
        try {
          await conn.beginTransaction();

          const idStr = String(identifier).trim();
          const idNum = (/^\d+$/.test(idStr) ? Number(idStr) : null);
          const idParam = (idNum !== null) ? idNum : idStr;

          // delete favorites rows for this user and q_id
          await conn.query(`DELETE FROM \`${t.favoritesTable}\` WHERE user_id = ? AND q_id = ?`, [userId, idParam]);

          // reflow page_id for remaining favorites
          const [rows] = await conn.query(`SELECT id FROM \`${t.favoritesTable}\` WHERE user_id = ? ORDER BY created_at ASC, id ASC`, [userId]);

          for (let i = 0; i < rows.length; i++) {
            const rid = rows[i].id;
            const newPage = computePageIdFromIndex(i + 1);
            await conn.query(`UPDATE \`${t.favoritesTable}\` SET page_id = ? WHERE id = ?`, [newPage, rid]);
          }

          await conn.commit();
        } catch (e) {
          await conn.rollback().catch(()=>{});
          console.error(`DELETE/REFLOW in ${t.favoritesTable} failed:`, e && (e.message || e));
          // continue to next lang
        } finally {
          conn.release();
        }
      }

      return res.json({ success: true });
    } catch (err) {
      console.error('DELETE /favorites/:identifier error:', err && (err.message || err));
      return res.status(500).json({ error: err && err.message ? err.message : '删除收藏失败' });
    }
  });

  return router;
};