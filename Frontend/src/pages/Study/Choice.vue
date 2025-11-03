<template>
  <div class="choice-root" :class="{ 'state-correct': state === 'correct', 'state-wrong': state === 'wrong' }">
    <header class="choice-header">
      <div class="q-number">题号：{{ displayIndex }}</div>
      <h2 class="q-title" v-html="localQuestion.title || '未命名题目'"></h2>
    </header>

    <div class="q-text" v-if="localQuestion.text" v-html="localQuestion.text"></div>

    <form class="options" @submit.prevent="onSubmit" aria-label="选择题选项">
      <label
        v-for="(opt, i) in parsedOptions"
        :key="i"
        :class="['option', {
          selected: selectedOption === i,
          disabled: inputDisabled,
          correct: reveal && (i+1) === parsedAnswer,
          wrong: reveal && selectedOption === i && (i+1) !== parsedAnswer
        }]"
        :aria-pressed="selectedOption === i"
      >
        <input
          type="radio"
          :name="'choice-' + displayIndex"
          :value="i"
          v-model.number="selectedOption"
          :disabled="inputDisabled"
          class="visually-hidden"
        />
        <span class="opt-key">{{ optionKey(i) }}</span>
        <span class="opt-text" v-html="opt"></span>
      </label>

      <div class="controls">
        <button type="submit" :disabled="selectedOption === null || inputDisabled" class="btn-submit">
          提交
        </button>
        <button type="button" @click="reset" class="btn-reset" :disabled="inputDisabled && state === 'correct'">重试</button>
        <div class="attempts">次数：{{ attempts }}</div>
      </div>
    </form>

    <div class="feedback" aria-live="polite">
      <div v-if="state === 'correct'" class="feedback-correct">
        ✅ 回答正确
      </div>
      <div v-else-if="state === 'wrong'" class="feedback-wrong">
        ❌ 回答错误，请再试一次
      </div>
    </div>

    <!-- hints area (shown when wrong and hint available) -->
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
        <div v-if="saveNotice" style="color:#666; font-size:13px;">{{ saveNotice }}</div>
      </div>
    </div>

    <div v-if="internalError" class="hint-box" style="margin-top:10px; color:#c23a2b;">
      {{ internalError }}
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue';

const props = defineProps({
  // parent provides full question object (including answer/hints/explanation)
  question: { type: Object, required: true },
  questionIndex: { type: Number, required: true },
  language: { type: String, default: 'py' },
  unitId: { type: [String, Number], default: '' },
  token: { type: String, default: '' },
  // parent can disable all inputs temporarily
  disabled: { type: Boolean, default: false },
  // total questions for this unit (used to know last question)
  totalQuestions: { type: Number, default: 15 }
});

// emits:
// 'correct' -> payload { questionIndex, attempts }
// 'next' -> payload { questionIndex, nextIndex }
const emit = defineEmits(['correct', 'next']);

// local state
const localQuestion = ref(props.question ? { ...props.question } : {});
const selectedOption = ref(null); // 0-based
const attempts = ref(0);
const state = ref('idle'); // 'idle' | 'correct' | 'wrong'
const reveal = ref(false); // whether to reveal correct/wrong highlights
const internalError = ref('');
const saveNotice = ref(''); // small notice area next to next button (populated by parent via props? kept here for future)
const nextDisabled = ref(false);

// input disabled state considers parent disabled or when answered correct we keep inputs disabled
const inputDisabled = computed(() => props.disabled || state.value === 'correct');

// display index
const displayIndex = computed(() => {
  if (props.questionIndex) return props.questionIndex;
  if (localQuestion.value?.q_id) return localQuestion.value.q_id;
  if (localQuestion.value?.id) return localQuestion.value.id;
  return '-';
});

// parse options (keeps original robust parsing)
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

// current hint to show based on attempts (1-based attempts)
const currentHint = computed(() => {
  const hs = localQuestion.value?.hints ?? null;
  if (!hs) return null;
  const arr = Array.isArray(hs) ? hs : (typeof hs === 'string' ? (() => {
    try { const p = JSON.parse(hs); if (Array.isArray(p)) return p; } catch {} return hs.split(/\r?\n/).map(s=>s.trim()).filter(Boolean);
  })() : null);
  if (!arr || arr.length === 0) return null;
  const idx = Math.max(0, Math.min(arr.length - 1, attempts.value - 1));
  return arr[idx] ?? null;
});

// whether this is the last question
const isLastQuestion = computed(() => {
  const t = Number(props.totalQuestions) || 15;
  return Number(props.questionIndex) >= t;
});

// reset UI when question changes
function reset() {
  selectedOption.value = null;
  attempts.value = 0;
  state.value = 'idle';
  reveal.value = false;
  internalError.value = '';
  saveNotice.value = '';
  nextDisabled.value = false;
}

// submission handling: judge locally, show hints, emit correct only when correct
function onSubmit() {
  if (inputDisabled.value) return;
  if (selectedOption.value === null) return;
  attempts.value += 1;
  const chosen1 = selectedOption.value + 1;
  const correct = parsedAnswer.value === chosen1;
  reveal.value = true;

  if (correct) {
    state.value = 'correct';
    // emit correct event with attempts count
    emit('correct', { questionIndex: props.questionIndex, attempts: attempts.value });
    // show explanation (child renders it) and show Next button
    // do NOT auto-advance; wait for user to click Next
  } else {
    state.value = 'wrong';
    // do not notify parent on wrong; just show hint (via currentHint computed)
    // allow retry after a short animation
    setTimeout(() => {
      state.value = 'idle';
      // keep reveal true so correct option is highlighted if you want; but we keep reveal true to show correct highlight
      // However we set state back to idle so inputs are usable
    }, 900);
  }
}

// when user clicks Next (only available when state === 'correct'), emit 'next'
function onNextClick() {
  if (state.value !== 'correct') return;
  nextDisabled.value = true;
  const nextIndex = props.questionIndex + 1;
  // emit next with both the current and next index (parent will clamp/handle completion)
  emit('next', { questionIndex: props.questionIndex, nextIndex });
  // re-enable later if needed (parent likely will replace component)
  setTimeout(() => { nextDisabled.value = false; }, 800);
}

// watch for parent question change
watch(() => props.question, (q) => {
  localQuestion.value = q ? { ...q } : {};
  reset();
}, { immediate: true });

watch(() => props.questionIndex, () => {
  // when parent programmatically changes index, reset local state
  reset();
});
</script>

<style scoped>
.choice-root { padding: 14px; background: #fff; border-radius: 10px; box-shadow: 0 6px 18px rgba(12,18,30,0.04); font-family: Inter, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial; color: #111; }

.choice-header { display:flex; flex-direction:column; gap:6px; margin-bottom:10px; }
.q-number { font-size:13px; color:#666; }
.q-title { margin:0; font-size:18px; }

.q-text { margin-bottom:12px; color:#333; }

.options { display:flex; flex-direction:column; gap:10px; }
.option { display:flex; align-items:flex-start; gap:12px; padding:10px 12px; border-radius:10px; border:1px solid transparent; cursor:pointer; transition: all .18s ease; background: #fafafa; }
.option:hover { transform: translateY(-2px); box-shadow: 0 6px 18px rgba(12,18,30,0.03); }
.option.selected { outline: 2px solid rgba(14,120,233,0.12); background: #f0f8ff; }
.option.disabled { opacity: 0.7; pointer-events: none; }

.opt-key { min-width:34px; height:34px; display:inline-flex; align-items:center; justify-content:center; background:#0e78e9; color:#fff; border-radius:8px; font-weight:700; }
.opt-text { flex:1; color:#111; }

.option.correct { border:1px solid #c7f0d0; background: linear-gradient(90deg,#f7fff6,#f0fff2); }
.option.wrong { border:1px solid #ffd7d7; background: linear-gradient(90deg,#fff6f6,#fff1f1); }

.controls { display:flex; align-items:center; gap:12px; margin-top:8px; }
.btn-submit { padding:8px 14px; background:#0e78e9; color:#fff; border-radius:8px; border:none; cursor:pointer; }
.btn-reset { padding:6px 10px; background:#fff; border:1px solid #ddd; border-radius:8px; cursor:pointer; }
.attempts { color:#666; font-size:13px; margin-left:auto; }

.feedback { margin-top:12px; min-height:24px; }
.feedback-correct { color:#0a8a3a; font-weight:700; animation: popIn .28s ease both; }
.feedback-wrong { color:#c23a2b; font-weight:700; animation: popShake .45s cubic-bezier(.36,.07,.19,.97) both; }

@keyframes popIn {
  0% { transform: scale(.9); opacity: 0; }
  60% { transform: scale(1.05); opacity: 1; }
  100% { transform: scale(1); opacity: 1; }
}
@keyframes popShake {
  0% { transform: translateX(0); }
  20% { transform: translateX(-8px); }
  40% { transform: translateX(8px); }
  60% { transform: translateX(-6px); }
  80% { transform: translateX(6px); }
  100% { transform: translateX(0); }
}

.state-wrong .options { animation: shakeContainer .45s cubic-bezier(.36,.07,.19,.97); }
@keyframes shakeContainer {
  0% { transform: translateX(0); }
  20% { transform: translateX(-6px); }
  40% { transform: translateX(6px); }
  60% { transform: translateX(-4px); }
  80% { transform: translateX(4px); }
  100% { transform: translateX(0); }
}

.state-correct { box-shadow: 0 10px 30px rgba(2,160,90,0.06); border-radius:12px; transition: box-shadow .3s ease; outline: 1px solid rgba(2,160,90,0.08); }

.visually-hidden { position: absolute !important; height: 1px; width: 1px; overflow: hidden; clip: rect(1px,1px,1px,1px); white-space: nowrap; border:0; padding:0; margin:-1px; }

.hint-box { padding:8px 12px; border-radius:8px; background: #fff6f6; color:#c23a2b; margin-top:8px; }

.explain-box { padding:12px; border-radius:8px; background:#f7f9fc; border:1px solid #eef2f7; color:#0b3b58; }
.btn-next { padding:8px 12px; background:#0e78e9; color:#fff; border-radius:8px; border:none; cursor:pointer; }
</style>