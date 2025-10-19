<template>
  <div
    class="study-root"
    :class="{ 'page-leave': navigatingToMap }"
    :style="{ paddingTop: navOffset + 'px' }"
  >
    <!-- 左上返回地图（fixed） -->
    <button
      class="back-map action-btn"
      @click="handleBackMapClick"
      :disabled="navigatingToMap"
    >
      ← 返回地图
    </button>

    <main class="container" role="main">
      <!-- header + progress -->
      <section class="header">
        <div class="title-wrap">
          <!-- 标题居中 -->
          <div class="title-center">
            <h1 class="unit-title">
              {{ unitData.title }}
            </h1>
            <p class="unit-sub lang-label">语言：<span style="text-transform:capitalize">{{ selectedLangLabel }}</span></p>
          </div>

          <!-- Energy 放右上角 -->
          <div class="energy-block" aria-hidden="false">
            <div v-if="!token" class="energy-guest">
              <div class="battery battery-disabled">
                <div class="battery-level" :style="{ width: '100%' }"></div>
                <div class="battery-cap"></div>
              </div>
              <div class="energy-text">请登录以启用能量机制</div>
            </div>

            <div v-else class="energy-user" title="能量状态">
              <div
                class="battery"
                :class="{ vip: isVip, 'low': !isVip && energyData.energy <= Math.max(3, Math.round((energyData.maxEnergy || 1) * 0.15)) }"
                role="img"
                aria-label="能量电池"
              >
                <div class="battery-level" :style="{ width: isVip ? '100%' : (batteryPercent + '%') }"></div>
                <div class="battery-cap"></div>
              </div>

              <div class="energy-meta">
                <div class="energy-numbers">
                  <template v-if="isVip">
                    <span class="energy-current">∞</span>
                  </template>
                  <template v-else>
                    <span class="energy-current">⚡{{ energyData.energy ?? '-' }}</span>
                    <span class="energy-slash">/</span>
                    <span class="energy-max">{{ energyData.maxEnergy ?? '-' }}</span>
                  </template>
                </div>

                <div v-if="!isVip" class="energy-subsmall">
                  <div v-if="timeToFullSeconds !== null">剩余时间：<strong>{{ formatDuration(timeToFullSeconds) }}</strong></div>
                  <div v-else>同步中…</div>
                </div>
              </div>
            </div>
          </div>
          <!-- end energy-block -->
        </div>

        <div class="progress-wrap">
          <div class="progress-bar-outer" role="progressbar" :aria-valuenow="progressPercent" aria-valuemin="0" aria-valuemax="100">
            <div class="progress-bar-inner" :style="{ width: progressPercent + '%' }"></div>
          </div>
        </div>

        <!-- entry error / info -->
        <div v-if="entryError" class="hint-box" style="margin-top:10px;">
          {{ entryError }}
        </div>

        <!-- blocking overlay while checking/deducting entry energy -->
        <div v-if="entryLoading" style="margin-top:10px;padding:10px;border-radius:10px;background:rgba(255,255,255,0.85); display:flex;align-items:center;gap:10px;">
          <div>正在检查学习进度与能量…</div>
        </div>

        <!-- 如果后端没有题目或加载失败显示提示 -->
        <div v-if="noServerData && !entryLoading" class="hint-box" style="margin-top:10px;">
          注意：当前题目来自本地示例，若要收藏或同步进度，请先将题库导入后端数据库或确认后端服务可用。
        </div>
      </section>

      <!-- 题目卡片 + 两列布局（左：题目/代码/输出/反馈；右：参考资料/示例） -->
      <section v-if="currentQuestion" class="question-card">
        <div
          class="qa-grid"
          :class="{ 'qa-grid--centered': !(currentQuestion && (currentQuestion.link || examples.length > 0)) }"
        >
          <!-- 左列：题目 + 交互主区 -->
          <div class="qa-main">
            <div class="q-header" :class="{ 'q-header--center': !(currentQuestion && currentQuestion.exec) }">
              <div class="q-left">
                <div class="q-index">第 {{ currentQuestionIndex + 1 }} / {{ totalQuestions }} 题</div>
                <div class="q-title" v-html="htmlWithLineBreaks(currentQuestion.text)"></div>
              </div>

              <!-- 操作区：收藏按钮 -->
              <div class="q-actions">
                <button class="fav-btn action-btn" @click="toggleFavorite" :disabled="favLoading || !getQuestionQid(currentQuestion)">
                  <span v-if="isFavorite" class="star">★</span>
                  <span v-else class="star">☆</span>
                  {{ getQuestionQid(currentQuestion) ? (isFavorite ? '已收藏' : '收藏') : '不可收藏' }}
                </button>
              </div>
            </div>

            <!-- 实操题编辑区 -->
            <div v-if="currentQuestion.exec" class="exec-area">
              <div class="exec-top">
                <div class="exec-meta" style="display:flex;gap:12px;align-items:center;">
                  <div style="font-weight:700;color:var(--brown-900);">实操题</div>
                  <div style="color:var(--muted);font-size:0.9rem;">{{ selectedLangLabel }} &nbsp;|&nbsp; ⚡{{ currentQuestion.energy ?? 3 }}</div>
                </div>
                <div style="margin-top:8px;color:var(--muted);">{{ currentQuestion.description || '' }}</div>
              </div>

              <div class="code-editor" style="margin-top:12px;">
                <label style="font-weight:700;margin-bottom:6px;display:block;">代码编辑器</label>
                <textarea v-model="codeEditorContent" class="code-input" rows="12" spellcheck="false"></textarea>

                <!-- improved stdin / actions layout -->
                <div class="stdin-row">
                  <div class="stdin-actions">
                    <button class="btn-primary action-btn" :disabled="execRunning" @click="runCode">运行</button>
                    <button class="btn-try action-btn" @click="resetExecOutput">清空输出</button>
                  </div>

                  <div class="stdin-area">
                    <label class="stdin-label">输入</label>
                    <textarea v-model="stdinContent" class="stdin-input" rows="3" placeholder="可选填（多行）"></textarea>
                  </div>

                  <div class="stdin-paste">
                    <button class="btn-try action-btn" @click="pasteIntoStdin" title="从剪贴板粘贴">粘贴</button>
                    <div v-if="pasteFeedback" class="paste-feedback">已粘贴</div>
                  </div>
                </div>
                <!-- end stdin row -->
              </div>

              <div class="exec-output" style="margin-top:12px;">
                <label style="font-weight:700;display:block;margin-bottom:6px;">输出</label>
                <div class="output-box colored-output" style="min-height:80px; white-space:pre-wrap; padding:10px; border-radius:8px; font-family:monospace;">
                  <div v-if="execOutputStdout">{{ execOutputStdout }}</div>
                  <div v-else style="opacity:0.6;">stdout 为空</div>
                </div>

                <div style="margin-top:8px;">
                  <label style="font-weight:700;display:block;margin-bottom:6px;">错误输出</label>
                  <div class="output-box colored-error" style="min-height:40px; white-space:pre-wrap; padding:10px; border-radius:8px; font-family:monospace;">
                    <div v-if="execOutputStderr">{{ execOutputStderr }}</div>
                    <div v-else style="opacity:0.6;">stderr 为空</div>
                  </div>
                </div>

                <div v-if="showExecHint" class="hint-box" role="status" style="margin-top:12px;">
                  <strong>提示：</strong>
                  <div class="hint-text">{{ currentExecHint }}</div>
                </div>

                <div class="feedback-area" v-if="execFeedback !== null" style="margin-top:12px;">
                  <div v-if="execFeedback === true" class="feedback success">
                    <div class="emoji">🎉</div>
                    <div class="feedback-body">
                      <div class="msg">代码运行成功！你可以进入下一题：</div>
                      <div class="explanation" v-if="currentQuestion.explanation" v-html="currentQuestion.explanation"></div>
                      <div v-if="currentQuestion.example" class="example">
                        <strong>示例代码：</strong>
                        <pre class="code">{{ currentQuestion.example }}</pre>
                      </div>

                      <div class="next-actions" style="margin-top:8px;">
                        <button
                          class="btn-primary action-btn"
                          :disabled="entryLoading || nextActionLoading"
                          @click="onNextClicked"
                        >
                          <span v-if="nextQuestionExists">
                            下一题
                            <span v-if="nextQuestionEnergy"> (⚡{{ nextQuestionEnergy }})</span>
                          </span>
                          <span v-else>完成本单元</span>
                        </button>
                      </div>
                    </div>
                  </div>

                  <div v-else class="feedback fail">
                    <div class="emoji">💡</div>
                    <div class="feedback-body">
                      <div class="msg">运行出错，请参考上方 stderr 与提示后再试。</div>
                      <div class="next-actions">
                        <button class="btn-try action-btn" @click="clearExecFail">继续尝试</button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- 选择题区 -->
            <div v-else class="options-grid" style="margin-top:12px;">
              <button
                v-for="(option, i) in currentQuestion.options"
                :key="i"
                class="opt-btn action-btn"
                :class="{
                  selected: selectedOption === i && feedback === null,
                  correct: feedback === true && i === currentQuestion.answer,
                  wrong: selectedOption === i && feedback === false,
                  disabled: disableOptions || entryLoading
                }"
                :disabled="disableOptions || entryLoading"
                @click="checkAnswer(i)"
              >
                <div class="opt-left">
                  <span class="bullet">{{ ['A','B','C','D'][i] || (i+1) }}</span>
                  <span class="opt-label preserve">{{ option }}</span>
                </div>

                <div class="opt-right" aria-hidden="true">
                  <span v-if="selectedOption === i && feedback === null" class="badge info">已选</span>
                  <span v-if="i === currentQuestion.answer && feedback === true" class="badge correct">✓ 正确</span>
                  <span v-if="selectedOption === i && feedback === false" class="badge wrong">✕ 错误</span>
                </div>
              </button>
            </div>

            <!-- 选择题提示 -->
            <div v-if="!currentQuestion.exec && showHint" class="hint-box" role="status" style="margin-top:12px;">
              <strong>提示：</strong>
              <div class="hint-text">{{ currentHint }}</div>
            </div>

            <!-- 选择题反馈与讲解 -->
            <div v-if="!currentQuestion.exec && feedback !== null" class="feedback-area" style="margin-top:12px;">
              <div v-if="feedback === true" class="feedback success">
                <div class="emoji">🎉</div>
                <div class="feedback-body">
                  <div class="msg">回答正确！下面是讲解：</div>

                  <div class="explanation" v-html="currentQuestion.explanation"></div>

                  <div v-if="currentQuestion.example" class="example">
                    <strong>举一反三 — 示例代码：</strong>
                    <pre class="code">{{ currentQuestion.example }}</pre>
                  </div>

                  <div v-if="energyInsufficient" class="hint-box" style="margin-top:10px;">
                    <div style="margin-bottom:8px;">
                      能量不足，无法进入下一题（需要 ⚡{{ pendingNextEnergy }}）。你可以：
                    </div>
                    <div style="display:flex;gap:8px;flex-wrap:wrap;">
                      <button class="btn-primary action-btn" @click="goToLibrary">前往资料库获取能量</button>
                      <button class="btn-try action-btn" @click="dismissInsufficient">稍后再试（保留本题答案）</button>
                    </div>
                    <div style="margin-top:8px;color:var(--muted);font-weight:700;font-size:0.9rem;">
                      （提示：能量会随时间恢复，或在资料库通过任务/兑换获得）
                    </div>
                  </div>

                  <div v-else class="next-actions" style="margin-top:8px;">
                    <button
                      class="btn-primary action-btn"
                      :disabled="entryLoading || nextActionLoading"
                      @click="onNextClicked"
                    >
                      <span v-if="nextQuestionExists">
                        下一题
                        <span v-if="nextQuestionEnergy"> (⚡{{ nextQuestionEnergy }})</span>
                      </span>
                      <span v-else>完成本单元</span>
                    </button>
                  </div>
                </div>
              </div>

              <div v-else class="feedback fail">
                <div class="emoji">💡</div>
                <div class="feedback-body">
                  <div class="msg">回答错误，请参考提示再试一次。</div>
                  <div class="next-actions">
                    <button class="btn-try action-btn" @click="clearWrong">继续尝试</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <!-- end qa-main -->

          <!-- 右列：参考资料 + 示例（与左列垂直平齐） -->
          <aside class="qa-side" v-if="(currentQuestion && (currentQuestion.link || examples.length > 0))">
            <!-- 参考资料（每个 link 渲染为独立卡片） -->
            <div v-if="currentQuestion && Array.isArray(currentQuestion.link)" class="resources-links-side">
              <div
                class="side-card resource-card"
                v-for="(ln, idx) in currentQuestion.link"
                :key="`linkcard-${idx}`"
                role="button"
                tabindex="0"
                @click.prevent="openResource(ln)"
                @keydown.enter.prevent="openResource(ln)"
              >
                <div class="res-card-header">
                  <!-- 主/副标题使用占位字体风格 -->
                  <div class="res-title placeholder">主标题</div>
                  <div class="res-sub placeholder">副标题</div>
                </div>

                <!-- 小提示，不显示真实链接 -->
                <div class="res-card-foot">
                  <div class="res-foot-text">点击卡片打开资料</div>
                </div>
              </div>
            </div>

            <div v-else-if="currentQuestion && currentQuestion.link" class="resources-links-side">
              <div class="side-card resource-card"
                   role="button"
                   tabindex="0"
                   @click.prevent="openResource(currentQuestion.link)"
                   @keydown.enter.prevent="openResource(currentQuestion.link)"
              >
                <div class="res-card-header">
                  <div class="res-title placeholder">{{ (currentQuestion.link && (currentQuestion.link.label || currentQuestion.link.title)) ? (currentQuestion.link.label || currentQuestion.link.title) : '资料' }}</div>
                  <div class="res-sub placeholder">{{ (currentQuestion.link && (currentQuestion.link.subtitle || currentQuestion.link.desc || currentQuestion.link.summary)) ? (currentQuestion.link.subtitle || currentQuestion.link.desc || currentQuestion.link.summary) : '副标题' }}</div>
                </div>
                <div class="res-card-foot">
                  <div class="res-foot-text">点击卡片打开资料</div>
                </div>
              </div>
            </div>

            <!-- 示例卡片（侧栏） -->
            <div v-if="examples.length > 0" class="examples-wrap side-card">
              <div class="examples-grid">
                <div
                  v-for="ex in examples"
                  :key="`ex-${ex.idx}`"
                  class="example-card"
                >
                  <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:8px;">
                    <div style="font-weight:700;">示例 {{ ex.idx }}</div>
                  </div>

                  <div style="margin-bottom:8px;display:flex;gap:8px;">
                    <div style="flex:1;">
                      <div style="font-weight:700;font-size:0.85rem;margin-bottom:4px;">输入</div>
                      <pre class="code" style="background:var(--code-bg);color:var(--code-fg);padding:8px;border-radius:6px;white-space:pre-wrap;font-family:monospace;margin:0;">{{ ex.in ?? '(无)' }}</pre>
                    </div>

                    <div style="display:flex;flex-direction:column;gap:8px;">
                      <button class="btn-try small action-btn" @click="copyExample(ex.in, ex.idx, 'in')">复制</button>
                      <button class="btn-try small action-btn" @click="fillStdinFromExample(ex.in)">填到 stdin</button>
                    </div>
                  </div>

                  <div style="display:flex;gap:8px;align-items:flex-start;">
                    <div style="flex:1;">
                      <div style="font-weight:700;font-size:0.85rem;margin-bottom:4px;">输出</div>
                      <pre class="code" style="background:var(--output-bg);color:var(--output-fg);padding:8px;border-radius:6px;white-space:pre-wrap;font-family:monospace;margin:0;">{{ ex.out ?? '(无)' }}</pre>
                    </div>

                    <div style="display:flex;flex-direction:column;gap:8px;">
                      <button class="btn-try small action-btn" @click="copyExample(ex.out, ex.idx, 'out')">复制</button>
                    </div>
                  </div>

                  <!-- 复制反馈 -->
                  <div v-if="copyStatus && copyStatus.idx === ex.idx" style="margin-top:8px;color:var(--accent);font-weight:700;">
                    {{ copyStatus.kind === 'in' ? '已复制输入' : (copyStatus.kind === 'out' ? '已复制输出' : '') }}
                  </div>
                </div>
              </div>
            </div>
          </aside>
          <!-- end qa-side -->
        </div>
        <!-- end qa-grid -->
      </section>

      <!-- 单元完成 -->
      <section v-else class="completed-card">
        <h2 class="complete-title">恭喜完成 {{ unitData.title }} 🎉</h2>
        <p class="complete-sub">你已完成本单元的所有题目。</p>
        <div class="complete-actions" style="display:flex;gap:12px;justify-content:center;">
          <button v-if="hasNextUnit" class="btn-primary action-btn" @click="goToNextUnit">下一单元 →</button>
          <button class="btn-primary action-btn" @click="$router.push('/map')">返回地图</button>
          <button class="btn-try action-btn" @click="confirmRestart">重新学习</button>
        </div>
      </section>
    </main>
  </div>
</template>

<script>
// 组件脚本通过小模块导入并合并（Options API）
import baseData from '../javascript_study/data.js';
import computedProps from '../javascript_study/computed.js';
import * as questionsMethods from '../javascript_study/questions.js';
import * as execMethods from '../javascript_study/exec.js';
import * as favoritesMethods from '../javascript_study/favorites.js';
import * as energyProgressMethods from '../javascript_study/energy_progress.js';

export default {
  name: 'Study',
  data() {
    // 使用 baseData.call(this) 保证内部可访问 this.$route
    let base = {};
    try {
      base = (typeof baseData === 'function') ? baseData.call(this) : (baseData || {});
    } catch (e) {
      console.error('调用 baseData 失败，使用空初始值：', e);
      base = {};
    }

    return {
      ...base,
      copyStatus: { idx: null, kind: null },
      pasteFeedback: false,
      pasteFeedbackTimer: null,
      navigatingToMap: false
    };
  },
  computed: {
    ...computedProps
  },
  methods: {
    // 保留你的基础交互方法（getQuestionQid, checkAnswer, ...）
    getQuestionQid(q) {
      if (!q) return null;
      const idVal = (q.q_id !== undefined && q.q_id !== null) ? q.q_id : (q.id !== undefined ? q.id : null);
      return idVal != null ? String(idVal) : null;
    },

    checkAnswer(i) {
      if (this.disableOptions || this.entryLoading) return;
      this.selectedOption = i;
      this.disableOptions = true;
      if (!this.currentQuestion) return;

      if (i === this.currentQuestion.answer) {
        this.feedback = true;
        this.attemptCount = 0;
        this.disableOptions = false;
      } else {
        this.feedback = false;
        this.attemptCount = this.attemptCount + 1;
        setTimeout(() => { this.disableOptions = false; }, 500);
      }
    },

    clearWrong() { this.feedback = null; this.selectedOption = null; this.disableOptions = false; },

    // 注入模块方法（绑定 this）
    ...questionsMethods,
    ...execMethods,
    ...favoritesMethods,
    ...energyProgressMethods,

    // 复制/粘贴/填充辅助
    async copyExample(text, idx, kind = 'in') {
      const str = (text === undefined || text === null) ? '' : String(text);
      try {
        if (navigator.clipboard && navigator.clipboard.writeText) {
          await navigator.clipboard.writeText(str);
        } else {
          window.prompt('请手动复制下面的内容（Ctrl/Cmd+C）', str);
        }
        this.copyStatus = { idx: idx, kind };
        setTimeout(() => { if (this.copyStatus && this.copyStatus.idx === idx) this.copyStatus = { idx: null, kind: null }; }, 1600);
      } catch (e) {
        console.error('copy failed', e);
        try { window.prompt('复制失败，请手动复制下面的内容（Ctrl/Cmd+C）', str); } catch (ee) {}
      }
    },

    async pasteIntoStdin() {
      try {
        if (navigator.clipboard && navigator.clipboard.readText) {
          const text = await navigator.clipboard.readText();
          if (text != null) {
            this.stdinContent = String(text);
            this.pasteFeedback = true;
            if (this.pasteFeedbackTimer) clearTimeout(this.pasteFeedbackTimer);
            this.pasteFeedbackTimer = setTimeout(() => { this.pasteFeedback = false; this.pasteFeedbackTimer = null; }, 1500);
            return;
          }
        } else {
          const manual = window.prompt('您的浏览器不支持自动读取剪贴板，请手动粘贴：', '');
          if (manual != null) { this.stdinContent = String(manual); this.pasteFeedback = true; setTimeout(() => this.pasteFeedback = false, 1500); }
        }
      } catch (e) {
        console.error('pasteIntoStdin error', e);
        try {
          const manual = window.prompt('粘贴失败，请手动输入或粘贴：', '');
          if (manual != null) { this.stdinContent = String(manual); this.pasteFeedback = true; setTimeout(() => this.pasteFeedback = false, 1500); }
        } catch (ee) {}
      }
    },

    fillStdinFromExample(text) {
      if (text == null) return;
      this.stdinContent = String(text);
      this.copyStatus = { idx: -1, kind: 'fill' };
      setTimeout(() => { if (this.copyStatus && this.copyStatus.kind === 'fill') this.copyStatus = { idx: null, kind: null }; }, 1400);
    },

    // 打开资源：如果是外部链接（以 http/https 开头 或 ln.external === true） -> window.open
    // 否则使用 vue-router 跳转（内部路由）
    openResource(ln) {
      try {
        const val = (typeof ln === 'string') ? ln : (ln && (ln.path || ln.link || ln.route) ? (ln.path || ln.link || ln.route) : null);
        const isExternalFlag = (ln && ln.external) || (typeof val === 'string' && /^(https?:)?\/\//i.test(val) && !val.startsWith('/'));
        if (isExternalFlag) {
          // external (open in new tab)
          window.open(val, '_blank', 'noopener');
          return;
        }
        // internal route: if val starts with "/" use push(path), else try push as path string
        if (typeof val === 'string') {
          if (val.startsWith('/')) {
            this.$router.push(val).catch(()=>{});
          } else {
            // fallback: attempt to treat it as route name or relative path
            try { this.$router.push({ path: val }).catch(()=>{}); } catch (e) { console.warn('router push fail', e); }
          }
          return;
        }

        // if ln is object with path property that seems external
        if (ln && ln.external && (ln.path || ln.link)) {
          window.open(ln.path || ln.link, '_blank', 'noopener');
          return;
        }

        // last fallback: go to /library
        this.$router.push('/library').catch(()=>{});
      } catch (e) {
        console.error('openResource error', e);
      }
    },

    // 点击返回地图：先触发页面出场动画，再路由跳转
    handleBackMapClick() {
      if (this.navigatingToMap) return;
      this.navigatingToMap = true;
      // 动画时长与样式中保持一致 (360ms)
      setTimeout(() => {
        // push 路由
        this.$router.push('/map').catch(()=>{});
      }, 380);
    },

    normalizeForDisplay(raw) {
      if (raw == null) return '';
      return String(raw).replace(/\\r\\n/g, '\r\n').replace(/\\n/g, '\n');
    },

    escapeHtml(s) {
      return String(s)
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#39;");
    },

    htmlWithLineBreaks(raw) {
      if (raw == null) return ''; 
      const s = this.normalizeForDisplay(raw); // 把 literal \n => real \n
      return this.escapeHtml(s).replace(/\r\n/g, '<br>').replace(/\n/g, '<br>');
    },
  },

  // lifecycle (保留之前逻辑)
  async created() {
    try {
      const rootStyles = getComputedStyle(document.documentElement);
      const cssNav = rootStyles.getPropertyValue('--nav-height');
      if (cssNav) { const v = parseInt(cssNav.trim()); if (!isNaN(v)) this.navOffset = v; }
    } catch (e) {}

    try {
      const saved = localStorage.getItem('yp_lang');
      const allow = ['python', 'cpp', 'c', 'java', 'html', 'css', 'js'];
      if (saved && allow.includes(saved)) this.selectedLang = saved
      else this.selectedLang = 'python';
    } catch (e) { this.selectedLang = 'python' }

    try {
      const qQuery = this.$route && this.$route.query && this.$route.query.q ? Number(this.$route.query.q) : null;
      if (qQuery && !isNaN(qQuery) && qQuery >= 1) this.currentQuestionIndex = Math.max(0, qQuery - 1);
      else this.currentQuestionIndex = 0;
    } catch (e) { this.currentQuestionIndex = 0; }

    this._onStorage = (ev) => {
      if (ev.key === 'yp_lang') {
        const newLang = ev.newValue || 'python';
        this.handleLanguageChanged(newLang).catch(()=>{});
      }
    };
    this._onLanguageChanged = (ev) => {
      const newLang = ev && ev.detail && ev.detail.lang ? ev.detail.lang : null;
      if (newLang) this.handleLanguageChanged(newLang).catch(()=>{});
    };
    window.addEventListener('storage', this._onStorage);
    window.addEventListener('language-changed', this._onLanguageChanged);

    await this.loadUnitQuestionsFromServer();
    await this.loadFavoritesFromServer();

    if (this.token) {
      await this.fetchEnergy();
      await this.fetchMembership();
      await this.ensureEntryEnergyAndProgress();
    } else {
      await this.loadProgressRemoteIfAny();
    }
  },

  beforeUnmount() {
    if (this._onStorage) window.removeEventListener('storage', this._onStorage);
    if (this._onLanguageChanged) window.removeEventListener('language-changed', this._onLanguageChanged);
    if (typeof this.stopEnergyTimer === 'function') this.stopEnergyTimer();
    if (this.pasteFeedbackTimer) clearTimeout(this.pasteFeedbackTimer);
  },

  watch: {
    '$route.params.unitId'(newVal) {
      this.unitId = newVal;
      this.currentQuestionIndex = 0;
      this.feedback = null;
      this.selectedOption = null;
      this.disableOptions = false;
      this.attemptCount = 0;
      this.unitQuestions = [];
      this.favoritesIds = [];
      this.$router.replace({ path: `/study/${this.unitId}`, query: {} });
      this.loadUnitQuestionsFromServer().then(() => {
        if (this.token) this.ensureEntryEnergyAndProgress();
      });
      this.loadFavoritesFromServer();
      this.loadProgressRemoteIfAny();
    }
  },

  mounted() {
    if (typeof this.fetchEnergy === 'function') this.fetchEnergy();
    if (typeof this.fetchMembership === 'function') this.fetchMembership();

    try {
      const bgUrl = '../assets/StudyBackground.png'; // 若你用不同路径请修改
      const img = new Image();
      img.onload = () => {
        // 图片加载完成后在 html 上添加一个标识类，用于启用 ::after 渐变或任何后续效果
        document.documentElement.classList.add('bg-ready');
      };
      img.onerror = () => {
        // 失败也添加标识以避免长期等待（并可记录或回退）
        document.documentElement.classList.add('bg-ready');
        console.warn('Study background image failed to load:', bgUrl);
      };
      // 立刻触发加载
      img.src = bgUrl;
    } catch (e) {
      console.error('preload bg failed', e);
      // 兜底：也打上标识，避免一直没有 .bg-ready 造成样式不一致
      document.documentElement.classList.add('bg-ready');
    }
  }
};
</script>

<style scoped>
/* 主题色变量（组件内定义，便于整体调色） */
.study-root {
  --study-bg-image: url('../assets/StudyBackground.png');
  --bg: #f6eefb; /* 轻柔紫色背景兜底（可替换） */
  --brown-900: #33122e; /* 深色用于文本（偏紫） */
  --primary: #772180; /* 主要紫色（主题色） */
  --primary-600: #5e195f; /* 稍深的主色 */
  --accent: #f0d9ff; /* 柔和的浅紫/粉作为强调色 */
  --danger: #e14b4b;
  --muted: #56304f; /* 中性偏紫的文字色 */
  --card-bg: rgba(119,33,128,0.12); /* 用主题色作为卡片的半透明底色 */
  --card-border: rgba(119,33,128,0.12);
  --code-bg: #0b1220;
  --code-fg: #e6eef8;
  --output-bg: #0f1724;
  --output-fg: #c7f9d0;

  /* 背景由伪元素处理，root 本身透明 */
  background: transparent;
  min-height: calc(100vh - 0px);
  box-sizing: border-box;
  position: relative;
  transition: transform .36s cubic-bezier(.2,.9,.2,1), opacity .28s ease;
  z-index: 1;
}

/* ::before - 放图片本体（兜底色 + 图片） */
.study-root::before {
  content: "";
  position: fixed;
  inset: 0;
  z-index: 0;
  pointer-events: none;
  background-image: url('../assets/StudyBackground.png');
  background-position: top center;
  background-repeat: no-repeat;
  background-size: cover;
  background-color: var(--bg);
  will-change: transform;
}

/* 页面离场动画：向左淡出（用于本组件的局部触发） */
.page-leave {
  transform: translateX(-14px);
  opacity: 0;
}

/* Back button */
.back-map {
  position: fixed;
  left: 16px;
  top: 10px;
  z-index: 80;
  background: linear-gradient(180deg, rgba(255,255,255,0.96), rgba(250,246,255,0.9));
  border: 1px solid rgba(119,33,128,0.06);
  padding: 8px 10px;
  border-radius: 10px;
  box-shadow: 0 10px 30px rgba(61,22,61,0.06);
  cursor: pointer;
  font-weight: 700;
  transition: transform .14s ease, box-shadow .14s ease, background .14s ease;
  color: var(--brown-900);
}
.back-map:hover {
  transform: translateY(-4px);
  box-shadow: 0 20px 40px rgba(61,22,61,0.12);
  background: linear-gradient(180deg, rgba(255,250,255,1), rgba(255,244,255,0.95));
}

/* container */
.container {
  max-width: 1400px;
  margin: 12px auto;
  display: flex;
  flex-direction: column;
  gap: 12px;
  box-sizing: border-box;
  padding: 0 12px;
  position: relative;
  z-index: 2;
}

/* header/title */
/* 使用带主题色调的毛玻璃（半透明 tint） */
.header { display:flex; flex-direction:column; gap:10px; }
.title-wrap {
  /* 主题色半透明毛玻璃：顶部偏浅，底部偏更透明 */
  background: linear-gradient(180deg, rgba(119,33,128,0.14), rgba(94,25,95,0.06));
  border: 1px solid var(--card-border);
  padding: 18px;
  position: relative;
  overflow: visible;
  border-radius: 12px;
  -webkit-backdrop-filter: blur(12px) saturate(120%);
  backdrop-filter: blur(12px) saturate(120%);
  box-shadow: 0 14px 40px rgba(61,22,61,0.06);
}
.title-center { text-align: center; max-width: 920px; margin: 0 auto; position: relative; z-index: 2;}
.unit-title { margin:0; font-size:1.25rem; font-weight:900; color:var(--brown-900); display:inline-block; letter-spacing:0.2px; }
.unit-sub { margin-top:6px; color:var(--muted); font-size:0.95rem; margin-bottom:0; }
.lang-label { margin-top:6px;font-weight:700;color:var(--muted);font-size:0.9rem; }
.title-wrap .energy-block { position: absolute; right: 18px; top: 18px; display:flex; align-items:center; gap:10px; z-index: 2;}
.progress-wrap { margin-top:6px; }
.progress-bar-outer { width:100%; height:12px; background: rgba(94,25,95,0.10); border-radius:999px; overflow:hidden; }
.progress-bar-inner { height:100%; width:0%; background: linear-gradient(90deg, var(--primary), var(--primary-600)); transition: width 420ms ease; }

/* question 卡片与两列布局 */
.question-card { margin-top: 4px; background: transparent; border-radius: 14px; padding: 0; box-shadow: none; display: block; overflow: visible; z-index: 2;}
.qa-grid { display: grid; grid-template-columns: 1fr 500px; gap: 18px; align-items: start; }
.qa-grid--centered { grid-template-columns: 1fr; justify-items: center; }
.qa-main { min-width: 0; width: 100%; }
.qa-grid--centered .qa-main { max-width: 880px; width: 100%; }
.qa-side { width: 100%; max-width: 500px; align-self: start; position: sticky; top: calc(var(--nav-height,64px) + 16px); }

/* side card & resources - 主题色毛玻璃 tint */
.side-card {
  background: linear-gradient(180deg, rgba(119,33,128,0.12), rgba(94,25,95,0.06));
  border-radius: 12px;
  padding: 14px;
  border: 1px solid rgba(119,33,128,0.08);
  box-shadow: 0 14px 40px rgba(61,22,61,0.04);
  margin-bottom:12px;
  position: relative;
  -webkit-backdrop-filter: blur(12px) saturate(120%);
  backdrop-filter: blur(12px) saturate(120%);
}

/* resource-card（单个资料卡）主题色毛玻璃 + 悬停效果 */
.resource-card {
  cursor: pointer;
  transition: transform 260ms cubic-bezier(.2,.9,.2,1), box-shadow 260ms cubic-bezier(.2,.9,.2,1), border-color 180ms, background .18s;
  border: 1px solid rgba(119,33,128,0.08);
  background: linear-gradient(180deg, rgba(119,33,128,0.10), rgba(255,255,255,0.04));
  padding: 14px;
  border-radius: 12px;
  -webkit-backdrop-filter: blur(14px) saturate(120%);
  backdrop-filter: blur(14px) saturate(120%);
}
.resource-card:hover {
  transform: translateY(-8px) scale(1.01);
  box-shadow: 0 36px 80px rgba(119,33,128,0.12);
  border-color: rgba(119,33,128,0.22);
  background: linear-gradient(180deg, rgba(119,33,128,0.14), rgba(255,255,255,0.06));
}
.res-card-header { padding: 6px 0 10px 0; }
.res-title { font-weight:900; font-size:1.05rem; color:var(--brown-900); }
.res-sub { color:var(--muted); margin-top:6px; font-size:0.92rem; }
.res-card-foot { margin-top:10px; display:flex; align-items:center; justify-content:flex-start; gap:8px; }
.res-foot-text { color:var(--muted); font-size:0.9rem; }

/* q header 主体 */
.q-header { display:flex; justify-content:space-between; align-items:flex-start; gap:12px; margin-bottom:8px; position: relative; }
.q-header--center { justify-content:center; text-align:center; }
.q-header--center .q-left { flex: none; max-width: 860px; width:100%; }
.q-header--center .q-actions { position: absolute; right: 12px; top: 0; }
.q-left { flex:1; min-width:0; }
.q-index { color:var(--muted); font-weight:700; margin-bottom:6px; }
.q-title { font-size:1.15rem; font-weight:900; color:var(--brown-900); word-break:break-word; }

/* exec / editor (主区卡片) - 主题色毛玻璃主卡 */
.exec-area {
  background: linear-gradient(180deg, rgba(119,33,128,0.10), rgba(255,255,255,0.04));
  padding: 14px;
  border-radius: 12px;
  border: 1px solid rgba(119,33,128,0.06);
  box-shadow: 0 16px 48px rgba(61,22,61,0.04);
  -webkit-backdrop-filter: blur(12px) saturate(120%);
  backdrop-filter: blur(12px) saturate(120%);
}
.code-input {
  width:100%;
  box-sizing:border-box;
  font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, "Roboto Mono", "Helvetica Neue", monospace;
  font-size:0.95rem;
  padding:10px;
  border-radius:8px;
  border:1px solid rgba(119,33,128,0.06);
  background: var(--code-bg);
  color:var(--code-fg);
}
.colored-output { background: var(--output-bg); color: var(--output-fg); }
.colored-error { background: #fff4f4; color: var(--danger); border: 1px solid rgba(225,75,75,0.07); }

/* stdin row layout */
.stdin-row { display:flex; gap:10px; align-items:flex-start; margin-top:12px; flex-wrap:wrap; }
.stdin-actions { display:flex; flex-direction:column; gap:8px; min-width:120px; }
.stdin-area { flex:1; min-width:200px; }
.stdin-label { font-weight:700;color:var(--muted);margin-bottom:6px;display:block; }
.stdin-input { width:100%; padding:8px; border-radius:8px; border:1px solid rgba(119,33,128,0.06); font-family: ui-monospace,monospace; resize:vertical; min-height:56px; background: rgba(255,255,255,0.96); color: var(--brown-900); }
.stdin-paste { display:flex; flex-direction:column; gap:8px; min-width:88px; align-items:center; }
.paste-feedback { color:var(--accent); font-weight:700; font-size:0.85rem; }

/* button common effects */
.action-btn { transition: transform .14s ease, box-shadow .14s ease, opacity .12s ease, background .12s; }
.action-btn:hover { transform: translateY(-4px); box-shadow: 0 22px 44px rgba(119,33,128,0.08); }
.action-btn:active { transform: translateY(-1px) scale(0.995); }

/* 主按钮：采用主题色渐变（保持实心以便可点击感） */
.btn-primary {
  background: linear-gradient(90deg, var(--primary), var(--primary-600));
  color:white;
  border:none;
  padding:10px 14px;
  border-radius:10px;
  font-weight:900;
  cursor:pointer;
  box-shadow: 0 12px 30px rgba(119,33,128,0.14);
}
.btn-primary:hover { box-shadow: 0 20px 48px rgba(119,33,128,0.18); transform: translateY(-5px); }

/* 次按钮：带主题色的半透明风格以配合毛玻璃 */
.btn-try {
  background: linear-gradient(180deg, rgba(119,33,128,0.06), rgba(255,255,255,0.02));
  border:1px solid rgba(119,33,128,0.06);
  padding:8px 12px;
  border-radius:10px;
  font-weight:800;
  cursor:pointer;
  color:var(--brown-900);
  -webkit-backdrop-filter: blur(6px) saturate(110%);
  backdrop-filter: blur(6px) saturate(110%);
}
.btn-try:hover { background: linear-gradient(180deg, rgba(119,33,128,0.10), rgba(255,255,255,0.04)); box-shadow: 0 12px 30px rgba(119,33,128,0.06); }

/* options grid & option buttons - 半透明带色卡片式 */
.options-grid { display:grid; grid-template-columns: repeat(2, 1fr); gap: 12px; }
.opt-btn {
  display:flex; justify-content:space-between; align-items:center; padding: 12px 14px; border-radius: 12px;
  background: linear-gradient(180deg, rgba(119,33,128,0.08), rgba(255,255,255,0.02));
  border:1px solid rgba(119,33,128,0.06);
  box-shadow: 0 10px 26px rgba(61,22,61,0.04);
  cursor:pointer; transition: transform 160ms ease, box-shadow 160ms ease, background 160ms ease;
  font-weight:800; color:var(--brown-900); min-height:56px; text-align:left;
  -webkit-backdrop-filter: blur(8px) saturate(110%);
  backdrop-filter: blur(8px) saturate(110%);
}
.opt-btn:hover:not(.disabled) { transform: translateY(-6px); box-shadow: 0 22px 46px rgba(119,33,128,0.06); }
.opt-left { display:flex; gap:12px; align-items:flex-start; flex:1; min-width:0; }
.bullet { width:36px; height:36px; display:flex; align-items:center; justify-content:center; border-radius:10px; background: linear-gradient(180deg, rgba(255,255,255,0.96), rgba(255,250,255,0.9)); color:var(--primary); font-weight:900; box-shadow: 0 6px 18px rgba(119,33,128,0.06); flex:0 0 36px; }
.opt-label { white-space:normal; word-break:break-word; }
.opt-right { flex:0 0 auto; display:flex; align-items:center; gap:8px; margin-left:12px; white-space:nowrap; }
.opt-btn.selected { border-color: rgba(119,33,128,0.9); box-shadow: 0 18px 40px rgba(119,33,128,0.08); }
.opt-btn.correct { border-color:#16a34a; background: linear-gradient(90deg, rgba(16,185,129,0.06), rgba(16,185,129,0.03)); transform: translateY(-2px); }
.opt-btn.wrong { border-color:var(--danger); background: linear-gradient(90deg, rgba(225,75,75,0.06), rgba(225,75,75,0.02)); }

/* feedback / hints (也使用主题色半透明毛玻璃) */
.hint-box {
  margin-top: 12px;
  background: linear-gradient(180deg, rgba(119,33,128,0.06), rgba(255,255,255,0.02));
  border:1px solid rgba(119,33,128,0.06);
  padding:10px 12px;
  border-radius:10px;
  color:var(--brown-900);
  font-weight:700;
  -webkit-backdrop-filter: blur(10px) saturate(110%);
  backdrop-filter: blur(10px) saturate(110%);
}
.feedback-area { margin-top:12px; }
.feedback {
  display:flex; gap:12px; align-items:flex-start; padding:12px; border-radius:12px;
  background: linear-gradient(180deg, rgba(255,255,255,0.02), rgba(119,33,128,0.04));
  border: 1px solid rgba(119,33,128,0.06);
  -webkit-backdrop-filter: blur(10px) saturate(110%);
  backdrop-filter: blur(10px) saturate(110%);
}
.feedback.success { border-color: rgba(16,185,129,0.08); }
.feedback.fail { border-color: rgba(225,75,75,0.06); }
.explanation { margin-top:8px; color:var(--brown-900); }
.example { margin-top:8px; font-size:0.95rem; }
.code { background: var(--code-bg); color: var(--code-fg); padding:8px; border-radius:8px; font-family:monospace; white-space:pre-wrap; }

/* --- Energy UI --- */
.energy-block { display:flex; align-items:center; gap:10px; margin-left:6px; }
.battery { position: relative; width: 56px; height: 28px; border-radius: 4px; border: 2px solid rgba(15,23,42,0.12); overflow: hidden; background: linear-gradient(180deg,#ffffff,#f3f4f6); box-shadow: 0 6px 16px rgba(2,6,23,0.04); }
.battery.low { border-color: #ef4444; }
.battery .battery-level {
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 50%;
  background: linear-gradient(90deg,#8bd3a6,#34d399);
  transition: width 420ms linear;
}
.battery .battery-cap {
  position: absolute;
  right: -8px;
  top: 25%;
  width: 6px;
  height: 50%;
  background: linear-gradient(180deg,#ffffff,#e6eef8);
  border-radius: 2px;
  border: 1px solid rgba(15,23,42,0.04);
}
.battery-disabled { opacity: 0.6; filter: grayscale(0.3); }
.energy-meta { display:flex; flex-direction:column; gap:4px; font-size:12px; color:#374151; margin-left:6px; }
.energy-numbers { font-weight:800; color:#0b1220; display:flex; align-items:center; gap:6px; }
.energy-subsmall { color:#6b7280; font-weight:700; font-size:11px; }
.battery-level { height: 100%; background: linear-gradient(90deg,#8bd3a6,#34d399); transition: width 0.3s ease; }
.battery.vip .battery-level { background: linear-gradient(90deg, #facc15, #eab308); }

/* 保留空格与换行；允许换行折行 */
.preserve {
  white-space: pre-wrap;    /* 保留空白和换行，但允许折行 */
  word-break: break-word;
  /* 如果你需要等宽显示（可选）：
  font-family: ui-monospace, "SFMono-Regular", Menlo, Monaco, "Roboto Mono", monospace;
  */
}


/* small screens */
@media (max-width:1100px) {
  .qa-grid { grid-template-columns: 1fr 1fr; gap:12px; }
  .qa-side { position: static; top: auto; max-width: none; width: 100%; }
}
@media (max-width:900px) {
  .qa-grid { grid-template-columns: 1fr; gap: 12px; }
  .title-wrap .energy-block { position: static; margin-top:10px; }
  .options-grid { grid-template-columns: 1fr; }
  .title-center { text-align: left; }
  .container { padding: 10px; }
}
</style>