// progress.js
const express = require('express');

/**
 * progress router
 * @param {import('mysql2/promise').Pool} pool
 * @param {Function} authMiddleware
 */

module.exports = (pool, authMiddleware) => {
  const router = express.Router();

  // =============================
  // 内部语言映射与表名工具函数
  // =============================
  const LANG_SUFFIX = {
    python: '_py',
    javascript: '_js',
    cpp: '_cpp',
    // 可在此继续添加其他语言
  };

  function getTablesForLang(lang) {
    if (!lang || typeof lang !== 'string') return null;
    lang = lang.toLowerCase();
    const suffix = LANG_SUFFIX[lang];
    if (!suffix) return null;
    return {
      lang,
      progressTable: `progress${suffix}`, // 例如 progress_py
    };
  }

  // 辅助函数：安全转换 unit_id
  const toUnitId = (val) => {
    const n = Number(val);
    return Number.isFinite(n) && n > 0 ? Math.floor(n) : null;
  };

  // =============================
  // 1. GET /api/progress?lang=python
  // =============================
  router.get('/', authMiddleware, async (req, res) => {
    const userId = req.user && req.user.id;
    if (!userId) return res.status(401).json({ error: 'unauthorized' });

    const langParam = (typeof req.query.lang === 'string' && req.query.lang.trim())
      ? req.query.lang.trim().toLowerCase()
      : null;

    try {
      if (langParam) {
        const t = getTablesForLang(langParam);
        if (!t) return res.status(400).json({ error: 'unsupported lang' });

        const [rows] = await pool.query(
          `SELECT id, user_id, unit_id, current_index, completed, updated_at 
           FROM \`${t.progressTable}\` 
           WHERE user_id = ? ORDER BY unit_id ASC`,
          [userId]
        );

        const parsed = (rows || []).map(r => ({ ...r, lang: langParam }));
        return res.json(parsed);
      } else {
        // 如果未指定 lang，则聚合所有语言进度
        const out = [];
        for (const l of Object.keys(LANG_SUFFIX)) {
          const t = getTablesForLang(l);
          if (!t) continue;
          try {
            const [rows] = await pool.query(
              `SELECT id, user_id, unit_id, current_index, completed, updated_at 
               FROM \`${t.progressTable}\` 
               WHERE user_id = ? ORDER BY unit_id ASC`,
              [userId]
            );
            (rows || []).forEach(r => out.push({ ...r, lang: l }));
          } catch (e) {
            console.error(`GET progress for ${l} failed:`, e.message);
          }
        }
        out.sort((a, b) => a.lang.localeCompare(b.lang) || (a.unit_id - b.unit_id));
        return res.json(out);
      }
    } catch (err) {
      console.error('GET /api/progress error:', err);
      return res.status(500).json({ error: err.message || '查询进度失败' });
    }
  });

  // =============================
  // 2. GET /api/progress/:unitId?lang=python
  // =============================
  router.get('/:unitId', authMiddleware, async (req, res) => {
    const userId = req.user && req.user.id;
    if (!userId) return res.status(401).json({ error: 'unauthorized' });

    const unitId = toUnitId(req.params.unitId);
    if (!unitId) return res.status(400).json({ error: 'unitId required' });

    const langParam = (typeof req.query.lang === 'string' && req.query.lang.trim())
      ? req.query.lang.trim().toLowerCase()
      : null;

    try {
      if (langParam) {
        const t = getTablesForLang(langParam);
        if (!t) return res.status(400).json({ error: 'unsupported lang' });

        const [rows] = await pool.query(
          `SELECT id, user_id, unit_id, current_index, completed, updated_at 
           FROM \`${t.progressTable}\` 
           WHERE user_id = ? AND unit_id = ? LIMIT 1`,
          [userId, unitId]
        );
        return res.json(rows && rows.length ? { ...rows[0], lang: langParam } : null);
      } else {
        for (const l of Object.keys(LANG_SUFFIX)) {
          const t = getTablesForLang(l);
          if (!t) continue;
          try {
            const [rows] = await pool.query(
              `SELECT id, user_id, unit_id, current_index, completed, updated_at 
               FROM \`${t.progressTable}\` 
               WHERE user_id = ? AND unit_id = ? LIMIT 1`,
              [userId, unitId]
            );
            if (rows && rows.length) return res.json({ ...rows[0], lang: l });
          } catch (e) {
            console.error(`GET progress ${t.progressTable} failed:`, e.message);
          }
        }
        return res.json(null);
      }
    } catch (err) {
      console.error('GET /api/progress/:unitId error:', err);
      return res.status(500).json({ error: err.message || '查询进度失败' });
    }
  });

  // =============================
  // 3. POST /api/progress
  // =============================
  router.post('/', authMiddleware, async (req, res) => {
    const userId = req.user && req.user.id;
    if (!userId) return res.status(401).json({ error: 'unauthorized' });

    const unit_id = toUnitId(req.body.unit_id);
    const current_index = Number(req.body.current_index || 0);
    const completedRaw = req.body.completed;
    const completed = (completedRaw === 1 || completedRaw === '1' || completedRaw === true) ? 1 : 0;
    const langParam = (typeof req.body.lang === 'string' && req.body.lang.trim())
      ? req.body.lang.trim().toLowerCase()
      : null;

    if (!unit_id || !langParam) {
      return res.status(400).json({ error: 'unit_id and lang are required' });
    }

    try {
      const t = getTablesForLang(langParam);
      if (!t) return res.status(400).json({ error: 'unsupported lang' });

      const [result] = await pool.query(
        `INSERT INTO \`${t.progressTable}\` 
          (user_id, unit_id, current_index, completed, updated_at)
         VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)
         ON DUPLICATE KEY UPDATE
           current_index = VALUES(current_index),
           completed = VALUES(completed),
           updated_at = CURRENT_TIMESTAMP`,
        [userId, unit_id, current_index, completed]
      );

      return res.json({ success: true, insertedId: result.insertId || null });
    } catch (err) {
      console.error('POST /api/progress error:', err);
      return res.status(500).json({ error: err.message || '保存进度失败' });
    }
  });

  return router;
};