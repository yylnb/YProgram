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
  // 语言后缀映射（注意：后缀带下划线）
  // =============================
  const LANG_SUFFIX = {
    python: '_py',
    c: '_c',
    cpp: '_cpp',
    java: '_java',
    javascript: '_js', // 如果将来需要
    // 如需支持更多语言，在这里添加映射
  };

  // normalize 简短名或后缀名到 LANG_SUFFIX 的 key
  function normalizeLangName(name) {
    if (!name || typeof name !== 'string') return null;
    const n = name.toLowerCase();
    // 直接匹配 key
    for (const k of Object.keys(LANG_SUFFIX)) {
      if (k === n) return k;
    }
    // 匹配后缀如 "py" -> python
    for (const k of Object.keys(LANG_SUFFIX)) {
      const suf = LANG_SUFFIX[k].replace(/^_/, ''); // remove leading underscore
      if (suf === n) return k;
    }
    return null;
  }

  // 获取当前连接默认数据库名
  async function getCurrentDatabaseName() {
    const [rows] = await pool.query('SELECT DATABASE() AS db');
    if (!rows || !rows.length) return null;
    return rows[0].db || null;
  }

  // 列出某语言对应的所有 progress 表，例如 progress_py_1, progress_py_2 ...
  async function listTablesForLang(langKey) {
    const suffix = LANG_SUFFIX[langKey];
    if (!suffix) return [];
    const dbName = await getCurrentDatabaseName();
    if (!dbName) return [];
    const likePattern = `progress${suffix}_%`; // e.g. progress_py_%
    const [tblRows] = await pool.query(
      `SELECT table_name FROM information_schema.tables
       WHERE table_schema = ? AND table_name LIKE ?
       ORDER BY table_name`,
      [dbName, likePattern]
    );
    return (tblRows || []).map(r => r.table_name);
  }

  // 检查单个表是否存在
  async function tableExists(tableName) {
    if (!tableName) return false;
    const dbName = await getCurrentDatabaseName();
    if (!dbName) return false;
    const [rows] = await pool.query(
      `SELECT 1 FROM information_schema.tables WHERE table_schema = ? AND table_name = ? LIMIT 1`,
      [dbName, tableName]
    );
    return !!(rows && rows.length);
  }

  // 解析 lang 和 index（可从 'python_1'、'py_1'、单独 lang + index 字段 等多种情况解析）
  function parseLangAndIndex(inputLang, explicitIndex) {
    let lang = null;
    let index = null;

    if (typeof explicitIndex !== 'undefined' && explicitIndex !== null && explicitIndex !== '') {
      const parsed = Number(explicitIndex);
      if (Number.isFinite(parsed) && parsed > 0) index = String(Math.floor(parsed));
    }

    if (typeof inputLang === 'string' && inputLang.trim()) {
      const raw = inputLang.trim();
      // 如果像 python_1 或 py-1 这类形式，尝试拆分
      const parts = raw.split(/[_-]/);
      if (parts.length > 1 && /^\d+$/.test(parts[parts.length - 1])) {
        // 最后一段是数字 -> 作为 index
        const last = parts.pop();
        index = index || last;
        const base = parts.join('_');
        lang = normalizeLangName(base) || null;
      } else {
        // 没有数字后缀，尝试直接 normalize
        lang = normalizeLangName(raw) || null;
      }
    }

    return { lang, index };
  }

  // 辅助函数：安全转换 unit_id
  const toUnitId = (val) => {
    const n = Number(val);
    return Number.isFinite(n) && n > 0 ? Math.floor(n) : null;
  };

  // =============================
  // 1. GET /api/progress?lang=python&index=1
  //    如果未指定 lang，则聚合所有语言下的所有 progress_* 表
  // =============================
  router.get('/', authMiddleware, async (req, res) => {
    const userId = req.user && req.user.id;
    if (!userId) return res.status(401).json({ error: 'unauthorized' });

    const rawLang = (typeof req.query.lang === 'string' && req.query.lang.trim()) ? req.query.lang.trim() : null;
    const rawIndex = (typeof req.query.index !== 'undefined') ? req.query.index : null;
    const parsed = parseLangAndIndex(rawLang, rawIndex);

    try {
      if (parsed.lang) {
        // 指定语言（可能指定了 index，也可能没指定）
        if (parsed.index) {
          // 指定了 index -> 查询特定表
          const tblName = `progress${LANG_SUFFIX[parsed.lang]}_${parsed.index}`;
          const exists = await tableExists(tblName);
          if (!exists) return res.status(400).json({ error: `table ${tblName} not found` });

          const [rows] = await pool.query(
            `SELECT id, user_id, unit_id, current_index, completed, updated_at
             FROM \`${tblName}\`
             WHERE user_id = ? ORDER BY unit_id ASC`,
            [userId]
          );
          const parsedRows = (rows || []).map(r => ({ ...r, lang: parsed.lang, index: Number(parsed.index), table: tblName }));
          return res.json(parsedRows);
        } else {
          // 未指定 index -> 列出该语言下所有表并合并
          const tables = await listTablesForLang(parsed.lang);
          const out = [];
          for (const t of tables) {
            try {
              const [rows] = await pool.query(
                `SELECT id, user_id, unit_id, current_index, completed, updated_at
                 FROM \`${t}\`
                 WHERE user_id = ? ORDER BY unit_id ASC`,
                [userId]
              );
              const idxMatch = t.match(/_(\d+)$/);
              const idx = idxMatch ? Number(idxMatch[1]) : null;
              (rows || []).forEach(r => out.push({ ...r, lang: parsed.lang, index: idx, table: t }));
            } catch (e) {
              console.error(`GET progress from ${t} failed:`, e.message || e);
            }
          }
          out.sort((a, b) => (a.index - b.index) || (a.unit_id - b.unit_id));
          return res.json(out);
        }
      } else {
        // 未指定 lang -> 聚合所有已知语言下的所有表
        const out = [];
        for (const langKey of Object.keys(LANG_SUFFIX)) {
          try {
            const tables = await listTablesForLang(langKey);
            for (const t of tables) {
              try {
                const [rows] = await pool.query(
                  `SELECT id, user_id, unit_id, current_index, completed, updated_at
                   FROM \`${t}\`
                   WHERE user_id = ? ORDER BY unit_id ASC`,
                  [userId]
                );
                const idxMatch = t.match(/_(\d+)$/);
                const idx = idxMatch ? Number(idxMatch[1]) : null;
                (rows || []).forEach(r => out.push({ ...r, lang: langKey, index: idx, table: t }));
              } catch (e) {
                console.error(`GET progress from ${t} failed:`, e.message || e);
              }
            }
          } catch (e) {
            console.error(`listTablesForLang ${langKey} failed:`, e.message || e);
          }
        }
        out.sort((a, b) => a.lang.localeCompare(b.lang) || (a.index - b.index) || (a.unit_id - b.unit_id));
        return res.json(out);
      }
    } catch (err) {
      console.error('GET /api/progress error:', err);
      return res.status(500).json({ error: err.message || '查询进度失败' });
    }
  });

  // =============================
  // 2. GET /api/progress/:unitId?lang=python&index=1
  //    查找某 unit 在某语言/课程下的进度；未指定 lang 时会在所有表中搜索
  // =============================
  router.get('/:unitId', authMiddleware, async (req, res) => {
    const userId = req.user && req.user.id;
    if (!userId) return res.status(401).json({ error: 'unauthorized' });

    const unitId = toUnitId(req.params.unitId);
    if (!unitId) return res.status(400).json({ error: 'unitId required' });

    const rawLang = (typeof req.query.lang === 'string' && req.query.lang.trim()) ? req.query.lang.trim() : null;
    const rawIndex = (typeof req.query.index !== 'undefined') ? req.query.index : null;
    const parsed = parseLangAndIndex(rawLang, rawIndex);

    try {
      if (parsed.lang) {
        if (parsed.index) {
          const tblName = `progress${LANG_SUFFIX[parsed.lang]}_${parsed.index}`;
          const exists = await tableExists(tblName);
          if (!exists) return res.status(400).json({ error: `table ${tblName} not found` });

          const [rows] = await pool.query(
            `SELECT id, user_id, unit_id, current_index, completed, updated_at
             FROM \`${tblName}\`
             WHERE user_id = ? AND unit_id = ? LIMIT 1`,
            [userId, unitId]
          );
          return res.json(rows && rows.length ? { ...rows[0], lang: parsed.lang, index: Number(parsed.index), table: tblName } : null);
        } else {
          // 未指定 index -> 在该语言的所有表中搜索，遇到第一条即返回
          const tables = await listTablesForLang(parsed.lang);
          for (const t of tables) {
            try {
              const [rows] = await pool.query(
                `SELECT id, user_id, unit_id, current_index, completed, updated_at
                 FROM \`${t}\`
                 WHERE user_id = ? AND unit_id = ? LIMIT 1`,
                [userId, unitId]
              );
              if (rows && rows.length) {
                const idxMatch = t.match(/_(\d+)$/);
                const idx = idxMatch ? Number(idxMatch[1]) : null;
                return res.json({ ...rows[0], lang: parsed.lang, index: idx, table: t });
              }
            } catch (e) {
              console.error(`GET progress ${t} failed:`, e.message || e);
            }
          }
          return res.json(null);
        }
      } else {
        // 未指定 lang -> 在所有已知语言表中搜索
        for (const langKey of Object.keys(LANG_SUFFIX)) {
          const tables = await listTablesForLang(langKey);
          for (const t of tables) {
            try {
              const [rows] = await pool.query(
                `SELECT id, user_id, unit_id, current_index, completed, updated_at
                 FROM \`${t}\`
                 WHERE user_id = ? AND unit_id = ? LIMIT 1`,
                [userId, unitId]
              );
              if (rows && rows.length) {
                const idxMatch = t.match(/_(\d+)$/);
                const idx = idxMatch ? Number(idxMatch[1]) : null;
                return res.json({ ...rows[0], lang: langKey, index: idx, table: t });
              }
            } catch (e) {
              console.error(`GET progress ${t} failed:`, e.message || e);
            }
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
//    body: { unit_id, current_index, completed, lang, index }
//    lang 可以是 'python' 或 'python_1'；index 可单独传
// =============================
router.post('/', authMiddleware, async (req, res) => {
  const userId = req.user && req.user.id;
  if (!userId) return res.status(401).json({ error: 'unauthorized' });

  const unit_id = toUnitId(req.body.unit_id);
  const current_index = Number(req.body.current_index || 0);
  const completedRaw = req.body.completed;
  const completed = (completedRaw === 1 || completedRaw === '1' || completedRaw === true) ? 1 : 0;

  const rawLang = (typeof req.body.lang === 'string' && req.body.lang.trim()) ? req.body.lang.trim() : null;
  const rawIndex = (typeof req.body.index !== 'undefined') ? req.body.index : null;
  const parsed = parseLangAndIndex(rawLang, rawIndex);

  if (!unit_id || !parsed.lang) {
    return res.status(400).json({ error: 'unit_id and lang are required (lang may include index like python_1 or provide index separately)' });
  }

  try {
    let targetTable = null;
    if (parsed.index) {
      const candidate = `progress${LANG_SUFFIX[parsed.lang]}_${parsed.index}`;
      const exists = await tableExists(candidate);
      if (!exists) return res.status(400).json({ error: `table ${candidate} not found` });
      targetTable = candidate;
    } else {
      // 没有 index：如果该语言只有一张表则自动使用，否则要求客户端指定 index（避免误写入）
      const tables = await listTablesForLang(parsed.lang);
      if (!tables || tables.length === 0) {
        return res.status(400).json({ error: `no progress tables found for lang ${parsed.lang}` });
      }
      if (tables.length === 1) {
        targetTable = tables[0];
      } else {
        return res.status(400).json({ error: `multiple tables found for lang ${parsed.lang}, please specify index` });
      }
    }

    // 使用连接与事务，先删除旧记录，再插入新记录（保证原子性）
    const conn = await pool.getConnection();
    try {
      await conn.beginTransaction();

      // 删除同 user_id + unit_id 的旧记录（无论 current_index 为多少，全部删除）
      const [deleteResult] = await conn.query(
        `DELETE FROM \`${targetTable}\` WHERE user_id = ? AND unit_id = ?`,
        [userId, unit_id]
      );

      // 插入新的记录
      const [insertResult] = await conn.query(
        `INSERT INTO \`${targetTable}\` (user_id, unit_id, current_index, completed, updated_at)
         VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)`,
        [userId, unit_id, current_index, completed]
      );

      await conn.commit();
      conn.release();

      return res.json({
        success: true,
        deletedRows: deleteResult.affectedRows || 0,
        insertedId: insertResult.insertId || null,
        table: targetTable
      });
    } catch (txErr) {
      // 事务中出错，回滚
      try { await conn.rollback(); } catch (e) { /* ignore rollback error */ }
      conn.release();
      console.error('POST /api/progress transaction error:', txErr);
      return res.status(500).json({ error: txErr.message || '保存进度失败（事务失败）' });
    }
  } catch (err) {
    console.error('POST /api/progress error:', err);
    return res.status(500).json({ error: err.message || '保存进度失败' });
  }
});


  return router;
};