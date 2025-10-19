// study.questions.js
// 负责：拉取题目、解析 choice/exec、把 link 和 eg_* 字段规范化
import axios from 'axios';
import { safeParse } from './utils.js';

// 放在文件顶部（或 parseExecs 上方）


export async function loadUnitQuestionsFromServer(force = false) {
  const lang = this.selectedLang || 'python';
  this.questionCache[lang] = this.questionCache[lang] || {};

  const qQuery = this.$route && this.$route.query && this.$route.query.q ? Number(this.$route.query.q) : null;
  if (qQuery && !isNaN(qQuery) && qQuery >= 1) this.currentQuestionIndex = Math.max(0, qQuery - 1);

  if (!force && this.questionCache[lang][this.unitId]) {
    this.unitQuestions = this.questionCache[lang][this.unitId].map(q => ({ ...q }));
    this.serverLoaded = true;
    this.noServerData = (this.unitQuestions.length === 0);
    this.currentQuestionIndex = Math.min(this.currentQuestionIndex, Math.max(0, this.unitQuestions.length - 1));
    this.updateRouteQuery();
    return;
  }

  function tryParseLinkField(raw) {
    if (raw == null) return null;
    if (Array.isArray(raw) || typeof raw === 'object') return raw;
    if (typeof raw === 'string') {
      try { return JSON.parse(raw); } catch (e) { return raw; }
    }
    return raw;
  };

  function normalizeLinkFieldForFrontend(raw) {
    if (raw == null) return null;

    // 如果 raw 是字符串：尝试解析 JSON（保险），失败则视为单一路由字符串
    if (typeof raw === 'string') {
      const s = raw.trim();
      if (!s) return null;
      try {
        const parsed = JSON.parse(s);
        // 解析成功：交给后续逻辑处理
        raw = parsed;
      } catch (e) {
        // 不是 JSON -> 当作单一路由字符串
        return [{ path: s, label: s, external: /^(https?:)?\/\//i.test(s) }];
      }
    }

    // 如果是对象（单个 link 对象），把它放入数组并规范化字段
    if (typeof raw === 'object' && !Array.isArray(raw)) {
      const path = raw.path ?? raw.link ?? raw.route ?? raw.url ?? null;
      const label = raw.label ?? raw.title ?? path ?? String(raw);
      const external = typeof path === 'string' && /^(https?:)?\/\//i.test(path);
      return [{ path, label, external }];
    }

    // 如果是数组 -> map 每一项为对象
    if (Array.isArray(raw)) {
      return raw.map(item => {
        if (!item && item !== '') return null;
        // item 可以是字符串或对象
        if (typeof item === 'string') {
          const p = item.trim();
          return { path: p, label: p, external: /^(https?:)?\/\//i.test(p) };
        }
        if (typeof item === 'object') {
          const path = item.path ?? item.link ?? item.route ?? item.url ?? null;
          const label = item.label ?? item.title ?? path ?? JSON.stringify(item);
          const external = typeof path === 'string' && /^(https?:)?\/\//i.test(path);
          return { path, label, external };
        }
        // 其它类型，转为字符串
        const s = String(item);
        return { path: s, label: s, external: /^(https?:)?\/\//i.test(s) };
      }).filter(Boolean);
    }

    // 最后兜底
    return null;
  };

  function normalizeExampleFieldForFrontend(v) {
    if (v == null) return null;
    if (Array.isArray(v)) return v.map(x => (x == null ? '' : String(x))).join('\n');
    if (typeof v === 'string') {
      const s = v.trim();
      if (!s) return null;
      try {
        const parsed = JSON.parse(s);
        if (Array.isArray(parsed)) return parsed.map(x => (x == null ? '' : String(x))).join('\n');
        if (typeof parsed === 'object') return JSON.stringify(parsed);
        return String(parsed);
      } catch (e) {
        return s; // 不是 JSON -> 原文（包含换行）
      }
    }
    if (typeof v === 'object') {
      try { return JSON.stringify(v); } catch (e) { return String(v); }
    }
    return String(v);
  };

  // 在文件顶部（或 parseExecs 上方）添加
  function normalizeForDisplay(raw) {
    if (raw == null) return raw;
    // 如果是数组 -> 对每项做同样处理并返回数组（通常 options 可能是 array）
    if (Array.isArray(raw)) {
      return raw.map(item => normalizeForDisplay(item));
    }
    if (typeof raw === 'object') {
      // 对象直接返回（前端会尝试解析 link 等），或者转为字符串
      try { return JSON.stringify(raw); } catch (e) { return String(raw); }
    }
    // 此时 raw 是字符串或可转成字符串的类型
    let s = String(raw);
    if (!s.length) return s;

    // 重要：不要进行 trim() —— 保留前后空格
    // 把字面 "\n"（两个字符）转换为真实换行符
    // 同理处理 Windows-style \r\n
    s = s.replace(/\\r\\n/g, '\r\n').replace(/\\n/g, '\n').replace(/\\r/g, '\r');

    // 如果字符串里包含 HTML，你不想当作 HTML 渲染 -> 这里直接返回原文（安全）
    return s;
  };


  const parseChoices = (data) => {
    return (Array.isArray(data) ? data : []).map(q => ({
      id: q.q_id ?? q.id ?? null,
      q_id: q.q_id ?? q.id ?? null,
      db_id: q.db_id ?? q.id ?? null,
      unit_id: q.unit_id ?? Number(this.unitId),
      text: normalizeForDisplay(q.text || q.question_text || q.title || ''),
      options: normalizeForDisplay(Array.isArray(q.options) ? q.options : (typeof q.options === 'string' ? safeParse(q.options) : [])),
      answer: (typeof q.answer === 'number' ? q.answer : (Array.isArray(q.options) ? 0 : q.answer)),
      hints: Array.isArray(q.hints) ? q.hints : (typeof q.hints === 'string' ? safeParse(q.hints) : []),
      explanation: q.explanation || '',
      example: q.example || '',
      lang: q.lang || lang,
      created_at: q.created_at || null,
      exec: false,
      energy: Number.isFinite(Number(q.energy)) ? Number(q.energy) : 2
    })); 
  };

  const parseExecs = (data) => {
    return (Array.isArray(data) ? data : []).map(q => {
      const linkParsed = tryParseLinkField(q.link ?? q.links ?? q.resource ?? null);

      const pick = (obj, ...names) => {
        for (const n of names) {
          if (obj && (obj[n] !== undefined && obj[n] !== null)) return obj[n];
        }
        return null;
      };

      // 原始字段（可能 TEXT / 多行 / JSON 字符串）
      const raw_in1 = pick(q, 'eg_in1', 'eg_in_1', 'sample_in1', 'input_example1', 'stdin_example1', 'in_example1');
      const raw_out1 = pick(q, 'eg_out1', 'eg_out_1', 'sample_out1', 'output_example1', 'stdout_example1', 'out_example1');
      const raw_in2 = pick(q, 'eg_in2', 'eg_in_2', 'sample_in2', 'input_example2', 'stdin_example2');
      const raw_out2 = pick(q, 'eg_out2', 'eg_out_2', 'sample_out2', 'output_example2', 'stdout_example2');
      const raw_in3 = pick(q, 'eg_in3', 'eg_in_3', 'sample_in3', 'input_example3', 'stdin_example3');
      const raw_out3 = pick(q, 'eg_out3', 'eg_out_3', 'sample_out3', 'output_example3', 'stdout_example3');

      return {
        id: q.q_id ?? q.id ?? null,
        q_id: q.q_id ?? q.id ?? null,
        db_id: q.db_id ?? q.id ?? null,
        unit_id: q.unit_id ?? Number(this.unitId),
        text: normalizeForDisplay(q.text || q.title || q.question_text || q.title || ''),
        description: normalizeForDisplay(q.description || q.detail || q.question_text || ''),
        options: [],
        answer: null,
        hints: Array.isArray(q.hints) ? q.hints : (typeof q.hints === 'string' ? safeParse(q.hints) : []),
        explanation: q.explanation || '',
        example: q.example || q.template || '',
        lang: q.lang || lang,
        created_at: q.created_at || null,
        exec: true,
        energy: Number.isFinite(Number(q.energy)) ? Number(q.energy) : 3,
        link: normalizeLinkFieldForFrontend(linkParsed),
        // 规范化后再放入 question 对象
        eg_in1: normalizeExampleFieldForFrontend(raw_in1),
        eg_out1: normalizeExampleFieldForFrontend(raw_out1),
        eg_in2: normalizeExampleFieldForFrontend(raw_in2),
        eg_out2: normalizeExampleFieldForFrontend(raw_out2),
        eg_in3: normalizeExampleFieldForFrontend(raw_in3),
        eg_out3: normalizeExampleFieldForFrontend(raw_out3),
      };
    });
  };

  try {
    const choiceReq = axios.get(`http://localhost:5000/api/questions`, { params: { unit: this.unitId, lang }, timeout: 8000, validateStatus: s => (s >= 200 && s < 500) });

    const execCandidates = [
      () => axios.get('http://localhost:5000/api/questions_exec', { params: { unit: this.unitId, lang }, timeout: 8000, validateStatus: s => (s >= 200 && s < 500) }),
      () => axios.get('http://localhost:5000/api/questions', { params: { unit: this.unitId, lang, exec: 1 }, timeout: 8000, validateStatus: s => (s >= 200 && s < 500) }),
      () => axios.get('http://localhost:5000/api/questions_exec', { params: { unit: this.unitId, lang }, timeout: 8000, validateStatus: s => (s >= 200 && s < 500) })
    ];

    const [choiceRes] = await Promise.all([choiceReq]);
    let choices = [];
    if (choiceRes && choiceRes.status === 200 && Array.isArray(choiceRes.data)) {
      choices = parseChoices(choiceRes.data);
    } else {
      choices = [];
    }

    let execs = [];
    for (let tryFn of execCandidates) {
      try {
        const r = await tryFn();
        if (r && r.status === 200 && Array.isArray(r.data) && r.data.length > 0) {
          execs = parseExecs(r.data);
          break;
        }
        if (r && r.status === 200 && Array.isArray(r.data) && r.data.length === 0) {
          execs = [];
          break;
        }
      } catch (ee) {
        continue;
      }
    }

    if ((!choices || choices.length === 0) && (!execs || execs.length === 0)) {
      this.unitQuestions = (this.unitData.questions || []).map(q => ({ ...q, id: null, q_id: null, db_id: null, _local: true, energy: q.energy ?? 1 }));
      this.serverLoaded = false;
      this.noServerData = true;
      this.questionCache[lang][this.unitId] = this.unitQuestions;
      this.currentQuestionIndex = Math.min(this.currentQuestionIndex, Math.max(0, this.unitQuestions.length - 1));
      this.updateRouteQuery();
      return;
    }

    const interleaved = [];
    let ci = 0, ei = 0;
    const CHUNK_CHOICES = 3, CHUNK_EXECS = 2;
    while (ci < choices.length || ei < execs.length) {
      for (let k = 0; k < CHUNK_CHOICES && ci < choices.length; k++, ci++) {
        interleaved.push(choices[ci]);
      }
      for (let k = 0; k < CHUNK_EXECS && ei < execs.length; k++, ei++) {
        interleaved.push(execs[ei]);
      }
      if ((ci >= choices.length) && (ei >= execs.length)) break;
    }

    const finalList = interleaved.length > 0 ? interleaved : choices;

    const normalized = finalList.map(q => ({
      ...q,
      text: q.text || q.title || q.question_text || '',
      options: Array.isArray(q.options) ? q.options : [],
      hints: Array.isArray(q.hints) ? q.hints : [],
      explanation: q.explanation || '',
      example: q.example || '',
      energy: q.energy ?? (q.exec ? 3 : 2),
    }));

    this.unitQuestions = normalized;
    this.serverLoaded = true;
    this.noServerData = false;
    this.questionCache[lang][this.unitId] = normalized;

    this.resetExecState();

    this.currentQuestionIndex = Math.min(this.currentQuestionIndex, Math.max(0, this.unitQuestions.length - 1));
    this.updateRouteQuery();

  } catch (e) {
    console.error('loadUnitQuestionsFromServer error', e);
    this.unitQuestions = (this.unitData.questions || []).map(q => ({ ...q, id: null, q_id: null, db_id: null, _local: true, energy: q.energy ?? 1 }));
    this.serverLoaded = false;
    this.noServerData = true;
  }
}

export function reloadQuestions() { return this.loadUnitQuestionsFromServer(true); }