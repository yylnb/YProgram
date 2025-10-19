// study.exec.js
import axios from 'axios';

// 保留你原有的 runCode（只是微调了错误处理）
export async function runCode() {
  if (!this.currentQuestion || !this.currentQuestion.exec) return;
  this.execRunning = true;
  this.execOutputStdout = '';
  this.execOutputStderr = '';
  this.execError = null;
  this.execFeedback = null;
  this.execAttemptFailed = false;

  const payload = {
    lang: this.selectedLang,
    code: this.codeEditorContent || '',
    stdin: (this.stdinContent && String(this.stdinContent).length > 0) ? String(this.stdinContent) : undefined
  };

  try {
    const res = await axios.post('http://localhost:5000/api/exec', payload, { timeout: 15000 });
    if (res && res.data) {
      this.execOutputStdout = res.data.stdout || '';
      this.execOutputStderr = res.data.stderr || '';
      if (res.data.error) {
        this.execError = res.data.error;
        this.execFeedback = false;
        this.execAttemptFailed = true;
      } else {
        this.execFeedback = true;
        this.execAttemptFailed = false;
        this.feedback = true;
        this.attemptCount = 0;
      }
    } else {
      this.execError = '未知执行结果';
      this.execFeedback = false;
      this.execAttemptFailed = true;
    }
  } catch (e) {
    console.error('runCode error', e);
    this.execOutputStdout = (e.response && e.response.data && e.response.data.stdout) ? e.response.data.stdout : '';
    this.execOutputStderr = (e.response && e.response.data && e.response.data.stderr) ? e.response.data.stderr : (e.message || '执行失败');
    this.execError = (e.response && e.response.data && e.response.data.error) ? e.response.data.error : e.message || '执行错误';
    this.execFeedback = false;
    this.execAttemptFailed = true;
  } finally {
    this.execRunning = false;
  }
}

// ----------------- 新增：判题 submitCode -----------------
// 依赖：如果题目在 DB（有 q_id），优先调用 /api/submit
// 否则回退：对每个示例调用 /api/exec 以本地模拟判题
export async function submitCode(opts = {}) {
  // opts 可选：{ timeLimitMs, memoryMB, compare }，会合并到请求体
  if (!this.currentQuestion || !this.currentQuestion.exec) return;

  // UI 状态（请在 data() 中确保这些字段存在）
  this.execSubmitRunning = true;
  this.execSubmitError = null;
  this.execSubmitResults = []; // [{ index, verdict, produced, stderr }]
  this.execSubmitVerdict = null;

  const lang = this.selectedLang;
  const code = this.codeEditorContent || '';
  const compare = opts.compare || (this.execCompare || 'trim');
  const timeLimitMs = opts.timeLimitMs || (this.execTimeLimitMs || 2000);
  const memoryMB = opts.memoryMB || (this.execMemoryMB || 200);

  // helper: local normalizer (match server's normalizeOutput)
  const normalizeCompare = (s, mode = 'trim') => {
    if (s == null) return '';
    s = String(s).replace(/\r\n/g, '\n');
    if (mode === 'exact') return s;
    if (mode === 'trim') return s.trim();
    if (mode === 'ignoreWS') return s.replace(/\s+/g, ' ').trim();
    return s;
  };

  // Attempt: if we have q_id -> call server-side judge
  const qId = this.currentQuestion.q_id ?? this.currentQuestion.id ?? null;

  try {
    if (qId) {
      // call /api/submit (server will fetch eg_in*/eg_out* from DB)
      const payload = {
        lang,
        code,
        q_id: qId,
        timeLimitMs,
        memoryMB,
        compare
      };
      const res = await axios.post('http://localhost:5000/api/submit', payload, { timeout: 30000 });
      if (res && res.data) {
        // res.data shape from server: { verdict, tests: [{index, verdict, code, stderr, produced}] , compileStderr? }
        this.execSubmitVerdict = res.data.verdict || 'UNKNOWN';
        // map tests to front-end friendly objects
        this.execSubmitResults = (res.data.tests || []).map(t => ({
          index: t.index,
          verdict: t.verdict,
          produced: t.produced || '',
          stderr: t.stderr || '',
          code: t.code != null ? t.code : null
        }));

        // if compile error present, surface it
        if (res.data.compileStderr) {
          this.execSubmitError = res.data.compileStderr;
        }
      } else {
        this.execSubmitError = '未收到服务器返回';
        this.execSubmitVerdict = 'ERROR';
      }
    } else {
      // 回退逻辑：没有 q_id（本地题/未同步） -> 使用 eg_in1..3 / eg_out1..3 做本地判题
      // currentQuestion.eg_in1..eg_out3 在 parseExecs 已处理为字符串或 null
      const tests = [];
      for (let i = 1; i <= 3; i++) {
        const inKey = `eg_in${i}`;
        const outKey = `eg_out${i}`;
        const input = (this.currentQuestion && this.currentQuestion[inKey]) ? String(this.currentQuestion[inKey]) : null;
        const expected = (this.currentQuestion && this.currentQuestion[outKey]) ? String(this.currentQuestion[outKey]) : null;
        if (input == null && expected == null) continue;
        tests.push({ input: input == null ? '' : input, expected: expected == null ? '' : expected, index: i - 1 });
      }

      if (tests.length === 0) {
        this.execSubmitError = '题目没有示例用例，无法提交判题';
        this.execSubmitVerdict = 'NO_TESTS';
      } else {
        // 逐例调用 /api/exec 并本地比对
        let overall = 'AC';
        for (let t of tests) {
          // call exec endpoint with stdin
          try {
            const execRes = await axios.post('http://localhost:5000/api/exec', { lang, code, stdin: t.input }, { timeout: timeLimitMs + 5000 });
            const stdout = execRes.data && execRes.data.stdout ? execRes.data.stdout : '';
            const stderr = execRes.data && execRes.data.stderr ? execRes.data.stderr : '';
            const errFlag = execRes.data && execRes.data.error ? execRes.data.error : null;

            // If exec returned error (timeout...) mark appropriately
            let verdict = 'AC';
            if (errFlag) {
              // server returns error e.g. 'timeout' -> treat as TLE/RE
              if (String(errFlag).toLowerCase().includes('timeout')) verdict = 'TLE';
              else verdict = 'RE';
            } else {
              // compare stdout vs expected using compare strategy
              const a = normalizeCompare(stdout, compare);
              const b = normalizeCompare(t.expected, compare);
              if (a !== b) verdict = 'WA';
            }

            this.execSubmitResults.push({
              index: t.index,
              verdict,
              produced: stdout,
              stderr: stderr
            });

            if (overall === 'AC' && verdict !== 'AC') overall = verdict;

          } catch (err) {
            console.error('submitCode exec fallback error', err);
            let stderr = (err.response && err.response.data && err.response.data.stderr) ? err.response.data.stderr : (err.message || 'exec error');
            let stdout = (err.response && err.response.data && err.response.data.stdout) ? err.response.data.stdout : '';
            let errFlag = (err.response && err.response.data && err.response.data.error) ? err.response.data.error : null;
            let verdict = errFlag && String(errFlag).toLowerCase().includes('timeout') ? 'TLE' : 'RE';
            this.execSubmitResults.push({
              index: t.index,
              verdict,
              produced: stdout,
              stderr
            });
            if (overall === 'AC' && verdict !== 'AC') overall = verdict;
          }
        } // end tests loop

        this.execSubmitVerdict = overall;
      }
    } // end else qId
  } catch (e) {
    console.error('submitCode error', e);
    this.execSubmitError = (e.response && e.response.data && e.response.data.error) ? e.response.data.error : (e.message || '提交失败');
    this.execSubmitVerdict = 'ERROR';
  } finally {
    this.execSubmitRunning = false;
  }
}

export function resetExecOutput() {
  this.execOutputStdout = '';
  this.execOutputStderr = '';
  this.execError = null;
  this.execFeedback = null;
  this.execAttemptFailed = false;
}

export function clearExecFail() {
  this.execFeedback = null;
  this.execAttemptFailed = false;
}

export function resetExecState() {
  this.codeEditorContent = this.currentQuestion && this.currentQuestion.exec && this.currentQuestion.example ? String(this.currentQuestion.example) : '';
  this.stdinContent = '';
  this.execRunning = false;
  this.execOutputStdout = '';
  this.execOutputStderr = '';
  this.execError = null;
  this.execFeedback = null;
  this.execAttemptFailed = false;
}