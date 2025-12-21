<template>
  <div class="choice-root" :class="{ 'state-correct': state === 'correct', 'state-wrong': state === 'wrong' }">
    <header class="choice-header">
      <!-- 题号（与标题并列，左对齐） -->
      <div class="q-number-wrap">
        <div class="q-number">{{ displayIndex }}</div>
      </div>

      <!-- 标题左对齐在同一行 -->
      <h2 class="q-title" v-html="localQuestion.title || '未命名题目'"></h2>
    </header>

    <!-- 问题文字居中 -->
    <div class="q-text" v-if="localQuestion.text" v-html="localQuestion.text"></div>

    <form class="options" @submit.prevent="onSubmit" aria-label="选择题选项">
      <label
        v-for="(opt, i) in parsedOptions"
        :key="i"
        :class="[
          'option',
          {
            selected: selectedOption === i,
            disabled: inputDisabled,
            correct: state === 'correct' && (i+1) === parsedAnswer,
            wrong: wrongSetHas(i)
          }
        ]"
        :aria-pressed="selectedOption === i"
      >
        <input
          type="radio"
          :name="'choice-' + displayIndex"
          :value="i"
          v-model.number="selectedOption"
          :disabled="inputDisabled || wrongSetHas(i)"
          class="visually-hidden"
        />
        <!-- 字母在最左端（绝对定位） -->
        <span class="opt-key">{{ optionKey(i) }}</span>
        <!-- 文字在卡片中间居中 -->
        <span class="opt-text" v-html="opt"></span>
      </label>

      <div class="controls">
        <button type="submit" :disabled="selectedOption === null || inputDisabled" class="btn-submit">
          提交
        </button>
      </div>
    </form>

    <div class="feedback" aria-live="polite">
      <div v-if="attempts > 0 && state === 'correct'" class="feedback-correct">
        ✅ 回答正确
      </div>
      <div v-else-if="attempts > 0 && state === 'wrong'" class="feedback-wrong">
        ❌ 回答错误，请再试一次
      </div>
    </div>

    <!-- hints area (shown only when last submission was wrong) -->
    <div v-if="currentHint" class="hint-box" style="margin-top:10px;">
      <strong>提示：</strong>
      <div v-html="currentHint"></div>
    </div>

    <!-- explanation area + next button (shown when correct) -->
    <div v-if="state === 'correct'" class="explain-box" style="margin-top:12px;">
      <div v-if="localQuestion.explanation" class="explanation" v-html="localQuestion.explanation"></div>
      <div style="margin-top:10px; display:flex; gap:8px; align-items:center;">
        <button
          class="btn-next"
          @click="onNextClick"
          :disabled="nextDisabled"
        >
          {{ isLastQuestion ? '完成单元' : '下一题' }}
        </button>
        <div v-if="saveNotice" style="color:#ddd; font-size:13px;">{{ saveNotice }}</div>
      </div>
    </div>

    <div v-if="internalError" class="hint-box" style="margin-top:10px; color:#ffb4b4;">
      {{ internalError }}
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue';

const props = defineProps({
  question: { type: Object, required: true },
  questionIndex: { type: Number, required: true },
  language: { type: String, default: 'py' },
  unitId: { type: [String, Number], default: '' },
  token: { type: String, default: '' },
  disabled: { type: Boolean, default: false },
  totalQuestions: { type: Number, default: 15 }
});

const emit = defineEmits(['correct', 'next']);

// local state
const localQuestion = ref(props.question ? { ...props.question } : {});
const selectedOption = ref(null); // 当前被选中的 option index（0-based）
const attempts = ref(0);
const state = ref('idle'); // 'idle' | 'correct' | 'wrong'
const internalError = ref('');
const saveNotice = ref('');
const nextDisabled = ref(false);

// 已尝试错误集合（0-based index）—— 错误选项保持红色并不可再选
const wrongSet = ref(new Set());

// 记录最近一次提交是否为错误 —— 用于控制提示显示逻辑
const lastSubmissionWasWrong = ref(false);

// 全局禁用（父组件禁用或已答对）
const inputDisabled = computed(() => props.disabled || state.value === 'correct');

// displayIndex 只显示数字（对 0 做容错）
const displayIndex = computed(() => {
  if (props.questionIndex !== undefined && props.questionIndex !== null) return props.questionIndex;
  if (localQuestion.value?.q_id !== undefined && localQuestion.value?.q_id !== null) return localQuestion.value.q_id;
  if (localQuestion.value?.id !== undefined && localQuestion.value?.id !== null) return localQuestion.value.id;
  return '-';
});

// parse options（保留原有健壮解析）
const parsedOptions = computed(() => {
  const opts = localQuestion.value?.options ?? [];
  if (!opts) return [];
  if (Array.isArray(opts)) return opts.map(o => String(o));
  if (typeof opts === 'string') {
    try {
      const parsed = JSON.parse(opts);
      if (Array.isArray(parsed)) return parsed.map(o => String(o));
      if (parsed && typeof parsed === 'object') {
        const keys = Object.keys(parsed);
        const order = ['A','B','C','D','1','2','3','4'];
        keys.sort((a,b) => {
          const ia = order.indexOf(a) >= 0 ? order.indexOf(a) : 999;
          const ib = order.indexOf(b) >= 0 ? order.indexOf(b) : 999;
          return ia - ib;
        });
        return keys.map(k => String(parsed[k] ?? ''));
      }
    } catch (e) {
      return opts.split(/\r?\n/).map(s => s.trim()).filter(Boolean);
    }
  }
  if (typeof opts === 'object') {
    const keys = Object.keys(opts);
    return keys.map(k => String(opts[k] ?? ''));
  }
  return [];
});

// parsed answer (1-based)
const parsedAnswer = computed(() => {
  const a = localQuestion.value?.answer;
  if (a == null) return null;
  if (typeof a === 'number') return a;
  if (typeof a === 'string') {
    try {
      const j = JSON.parse(a);
      if (Array.isArray(j)) return (Number(j[0]) || null);
    } catch {}
    const n = parseInt(a, 10);
    return Number.isNaN(n) ? null : n;
  }
  return null;
});

function optionKey(i) {
  return String.fromCharCode(65 + i);
}

// current hint only when last submission was wrong and attempts > 0
const currentHint = computed(() => {
  if (!lastSubmissionWasWrong.value) return null;
  if (attempts.value <= 0) return null;
  const hs = localQuestion.value?.hints ?? null;
  if (!hs) return null;
  const arr = Array.isArray(hs) ? hs : (typeof hs === 'string' ? (() => {
    try { const p = JSON.parse(hs); if (Array.isArray(p)) return p; } catch {} return hs.split(/\r?\n/).map(s=>s.trim()).filter(Boolean);
  })() : null);
  if (!arr || arr.length === 0) return null;
  // attempts counts number of submissions (including correct first try)
  // for hints we index by wrong-attempts count. If you prefer hints to base on total attempts,
  // keep as-is; otherwise we could track wrongAttempts separately. For now use attempts index:
  const idx = Math.max(0, Math.min(arr.length - 1, attempts.value - 1));
  return arr[idx] ?? null;
});

// whether last question
const isLastQuestion = computed(() => {
  const t = Number(props.totalQuestions) || 15;
  return Number(props.questionIndex) >= t;
});

// helper to check wrongSet
function wrongSetHas(i) {
  return wrongSet.value.has(i);
}

// reset UI when question changes or user triggers reset (no visible reset button in UI)
function reset() {
  selectedOption.value = null;
  attempts.value = 0;
  state.value = 'idle';
  internalError.value = '';
  saveNotice.value = '';
  nextDisabled.value = false;
  wrongSet.value = new Set();
  lastSubmissionWasWrong.value = false;
}

// submission handling
function onSubmit() {
  if (inputDisabled.value) return;
  if (selectedOption.value === null) return;

  const chosenIndex = selectedOption.value;       // 0-based
  const chosen1 = chosenIndex + 1;                // 1-based for comparison
  attempts.value += 1;

  const correct = parsedAnswer.value === chosen1;

  if (correct) {
    // 答对：显示绿色，禁止进一步操作，通知父组件
    state.value = 'correct';
    lastSubmissionWasWrong.value = false; // <-- important: correct -> do not show hint
    console.log('[Choice] emit correct', { questionIndex: props.questionIndex, attempts: attempts.value });
    emit('correct', { questionIndex: props.questionIndex, attempts: attempts.value });
  } else {
    // 错误：把该选项加入 wrongSet，显示 wrong 动画，不显示正确项
    wrongSet.value.add(chosenIndex);

    state.value = 'wrong';
    lastSubmissionWasWrong.value = true; // <-- important: wrong -> allow hint to show

    // 清除 selectedOption 以便用户选择新选项时显示蓝色（但错误项保持红色）
    selectedOption.value = null;

    // 短暂显示错误动画后恢复为 idle
    setTimeout(() => {
      state.value = 'idle';
    }, 900);
  }
}

// 下一题
function onNextClick() {
  if (state.value !== 'correct') return;
  nextDisabled.value = true;
  const nextIndex = props.questionIndex + 1;
  console.log('[Choice] emit next', { questionIndex: props.questionIndex, nextIndex });
  emit('next', { questionIndex: props.questionIndex, nextIndex });
  setTimeout(() => { nextDisabled.value = false; }, 800);
}

// watch for parent question changes
watch(() => props.question, (q) => {
  localQuestion.value = q ? { ...q } : {};
  reset();
}, { immediate: true });

watch(() => props.questionIndex, () => {
  reset();
});
</script>

<style scoped>
/* 容器：黑底白字 */
.choice-root {
  padding: 22px;
  margin-top: 10px;
  margin-left: 15%;
  margin-right: 15%;
  border-radius: 30px;
  background: #1c1c1c;
  color: #fff;
  box-shadow: 12px 12px 36px rgba(194, 194, 194, 0.7);
  font-family: Inter, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial;
}
@media (max-width: 900px) {
  .choice-root {
    margin-left: 2.5%;
    margin-right: 2.5%;
  }
}

/* Header：题号与标题并列，左对齐 */
.choice-header {
  display:flex;
  flex-direction:row;
  align-items:center;
  gap:12px;
  margin-bottom:16px;
  padding-left:12px; /* 稍微的左内边距 */
}

/* 渐变圆形底包裹题号（小圆） */
.q-number-wrap {
  width:56px;
  height:56px;
  border-radius:50%;
  display:flex;
  align-items:center;
  justify-content:center;
  /* 渐变色底（可调整颜色） */
  background: linear-gradient(135deg,#ff7a18 0%, #af002d 50%, #6a11cb 100%);
  box-shadow: 0 6px 18px rgba(0,0,0,0.6), inset 0 -6px 18px rgba(255,255,255,0.04);
}
@media (max-width: 900px) {
  .q-number-wrap {
    width: 44px;
    height: 44px;
  }
}

/* 题号数字样式 */
.q-number {
  font-size:18px;
  font-weight:800;
  color:#fff;
  line-height:1;
}

/* 标题左对齐（在同一行） */
.q-title {
  margin:0;
  font-size:18px;
  color:#fff;
  font-weight:700;
}

/* 问题文本仍居中 */
.q-text {
  margin:12px 0 24px 0;
  color:#e6eef8;
  text-align:center;
  font-size:19px;
}

/* 选项使用 2 列网格：AB 第一行，CD 第二行 */
.options {
  display:grid;
  grid-template-columns: 1fr 1fr; /* 两列 */
  gap:14px;
}
@media (max-width: 900px) {
  .options {
    grid-template-columns: 1fr;
  }
}

/* 单个 option 样式（变大、居中、纯白色边框） */
.option {
  position:relative;            /* 为左侧字母绝对定位留位置 */
  display:flex;
  align-items:center;
  justify-content:center;
  gap:10px;
  padding:18px 18px 18px 86px;  /* 给左侧字母留出空间（padding-left） */
  border-radius:12px;
  border:2px solid #fff;        /* 纯白色边框（基线） */
  cursor:pointer;
  transition: all .14s ease;
  background: rgba(255,255,255,0.02);
  min-height:72px;              /* 更大尺寸 */
  box-sizing:border-box;
  overflow:hidden;
}
@media (max-width: 900px) {
  .option {
    min-height: 60px;
  }
}

/* 悬停略微抬起 */
.option:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 26px rgba(0,0,0,0.65);
}

/* A/B/C/D 字母：绝对定位在卡片最左端 */
.opt-key {
  position:absolute;
  left:16px;
  top:50%;
  transform:translateY(-50%);
  width:44px;
  height:44px;
  display:inline-flex;
  align-items:center;
  justify-content:center;
  background:#0e78e9;
  color:#fff;
  border-radius:10px;
  font-weight:800;
  font-size:16px;
  flex-shrink:0;
  box-shadow: 0 4px 10px rgba(0,0,0,0.5);
}
@media (max-width: 900px) {
  .opt-key {
    width: 35px;
    height: 35px;
    font-size: 14px;
  }
}

/* 选项文本：水平垂直居中显示（视觉中心） */
.opt-text {
  flex:1;
  color:#fff;
  font-size:16px;
  line-height:1.3;
  text-align:center;
  word-break:break-word;
  padding-right:12px; /* 避免靠右边太紧 */
}

/* 选中（蓝色）—— 更明显的蓝色边框与背景 */
.option.selected {
  border-color: #0a66ff;
  background: linear-gradient(90deg,#03243f, #06324f);
  box-shadow: 0 12px 30px rgba(10,102,255,0.12);
}

/* 全局禁用（例如答对后） */
.option.disabled {
  opacity: 0.6;
  pointer-events: none;
}

/* 错误项（更明显的红色）—— 已被尝试过且不可再选；保持红色且边框为红色 */
.option.wrong {
  border-color: #ff3b30;
  background: linear-gradient(90deg, rgba(255,59,48,0.15), rgba(255,59,48,0.06));
  color: #fff;
  pointer-events: none;
  box-shadow: 0 8px 20px rgba(255,59,48,0.06);
}

/* 正确项（更明显的绿色）—— 仅在 state === 'correct' 时显示 */
.option.correct {
  border-color: #22c55e;
  background: linear-gradient(90deg, rgba(34,197,94,0.14), rgba(34,197,94,0.04));
  box-shadow: 0 12px 30px rgba(34,197,94,0.08);
}

/* 控件区域：提交按钮横跨两列 */
.controls {
  grid-column: 1 / -1;
  display:flex;
  align-items:center;
  gap:12px;
  margin-top:12px;
  justify-content:center;
}
.btn-submit {
  padding:12px 18px;
  background:#0e78e9;
  color:#fff;
  border-radius:10px;
  border:none;
  cursor:pointer;
  font-weight:700;
  font-size:15px;
}
.btn-submit[disabled] {
  opacity:0.5;
  cursor:not-allowed;
}

/* 反馈文字 */
.feedback { margin-top:14px; min-height:26px; text-align:center; }
.feedback-correct { color:#7ff1b1; font-weight:800; animation: popIn .28s ease both; }
.feedback-wrong { color:#ff9b9b; font-weight:800; animation: popShake .45s cubic-bezier(.36,.07,.19,.97) both; }

@keyframes popIn {
  0% { transform: scale(.95); opacity: 0; }
  60% { transform: scale(1.04); opacity: 1; }
  100% { transform: scale(1); opacity: 1; }
}
@keyframes popShake {
  0% { transform: translateX(0); }
  20% { transform: translateX(-6px); }
  40% { transform: translateX(6px); }
  60% { transform: translateX(-4px); }
  80% { transform: translateX(4px); }
  100% { transform: translateX(0); }
}

/* 错误时整体抖动 */
.state-wrong .options { animation: shakeContainer .45s cubic-bezier(.36,.07,.19,.97); }
@keyframes shakeContainer {
  0% { transform: translateX(0); }
  20% { transform: translateX(-6px); }
  40% { transform: translateX(6px); }
  60% { transform: translateX(-4px); }
  80% { transform: translateX(4px); }
  100% { transform: translateX(0); }
}

/* 答对时的外观（卡片轻微发光） */
.state-correct { box-shadow: 0 14px 40px rgba(34,197,94,0.08); transition: box-shadow .3s ease; outline: 1px solid rgba(34,197,94,0.06); }

/* 隐藏但可访问的 input */
.visually-hidden { position: absolute !important; height: 1px; width: 1px; overflow: hidden; clip: rect(1px,1px,1px,1px); white-space: nowrap; border:0; padding:0; margin:-1px; }

/* 提示 / 解释 框（暗主题适配） */
.hint-box {
  padding:12px;
  border-radius:10px;
  background: rgba(255,255,255,0.02);
  color:#ffb4b4;
  margin-top:10px;
  border:1px solid rgba(255,255,255,0.03);
}

.explain-box {
  padding:14px;
  border-radius:20px;
  background: rgba(0, 0, 0, 0.351);
  border:1px solid rgba(255, 255, 255, 0.273);
  color:#dbeefe;
}
.btn-next {
  padding:10px 14px;
  background:#0e78e9;
  color:#fff;
  border-radius:10px;
  border:none;
  cursor:pointer;
  font-weight:700;
}
</style>