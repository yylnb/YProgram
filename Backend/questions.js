// questions.js
const express = require('express');

/**
 * 导出函数，接收 (poolQuestions, authMiddleware)
 */
module.exports = (poolQuestions, authMiddleware) => {
  const router = express.Router();

  // 白名单
  const VALID_FORMS = new Set(['choice', 'fill']);
  const VALID_LANGS = new Set(['py', 'cpp', 'c', 'java']);

  function tableNameFrom(form, lang, index) {
    if (!VALID_FORMS.has(form)) return null;
    if (!VALID_LANGS.has(lang)) return null;
    const idx = Number(index);
    if (!Number.isInteger(idx) || idx <= 0) return null;
    return `que_${form}_${lang}_${idx}`;
  }

  function tryParseJSONField(field) {
    if (field === null || field === undefined) return field;
    if (typeof field === 'object') return field;
    try {
      return JSON.parse(field);
    } catch (e) {
      return field;
    }
  }

  // ----------------------------
  // 1) 批量获取（列表）/ 包含 answer（按 unit_id、分页）
  // GET /:form/:lang/:index?unit_id=...&page=...&pageSize=...
  // 需要登录（authMiddleware）
  // ----------------------------
  router.get('/:form/:lang/:index', authMiddleware, async (req, res) => {
    try {
      const { form, lang, index } = req.params;
      const table = tableNameFrom(form, lang, index);
      if (!table) return res.status(400).json({ error: 'Invalid form/lang/index' });

      const unitId = req.query.unit_id ? Number(req.query.unit_id) : null;
      const page = Math.max(1, parseInt(req.query.page || '1', 10));
      const pageSize = Math.min(200, parseInt(req.query.pageSize || '50', 10)); // 前端控制批量大小
      const offset = (page - 1) * pageSize;

      let sql = `SELECT id, q_id, unit_id, title, text, options, hints, explanation, example, answer, created_at, updated_at FROM \`${table}\``;
      const params = [];
      if (unitId) {
        sql += ' WHERE unit_id = ?';
        params.push(unitId);
      }
      sql += ' ORDER BY id ASC LIMIT ? OFFSET ?';
      params.push(pageSize, offset);

      const [rows] = await poolQuestions.query(sql, params);

      const data = rows.map(r => ({
        ...r,
        text: tryParseJSONField(r.text),
        options: tryParseJSONField(r.options),
        hints: tryParseJSONField(r.hints),
        answer: tryParseJSONField(r.answer) // 现在列表包含 answer（按你要求）
      }));

      return res.json({ data, page, pageSize });
    } catch (err) {
      console.error('GET list error:', err);
      return res.status(500).json({ error: 'Server error' });
    }
  });

  // ----------------------------
  // 2) 单题获取
  // GET /:form/:lang/:index/:q_id
  // 需要登录
  // 支持 query hide_answer=true 来隐藏 answer（若前端想要）
  // ----------------------------
  router.get('/:form/:lang/:index/:q_id', authMiddleware, async (req, res) => {
    try {
      const { form, lang, index, q_id } = req.params;
      const table = tableNameFrom(form, lang, index);
      if (!table) return res.status(400).json({ error: 'Invalid form/lang/index' });

      const qidNum = Number(q_id);
      if (Number.isNaN(qidNum)) return res.status(400).json({ error: 'Invalid q_id' });

      const sql = `SELECT * FROM \`${table}\` WHERE q_id = ? LIMIT 1`;
      const [rows] = await poolQuestions.query(sql, [qidNum]);
      if (!rows || rows.length === 0) return res.status(404).json({ error: 'Question not found' });

      const row = rows[0];
      const parsed = {
        ...row,
        text: tryParseJSONField(row.text),
        options: tryParseJSONField(row.options),
        hints: tryParseJSONField(row.hints),
        answer: tryParseJSONField(row.answer)
      };

      if (req.query.hide_answer === 'true') delete parsed.answer;

      return res.json({ data: parsed });
    } catch (err) {
      console.error('GET single error:', err);
      return res.status(500).json({ error: 'Server error' });
    }
  });

  // ----------------------------
  // 3) 单题提交判定
  // POST /:form/:lang/:index/:q_id/submit
  // 需要登录
  // body: { answer: number } 或 { answer: [numbers] }
  // ----------------------------
  router.post('/:form/:lang/:index/:q_id/submit', authMiddleware, async (req, res) => {
    try {
      const { form, lang, index, q_id } = req.params;
      const table = tableNameFrom(form, lang, index);
      if (!table) return res.status(400).json({ error: 'Invalid form/lang/index' });

      const qidNum = Number(q_id);
      if (Number.isNaN(qidNum)) return res.status(400).json({ error: 'Invalid q_id' });

      const userAnswer = req.body.answer;
      if (userAnswer === undefined) return res.status(400).json({ error: 'Missing answer in body' });

      const sql = `SELECT * FROM \`${table}\` WHERE q_id = ? LIMIT 1`;
      const [rows] = await poolQuestions.query(sql, [qidNum]);
      if (!rows || rows.length === 0) return res.status(404).json({ error: 'Question not found' });

      const question = rows[0];

      if (form === 'choice') {
        const correct = Number(question.answer);
        const userAnsNum = Number(userAnswer);
        const ok = userAnsNum === correct;
        return res.json({ correct: ok, correctAnswer: correct });
      } else {
        let correctAnswer = tryParseJSONField(question.answer);
        if (!Array.isArray(correctAnswer)) {
          try { correctAnswer = JSON.parse(question.answer); } catch (e) { correctAnswer = []; }
        }
        const expected = correctAnswer.map(n => Number(n));
        const userArr = Array.isArray(userAnswer) ? userAnswer.map(n => Number(n)) : [];
        const ok = userArr.length === expected.length && userArr.every((v, i) => v === expected[i]);
        return res.json({ correct: ok, correctAnswer: expected });
      }
    } catch (err) {
      console.error('POST submit error:', err);
      return res.status(500).json({ error: 'Server error' });
    }
  });

  // ----------------------------
  // 4) 按 q_id 列表批量获取（前端传具体要取的 q_id 数组）
  // POST /:form/:lang/:index/batch
  // body: { q_ids: [1001, 1002, ...] }
  // 需要登录
  // ----------------------------
  router.post('/:form/:lang/:index/batch', authMiddleware, async (req, res) => {
    try {
      const { form, lang, index } = req.params;
      const table = tableNameFrom(form, lang, index);
      if (!table) return res.status(400).json({ error: 'Invalid form/lang/index' });

      const qIds = Array.isArray(req.body.q_ids) ? req.body.q_ids.map(n => Number(n)).filter(n => !Number.isNaN(n)) : [];
      if (qIds.length === 0) return res.status(400).json({ error: 'q_ids array required' });

      // 使用 IN 查询（注意：长度可能影响 performance）
      const placeholders = qIds.map(_ => '?').join(',');
      const sql = `SELECT * FROM \`${table}\` WHERE q_id IN (${placeholders}) ORDER BY FIELD(q_id, ${placeholders})`;
      // double the params because FIELD needs same qIds to preserve order in mysql
      const params = [...qIds, ...qIds];
      const [rows] = await poolQuestions.query(sql, params);

      const data = rows.map(r => ({
        ...r,
        text: tryParseJSONField(r.text),
        options: tryParseJSONField(r.options),
        hints: tryParseJSONField(r.hints),
        answer: tryParseJSONField(r.answer)
      }));

      return res.json({ data });
    } catch (err) {
      console.error('POST batch error:', err);
      return res.status(500).json({ error: 'Server error' });
    }
  });

  // No create/update/delete endpoints (per your request)

  return router;
};