// server.js
const express = require('express');
const cors = require('cors');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const pool = require('./db'); // mysql2/promise pool
require('dotenv').config();

const bodyParser = require('body-parser');
const util = require('util');
const execAsync = util.promisify(require('child_process').exec);
const fs = require('fs');
const path = require('path');
const os = require('os');

const cookieParser = require('cookie-parser');

const app = express();

const { spawn } = require('child_process');

// allow credentials and common headers (including Authorization)
app.use(cors({ origin: true, credentials: true }));
app.use(express.json());
app.use(bodyParser.json());
app.use(cookieParser()); // 支持读取 refreshToken cookie

// config
const JWT_SECRET = process.env.JWT_SECRET || 'dev_secret';
const JWT_EXPIRES_IN = process.env.JWT_EXPIRES_IN || '7d';

// refresh token (stateless JWT) config
const REFRESH_JWT_SECRET = process.env.REFRESH_JWT_SECRET || JWT_SECRET;
const REFRESH_EXPIRES_IN = process.env.REFRESH_EXPIRES_IN || '30d';

//-------- 挂载其它页面api ----------
// 注意：authMiddleware 是函数声明（下文定义），函数声明会被提升（hoist），
// 所以这里传入 authMiddleware 是可以工作的（与你原文件结构保持一致）。
const calendarRouter = require('./calendar')(pool, authMiddleware);
app.use('/api/calendar', calendarRouter);


// --------- helper: create JWT ----------
function signToken(payload) {
  return jwt.sign(payload, JWT_SECRET, { expiresIn: JWT_EXPIRES_IN });
}

// --------- refresh token (stateless) helpers ----------
function signRefreshTokenStateless(payload) {
  // payload example: { id, username }
  return jwt.sign(payload, REFRESH_JWT_SECRET, { expiresIn: REFRESH_EXPIRES_IN });
}

function validateRefreshTokenStateless(token) {
  if (!token) return null;
  try {
    const decoded = jwt.verify(token, REFRESH_JWT_SECRET);
    return decoded; // return payload (contains id, username, iat, exp...)
  } catch (e) {
    return null;
  }
}

// Helper to set refresh token cookie (httpOnly) and header for non-cookie clients
function setRefreshTokenCookie(res, refreshToken) {
  const cookieOpts = {
    httpOnly: true,
    sameSite: 'lax',
    secure: process.env.NODE_ENV === 'production',
    maxAge: (function () {
      // REFRESH_EXPIRES_IN may be like '30d' or seconds; for simplicity use 30 days if default
      // Try to parse numeric seconds if REFRESH_EXPIRES_IN is number-like
      if (/^\d+$/.test(REFRESH_EXPIRES_IN)) {
        return parseInt(REFRESH_EXPIRES_IN, 10) * 1000;
      }
      // fallback to 30 days
      return 30 * 24 * 60 * 60 * 1000;
    })()
  };
  res.cookie('refreshToken', refreshToken, cookieOpts);
  // also expose in header if frontend can't read cookie (non-httpOnly flows)
  res.setHeader('x-refresh-token', refreshToken);
}

// --------- middleware: auth (supports auto refresh via stateless refresh token) ----------
async function authMiddleware(req, res, next) {
  const auth = req.headers.authorization || req.headers.Authorization;
  if (!auth) return res.status(401).json({ error: 'Missing Authorization header' });
  const parts = auth.split(' ');
  if (parts.length !== 2 || parts[0] !== 'Bearer') return res.status(401).json({ error: 'Invalid Authorization format' });

  const token = parts[1];
  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    req.user = decoded;
    return next();
  } catch (err) {
    // If token expired, attempt refresh using stateless refresh token (cookie / header / body)
    if (err && err.name === 'TokenExpiredError') {
      try {
        const incomingRefresh = req.cookies?.refreshToken || req.headers['x-refresh-token'] || req.body?.refreshToken || null;
        if (!incomingRefresh) {
          return res.status(401).json({ error: 'Token expired', code: 'token_expired' });
        }

        const decodedRefresh = validateRefreshTokenStateless(incomingRefresh);
        if (!decodedRefresh || !decodedRefresh.id) {
          return res.status(401).json({ error: 'Invalid/expired refresh token' });
        }

        // confirm user still exists (and not disabled)
        const [uRows] = await pool.query('SELECT id, username FROM users WHERE id = ? LIMIT 1', [decodedRefresh.id]);
        if (!uRows || !uRows.length) {
          return res.status(401).json({ error: 'User not found for refresh token' });
        }
        const user = uRows[0];

        // rotate refresh token (issue new stateless refresh JWT)
        const newRefresh = signRefreshTokenStateless({ id: user.id, username: user.username });
        setRefreshTokenCookie(res, newRefresh);

        // sign new access token
        const newAccess = signToken({ id: user.id, username: user.username });
        // expose new access token to client so it can update stored token
        res.setHeader('x-access-token', newAccess);

        // attach to request and continue
        req.user = jwt.verify(newAccess, JWT_SECRET);
        return next();
      } catch (refreshErr) {
        console.error('authMiddleware refresh error:', refreshErr);
        return res.status(401).json({ error: 'Token expired and refresh failed' });
      }
    } else {
      return res.status(401).json({ error: 'Invalid/Expired token' });
    }
  }
}

// --------- helper ----------
function safeParseJSON(value) {
  if (value === null || value === undefined) return null;
  if (typeof value === 'object') return value;
  if (typeof value !== 'string') return value;
  try { return JSON.parse(value); } catch { return value; }
}
function toISO(d) {
  if (!d) return null;
  try { return (new Date(d)).toISOString(); } catch(e) { return null; }
}

// --------- Routes ----------
// health
app.get('/', (req, res) => res.json({ ok: true, now: new Date() }));

// ---------- AUTH: register ----------
app.post('/api/register', async (req, res) => {
  const { username, password } = req.body;
  if (!username || !password) return res.status(400).json({ error: 'username and password required' });

  try {
    const [rows] = await pool.query('SELECT id FROM users WHERE username = ?', [username]);
    if (rows.length) return res.status(409).json({ error: 'username exists' });

    const hashed = await bcrypt.hash(password, 10);
    const [r] = await pool.query('INSERT INTO users (username, password) VALUES (?, ?)', [username, hashed]);
    const userId = r.insertId;

    const token = signToken({ id: userId, username });
    // create stateless refresh token and set cookie/header
    const refreshToken = signRefreshTokenStateless({ id: userId, username });
    setRefreshTokenCookie(res, refreshToken);

    res.json({ success: true, token, refreshToken, user: { id: userId, username } });
  } catch (err) {
    console.error('register error:', err);
    res.status(500).json({ error: err.message || 'register failed' });
  }
});

// ---------- AUTH: login ----------
app.post('/api/login', async (req, res) => {
  const { username, password } = req.body;
  if (!username || !password) return res.status(400).json({ error: 'username and password required' });

  try {
    const [rows] = await pool.query('SELECT id, username, password FROM users WHERE username = ?', [username]);
    if (!rows.length) return res.status(401).json({ error: 'invalid credentials' });

    const user = rows[0];
    const ok = await bcrypt.compare(password, user.password);
    if (!ok) return res.status(401).json({ error: 'invalid credentials' });

    // 查最新 membership
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
    res.status(500).json({ error: err.message || 'login failed' });
  }
});

// ---------- TOKEN refresh endpoint (explicit) ----------
app.post('/api/token/refresh', async (req, res) => {
  try {
    // accept refresh token from cookie / header / body
    const incoming = req.cookies?.refreshToken || req.headers['x-refresh-token'] || req.body?.refreshToken || null;
    if (!incoming) return res.status(400).json({ error: 'refreshToken required' });

    const decoded = validateRefreshTokenStateless(incoming);
    if (!decoded || !decoded.id) return res.status(401).json({ error: 'invalid or expired refresh token' });

    // verify user exists
    const [uRows] = await pool.query('SELECT id, username FROM users WHERE id = ? LIMIT 1', [decoded.id]);
    if (!uRows || !uRows.length) return res.status(404).json({ error: 'user not found' });
    const user = uRows[0];

    // rotate refresh token
    const newRefresh = signRefreshTokenStateless({ id: user.id, username: user.username });
    setRefreshTokenCookie(res, newRefresh);

    const newAccess = signToken({ id: user.id, username: user.username });
    res.json({ token: newAccess, refreshToken: newRefresh, user: { id: user.id, username: user.username } });
  } catch (err) {
    console.error('/api/token/refresh error:', err);
    res.status(500).json({ error: 'refresh failed' });
  }
});

// ---------- LOGOUT ----------
app.post('/api/logout', async (req, res) => {
  try {
    // Clear cookie. For stateless refresh tokens we cannot revoke on server without storage.
    res.clearCookie('refreshToken');
    // also clear header by setting empty
    res.setHeader('x-refresh-token', '');
    res.json({ success: true });
  } catch (err) {
    console.error('/api/logout error:', err);
    res.status(500).json({ error: 'logout failed' });
  }
});


// ---------- language -> table suffix map (whitelist) ----------
const LANG_SUFFIX = {
  python: 'py',
  cpp: 'cpp',
  c: 'c',
  java: 'java',
  html: 'html',
  css: 'css',
  js: 'js'
};

function getTablesForLang(lang) {
  // return null if lang not recognized
  if (!lang || typeof lang !== 'string') return null;
  const key = lang.trim().toLowerCase();
  const suf = LANG_SUFFIX[key];
  if (!suf) return null;
  return {
    questionsTable: `questions_${suf}`,
    progressTable: `progress_${suf}`,
    favoritesTable: `questions_favorites_${suf}`,
    langKey: key
  };
}

// ---------- QUESTIONS ----------
// GET /api/questions?unit=12&lang=python
app.get('/api/questions', async (req, res) => {
  const unit = Number(req.query.unit || 0);
  const langParam = (typeof req.query.lang === 'string' && req.query.lang.trim()) ? req.query.lang.trim().toLowerCase() : null;
  const userId = req.user?.id; // 假设JWT里有用户ID
  try {
    // 检查会员有效性
    let isVip = false;
    if (userId) {
      const [membershipRows] = await pool.query(
        'SELECT 1 FROM memberships WHERE user_id = ? AND end_at > NOW() LIMIT 1',
        [userId]
      );
      if (membershipRows.length > 0) {
        isVip = true;
      }
    }

    if (unit > 0) {
      if (langParam) {
        // specific language table
        const t = getTablesForLang(langParam);
        if (!t) return res.status(400).json({ error: 'unsupported lang' });
        const sql = `SELECT id AS db_id, q_id, unit_id, title, question_text, options, answer, hints, explanation, example, created_at, energy FROM \`${t.questionsTable}\` WHERE unit_id = ? ORDER BY id ASC`;
        const [rows] = await pool.query(sql, [unit]);
        const parsed = rows.map(r => ({
          db_id: r.db_id,
          q_id: r.q_id != null ? String(r.q_id) : null,
          unit_id: r.unit_id,
          title: r.title,
          text: r.question_text,
          options: safeParseJSON(r.options) || [],
          answer: r.answer,
          hints: safeParseJSON(r.hints) || [],
          explanation: r.explanation,
          example: r.example,
          lang: t.langKey,
          created_at: r.created_at,
          energy: isVip ? 0 : r.energy
        }));
        return res.json(parsed);
      } else {
        // no lang: aggregate across all language question tables (may be slower)
        const results = [];
        for (const l of Object.keys(LANG_SUFFIX)) {
          const t = getTablesForLang(l);
          const sql = `SELECT id AS db_id, q_id, unit_id, title, question_text, options, answer, hints, explanation, example, created_at, energy FROM \`${t.questionsTable}\` WHERE unit_id = ? ORDER BY id ASC`;
          try {
            const [rows] = await pool.query(sql, [unit]);
            rows.forEach(r => {
              results.push({
                db_id: r.db_id,
                q_id: r.q_id != null ? String(r.q_id) : null,
                unit_id: r.unit_id,
                title: r.title,
                text: r.question_text,
                options: safeParseJSON(r.options) || [],
                answer: r.answer,
                hints: safeParseJSON(r.hints) || [],
                explanation: r.explanation,
                example: r.example,
                lang: l,
                created_at: r.created_at,
                energy: isVip ? 0 : r.energy
              });
            });
          } catch (e) {
            // ignore per-lang errors but log
            console.error(`query ${t.questionsTable} failed:`, e && e.message);
          }
        }
        // optional: sort by lang then db_id for stable order
        results.sort((a, b) => (a.lang === b.lang ? (Number(a.db_id || 0) - Number(b.db_id || 0)) : a.lang.localeCompare(b.lang)));
        return res.json(results);
      }
    } else {
      // unit not provided -> return listing (limit, optional lang)
      const limit = Number(req.query.limit) || 50;
      if (langParam) {
        const t = getTablesForLang(langParam);
        if (!t) return res.status(400).json({ error: 'unsupported lang' });
        const [rows] = await pool.query(
          `SELECT id AS db_id, q_id, unit_id, title, created_at FROM \`${t.questionsTable}\` ORDER BY unit_id ASC, id ASC LIMIT ?`,
          [limit]
        );
        return res.json(rows.map(r => ({
          db_id: r.db_id,
          q_id: r.q_id != null ? String(r.q_id) : null,
          unit_id: r.unit_id,
          title: r.title,
          lang: langParam,
          created_at: r.created_at,
          energy: isVip ? 0 : undefined
        })));
      } else {
        // aggregate across languages for directory
        const out = [];
        for (const l of Object.keys(LANG_SUFFIX)) {
          const t = getTablesForLang(l);
          try {
            const [rows] = await pool.query(`SELECT id AS db_id, q_id, unit_id, title, created_at FROM \`${t.questionsTable}\` ORDER BY unit_id ASC, id ASC LIMIT ?`, [limit]);
            rows.forEach(r => out.push({
              db_id: r.db_id,
              q_id: r.q_id != null ? String(r.q_id) : null,
              unit_id: r.unit_id,
              title: r.title,
              lang: l,
              created_at: r.created_at,
              energy: isVip ? 0 : undefined
            }));
          } catch (e) {
            console.error(`list ${t.questionsTable} failed:`, e && e.message);
          }
        }
        // optional sort by lang, unit_id
        out.sort((a,b) => a.lang.localeCompare(b.lang) || (a.unit_id - b.unit_id));
        return res.json(out.slice(0, limit));
      }
    }
  } catch (err) {
    console.error('GET /api/questions error:', err);
    res.status(500).json({ error: err.message || '数据库查询失败' });
  }
});

// ---------- QUESTIONS_EXEC (实操题) ----------
// GET /api/questions_exec?unit=12&lang=python
app.get('/api/questions_exec', async (req, res) => {
  const unit = Number(req.query.unit || 0);
  const langParam = (typeof req.query.lang === 'string' && req.query.lang.trim()) ? req.query.lang.trim().toLowerCase() : null;
  const limit = Number(req.query.limit || 200);
  const userId = req.user?.id;

  // hints 解析
  function safeParseHints(v) {
    if (v == null) return [];
    if (Array.isArray(v)) return v;
    try {
      const parsed = JSON.parse(String(v));
      if (Array.isArray(parsed)) return parsed;
      if (typeof parsed === 'string') return [parsed];
      return [String(parsed)];
    } catch (e) {
      const s = String(v || '').trim();
      if (!s) return [];
      return s.split(',').map(x => x.trim()).filter(Boolean);
    }
  }

  // link 解析：尝试 JSON.parse，否则保留字符串/null
  function parseLinkField(raw) {
    if (raw == null) return null;
    if (Array.isArray(raw) || typeof raw === 'object') return raw;
    if (typeof raw === 'string') {
      const s = raw.trim();
      if (!s) return null;
      try { return JSON.parse(s); } catch (e) { return s; }
    }
    return raw;
  }

  // 把 db 的示例字段统一成字符串 (若为 JSON 数组字符串 -> join 行；对象 -> JSON.stringify)
  function stringifyExampleField(v) {
    if (v == null) return null;
    // 如果已经是数组
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
        return s;
      }
    }
    if (typeof v === 'object') {
      try { return JSON.stringify(v); } catch (e) { return String(v); }
    }
    return String(v);
  }

  try {
    // 会员判断（与其它路由一致）
    let isVip = false;
    if (userId) {
      const [membershipRows] = await pool.query(
        'SELECT 1 FROM memberships WHERE user_id = ? AND end_at > NOW() LIMIT 1',
        [userId]
      );
      if (membershipRows && membershipRows.length > 0) isVip = true;
    }

    function execTableFor(t) {
      if (!t || !t.questionsTable) return null;
      if (t.questionsTable.endsWith('_exec')) return t.questionsTable;
      return `${t.questionsTable}_exec`;
    }

    // 如果提供 unit -> 返回该 unit 的实操题（按 lang 或聚合）
    if (unit > 0) {
      if (langParam) {
        const t = getTablesForLang(langParam);
        if (!t) return res.status(400).json({ error: 'unsupported lang' });

        const execTable = execTableFor(t);
        if (!execTable) return res.status(500).json({ error: 'exec table mapping error' });

        // **显式列出你给出的字段名** 保证返回属性名与前端期望一致
        const sql = `SELECT id, q_id, unit_id, title, energy,
                           question_text, hints, link,
                           eg_in1, eg_out1, eg_in2, eg_out2, eg_in3, eg_out3,
                           created_at
                     FROM \`${execTable}\`
                     WHERE unit_id = ?
                     ORDER BY id ASC
                     LIMIT ?`;
        const [rows] = await pool.query(sql, [unit, limit]);

        const parsed = (rows || []).map(r => ({
          db_id: r.id ?? null,
          q_id: r.q_id != null ? String(r.q_id) : null,
          unit_id: r.unit_id,
          title: r.title || '',
          text: (r.title || r.question_text || '').toString(),
          description: (r.question_text || r.title || '').toString(),
          hints: safeParseHints(r.hints),
          link: parseLinkField(r.link ?? null),
          eg_in1: stringifyExampleField(r.eg_in1 ?? null),
          eg_out1: stringifyExampleField(r.eg_out1 ?? null),
          eg_in2: stringifyExampleField(r.eg_in2 ?? null),
          eg_out2: stringifyExampleField(r.eg_out2 ?? null),
          eg_in3: stringifyExampleField(r.eg_in3 ?? null),
          eg_out3: stringifyExampleField(r.eg_out3 ?? null),
          energy: isVip ? 0 : (Number.isFinite(Number(r.energy)) ? Number(r.energy) : 3),
          created_at: r.created_at,
          lang: t.langKey || langParam
        }));

        return res.json(parsed);
      } else {
        // 聚合所有语言
        const results = [];
        for (const l of Object.keys(LANG_SUFFIX)) {
          const t = getTablesForLang(l);
          if (!t) continue;
          const execTable = execTableFor(t);
          if (!execTable) continue;

          const sql = `SELECT id, q_id, unit_id, title, energy,
                             question_text, hints, link,
                             eg_in1, eg_out1, eg_in2, eg_out2, eg_in3, eg_out3,
                             created_at
                       FROM \`${execTable}\`
                       WHERE unit_id = ?
                       ORDER BY id ASC
                       LIMIT ?`;
          try {
            const [rows] = await pool.query(sql, [unit, limit]);
            (rows || []).forEach(r => results.push({
              db_id: r.id ?? null,
              q_id: r.q_id != null ? String(r.q_id) : null,
              unit_id: r.unit_id,
              title: r.title || '',
              text: (r.title || r.question_text || '').toString(),
              description: (r.question_text || r.title || '').toString(),
              hints: safeParseHints(r.hints),
              link: parseLinkField(r.link ?? null),
              eg_in1: stringifyExampleField(r.eg_in1 ?? null),
              eg_out1: stringifyExampleField(r.eg_out1 ?? null),
              eg_in2: stringifyExampleField(r.eg_in2 ?? null),
              eg_out2: stringifyExampleField(r.eg_out2 ?? null),
              eg_in3: stringifyExampleField(r.eg_in3 ?? null),
              eg_out3: stringifyExampleField(r.eg_out3 ?? null),
              energy: isVip ? 0 : (Number.isFinite(Number(r.energy)) ? Number(r.energy) : 3),
              created_at: r.created_at,
              lang: t.langKey || l
            }));
          } catch (e) {
            console.error(`query ${execTable} failed:`, e && e.message);
            // 忽略单语言错误，继续
          }
        }

        results.sort((a, b) => (a.lang === b.lang ? (Number(a.db_id || 0) - Number(b.db_id || 0)) : a.lang.localeCompare(b.lang)));
        return res.json(results);
      }
    } else {
      // 没有 unit：返回目录列表（简略字段）
      const out = [];
      if (langParam) {
        const t = getTablesForLang(langParam);
        if (!t) return res.status(400).json({ error: 'unsupported lang' });
        const execTable = execTableFor(t);
        if (!execTable) return res.status(500).json({ error: 'exec table mapping error' });

        const sql = `SELECT id AS db_id, q_id, unit_id, title, created_at, energy FROM \`${execTable}\` ORDER BY unit_id ASC, id ASC LIMIT ?`;
        const [rows] = await pool.query(sql, [limit]);
        (rows || []).forEach(r => out.push({
          db_id: r.db_id,
          q_id: r.q_id != null ? String(r.q_id) : null,
          unit_id: r.unit_id,
          title: r.title,
          lang: t.langKey || langParam,
          created_at: r.created_at,
          energy: isVip ? 0 : (Number.isFinite(Number(r.energy)) ? Number(r.energy) : undefined)
        }));
        return res.json(out);
      } else {
        for (const l of Object.keys(LANG_SUFFIX)) {
          const t = getTablesForLang(l);
          if (!t) continue;
          const execTable = execTableFor(t);
          if (!execTable) continue;
          try {
            const sql = `SELECT id AS db_id, q_id, unit_id, title, created_at, energy FROM \`${execTable}\` ORDER BY unit_id ASC, id ASC LIMIT ?`;
            const [rows] = await pool.query(sql, [limit]);
            (rows || []).forEach(r => out.push({
              db_id: r.db_id,
              q_id: r.q_id != null ? String(r.q_id) : null,
              unit_id: r.unit_id,
              title: r.title,
              lang: t.langKey || l,
              created_at: r.created_at,
              energy: isVip ? 0 : (Number.isFinite(Number(r.energy)) ? Number(r.energy) : undefined)
            }));
          } catch (e) {
            console.error(`list ${execTable} failed:`, e && e.message);
          }
        }
        out.sort((a,b) => a.lang.localeCompare(b.lang) || (a.unit_id - b.unit_id));
        return res.json(out.slice(0, limit));
      }
    }
  } catch (err) {
    console.error('GET /api/questions_exec error:', err);
    return res.status(500).json({ error: err.message || '数据库查询失败' });
  }
});

// ---------- CODE EXECUTION ----------
app.post('/api/exec', async (req, res) => {
  const { lang, code, stdin } = req.body || {};
  if (!lang || !code) return res.status(400).json({ error: 'lang and code required' });

  const config = {
    python: { image: 'python:3.11-slim', filename: 'code.py' },
    cpp: { image: 'gcc:12', filename: 'code.cpp' }
  };

  if (!config[lang]) return res.status(400).json({ error: 'unsupported lang' });

  const prefix = path.join(os.tmpdir(), 'yp-sandbox-');
  let tmpDir;
  try {
    tmpDir = await fs.promises.mkdtemp(prefix);
  } catch (e) {
    console.error('mkdtemp error:', e);
    return res.status(500).json({ error: 'server tmpdir error' });
  }

  const filename = config[lang].filename;
  const filePath = path.join(tmpDir, filename);
  const runShPath = path.join(tmpDir, 'run.sh');

  try {
    // 写入代码文件
    await fs.promises.writeFile(filePath, code, { encoding: 'utf8', mode: 0o644 });
    if (stdin) {
      await fs.promises.writeFile(path.join(tmpDir, 'stdin.txt'), stdin, { encoding: 'utf8', mode: 0o600 });
    }

    // run.sh 内容（不再加 ===Start/End===）
    const scriptLines = ['#!/bin/sh', 'set -e', 'cd /work'];

    if (lang === 'python') {
      if (stdin) {
        scriptLines.push(`python3 ${filename} < stdin.txt`);
      } else {
        scriptLines.push(`python3 ${filename}`);
      }
    } else if (lang === 'cpp') {
      scriptLines.push(`g++ ${filename} -O2 -std=c++17 -o code_exec`);
      if (stdin) {
        scriptLines.push(`./code_exec < stdin.txt`);
      } else {
        scriptLines.push(`./code_exec`);
      }
    }

    await fs.promises.writeFile(runShPath, scriptLines.join('\n') + '\n', {
      encoding: 'utf8',
      mode: 0o755
    });

    // Docker 命令
    const dockerCmd = [
      'docker', 'run',
      '--rm',
      '--network', 'none',
      '--memory', '200m',
      '--cpus', '0.5',
      '-v', `${tmpDir.replace(/\\/g, '/')}:/work`,
      '-w', '/work',
      config[lang].image,
      '/bin/sh', 'run.sh'
    ].join(' ');

    const TIMEOUT_MS = 8000;
    try {
      const { stdout, stderr } = await execAsync(dockerCmd, {
        timeout: TIMEOUT_MS,
        maxBuffer: 1024 * 1024
      });

      // 直接返回 stdout / stderr（分离）
      res.json({ stdout, stderr });

    } catch (execErr) {
      res.json({
        stdout: execErr.stdout || '',
        stderr: execErr.stderr || execErr.message || 'execution failed',
        error: execErr.killed ? 'timeout' : execErr.message
      });
    }

  } catch (e) {
    console.error('/api/exec internal error:', e);
    try { res.status(500).json({ error: 'server error executing code' }); } catch {}
  } finally {
    try {
      // 调试时保留文件夹，生产环境可以删掉
      await fs.promises.rm(tmpDir, { recursive: true, force: true });
    } catch {}
  }
});

// ---------- runtime helpers ----------
function dockerRunArgs(tmpDir, image, opts = {}) {
  return [
    'run','--rm',
    '--network', 'none',
    '--memory', `${opts.memory || '200m'}`,
    '--cpus', `${opts.cpus || '0.5'}`,
    '--pids-limit', '64',
    '--security-opt', 'no-new-privileges',
    '--cap-drop', 'ALL',
    '--read-only',
    '-v', `${tmpDir}:/work:rw`,
    '-w', '/work',
    image
  ];
}

function spawnDocker(tmpDir, image, insideCmdArray, options = {}) {
  return new Promise((resolve) => {
    const dockerArgs = dockerRunArgs(tmpDir, image, options).concat(insideCmdArray);
    const proc = spawn('docker', dockerArgs, { stdio: ['ignore', 'pipe', 'pipe'] });

    let stdout = '', stderr = '';
    proc.stdout.on('data', d => stdout += d.toString());
    proc.stderr.on('data', d => stderr += d.toString());

    let timedOut = false;
    let timer = null;
    if (options.timeout) {
      timer = setTimeout(() => {
        timedOut = true;
        try { proc.kill('SIGKILL'); } catch (e) {}
      }, options.timeout);
    }

    proc.on('close', (code, sig) => {
      if (timer) clearTimeout(timer);
      resolve({ code, stdout, stderr, timedOut, sig });
    });

    proc.on('error', (err) => {
      if (timer) clearTimeout(timer);
      resolve({ code: 127, stdout, stderr: stderr + '\n' + err.toString(), timedOut: false });
    });
  });
}

function normalizeOutput(s, mode = 'trim') {
  if (s == null) return '';
  s = String(s).replace(/\r\n/g, '\n');
  if (mode === 'exact') return s;
  if (mode === 'trim') return s.trim();
  if (mode === 'ignoreWS') return s.replace(/\s+/g, ' ').trim();
  return s;
}

// ---------- 新增判题接口 /api/submit ----------
/*
Request JSON:
{
  lang: "python" | "cpp" | "java",
  code: "...",
  q_id: 123,                 // 题目 id （会在 questions_*_exec 表里查 eg_in1..eg_out3）
  timeLimitMs: 2000,         // 每用例超时（可选）
  memoryMB: 200,             // 内存限制（可选）
  compare: "trim"|"exact"|"ignoreWS"  // 比较策略（可选）
}
*/
app.post('/api/submit', async (req, res) => {
  const body = req.body || {};
  const { lang, code, q_id, timeLimitMs = 2000, memoryMB = 200, compare = 'trim' } = body;
  if (!lang || !code || !q_id) return res.status(400).json({ error: 'lang, code, q_id required' });

  const config = {
    python: { image: 'python:3.11-slim', filename: 'code.py' },
    cpp:    { image: 'gcc:12', filename: 'code.cpp' },
    java:   { image: 'openjdk:17', filename: 'Main.java' }
  };
  if (!config[lang]) return res.status(400).json({ error: 'unsupported lang' });

  // 根据 lang 选择表名
  const tableMap = {
    python: 'questions_py_exec',
    cpp:    'questions_cpp_exec',
    java:   'questions_java_exec'
  };
  const table = tableMap[lang];

  // 取出 eg_in1..eg_out3
  let row = null;
  try {
    // 先尝试以 q_id 字段查找（兼容你之前提到的 q_id）
    const [rows1] = await pool.query(`SELECT eg_in1, eg_out1, eg_in2, eg_out2, eg_in3, eg_out3 FROM \`${table}\` WHERE q_id = ? LIMIT 1`, [q_id]);
    if (rows1 && rows1.length > 0) row = rows1[0];
    else {
      // 回退尝试 id 字段
      const [rows2] = await pool.query(`SELECT eg_in1, eg_out1, eg_in2, eg_out2, eg_in3, eg_out3 FROM \`${table}\` WHERE id = ? LIMIT 1`, [q_id]);
      if (rows2 && rows2.length > 0) row = rows2[0];
    }
  } catch (dbErr) {
    console.error('/api/submit DB query error:', dbErr);
    return res.status(500).json({ error: 'db query failed' });
  }

  if (!row) {
    return res.status(404).json({ error: 'question not found or no examples stored' });
  }

  // assemble tests array from eg_in/out fields (最多 3，对空的忽略)
  const tests = [];
  for (let i = 1; i <= 3; i++) {
    const inField = row[`eg_in${i}`];
    const outField = row[`eg_out${i}`];
    if (inField == null && outField == null) continue;
    tests.push({ input: inField == null ? '' : String(inField), expected: outField == null ? '' : String(outField) });
  }
  if (tests.length === 0) return res.status(400).json({ error: 'no example testcases found in DB' });

  // create tmp dir
  const prefix = path.join(os.tmpdir(), 'yp-judge-');
  let tmpDir;
  try {
    tmpDir = await fs.promises.mkdtemp(prefix);
  } catch (e) {
    console.error('mkdtemp error:', e);
    return res.status(500).json({ error: 'server tmpdir error' });
  }
  const hostTmp = tmpDir.replace(/\\/g, '/');

  const filename = config[lang].filename;
  const filePath = path.join(tmpDir, filename);

  try {
    // write code
    await fs.promises.writeFile(filePath, code, { encoding: 'utf8', mode: 0o644 });

    // Java requirement: ensure class name Main if code doesn't have it -> NOTE: we won't alter code; assume author provides Main class
    // C++: compile step
    if (lang === 'cpp') {
      const compileCmd = ['/bin/sh', '-c', `g++ ${filename} -O2 -std=c++17 -o code_exec`];
      const compileRes = await spawnDocker(hostTmp, config[lang].image, compileCmd, { timeout: 20000, memory: `${memoryMB}m`, cpus: '0.5' });
      if (compileRes.timedOut) {
        return res.json({ verdict: 'CE', compileStderr: 'compile timed out', tests: [] });
      }
      if (compileRes.code !== 0) {
        return res.json({ verdict: 'CE', compileStderr: compileRes.stderr || 'compile failed', tests: [] });
      }
    } else if (lang === 'java') {
      // compile java
      const compileCmd = ['/bin/sh', '-c', `javac ${filename}`];
      const compileRes = await spawnDocker(hostTmp, config[lang].image, compileCmd, { timeout: 20000, memory: `${memoryMB}m`, cpus: '0.5' });
      if (compileRes.timedOut) {
        return res.json({ verdict: 'CE', compileStderr: 'javac timed out', tests: [] });
      }
      if (compileRes.code !== 0) {
        return res.json({ verdict: 'CE', compileStderr: compileRes.stderr || 'javac failed', tests: [] });
      }
    }

    // per-test execution
    const results = [];
    let overall = 'AC';
    for (let i = 0; i < tests.length; i++) {
      const t = tests[i];
      await fs.promises.writeFile(path.join(tmpDir, 'stdin.txt'), t.input, { encoding: 'utf8', mode: 0o600 });
      await fs.promises.writeFile(path.join(tmpDir, 'expected.txt'), t.expected, { encoding: 'utf8', mode: 0o600 });

      let runCmd;
      if (lang === 'python') {
        runCmd = ['/bin/sh', '-c', `python3 ${filename} < stdin.txt > out.txt`];
      } else if (lang === 'cpp') {
        runCmd = ['/bin/sh', '-c', `./code_exec < stdin.txt > out.txt`];
      } else if (lang === 'java') {
        // run Main class (assumes Main exists)
        runCmd = ['/bin/sh', '-c', `timeout ${Math.ceil(timeLimitMs / 1000) + 1}s java Main < stdin.txt > out.txt`];
        // Note: using timeout inside container is optional; we also rely on spawnDocker timeout
      } else {
        runCmd = ['/bin/sh', '-c', `echo "unsupported" > out.txt; exit 2`];
      }

      const perTestTimeout = Math.max(200, timeLimitMs || 2000);
      const runRes = await spawnDocker(hostTmp, config[lang].image, runCmd, { timeout: perTestTimeout + 500, memory: `${memoryMB}m`, cpus: '0.5' });

      // read produced output if any
      let produced = '';
      try {
        produced = await fs.promises.readFile(path.join(tmpDir, 'out.txt'), 'utf8');
      } catch (e) { produced = ''; }

      let verdict = 'AC';
      if (runRes.timedOut) {
        verdict = 'TLE';
      } else if (runRes.code !== 0) {
        // Non-zero exit; if produced empty and stderr exists => RE
        if (!produced) verdict = 'RE';
        else {
          // still compare produced to expected
          // fallthrough to compare
        }
      }

      if (verdict === 'AC' || verdict === 'RE') {
        const a = normalizeOutput(produced, compare);
        const b = normalizeOutput(t.expected, compare);
        if (a !== b) verdict = 'WA';
      }

      results.push({
        index: i,
        verdict,
        code: runRes.code,
        stderr: runRes.stderr ? runRes.stderr.slice(0, 4000) : '',
        produced: produced ? produced.slice(0, 2000) : ''
      });

      if (overall === 'AC' && verdict !== 'AC') overall = verdict;
      // 如果希望遇到第一个非 AC 就停止，把下面注释取消
      // if (overall !== 'AC') break;
    }

    return res.json({ verdict: overall, tests: results });

  } catch (err) {
    console.error('/api/submit error:', err);
    return res.status(500).json({ error: 'server error during judge' });
  } finally {
    // 永远清理临时目录（生产必须）
    try { await fs.promises.rm(tmpDir, { recursive: true, force: true }); } catch (e) {}
  }
});


// ---------- FAVORITES (per-language favorites tables) ----------
// helper: compute page_id from 1-based index
function computePageIdFromIndex(idx) {
  return Math.max(1, Math.ceil(idx / 5));
}

// POST /api/favorites
// body: { q_id, lang, unit_id, page_id? }
// If page_id not provided -> compute next page for the user+lang
app.post('/api/favorites', authMiddleware, async (req, res) => {
  const userId = req.user.id;
  let { q_id, lang, unit_id, page_id } = req.body || {};

  if (!q_id) return res.status(400).json({ error: 'q_id required' });
  if (!lang) return res.status(400).json({ error: 'lang required' });

  lang = String(lang).toLowerCase();
  const t = getTablesForLang(lang);
  if (!t) return res.status(400).json({ error: 'unsupported lang' });

  // normalize q_id: keep as string but also prepare numeric if possible
  const qidStr = String(q_id).trim();
  const qidNum = (/^\d+$/.test(qidStr) ? Number(qidStr) : null);
  const qidParam = (qidNum !== null) ? qidNum : qidStr;

  const conn = await pool.getConnection();
  try {
    await conn.beginTransaction();

    // --- VERIFY that q_id exists in either questions table or questions_exec table ---
    const questionsTable = t.questionsTable; // e.g. 'questions_py'
    const execTable = `${questionsTable}_exec`; // e.g. 'questions_py_exec'

    // check in main questions table
    let found = false;
    try {
      const [rowsQ] = await conn.query(`SELECT 1 FROM \`${questionsTable}\` WHERE q_id = ? LIMIT 1`, [qidParam]);
      if (Array.isArray(rowsQ) && rowsQ.length > 0) found = true;
    } catch (e) {
      // if table not exist or query fail, ignore here and try exec table
      // console.warn('check main questions table failed', e && e.message);
    }

    // if not found, check exec table
    if (!found) {
      try {
        const [rowsE] = await conn.query(`SELECT 1 FROM \`${execTable}\` WHERE q_id = ? LIMIT 1`, [qidParam]);
        if (Array.isArray(rowsE) && rowsE.length > 0) found = true;
      } catch (e) {
        // exec table might not exist for some langs; ignore
        // console.warn('check exec table failed', e && e.message);
      }
    }

    if (!found) {
      await conn.rollback().catch(()=>{});
      return res.status(400).json({ error: `q_id not found in questions for lang=${lang}` });
    }

    // If page_id explicitly provided and valid, use it; otherwise compute next page.
    let finalPageId = null;
    if (page_id != null) {
      finalPageId = Number(page_id) || 1;
    } else {
      // compute current count of favorites for user+lang
      const [cntRows] = await conn.query(`SELECT COUNT(*) AS cnt FROM \`${t.favoritesTable}\` WHERE user_id = ?`, [userId]);
      const cnt = (cntRows && cntRows[0] && cntRows[0].cnt) ? Number(cntRows[0].cnt) : 0;
      const nextIndex = cnt + 1;
      finalPageId = computePageIdFromIndex(nextIndex);
    }

    // Upsert. Requires UNIQUE(user_id, q_id) on favorites table.
    // Normalize unit_id to integer or NULL
    const unitIdParam = (unit_id != null && !isNaN(Number(unit_id))) ? Number(unit_id) : null;

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

    // 返回成功与分配到的 page_id（供前端刷新/校验）
    return res.json({ success: true, page_id: finalPageId });
  } catch (err) {
    await conn.rollback().catch(()=>{});
    console.error('POST /api/favorites error:', err && (err.message || err));
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
app.get('/api/favorites', authMiddleware, async (req, res) => {
  const userId = req.user.id;
  const lang = (req.query.lang || '').toLowerCase();
  const page = Math.max(1, parseInt(req.query.page, 10) || 1);

  const t = getTablesForLang(lang);
  if (!t) return res.status(400).json({ error: 'unsupported lang' });

  try {
    // 计算总数和总页数
    const [countRows] = await pool.query(
      `SELECT COUNT(*) AS cnt FROM \`${t.favoritesTable}\` WHERE user_id = ?`,
      [userId]
    );
    const total = countRows && countRows[0] ? Number(countRows[0].cnt || 0) : 0;
    const totalPages = Math.max(1, Math.ceil(total / 5));

    // 分页查询：左连接到两个题表（选择题与实操题），取第一个非空的题目文本/标题
    const offset = (page - 1) * 5;
    const questionsTable = t.questionsTable; // e.g. 'questions_py'
    const execTable = `${questionsTable}_exec`; // e.g. 'questions_py_exec'

    // NOTE:
    // - some rows may be from exec table, some from main questions.
    // - We try to select several useful fields and prefer main q.question_text or q.title, fallback to exec table fields.
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

    // Normalize each row to a predictable client shape
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
    console.error('GET /api/favorites error:', err && (err.message || err));
    res.status(500).json({ error: '服务器错误' });
  }
});


// DELETE /api/favorites/:identifier
// identifier may be q_id (string) — we attempt to delete that q_id in the given lang or across all langs
app.delete('/api/favorites/:identifier', authMiddleware, async (req, res) => {
  const userId = req.user.id;
  const identifier = req.params.identifier;
  const langParam = (typeof req.query.lang === 'string' && req.query.lang.trim()) ? req.query.lang.trim().toLowerCase() : null;

  if (!identifier) return res.status(400).json({ error: 'identifier required' });

  // define which languages to operate on
  const langsToProcess = langParam ? [langParam] : Object.keys(LANG_SUFFIX || {});

  try {
    for (const l of langsToProcess) {
      const t = getTablesForLang(l);
      if (!t) continue;

      const conn = await pool.getConnection();
      try {
        await conn.beginTransaction();

        // normalize identifier param (q_id could be numeric string)
        const idStr = String(identifier).trim();
        const idNum = (/^\d+$/.test(idStr) ? Number(idStr) : null);
        const idParam = (idNum !== null) ? idNum : idStr;

        // Delete favorites row(s) for this user and identifier (q_id)
        await conn.query(`DELETE FROM \`${t.favoritesTable}\` WHERE user_id = ? AND q_id = ?`, [userId, idParam]);

        // Reflow page_id: select remaining favorites for user ordered by created_at ASC (older first),
        // then set page_id = computePageIdFromIndex(index)
        const [rows] = await conn.query(`SELECT id FROM \`${t.favoritesTable}\` WHERE user_id = ? ORDER BY created_at ASC, id ASC`, [userId]);

        for (let i = 0; i < rows.length; i++) {
          const rid = rows[i].id;
          const newPage = computePageIdFromIndex(i + 1); // i is 0-based -> index = i+1
          await conn.query(`UPDATE \`${t.favoritesTable}\` SET page_id = ? WHERE id = ?`, [newPage, rid]);
        }

        await conn.commit();
      } catch (e) {
        await conn.rollback().catch(()=>{});
        console.error(`DELETE/REFLOW in ${t.favoritesTable} failed:`, e && (e.message || e));
        // continue to next lang (don't interrupt others)
      } finally {
        conn.release();
      }
    }

    return res.json({ success: true });
  } catch (err) {
    console.error('DELETE /api/favorites/:identifier error:', err && (err.message || err));
    return res.status(500).json({ error: err && err.message ? err.message : '删除收藏失败' });
  }
});


// ---------- PROGRESS (per-language progress tables) ----------
// GET /api/progress?lang=python
app.get('/api/progress', authMiddleware, async (req, res) => {
  const userId = req.user.id;
  const langParam = (typeof req.query.lang === 'string' && req.query.lang.trim()) ? req.query.lang.trim().toLowerCase() : null;
  try {
    if (langParam) {
      const t = getTablesForLang(langParam);
      if (!t) return res.status(400).json({ error: 'unsupported lang' });
      const [rows] = await pool.query(`SELECT id, user_id, unit_id, current_index, completed, updated_at FROM \`${t.progressTable}\` WHERE user_id = ? ORDER BY unit_id ASC`, [userId]);
      // annotate lang
      const parsed = (rows || []).map(r => (Object.assign({}, r, { lang: langParam })));
      return res.json(parsed);
    } else {
      // aggregate across all languages
      const out = [];
      for (const l of Object.keys(LANG_SUFFIX)) {
        const t = getTablesForLang(l);
        try {
          const [rows] = await pool.query(`SELECT id, user_id, unit_id, current_index, completed, updated_at FROM \`${t.progressTable}\` WHERE user_id = ? ORDER BY unit_id ASC`, [userId]);
          (rows || []).forEach(r => out.push(Object.assign({}, r, { lang: l })));
        } catch (e) {
          console.error(`GET progress for ${l} failed:`, e && e.message);
        }
      }
      // optionally sort by lang then unit
      out.sort((a,b) => a.lang.localeCompare(b.lang) || (a.unit_id - b.unit_id));
      return res.json(out);
    }
  } catch (err) {
    console.error('GET /api/progress error:', err);
    res.status(500).json({ error: err.message || '查询进度失败' });
  }
});
// GET /api/progress/:unitId?lang=python
app.get('/api/progress/:unitId', authMiddleware, async (req, res) => {
  const userId = req.user.id;
  const unitId = Number(req.params.unitId || 0);
  const langParam = (typeof req.query.lang === 'string' && req.query.lang.trim()) ? req.query.lang.trim().toLowerCase() : null;
  if (!unitId) return res.status(400).json({ error: 'unitId required' });

  try {
    if (langParam) {
      const t = getTablesForLang(langParam);
      if (!t) return res.status(400).json({ error: 'unsupported lang' });
      const [rows] = await pool.query(`SELECT id, user_id, unit_id, current_index, completed, updated_at FROM \`${t.progressTable}\` WHERE user_id = ? AND unit_id = ? LIMIT 1`, [userId, unitId]);
      return res.json(rows && rows.length ? Object.assign({}, rows[0], { lang: langParam }) : null);
    } else {
      // search across languages for the given unitId (return first found or null)
      for (const l of Object.keys(LANG_SUFFIX)) {
        const t = getTablesForLang(l);
        try {
          const [rows] = await pool.query(`SELECT id, user_id, unit_id, current_index, completed, updated_at FROM \`${t.progressTable}\` WHERE user_id = ? AND unit_id = ? LIMIT 1`, [userId, unitId]);
          if (rows && rows.length) return res.json(Object.assign({}, rows[0], { lang: l }));
        } catch (e) {
          console.error(`GET progress ${t.progressTable} failed:`, e && e.message);
        }
      }
      return res.json(null);
    }
  } catch (err) {
    console.error('GET /api/progress/:unitId error:', err);
    res.status(500).json({ error: err.message || '查询进度失败' });
  }
});
// POST /api/progress
// upsert 进度记录：body { unit_id, current_index, completed (0/1 or boolean), lang }
app.post('/api/progress', authMiddleware, async (req, res) => {
  const userId = req.user.id;
  const unit_id = Number(req.body.unit_id || 0);
  const current_index = Number(req.body.current_index || 0);
  const completedRaw = req.body.completed;
  const completed = (completedRaw === 1 || completedRaw === '1' || completedRaw === true) ? 1 : 0;
  const langParam = (typeof req.body.lang === 'string' && req.body.lang.trim()) ? req.body.lang.trim().toLowerCase() : null;

  if (!unit_id || !langParam) {
    return res.status(400).json({ error: 'unit_id and lang are required' });
  }

  try {
    const t = getTablesForLang(langParam);
    if (!t) return res.status(400).json({ error: 'unsupported lang' });

    // Ensure (user_id, unit_id) unique index exists in progress table to allow on duplicate update
    const [result] = await pool.query(
      `INSERT INTO \`${t.progressTable}\` (user_id, unit_id, current_index, completed, updated_at)
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
    res.status(500).json({ error: err.message || '保存进度失败' });
  }
});


// ---------- INVITE (register bonus) ----------
app.post('/api/invite', authMiddleware, async (req, res) => {
  const referrer = (req.body && req.body.referrer || '').trim();
  if (!referrer) return res.status(400).json({ error: 'referrer required' });

  try {
    const [rows] = await pool.query('SELECT id FROM users WHERE username = ? LIMIT 1', [referrer]);
    if (!rows.length) return res.status(404).json({ error: 'referrer not found' });

    const referrerId = rows[0].id;
    const [mRows] = await pool.query('SELECT end_at FROM memberships WHERE user_id = ? ORDER BY end_at DESC LIMIT 1', [referrerId]);
    const existingEnd = (mRows && mRows[0] && mRows[0].end_at) ? new Date(mRows[0].end_at) : null;

    let startAt = new Date();
    if (existingEnd && existingEnd > startAt) startAt = existingEnd;
    const endAt = new Date(startAt);
    endAt.setMonth(endAt.getMonth() + 1);

    await pool.query('INSERT INTO memberships (user_id, start_at, end_at, source) VALUES (?, ?, ?, ?)', [
      referrerId, startAt, endAt, 'invite_bonus'
    ]);

    return res.json({ success: true, grantedTo: referrer, start_at: toISO(startAt), end_at: toISO(endAt) });
  } catch (err) {
    console.error('POST /api/invite error:', err);
    return res.status(500).json({ error: 'server error' });
  }
});

// ---------- ME ----------
app.get('/api/me', authMiddleware, async (req, res) => {
  const userId = req.user.id;
  try {
    const [rows] = await pool.query('SELECT id, username, created_at FROM users WHERE id = ? LIMIT 1', [userId]);
    if (!rows.length) return res.status(404).json({ error: 'user not found' });

    let membership = null;
    try {
      const [mRows] = await pool.query('SELECT start_at, end_at, source FROM memberships WHERE user_id = ? ORDER BY end_at DESC LIMIT 1', [userId]);
      if (mRows && mRows[0]) {
        membership = { start_at: toISO(mRows[0].start_at), end_at: toISO(mRows[0].end_at), source: mRows[0].source || null };
      }
    } catch (e) {
      membership = null;
    }

    res.json({ id: rows[0].id, username: rows[0].username, created_at: toISO(rows[0].created_at), membership });
  } catch (err) {
    console.error('/api/me error', err);
    res.status(500).json({ error: 'server error' });
  }
});

// ---------- MEMBERSHIP ----------
app.get('/api/membership', authMiddleware, async (req, res) => {
  try {
    const [rows] = await pool.query(
      `SELECT start_at, end_at, source FROM memberships WHERE user_id=? ORDER BY end_at DESC LIMIT 1`,
      [req.user.id]
    );
    if (rows.length === 0) return res.json({});
    res.json({ start_at: toISO(rows[0].start_at), end_at: toISO(rows[0].end_at), source: rows[0].source });
  } catch (e) {
    console.error('/api/membership error:', e);
    res.status(500).json({ error: '获取会员信息失败' });
  }
});


const ALLOWED_DIFFICULTIES = new Set(['beginner', 'intermediate', 'advanced']);

// ---------- LIBRARY (list with pagination, search, filter) ----------
app.get('/api/library', async (req, res) => {
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
      // JSON_SEARCH(tags, "one", ?) 返回 NULL 或路径
      where.push('(title LIKE ? OR summary LIKE ? OR JSON_SEARCH(tags, "one", ?) IS NOT NULL)');
      const like = `%${q}%`;
      params.push(like, like, q);
    }

    const whereSQL = where.length ? ('WHERE ' + where.join(' AND ')) : '';

    // 总数
    const [countRows] = await pool.query(`SELECT COUNT(1) AS total FROM library ${whereSQL}`, params);
    const total = (countRows && countRows[0] && countRows[0].total) ? Number(countRows[0].total) : 0;

    // 列表：按 id 降序（因为表中没有 updated_at/created_at 字段）
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
    console.error('GET /api/library error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

// ---------- LIBRARY favorites (per-user, uses lang+lb_id to join) ----------
app.get('/api/library/favorites', authMiddleware, async (req, res) => {
  const userId = req.user && req.user.id;
  if (!userId) return res.status(401).json({ error: '未登录' });

  try {
    // 用 f.lang + f.lb_id 去 join library，返回最新的 library 信息（若 library 被删除将不会出现在结果中）
    const [rows] = await pool.query(
      `SELECT l.id AS id, l.lang AS lang, l.lb_id AS lb_id, l.title AS title, l.summary AS summary, l.difficulty AS difficulty, f.created_at AS favorited_at
       FROM library_favorites f
       JOIN library l ON f.lang = l.lang AND f.lb_id = l.lb_id
       WHERE f.user_id = ?
       ORDER BY f.created_at DESC`,
      [userId]
    );

    const out = rows.map(r => ({
      id: r.id,                 // library.id
      lang: r.lang,
      lb_id: r.lb_id,
      title: r.title,
      summary: r.summary,
      difficulty: r.difficulty,
      favorited_at: r.favorited_at
    }));

    res.json(out);
  } catch (err) {
    console.error('GET /api/library/favorites error:', err);
    res.status(500).json({ error: '获取收藏失败' });
  }
});

// ---------- add/update favorite ----------
app.post('/api/library/favorite', authMiddleware, async (req, res) => {
  const userId = req.user && req.user.id;
  if (!userId) return res.status(401).json({ error: '未登录' });

  try {
    // 支持两种请求体形式：
    // 1) { id: <library.id> }  或
    // 2) { lang: 'python', lb_id: 5 }
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

    // 先查是否存在（按 user_id + lang + lb_id 唯一识别）
    const [exists] = await pool.query('SELECT id FROM library_favorites WHERE user_id = ? AND lang = ? AND lb_id = ? LIMIT 1', [userId, lang, lb_id]);
    if (exists && exists.length) {
      // 如果已存在，更新 created_at（刷新收藏时间）和可能的 title/page 快照
      await pool.query('UPDATE library_favorites SET created_at = CURRENT_TIMESTAMP, title = ?, page = ? WHERE id = ?', [title, libPage, exists[0].id]);
    } else {
      // 插入新收藏（created_at 由 DB 默认填充）
      await pool.query('INSERT INTO library_favorites (user_id, lang, lb_id, title, page) VALUES (?, ?, ?, ?, ?)', [userId, lang, lb_id, title, libPage]);
    }

    res.json({ success: true });
  } catch (err) {
    console.error('POST /api/library/favorite error:', err);
    res.status(500).json({ error: '添加收藏失败' });
  }
});

// ---------- delete favorite by library.id (frontend passes library.id) ----------
app.delete('/api/library/favorite/:id', authMiddleware, async (req, res) => {
  const userId = req.user && req.user.id;
  if (!userId) return res.status(401).json({ error: '未登录' });

  const libraryId = Number(req.params.id);
  if (!libraryId) return res.status(400).json({ error: '非法 id' });

  try {
    // 找到对应的 lang + lb_id
    const [r] = await pool.query('SELECT lang, lb_id FROM library WHERE id = ? LIMIT 1', [libraryId]);
    if (!r || !r.length) return res.status(404).json({ error: 'topic not found' });
    const { lang, lb_id } = r[0];

    await pool.query('DELETE FROM library_favorites WHERE user_id = ? AND lang = ? AND lb_id = ?', [userId, lang, lb_id]);
    res.json({ success: true });
  } catch (err) {
    console.error('DELETE /api/library/favorite/:id error:', err);
    res.status(500).json({ error: '删除收藏失败' });
  }
});

// ---------- LIBRARY detail ----------
app.get('/api/library/:id', async (req, res) => {
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
    console.error('GET /api/library/:id error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});


// ---------- FRIENDS & FRIEND REQUESTS (按照你提供的逻辑) ----------

// 获取好友列表（从 friends 表查询，返回另一端用户信息）
app.get('/api/friends', authMiddleware, async (req, res) => {
  const userId = req.user.id;
  try {
    const [rows] = await pool.query(
      `SELECT u.id, u.username, u.created_at
       FROM friends f
       JOIN users u ON (CASE WHEN f.user_id = ? THEN f.friend_id ELSE f.user_id END) = u.id
       WHERE f.user_id = ? OR f.friend_id = ?
       ORDER BY f.created_at DESC`,
      [userId, userId, userId]
    );
    res.json(rows);
  } catch (err) {
    console.error('GET /api/friends error', err);
    res.status(500).json({ error: '获取好友失败' });
  }
});

// 1) 新增：批量检查与当前用户的关系状态（用于前端在一批 search results 上做标记）
app.get('/api/friends/statuses', authMiddleware, async (req, res) => {
  try {
    const me = Number(req.user.id);
    const ids = parseIdsParam(req.query.ids || req.query.ids_list || req.query.q || req.query.ids);
    if (!ids.length) return res.json([]);

    // 去重并排除自己
    const uniqueIds = Array.from(new Set(ids)).filter(i => i !== me);
    if (!uniqueIds.length) return res.json([]);

    const placeholders = uniqueIds.map(() => '?').join(',');

    // 1) 查 friends 表是否为好友（任意方向）
    const [friendsRows] = await pool.query(
      `SELECT user_id, friend_id FROM friends
       WHERE (user_id = ? AND friend_id IN (${placeholders}))
          OR (friend_id = ? AND user_id IN (${placeholders}))`,
      [me, ...uniqueIds, me, ...uniqueIds]
    );

    // 2) 查 pending requests 我发出的（pending_sent）
    const [pendingSentRows] = await pool.query(
      `SELECT to_id AS id, id AS requestId FROM friend_requests WHERE from_id = ? AND to_id IN (${placeholders}) AND status = 'pending'`,
      [me, ...uniqueIds]
    );

    // 3) 查 pending requests 我收到的（pending_received）
    const [pendingRecvRows] = await pool.query(
      `SELECT from_id AS id, id AS requestId FROM friend_requests WHERE to_id = ? AND from_id IN (${placeholders}) AND status = 'pending'`,
      [me, ...uniqueIds]
    );

    // Build maps for quick lookup
    const friendSet = new Set(friendsRows.map(r => (r.user_id === me ? r.friend_id : r.user_id)));
    const sentMap = new Map(pendingSentRows.map(r => [r.id, r.requestId]));
    const recvMap = new Map(pendingRecvRows.map(r => [r.id, r.requestId]));

    const result = uniqueIds.map(id => {
      if (friendSet.has(id)) return { id, status: 'accepted' };
      if (sentMap.has(id)) return { id, status: 'pending_sent', requestId: sentMap.get(id) };
      if (recvMap.has(id)) return { id, status: 'pending_received', requestId: recvMap.get(id) };
      return { id, status: 'none' };
    });

    return res.json(result);
  } catch (err) {
    console.error('GET /api/friends/statuses error', err);
    res.status(500).json({ error: '检查关系状态失败' });
  }
});

// 2) 发送好友请求（A -> B）
app.post('/api/friends/request', authMiddleware, async (req, res) => {
  try {
    const fromId = Number(req.user.id);
    const toUserId = Number(req.body.toUserId ?? req.body.to_id ?? req.body.toId);

    if (!toUserId) return res.status(400).json({ error: 'toUserId 必须提供' });
    if (toUserId === fromId) return res.status(400).json({ error: '不能添加自己为好友' });

    // 检查目标用户存在
    const [uRows] = await pool.query('SELECT id FROM users WHERE id = ? LIMIT 1', [toUserId]);
    if (!uRows.length) return res.status(404).json({ error: '目标用户不存在' });

    // 检查是否已经是好友（friends 表）
    const [fRows] = await pool.query(
      `SELECT id FROM friends WHERE (user_id = ? AND friend_id = ?) OR (user_id = ? AND friend_id = ?) LIMIT 1`,
      [fromId, toUserId, toUserId, fromId]
    );
    if (fRows.length) return res.status(400).json({ error: '你们已经是好友' });

    // 检查是否已有尚未处理的 pending（同向 from->to），如果有禁止重复发送
    const [pendingRows] = await pool.query(
      `SELECT id, status FROM friend_requests WHERE from_id = ? AND to_id = ? ORDER BY id DESC LIMIT 1`,
      [fromId, toUserId]
    );
    if (pendingRows.length && pendingRows[0].status === 'pending') {
      return res.status(400).json({ error: '请求已存在（待对方处理）' });
    }

    // 允许插入新请求（无论之前被拒绝还是不存在），以保留历史
    const [r] = await pool.query(
      `INSERT INTO friend_requests (from_id, to_id, status) VALUES (?, ?, 'pending')`,
      [fromId, toUserId]
    );

    return res.json({ message: '好友请求已发送', requestId: r.insertId });
  } catch (err) {
    console.error('POST /api/friends/request error', err);
    res.status(500).json({ error: '发送好友请求失败' });
  }
});

// Helper: parse ids list from query param
function parseIdsParam(str) {
  if (!str) return [];
  return String(str).split(',').map(s => Number(s)).filter(n => !Number.isNaN(n) && n > 0);
}

// 获取收到的好友请求（pending）
app.get('/api/friends/requests', authMiddleware, async (req, res) => {
  try {
    const userId = Number(req.user.id);
    const [rows] = await pool.query(
      `SELECT fr.id, fr.from_id, u.username, fr.status, fr.created_at, fr.updated_at
       FROM friend_requests fr
       JOIN users u ON u.id = fr.from_id
       WHERE fr.to_id = ? AND fr.status = 'pending'
       ORDER BY fr.created_at DESC`,
      [userId]
    );
    res.json(rows);
  } catch (err) {
    console.error('GET /api/friends/requests error', err);
    res.status(500).json({ error: '获取好友请求失败' });
  }
});

// 搜索用户（兼容 q 或 keyword，显示 id + username）
app.get('/api/users/search', authMiddleware, async (req, res) => {
  try {
    const q = (req.query.q || req.query.keyword || '').trim();
    if (!q) return res.json([]);

    if (/^\d+$/.test(q)) {
      // 按 id 精准查
      const [rows] = await pool.query('SELECT id, username FROM users WHERE id = ? LIMIT 1', [Number(q)]);
      return res.json(rows);
    } else {
      const like = `%${q}%`;
      const [rows] = await pool.query('SELECT id, username FROM users WHERE username LIKE ? LIMIT 50', [like]);
      return res.json(rows);
    }
  } catch (err) {
    console.error('GET /api/users/search error', err);
    res.status(500).json({ error: '用户搜索失败' });
  }
});

// 发送好友请求（from = 当前用户，toUserId 来自 body）
app.post('/api/friends/request', authMiddleware, async (req, res) => {
  const fromId = req.user.id;
  const toUserId = Number(req.body.toUserId || req.body.to_id || req.body.toId);

  if (!toUserId) return res.status(400).json({ error: 'toUserId 必须提供' });
  if (toUserId === fromId) return res.status(400).json({ error: '不能添加自己为好友' });

  try {
    // 1) 检查目标用户存在
    const [uRows] = await pool.query('SELECT id FROM users WHERE id = ? LIMIT 1', [toUserId]);
    if (!uRows.length) return res.status(404).json({ error: '目标用户不存在' });

    // 2) 检查是否已在 friends 表（已经是好友）
    const [fRows] = await pool.query(
      `SELECT id FROM friends WHERE (user_id = ? AND friend_id = ?) OR (user_id = ? AND friend_id = ?) LIMIT 1`,
      [fromId, toUserId, toUserId, fromId]
    );
    if (fRows.length) return res.status(400).json({ error: '你们已经是好友' });

    // 3) 检查 friend_requests 表里是否已有记录
    const [rRows] = await pool.query(
      `SELECT id, status FROM friend_requests WHERE from_id = ? AND to_id = ? ORDER BY id DESC LIMIT 1`,
      [fromId, toUserId]
    );

    if (rRows.length) {
      const st = rRows[0].status;
      if (st === 'pending') {
        return res.status(400).json({ error: '请求已存在（待对方处理）' });
      }
      if (st === 'accepted') {
        return res.status(400).json({ error: '你们已经是好友' });
      }
      if (st === 'rejected') {
        // 重发：把最近一条更新为 pending（保留历史记录也可，当前选择更新最新一条）
        await pool.query('UPDATE friend_requests SET status = ?, updated_at = NOW() WHERE id = ?', ['pending', rRows[0].id]);
        return res.json({ message: '好友请求已重新发送' });
      }
    }

    // 4) 若没有历史记录，插入一条新的 pending
    await pool.query('INSERT INTO friend_requests (from_id, to_id, status) VALUES (?, ?, ?)', [fromId, toUserId, 'pending']);
    res.json({ message: '好友请求已发送' });
  } catch (err) {
    console.error('POST /api/friends/request error', err);
    res.status(500).json({ error: '发送好友请求失败' });
  }
});

// 处理好友请求（接受或拒绝）
app.post('/api/friends/respond', authMiddleware, async (req, res) => {
  const userId = Number(req.user.id);
  const requestId = Number(req.body.requestId);
  const accept = !!req.body.accept;

  if (!requestId) return res.status(400).json({ error: 'requestId 必须提供' });

  try {
    // 查询请求
    const [rows] = await pool.query('SELECT * FROM friend_requests WHERE id = ? LIMIT 1', [requestId]);
    if (!rows.length) return res.status(404).json({ error: '请求不存在' });
    const reqRow = rows[0];

    if (Number(reqRow.to_id) !== userId) return res.status(403).json({ error: '无权处理该请求' });

    if (!accept) {
      // 拒绝：只更新当前请求的 status（保留记录）
      await pool.query('UPDATE friend_requests SET status = ?, updated_at = NOW() WHERE id = ?', ['rejected', requestId]);
      return res.json({ message: '已拒绝好友请求' });
    }

    // 接受：事务中 update request.status = accepted + 在 friends 表插入一行（若尚未存在）
    const conn = await pool.getConnection();
    try {
      await conn.beginTransaction();

      const fromId = Number(reqRow.from_id);
      const toId = Number(reqRow.to_id);

      // 再次检查是否已是好友（防并发）
      const [already] = await conn.query(
        `SELECT id FROM friends WHERE (user_id = ? AND friend_id = ?) OR (user_id = ? AND friend_id = ?) LIMIT 1`,
        [fromId, toId, toId, fromId]
      );

      // 更新请求行为 accepted
      await conn.query('UPDATE friend_requests SET status = ?, updated_at = NOW() WHERE id = ?', ['accepted', requestId]);

      if (!already.length) {
        // 插入 friends (A as user_id, B as friend_id)
        await conn.query('INSERT INTO friends (user_id, friend_id) VALUES (?, ?)', [fromId, toId]);
      }

      await conn.commit();
      conn.release();
      return res.json({ message: '好友请求已同意' });
    } catch (txErr) {
      await conn.rollback();
      conn.release();
      console.error('transaction respond error', txErr);
      return res.status(500).json({ error: '处理请求失败' });
    }
  } catch (err) {
    console.error('POST /api/friends.respond error', err);
    res.status(500).json({ error: '处理好友请求失败' });
  }
});

// 删除好友（任一方向）
app.delete('/api/friends/:id', authMiddleware, async (req, res) => {
  try {
    const userId = Number(req.user.id);
    const friendId = Number(req.params.id);
    if (!friendId || friendId === userId) return res.status(400).json({ error: '非法好友 ID' });

    const [result] = await pool.query(
      `DELETE FROM friends WHERE (user_id = ? AND friend_id = ?) OR (user_id = ? AND friend_id = ?)`,
      [userId, friendId, friendId, userId]
    );

    if (result.affectedRows === 0) {
      return res.status(404).json({ error: '未找到好友关系' });
    }
    return res.json({ success: true });
  } catch (err) {
    console.error('DELETE /api/friends/:id error', err);
    res.status(500).json({ error: '删除好友失败' });
  }
});

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

async function refreshUserEnergy(userId, pool) {
  const [rows] = await pool.query('SELECT energy, last_energy_update FROM users WHERE id = ?', [userId]);
  if (!rows || rows.length === 0) throw new Error('User not found');

  let energy = Number(rows[0].energy || 0);
  const lastStr = rows[0].last_energy_update;
  let lastDate = lastStr ? new Date(lastStr + "Z") : new Date();
  if (isNaN(lastDate.getTime())) lastDate = new Date();

  const now = new Date();
  const nowMs = now.getTime();
  let lastMs = lastDate.getTime();

  // 计算已恢复点数
  const diffMs = nowMs - lastMs;
  const recovered = Math.floor(diffMs / RECOVER_INTERVAL_MS);

  // 只有当确实有恢复且当前并未满才写回 DB
  if (recovered > 0 && energy < MAX_ENERGY) {
    const newEnergy = Math.min(MAX_ENERGY, energy + recovered);
    const appliedLastMs = lastMs + recovered * RECOVER_INTERVAL_MS;
    const appliedLastSQL = toSQLDateTime(new Date(appliedLastMs));

    if (newEnergy !== energy) {
      await pool.query('UPDATE users SET energy = ?, last_energy_update = ? WHERE id = ?', [newEnergy, appliedLastSQL, userId]);
      energy = newEnergy;
      lastMs = appliedLastMs;
    }
  }

  let secondsToNext = null;
  if (energy < MAX_ENERGY) {
    const elapsedSinceLast = nowMs - lastMs;
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
app.post('/api/user/use-energy', authMiddleware, async (req, res) => {
  const amount = parseInt(req.body && req.body.amount, 10) || 1;
  if (amount <= 0) return res.status(400).json({ error: 'amount 必须为正数' });

  const CHECKIN_THRESHOLD = 20; // 打卡阈值（每日）
  const MAX_ENERGY_CONST = (typeof MAX_ENERGY !== 'undefined' ? MAX_ENERGY : 100); // 你的全局常量或默认值

  let conn;
  try {
    conn = await pool.getConnection();
    await conn.beginTransaction();

    // 1) 锁定 users 行并读取当前能量
    const [userRows] = await conn.query('SELECT energy, last_energy_update FROM users WHERE id = ? FOR UPDATE', [req.user.id]);
    if (!userRows || userRows.length === 0) {
      await conn.rollback();
      return res.status(404).json({ error: '用户未找到' });
    }

    // 2) 是否为 VIP（membership 表）
    const [mbRows] = await conn.query('SELECT 1 FROM memberships WHERE user_id = ? AND end_at > NOW() LIMIT 1', [req.user.id]);
    const isVip = (mbRows && mbRows.length > 0);

    let energyAfter = Number(userRows[0].energy || 0);
    const MAX_ENERGY = MAX_ENERGY_CONST;

    // 3) 非 VIP -> 恢复并扣减能量（保持你原来的恢复算法）
    if (!isVip) {
      let lastStr = userRows[0].last_energy_update;
      let lastDate = lastStr ? new Date(lastStr + "Z") : new Date();
      if (isNaN(lastDate.getTime())) lastDate = new Date();

      const now = new Date();
      const nowMs = now.getTime();
      let lastMs = lastDate.getTime();

      const diffMs = nowMs - lastMs;
      const recovered = Math.floor(diffMs / RECOVER_INTERVAL_MS);
      if (recovered > 0 && energyAfter < MAX_ENERGY) {
        energyAfter = Math.min(MAX_ENERGY, energyAfter + recovered);
        lastMs = lastMs + recovered * RECOVER_INTERVAL_MS;
      }

      if (energyAfter < amount) {
        await conn.rollback();
        return res.status(400).json({ error: '能量不足', energy: energyAfter, maxEnergy: MAX_ENERGY });
      }

      const energyBeforeDeduction = energyAfter;
      energyAfter = energyAfter - amount;

      let lastToWriteMs;
      if (energyBeforeDeduction >= MAX_ENERGY) {
        lastToWriteMs = nowMs;
      } else {
        lastToWriteMs = lastMs;
      }
      // 写回 users.last_energy_update（还是用后端时间格式：DATETIME 字符串）
      const lastSQL = (new Date(lastToWriteMs)).toISOString().slice(0, 19).replace('T', ' ');
      await conn.query('UPDATE users SET energy = ?, last_energy_update = ? WHERE id = ?', [energyAfter, lastSQL, req.user.id]);
    } else {
      // VIP: 不更改 users.energy（保持原值），但仍需要记录到 energy_daily
      energyAfter = Number(userRows[0].energy || 0);
    }

    // 4) 原子地更新 energy_daily（使用 DB 的 CURDATE()，避免 JS 日期判断）
    //    需要 energy_daily 对 user_id 有 UNIQUE 索引
    // 插入或累加 cost_today，并把 last_update 置为当天日期（CURDATE()）
    await conn.query(
      `INSERT INTO energy_daily (user_id, cost_today, last_update)
       VALUES (?, ?, CURDATE())
       ON DUPLICATE KEY UPDATE
         cost_today = cost_today + VALUES(cost_today),
         last_update = CURDATE()`,
      [req.user.id, amount]
    );

    // 5) 读取更新后的 cost_today（在同一事务内）
    const [edRowsAfter] = await conn.query('SELECT cost_today FROM energy_daily WHERE user_id = ? LIMIT 1', [req.user.id]);
    const costToday = (edRowsAfter && edRowsAfter[0]) ? Number(edRowsAfter[0].cost_today || 0) : amount;

    // 6) 如果达到阈值并且当天还没有打卡记录 -> 插入 checkin_records（使用 CURDATE()）
    if (costToday >= CHECKIN_THRESHOLD) {
      // 依赖 UNIQUE(user_id,date) 约束；用 INSERT IGNORE 防止重复
      await conn.query(
        `INSERT IGNORE INTO checkin_records (user_id, date)
         VALUES (?, CURDATE())`,
        [req.user.id]
      );
      // 如果你想拿到新插入的 id，可以 SELECT LAST_INSERT_ID() 之类，但 INSERT IGNORE 不会返回插入 id 当未插入
    }

    await conn.commit();

    // 返回给前端：包含当前 daily 成本（cost_today）
    return res.json({
      energy: isVip ? energyAfter : energyAfter,
      maxEnergy: MAX_ENERGY,
      cost_today: costToday,
      threshold: CHECKIN_THRESHOLD,
      isVip: !!isVip
    });

  } catch (err) {
    if (conn) try { await conn.rollback(); } catch (e) {}
    console.error('POST /api/user/use-energy error', err);
    return res.status(500).json({ error: '扣减能量失败' });
  } finally {
    if (conn) conn.release();
  }
});


// ---------- PORT ----------
const port = process.env.PORT || 5000;
app.listen(port, () => console.log(`YProgram backend running on http://localhost:${port}`));
