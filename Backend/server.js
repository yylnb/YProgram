// server.js
const express = require('express');
const cors = require('cors');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { pool, poolQuestions } = require('./db'); // mysql2/promise pool
// console.log('db export =', require('./db'));
// const pool = require('./db'); 
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

const libraryRouter = require('./library')(pool, authMiddleware);
app.use('/api/library', libraryRouter);

const progressRouter = require('./progress')(poolQuestions, authMiddleware);
app.use('/api/progress', progressRouter);

const friendsRouter = require('./friends')(pool, authMiddleware);
app.use('/api/friends', friendsRouter);

const favoritesRouter = require('./favorites')(pool, authMiddleware);
app.use('/api/favorites', favoritesRouter);

const userRouter = require('./user')(pool, authMiddleware, { JWT_SECRET: process.env.JWT_SECRET });
app.use('/api/user', userRouter);

const questionRoutes = require('./questions')(poolQuestions, authMiddleware);
app.use('/api/question', questionRoutes);


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
// app.get('/api/questions', async (req, res) => {
//   const unit = Number(req.query.unit || 0);
//   const langParam = (typeof req.query.lang === 'string' && req.query.lang.trim()) ? req.query.lang.trim().toLowerCase() : null;
//   const userId = req.user?.id; // 假设JWT里有用户ID
//   try {
//     // 检查会员有效性
//     let isVip = false;
//     if (userId) {
//       const [membershipRows] = await pool.query(
//         'SELECT 1 FROM memberships WHERE user_id = ? AND end_at > NOW() LIMIT 1',
//         [userId]
//       );
//       if (membershipRows.length > 0) {
//         isVip = true;
//       }
//     }

//     if (unit > 0) {
//       if (langParam) {
//         // specific language table
//         const t = getTablesForLang(langParam);
//         if (!t) return res.status(400).json({ error: 'unsupported lang' });
//         const sql = `SELECT id AS db_id, q_id, unit_id, title, question_text, options, answer, hints, explanation, example, created_at, energy FROM \`${t.questionsTable}\` WHERE unit_id = ? ORDER BY id ASC`;
//         const [rows] = await pool.query(sql, [unit]);
//         const parsed = rows.map(r => ({
//           db_id: r.db_id,
//           q_id: r.q_id != null ? String(r.q_id) : null,
//           unit_id: r.unit_id,
//           title: r.title,
//           text: r.question_text,
//           options: safeParseJSON(r.options) || [],
//           answer: r.answer,
//           hints: safeParseJSON(r.hints) || [],
//           explanation: r.explanation,
//           example: r.example,
//           lang: t.langKey,
//           created_at: r.created_at,
//           energy: isVip ? 0 : r.energy
//         }));
//         return res.json(parsed);
//       } else {
//         // no lang: aggregate across all language question tables (may be slower)
//         const results = [];
//         for (const l of Object.keys(LANG_SUFFIX)) {
//           const t = getTablesForLang(l);
//           const sql = `SELECT id AS db_id, q_id, unit_id, title, question_text, options, answer, hints, explanation, example, created_at, energy FROM \`${t.questionsTable}\` WHERE unit_id = ? ORDER BY id ASC`;
//           try {
//             const [rows] = await pool.query(sql, [unit]);
//             rows.forEach(r => {
//               results.push({
//                 db_id: r.db_id,
//                 q_id: r.q_id != null ? String(r.q_id) : null,
//                 unit_id: r.unit_id,
//                 title: r.title,
//                 text: r.question_text,
//                 options: safeParseJSON(r.options) || [],
//                 answer: r.answer,
//                 hints: safeParseJSON(r.hints) || [],
//                 explanation: r.explanation,
//                 example: r.example,
//                 lang: l,
//                 created_at: r.created_at,
//                 energy: isVip ? 0 : r.energy
//               });
//             });
//           } catch (e) {
//             // ignore per-lang errors but log
//             console.error(`query ${t.questionsTable} failed:`, e && e.message);
//           }
//         }
//         // optional: sort by lang then db_id for stable order
//         results.sort((a, b) => (a.lang === b.lang ? (Number(a.db_id || 0) - Number(b.db_id || 0)) : a.lang.localeCompare(b.lang)));
//         return res.json(results);
//       }
//     } else {
//       // unit not provided -> return listing (limit, optional lang)
//       const limit = Number(req.query.limit) || 50;
//       if (langParam) {
//         const t = getTablesForLang(langParam);
//         if (!t) return res.status(400).json({ error: 'unsupported lang' });
//         const [rows] = await pool.query(
//           `SELECT id AS db_id, q_id, unit_id, title, created_at FROM \`${t.questionsTable}\` ORDER BY unit_id ASC, id ASC LIMIT ?`,
//           [limit]
//         );
//         return res.json(rows.map(r => ({
//           db_id: r.db_id,
//           q_id: r.q_id != null ? String(r.q_id) : null,
//           unit_id: r.unit_id,
//           title: r.title,
//           lang: langParam,
//           created_at: r.created_at,
//           energy: isVip ? 0 : undefined
//         })));
//       } else {
//         // aggregate across languages for directory
//         const out = [];
//         for (const l of Object.keys(LANG_SUFFIX)) {
//           const t = getTablesForLang(l);
//           try {
//             const [rows] = await pool.query(`SELECT id AS db_id, q_id, unit_id, title, created_at FROM \`${t.questionsTable}\` ORDER BY unit_id ASC, id ASC LIMIT ?`, [limit]);
//             rows.forEach(r => out.push({
//               db_id: r.db_id,
//               q_id: r.q_id != null ? String(r.q_id) : null,
//               unit_id: r.unit_id,
//               title: r.title,
//               lang: l,
//               created_at: r.created_at,
//               energy: isVip ? 0 : undefined
//             }));
//           } catch (e) {
//             console.error(`list ${t.questionsTable} failed:`, e && e.message);
//           }
//         }
//         // optional sort by lang, unit_id
//         out.sort((a,b) => a.lang.localeCompare(b.lang) || (a.unit_id - b.unit_id));
//         return res.json(out.slice(0, limit));
//       }
//     }
//   } catch (err) {
//     console.error('GET /api/questions error:', err);
//     res.status(500).json({ error: err.message || '数据库查询失败' });
//   }
// });

// ---------- QUESTIONS_EXEC (实操题) ----------
// GET /api/questions_exec?unit=12&lang=python
// app.get('/api/questions_exec', async (req, res) => {
//   const unit = Number(req.query.unit || 0);
//   const langParam = (typeof req.query.lang === 'string' && req.query.lang.trim()) ? req.query.lang.trim().toLowerCase() : null;
//   const limit = Number(req.query.limit || 200);
//   const userId = req.user?.id;

//   // hints 解析
//   function safeParseHints(v) {
//     if (v == null) return [];
//     if (Array.isArray(v)) return v;
//     try {
//       const parsed = JSON.parse(String(v));
//       if (Array.isArray(parsed)) return parsed;
//       if (typeof parsed === 'string') return [parsed];
//       return [String(parsed)];
//     } catch (e) {
//       const s = String(v || '').trim();
//       if (!s) return [];
//       return s.split(',').map(x => x.trim()).filter(Boolean);
//     }
//   }

//   // link 解析：尝试 JSON.parse，否则保留字符串/null
//   function parseLinkField(raw) {
//     if (raw == null) return null;
//     if (Array.isArray(raw) || typeof raw === 'object') return raw;
//     if (typeof raw === 'string') {
//       const s = raw.trim();
//       if (!s) return null;
//       try { return JSON.parse(s); } catch (e) { return s; }
//     }
//     return raw;
//   }

//   // 把 db 的示例字段统一成字符串 (若为 JSON 数组字符串 -> join 行；对象 -> JSON.stringify)
//   function stringifyExampleField(v) {
//     if (v == null) return null;
//     // 如果已经是数组
//     if (Array.isArray(v)) return v.map(x => (x == null ? '' : String(x))).join('\n');
//     if (typeof v === 'string') {
//       const s = v.trim();
//       if (!s) return null;
//       try {
//         const parsed = JSON.parse(s);
//         if (Array.isArray(parsed)) return parsed.map(x => (x == null ? '' : String(x))).join('\n');
//         if (typeof parsed === 'object') return JSON.stringify(parsed);
//         return String(parsed);
//       } catch (e) {
//         return s;
//       }
//     }
//     if (typeof v === 'object') {
//       try { return JSON.stringify(v); } catch (e) { return String(v); }
//     }
//     return String(v);
//   }

//   try {
//     // 会员判断（与其它路由一致）
//     let isVip = false;
//     if (userId) {
//       const [membershipRows] = await pool.query(
//         'SELECT 1 FROM memberships WHERE user_id = ? AND end_at > NOW() LIMIT 1',
//         [userId]
//       );
//       if (membershipRows && membershipRows.length > 0) isVip = true;
//     }

//     function execTableFor(t) {
//       if (!t || !t.questionsTable) return null;
//       if (t.questionsTable.endsWith('_exec')) return t.questionsTable;
//       return `${t.questionsTable}_exec`;
//     }

//     // 如果提供 unit -> 返回该 unit 的实操题（按 lang 或聚合）
//     if (unit > 0) {
//       if (langParam) {
//         const t = getTablesForLang(langParam);
//         if (!t) return res.status(400).json({ error: 'unsupported lang' });

//         const execTable = execTableFor(t);
//         if (!execTable) return res.status(500).json({ error: 'exec table mapping error' });

//         // **显式列出你给出的字段名** 保证返回属性名与前端期望一致
//         const sql = `SELECT id, q_id, unit_id, title, energy,
//                            question_text, hints, link,
//                            eg_in1, eg_out1, eg_in2, eg_out2, eg_in3, eg_out3,
//                            created_at
//                      FROM \`${execTable}\`
//                      WHERE unit_id = ?
//                      ORDER BY id ASC
//                      LIMIT ?`;
//         const [rows] = await pool.query(sql, [unit, limit]);

//         const parsed = (rows || []).map(r => ({
//           db_id: r.id ?? null,
//           q_id: r.q_id != null ? String(r.q_id) : null,
//           unit_id: r.unit_id,
//           title: r.title || '',
//           text: (r.title || r.question_text || '').toString(),
//           description: (r.question_text || r.title || '').toString(),
//           hints: safeParseHints(r.hints),
//           link: parseLinkField(r.link ?? null),
//           eg_in1: stringifyExampleField(r.eg_in1 ?? null),
//           eg_out1: stringifyExampleField(r.eg_out1 ?? null),
//           eg_in2: stringifyExampleField(r.eg_in2 ?? null),
//           eg_out2: stringifyExampleField(r.eg_out2 ?? null),
//           eg_in3: stringifyExampleField(r.eg_in3 ?? null),
//           eg_out3: stringifyExampleField(r.eg_out3 ?? null),
//           energy: isVip ? 0 : (Number.isFinite(Number(r.energy)) ? Number(r.energy) : 3),
//           created_at: r.created_at,
//           lang: t.langKey || langParam
//         }));

//         return res.json(parsed);
//       } else {
//         // 聚合所有语言
//         const results = [];
//         for (const l of Object.keys(LANG_SUFFIX)) {
//           const t = getTablesForLang(l);
//           if (!t) continue;
//           const execTable = execTableFor(t);
//           if (!execTable) continue;

//           const sql = `SELECT id, q_id, unit_id, title, energy,
//                              question_text, hints, link,
//                              eg_in1, eg_out1, eg_in2, eg_out2, eg_in3, eg_out3,
//                              created_at
//                        FROM \`${execTable}\`
//                        WHERE unit_id = ?
//                        ORDER BY id ASC
//                        LIMIT ?`;
//           try {
//             const [rows] = await pool.query(sql, [unit, limit]);
//             (rows || []).forEach(r => results.push({
//               db_id: r.id ?? null,
//               q_id: r.q_id != null ? String(r.q_id) : null,
//               unit_id: r.unit_id,
//               title: r.title || '',
//               text: (r.title || r.question_text || '').toString(),
//               description: (r.question_text || r.title || '').toString(),
//               hints: safeParseHints(r.hints),
//               link: parseLinkField(r.link ?? null),
//               eg_in1: stringifyExampleField(r.eg_in1 ?? null),
//               eg_out1: stringifyExampleField(r.eg_out1 ?? null),
//               eg_in2: stringifyExampleField(r.eg_in2 ?? null),
//               eg_out2: stringifyExampleField(r.eg_out2 ?? null),
//               eg_in3: stringifyExampleField(r.eg_in3 ?? null),
//               eg_out3: stringifyExampleField(r.eg_out3 ?? null),
//               energy: isVip ? 0 : (Number.isFinite(Number(r.energy)) ? Number(r.energy) : 3),
//               created_at: r.created_at,
//               lang: t.langKey || l
//             }));
//           } catch (e) {
//             console.error(`query ${execTable} failed:`, e && e.message);
//             // 忽略单语言错误，继续
//           }
//         }

//         results.sort((a, b) => (a.lang === b.lang ? (Number(a.db_id || 0) - Number(b.db_id || 0)) : a.lang.localeCompare(b.lang)));
//         return res.json(results);
//       }
//     } else {
//       // 没有 unit：返回目录列表（简略字段）
//       const out = [];
//       if (langParam) {
//         const t = getTablesForLang(langParam);
//         if (!t) return res.status(400).json({ error: 'unsupported lang' });
//         const execTable = execTableFor(t);
//         if (!execTable) return res.status(500).json({ error: 'exec table mapping error' });

//         const sql = `SELECT id AS db_id, q_id, unit_id, title, created_at, energy FROM \`${execTable}\` ORDER BY unit_id ASC, id ASC LIMIT ?`;
//         const [rows] = await pool.query(sql, [limit]);
//         (rows || []).forEach(r => out.push({
//           db_id: r.db_id,
//           q_id: r.q_id != null ? String(r.q_id) : null,
//           unit_id: r.unit_id,
//           title: r.title,
//           lang: t.langKey || langParam,
//           created_at: r.created_at,
//           energy: isVip ? 0 : (Number.isFinite(Number(r.energy)) ? Number(r.energy) : undefined)
//         }));
//         return res.json(out);
//       } else {
//         for (const l of Object.keys(LANG_SUFFIX)) {
//           const t = getTablesForLang(l);
//           if (!t) continue;
//           const execTable = execTableFor(t);
//           if (!execTable) continue;
//           try {
//             const sql = `SELECT id AS db_id, q_id, unit_id, title, created_at, energy FROM \`${execTable}\` ORDER BY unit_id ASC, id ASC LIMIT ?`;
//             const [rows] = await pool.query(sql, [limit]);
//             (rows || []).forEach(r => out.push({
//               db_id: r.db_id,
//               q_id: r.q_id != null ? String(r.q_id) : null,
//               unit_id: r.unit_id,
//               title: r.title,
//               lang: t.langKey || l,
//               created_at: r.created_at,
//               energy: isVip ? 0 : (Number.isFinite(Number(r.energy)) ? Number(r.energy) : undefined)
//             }));
//           } catch (e) {
//             console.error(`list ${execTable} failed:`, e && e.message);
//           }
//         }
//         out.sort((a,b) => a.lang.localeCompare(b.lang) || (a.unit_id - b.unit_id));
//         return res.json(out.slice(0, limit));
//       }
//     }
//   } catch (err) {
//     console.error('GET /api/questions_exec error:', err);
//     return res.status(500).json({ error: err.message || '数据库查询失败' });
//   }
// });

// ---------- CODE EXECUTION ----------
// app.post('/api/exec', async (req, res) => {
//   const { lang, code, stdin } = req.body || {};
//   if (!lang || !code) return res.status(400).json({ error: 'lang and code required' });

//   const config = {
//     python: { image: 'python:3.11-slim', filename: 'code.py' },
//     cpp: { image: 'gcc:12', filename: 'code.cpp' }
//   };

//   if (!config[lang]) return res.status(400).json({ error: 'unsupported lang' });

//   const prefix = path.join(os.tmpdir(), 'yp-sandbox-');
//   let tmpDir;
//   try {
//     tmpDir = await fs.promises.mkdtemp(prefix);
//   } catch (e) {
//     console.error('mkdtemp error:', e);
//     return res.status(500).json({ error: 'server tmpdir error' });
//   }

//   const filename = config[lang].filename;
//   const filePath = path.join(tmpDir, filename);
//   const runShPath = path.join(tmpDir, 'run.sh');

//   try {
//     // 写入代码文件
//     await fs.promises.writeFile(filePath, code, { encoding: 'utf8', mode: 0o644 });
//     if (stdin) {
//       await fs.promises.writeFile(path.join(tmpDir, 'stdin.txt'), stdin, { encoding: 'utf8', mode: 0o600 });
//     }

//     // run.sh 内容（不再加 ===Start/End===）
//     const scriptLines = ['#!/bin/sh', 'set -e', 'cd /work'];

//     if (lang === 'python') {
//       if (stdin) {
//         scriptLines.push(`python3 ${filename} < stdin.txt`);
//       } else {
//         scriptLines.push(`python3 ${filename}`);
//       }
//     } else if (lang === 'cpp') {
//       scriptLines.push(`g++ ${filename} -O2 -std=c++17 -o code_exec`);
//       if (stdin) {
//         scriptLines.push(`./code_exec < stdin.txt`);
//       } else {
//         scriptLines.push(`./code_exec`);
//       }
//     }

//     await fs.promises.writeFile(runShPath, scriptLines.join('\n') + '\n', {
//       encoding: 'utf8',
//       mode: 0o755
//     });

//     // Docker 命令
//     const dockerCmd = [
//       'docker', 'run',
//       '--rm',
//       '--network', 'none',
//       '--memory', '200m',
//       '--cpus', '0.5',
//       '-v', `${tmpDir.replace(/\\/g, '/')}:/work`,
//       '-w', '/work',
//       config[lang].image,
//       '/bin/sh', 'run.sh'
//     ].join(' ');

//     const TIMEOUT_MS = 8000;
//     try {
//       const { stdout, stderr } = await execAsync(dockerCmd, {
//         timeout: TIMEOUT_MS,
//         maxBuffer: 1024 * 1024
//       });

//       // 直接返回 stdout / stderr（分离）
//       res.json({ stdout, stderr });

//     } catch (execErr) {
//       res.json({
//         stdout: execErr.stdout || '',
//         stderr: execErr.stderr || execErr.message || 'execution failed',
//         error: execErr.killed ? 'timeout' : execErr.message
//       });
//     }

//   } catch (e) {
//     console.error('/api/exec internal error:', e);
//     try { res.status(500).json({ error: 'server error executing code' }); } catch {}
//   } finally {
//     try {
//       // 调试时保留文件夹，生产环境可以删掉
//       await fs.promises.rm(tmpDir, { recursive: true, force: true });
//     } catch {}
//   }
// });

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
// app.post('/api/submit', async (req, res) => {
//   const body = req.body || {};
//   const { lang, code, q_id, timeLimitMs = 2000, memoryMB = 200, compare = 'trim' } = body;
//   if (!lang || !code || !q_id) return res.status(400).json({ error: 'lang, code, q_id required' });

//   const config = {
//     python: { image: 'python:3.11-slim', filename: 'code.py' },
//     cpp:    { image: 'gcc:12', filename: 'code.cpp' },
//     java:   { image: 'openjdk:17', filename: 'Main.java' }
//   };
//   if (!config[lang]) return res.status(400).json({ error: 'unsupported lang' });

//   // 根据 lang 选择表名
//   const tableMap = {
//     python: 'questions_py_exec',
//     cpp:    'questions_cpp_exec',
//     java:   'questions_java_exec'
//   };
//   const table = tableMap[lang];

//   // 取出 eg_in1..eg_out3
//   let row = null;
//   try {
//     // 先尝试以 q_id 字段查找（兼容你之前提到的 q_id）
//     const [rows1] = await pool.query(`SELECT eg_in1, eg_out1, eg_in2, eg_out2, eg_in3, eg_out3 FROM \`${table}\` WHERE q_id = ? LIMIT 1`, [q_id]);
//     if (rows1 && rows1.length > 0) row = rows1[0];
//     else {
//       // 回退尝试 id 字段
//       const [rows2] = await pool.query(`SELECT eg_in1, eg_out1, eg_in2, eg_out2, eg_in3, eg_out3 FROM \`${table}\` WHERE id = ? LIMIT 1`, [q_id]);
//       if (rows2 && rows2.length > 0) row = rows2[0];
//     }
//   } catch (dbErr) {
//     console.error('/api/submit DB query error:', dbErr);
//     return res.status(500).json({ error: 'db query failed' });
//   }

//   if (!row) {
//     return res.status(404).json({ error: 'question not found or no examples stored' });
//   }

//   // assemble tests array from eg_in/out fields (最多 3，对空的忽略)
//   const tests = [];
//   for (let i = 1; i <= 3; i++) {
//     const inField = row[`eg_in${i}`];
//     const outField = row[`eg_out${i}`];
//     if (inField == null && outField == null) continue;
//     tests.push({ input: inField == null ? '' : String(inField), expected: outField == null ? '' : String(outField) });
//   }
//   if (tests.length === 0) return res.status(400).json({ error: 'no example testcases found in DB' });

//   // create tmp dir
//   const prefix = path.join(os.tmpdir(), 'yp-judge-');
//   let tmpDir;
//   try {
//     tmpDir = await fs.promises.mkdtemp(prefix);
//   } catch (e) {
//     console.error('mkdtemp error:', e);
//     return res.status(500).json({ error: 'server tmpdir error' });
//   }
//   const hostTmp = tmpDir.replace(/\\/g, '/');

//   const filename = config[lang].filename;
//   const filePath = path.join(tmpDir, filename);

//   try {
//     // write code
//     await fs.promises.writeFile(filePath, code, { encoding: 'utf8', mode: 0o644 });

//     // Java requirement: ensure class name Main if code doesn't have it -> NOTE: we won't alter code; assume author provides Main class
//     // C++: compile step
//     if (lang === 'cpp') {
//       const compileCmd = ['/bin/sh', '-c', `g++ ${filename} -O2 -std=c++17 -o code_exec`];
//       const compileRes = await spawnDocker(hostTmp, config[lang].image, compileCmd, { timeout: 20000, memory: `${memoryMB}m`, cpus: '0.5' });
//       if (compileRes.timedOut) {
//         return res.json({ verdict: 'CE', compileStderr: 'compile timed out', tests: [] });
//       }
//       if (compileRes.code !== 0) {
//         return res.json({ verdict: 'CE', compileStderr: compileRes.stderr || 'compile failed', tests: [] });
//       }
//     } else if (lang === 'java') {
//       // compile java
//       const compileCmd = ['/bin/sh', '-c', `javac ${filename}`];
//       const compileRes = await spawnDocker(hostTmp, config[lang].image, compileCmd, { timeout: 20000, memory: `${memoryMB}m`, cpus: '0.5' });
//       if (compileRes.timedOut) {
//         return res.json({ verdict: 'CE', compileStderr: 'javac timed out', tests: [] });
//       }
//       if (compileRes.code !== 0) {
//         return res.json({ verdict: 'CE', compileStderr: compileRes.stderr || 'javac failed', tests: [] });
//       }
//     }

//     // per-test execution
//     const results = [];
//     let overall = 'AC';
//     for (let i = 0; i < tests.length; i++) {
//       const t = tests[i];
//       await fs.promises.writeFile(path.join(tmpDir, 'stdin.txt'), t.input, { encoding: 'utf8', mode: 0o600 });
//       await fs.promises.writeFile(path.join(tmpDir, 'expected.txt'), t.expected, { encoding: 'utf8', mode: 0o600 });

//       let runCmd;
//       if (lang === 'python') {
//         runCmd = ['/bin/sh', '-c', `python3 ${filename} < stdin.txt > out.txt`];
//       } else if (lang === 'cpp') {
//         runCmd = ['/bin/sh', '-c', `./code_exec < stdin.txt > out.txt`];
//       } else if (lang === 'java') {
//         // run Main class (assumes Main exists)
//         runCmd = ['/bin/sh', '-c', `timeout ${Math.ceil(timeLimitMs / 1000) + 1}s java Main < stdin.txt > out.txt`];
//         // Note: using timeout inside container is optional; we also rely on spawnDocker timeout
//       } else {
//         runCmd = ['/bin/sh', '-c', `echo "unsupported" > out.txt; exit 2`];
//       }

//       const perTestTimeout = Math.max(200, timeLimitMs || 2000);
//       const runRes = await spawnDocker(hostTmp, config[lang].image, runCmd, { timeout: perTestTimeout + 500, memory: `${memoryMB}m`, cpus: '0.5' });

//       // read produced output if any
//       let produced = '';
//       try {
//         produced = await fs.promises.readFile(path.join(tmpDir, 'out.txt'), 'utf8');
//       } catch (e) { produced = ''; }

//       let verdict = 'AC';
//       if (runRes.timedOut) {
//         verdict = 'TLE';
//       } else if (runRes.code !== 0) {
//         // Non-zero exit; if produced empty and stderr exists => RE
//         if (!produced) verdict = 'RE';
//         else {
//           // still compare produced to expected
//           // fallthrough to compare
//         }
//       }

//       if (verdict === 'AC' || verdict === 'RE') {
//         const a = normalizeOutput(produced, compare);
//         const b = normalizeOutput(t.expected, compare);
//         if (a !== b) verdict = 'WA';
//       }

//       results.push({
//         index: i,
//         verdict,
//         code: runRes.code,
//         stderr: runRes.stderr ? runRes.stderr.slice(0, 4000) : '',
//         produced: produced ? produced.slice(0, 2000) : ''
//       });

//       if (overall === 'AC' && verdict !== 'AC') overall = verdict;
//       // 如果希望遇到第一个非 AC 就停止，把下面注释取消
//       // if (overall !== 'AC') break;
//     }

//     return res.json({ verdict: overall, tests: results });

//   } catch (err) {
//     console.error('/api/submit error:', err);
//     return res.status(500).json({ error: 'server error during judge' });
//   } finally {
//     // 永远清理临时目录（生产必须）
//     try { await fs.promises.rm(tmpDir, { recursive: true, force: true }); } catch (e) {}
//   }
// });


// ---------- PORT ----------


const port = process.env.PORT || 5000;
const host = process.env.HOST || '0.0.0.0';
app.listen(port, host,() => console.log(`YProgram backend running on http://${host}:${port}`));