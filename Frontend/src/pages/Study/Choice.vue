<template>
  <div class="choice-root" :class="{ 'state-correct': state === 'correct', 'state-wrong': state === 'wrong' }">
    <header class="choice-header">
      <div class="q-number">题号：{{ displayIndex }}</div>
      <h2 class="q-title" v-html="question.title || '未命名题目'"></h2>
    </header>

    <div class="q-text" v-if="question.text" v-html="question.text"></div>

    <form class="options" @submit.prevent="onSubmit" aria-label="选择题选项">
      <label
        v-for="(opt, i) in parsedOptions"
        :key="i"
        :class="['option', {
          selected: selectedOption === i,
          disabled: disabled,
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
          :disabled="disabled"
          class="visually-hidden"
        />
        <span class="opt-key">{{ optionKey(i) }}</span>
        <span class="opt-text" v-html="opt"></span>
      </label>

      <div class="controls">
        <button type="submit" :disabled="selectedOption === null || disabled" class="btn-submit">
          提交
        </button>
        <button type="button" @click="reset" class="btn-reset" :disabled="disabled && state === 'correct'">重试</button>
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
  </div>
</template>

<script setup>
import { ref, computed, watch, onMounted } from 'vue';
const props = defineProps({
  question: { type: Object, required: true },
  language: { type: String, default: 'py' },
  // 可选：当 Questions.vue 想传入序号时使用
  questionIndex: { type: Number, default: null }
});
const emit = defineEmits(['answered']);

// state
const selectedOption = ref(null); // 0-based index
const attempts = ref(0);
const state = ref('idle'); // 'idle' | 'correct' | 'wrong'
const reveal = ref(false);  // 是否显示正确/错误标识
const disabled = computed(() => state.value === 'correct');

// display index: 优先 questionIndex，然后 question.q_id，再 question.id
const displayIndex = computed(() => {
  if (props.questionIndex) return props.questionIndex;
  if (props.question?.q_id) return props.question.q_id;
  return props.question?.id ?? '-';
});

// parse options from question.options (string/object/array)
const parsedOptions = computed(() => {
  const opts = props.question?.options ?? [];
  if (!opts) return [];
  if (Array.isArray(opts)) return opts.map(o => String(o));
  if (typeof opts === 'string') {
    // try JSON parse
    try {
      const parsed = JSON.parse(opts);
      if (Array.isArray(parsed)) return parsed.map(o => String(o));
      if (parsed && typeof parsed === 'object') {
        // object -> order by keys A,B,C,D or 1,2,3...
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
      // not JSON => split by newlines
      return opts.split(/\r?\n/).map(s => s.trim()).filter(Boolean);
    }
  }
  if (typeof opts === 'object') {
    // object mapping
    const keys = Object.keys(opts);
    return keys.map(k => String(opts[k] ?? ''));
  }
  return [];
});

// parsed answer (question.answer expected as 1-based int or JSON)
const parsedAnswer = computed(() => {
  const a = props.question?.answer;
  if (a == null) return null;
  if (typeof a === 'number') return a; // 1-based
  if (typeof a === 'string') {
    // maybe JSON
    try {
      const j = JSON.parse(a);
      if (Array.isArray(j)) return (Number(j[0]) || null); // fallback
    } catch {}
    const n = parseInt(a, 10);
    return Number.isNaN(n) ? null : n;
  }
  return null;
});

// option key
function optionKey(i) {
  return String.fromCharCode(65 + i); // A, B, C...
}

// handle submit
function onSubmit() {
  if (selectedOption.value === null) return;
  attempts.value += 1;
  const chosenIndex1Based = selectedOption.value + 1;
  const correct = parsedAnswer.value === chosenIndex1Based;
  reveal.value = true;
  if (correct) {
    state.value = 'correct';
    // emit answered
    emit('answered', { correct: true, attempts: attempts.value, question: props.question });
  } else {
    // wrong: set state to wrong briefly to trigger animation, then back to idle to allow retry
    state.value = 'wrong';
    emit('answered', { correct: false, attempts: attempts.value, question: props.question });
    // allow retry after animation duration (e.g., 800ms)
    setTimeout(() => {
      // keep reveal true so correct option stays highlighted, but allow user to change selection
      state.value = 'idle';
    }, 900);
  }
}

// reset (manual)
function reset() {
  selectedOption.value = null;
  reveal.value = false;
  state.value = 'idle';
  attempts.value = 0;
}

// reset when question changes
watch(() => props.question, () => {
  reset();
}, { immediate: true });

onMounted(() => {
  // ensure selection cleared
  reset();
});
</script>

<style scoped>
.choice-root { padding: 14px; background: #fff; border-radius: 10px; box-shadow: 0 6px 18px rgba(12,18,30,0.04); font-family: Inter, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial; color: #111; }

/* header */
.choice-header { display:flex; flex-direction:column; gap:6px; margin-bottom:10px; }
.q-number { font-size:13px; color:#666; }
.q-title { margin:0; font-size:18px; }

/* question text */
.q-text { margin-bottom:12px; color:#333; }

/* options */
.options { display:flex; flex-direction:column; gap:10px; }
.option { display:flex; align-items:flex-start; gap:12px; padding:10px 12px; border-radius:10px; border:1px solid transparent; cursor:pointer; transition: all .18s ease; background: #fafafa; }
.option:hover { transform: translateY(-2px); box-shadow: 0 6px 18px rgba(12,18,30,0.03); }
.option.selected { outline: 2px solid rgba(14,120,233,0.12); background: #f0f8ff; }
.option.disabled { opacity: 0.7; pointer-events: none; }

.opt-key { min-width:34px; height:34px; display:inline-flex; align-items:center; justify-content:center; background:#0e78e9; color:#fff; border-radius:8px; font-weight:700; }
.opt-text { flex:1; color:#111; }

/* correct / wrong highlight when reveal */
.option.correct { border:1px solid #c7f0d0; background: linear-gradient(90deg,#f7fff6,#f0fff2); }
.option.wrong { border:1px solid #ffd7d7; background: linear-gradient(90deg,#fff6f6,#fff1f1); }

/* controls */
.controls { display:flex; align-items:center; gap:12px; margin-top:8px; }
.btn-submit { padding:8px 14px; background:#0e78e9; color:#fff; border-radius:8px; border:none; cursor:pointer; }
.btn-reset { padding:6px 10px; background:#fff; border:1px solid #ddd; border-radius:8px; cursor:pointer; }
.attempts { color:#666; font-size:13px; margin-left:auto; }

/* feedback */
.feedback { margin-top:12px; min-height:24px; }
.feedback-correct { color:#0a8a3a; font-weight:700; animation: popIn .28s ease both; }
.feedback-wrong { color:#c23a2b; font-weight:700; animation: popShake .45s cubic-bezier(.36,.07,.19,.97) both; }

/* animations */
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

/* state-specific container animations */
/* 在 wrong 状态时让整个选项区抖动一小下 */
.state-wrong .options { animation: shakeContainer .45s cubic-bezier(.36,.07,.19,.97); }
@keyframes shakeContainer {
  0% { transform: translateX(0); }
  20% { transform: translateX(-6px); }
  40% { transform: translateX(6px); }
  60% { transform: translateX(-4px); }
  80% { transform: translateX(4px); }
  100% { transform: translateX(0); }
}

/* 在 correct 状态时给容器一点绿色光晕 */
.state-correct { box-shadow: 0 10px 30px rgba(2,160,90,0.06); border-radius:12px; transition: box-shadow .3s ease; outline: 1px solid rgba(2,160,90,0.08); }

/* small accessibility helpers */
.visually-hidden { position: absolute !important; height: 1px; width: 1px; overflow: hidden; clip: rect(1px,1px,1px,1px); white-space: nowrap; border:0; padding:0; margin:-1px; }
</style>