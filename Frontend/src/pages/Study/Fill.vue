<template>
  <div class="fill-root" :class="{ 'state-correct': state==='correct', 'state-wrong': state==='wrong' }">
    <header class="fill-header">
      <div class="q-number">题号：{{ displayIndex }}</div>
      <h2 class="q-title" v-html="question.title || '未命名填空题'"></h2>
    </header>

    <div class="q-body">
      <div class="q-text" v-html="renderedText"></div>

      <div class="blanks-row" v-if="blanks.length">
        <div
          v-for="(b, idx) in blanks"
          :key="b.id"
          class="blank-slot"
          :class="{ occupied: !!b.item, highlight: dragOverIndex === idx }"
          @dragover.prevent="handleDragOverBlank($event, idx)"
          @dragenter.prevent="handleDragEnterBlank($event, idx)"
          @dragleave="handleDragLeaveBlank($event, idx)"
          @drop.prevent="handleDropToBlank($event, idx)"
        >
          <div
            v-if="b.item"
            class="slot-item"
            draggable="true"
            @dragstart="handleDragStartFromSlot($event, idx)"
            @dragend="handleDragEnd"
          >
            {{ b.item.label }}
          </div>
          <div v-else class="slot-placeholder">拖拽答案到此处</div>
        </div>
      </div>

      <div class="controls">
        <button class="btn-submit" @click="submitAnswers" :disabled="submitting">提交答案</button>
        <button class="btn-reset" @click="resetAll" :disabled="submitting">重置</button>
        <div class="attempts">尝试：{{ attempts }}</div>
      </div>

      <div
        class="options-pool"
        aria-label="可选答案池"
        @dragover.prevent
        @drop.prevent="handleDropToPool"
      >
        <h4>可选填项</h4>
        <div class="pool-list">
          <div
            v-for="(opt, i) in pool"
            :key="opt.id"
            class="pool-item"
            draggable="true"
            @dragstart="handleDragStartFromPool($event, i)"
            @dragend="handleDragEnd"
            :aria-grabbed="draggingFromPoolIndex === i"
          >
            {{ opt.label }}
          </div>
        </div>
      </div>

      <div class="feedback" aria-live="polite">
        <div v-if="state==='correct'" class="feedback-correct">✅ 回答全部正确</div>
        <div v-else-if="state==='wrong'" class="feedback-wrong">❌ 回答有误，请检查或重试</div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch, onMounted } from 'vue';

const props = defineProps({
  question: { type: Object, required: true },
  language: { type: String, default: 'py' },
  questionIndex: { type: Number, default: null }
});
const emit = defineEmits(['answered']);

const pool = ref([]); // available candidates
const blanks = ref([]); // blanks with item or null
const attempts = ref(0);
const state = ref('idle'); // idle | correct | wrong
const submitting = ref(false);

const draggingFromPoolIndex = ref(null);
const draggingFromSlotIndex = ref(null);
const dragOverIndex = ref(null);

const displayIndex = computed(() => {
  if (props.questionIndex) return props.questionIndex;
  if (props.question?.q_id) return props.question.q_id;
  return props.question?.id ?? '-';
});

function parseOptions(raw) {
  if (!raw) return [];
  if (Array.isArray(raw)) return raw.map((v, idx) => ({ id: `opt-${idx}`, label: String(v) }));
  if (typeof raw === 'string') {
    try {
      const parsed = JSON.parse(raw);
      if (Array.isArray(parsed)) return parsed.map((v, idx) => ({ id: `opt-${idx}`, label: String(v) }));
      if (parsed && typeof parsed === 'object') {
        const keys = Object.keys(parsed);
        return keys.map((k, idx) => ({ id: `opt-${k}-${idx}`, label: String(parsed[k]) }));
      }
    } catch (e) {
      return raw.split(/\r?\n/).filter(Boolean).map((v, idx) => ({ id: `opt-${idx}`, label: v.trim() }));
    }
  }
  if (typeof raw === 'object') {
    const keys = Object.keys(raw);
    return keys.map((k, idx) => ({ id: `opt-${k}-${idx}`, label: String(raw[k]) }));
  }
  return [];
}

function parseAnswer(raw) {
  if (raw == null) return null;
  if (Array.isArray(raw)) return raw.map(v => String(v));
  if (typeof raw === 'string') {
    try {
      const parsed = JSON.parse(raw);
      if (Array.isArray(parsed)) return parsed.map(v => String(v));
    } catch {}
    return raw.split(',').map(s => s.trim());
  }
  return [String(raw)];
}

const renderedText = computed(() => {
  const txt = props.question?.text ?? '';
  if (!txt) return '';
  if (txt.includes('data-blank')) return txt;
  return String(txt).replace(/\[\[blank\]\]/g, '<strong class="inline-blank">_____</strong>').replace(/\{\{blank\}\}/g, '<strong class="inline-blank">_____</strong>');
});

function initFromQuestion() {
  const opts = parseOptions(props.question?.options);
  pool.value = opts.slice();
  let blanksCount = 0;
  const txt = props.question?.text ?? '';
  if (txt.includes('data-blank')) {
    const matches = [...txt.matchAll(/<span[^>]*data-blank[^>]*>(.*?)<\/span>/gi)];
    blanksCount = matches.length || 0;
  } else {
    const m1 = (txt.match(/\[\[blank\]\]/g) || []).length;
    const m2 = (txt.match(/\{\{blank\}\}/g) || []).length;
    blanksCount = Math.max(m1, m2);
    if (blanksCount === 0) {
      const parsedAns = parseAnswer(props.question?.answer);
      if (parsedAns && parsedAns.length > 0) blanksCount = parsedAns.length;
    }
  }
  blanksCount = Math.max(1, blanksCount);
  blanks.value = Array.from({ length: blanksCount }, (_, i) => ({ id: `blank-${i}`, item: null }));
  attempts.value = 0;
  state.value = 'idle';
  submitting.value = false;
  draggingFromPoolIndex.value = null;
  draggingFromSlotIndex.value = null;
  dragOverIndex.value = null;
}

/* ============================
   Drag & Drop handlers (unique names)
   ============================ */

// Pool -> drag start
function handleDragStartFromPool(evt, poolIndex) {
  draggingFromPoolIndex.value = poolIndex;
  evt.dataTransfer.effectAllowed = 'move';
  evt.dataTransfer.setData('text/plain', JSON.stringify({ from: 'pool', index: poolIndex }));
}

// Slot -> drag start
function handleDragStartFromSlot(evt, slotIndex) {
  draggingFromSlotIndex.value = slotIndex;
  evt.dataTransfer.effectAllowed = 'move';
  evt.dataTransfer.setData('text/plain', JSON.stringify({ from: 'slot', index: slotIndex }));
}

// Common drag end cleanup
function handleDragEnd() {
  draggingFromPoolIndex.value = null;
  draggingFromSlotIndex.value = null;
  dragOverIndex.value = null;
}

// Drag over blank
function handleDragOverBlank(evt, idx) {
  evt.preventDefault();
  evt.dataTransfer.dropEffect = 'move';
}

// Drag enter blank
function handleDragEnterBlank(evt, idx) {
  dragOverIndex.value = idx;
}

// Drag leave blank
function handleDragLeaveBlank(evt, idx) {
  if (dragOverIndex.value === idx) dragOverIndex.value = null;
}

// Drop into blank
function handleDropToBlank(evt, idx) {
  dragOverIndex.value = null;
  let payload = null;
  try { payload = JSON.parse(evt.dataTransfer.getData('text/plain') || null); } catch {}
  if (payload && payload.from === 'pool') {
    const pIdx = Number(payload.index);
    if (Number.isFinite(pIdx) && pool.value[pIdx]) {
      const item = pool.value[pIdx];
      if (blanks.value[idx].item) pool.value.push(blanks.value[idx].item);
      pool.value.splice(pIdx, 1);
      blanks.value[idx].item = item;
    }
  } else if (payload && payload.from === 'slot') {
    const sIdx = Number(payload.index);
    if (Number.isFinite(sIdx) && blanks.value[sIdx]) {
      const moving = blanks.value[sIdx].item;
      const targetItem = blanks.value[idx].item;
      blanks.value[idx].item = moving;
      blanks.value[sIdx].item = targetItem || null;
    }
  } else {
    const txt = evt.dataTransfer.getData('text/plain') || '';
    if (txt) {
      const findIdx = pool.value.findIndex(p => p.label === txt);
      if (findIdx !== -1) {
        const item = pool.value.splice(findIdx, 1)[0];
        if (blanks.value[idx].item) pool.value.push(blanks.value[idx].item);
        blanks.value[idx].item = item;
      } else {
        const temp = { id: `tmp-${Date.now()}`, label: txt };
        if (blanks.value[idx].item) pool.value.push(blanks.value[idx].item);
        blanks.value[idx].item = temp;
      }
    }
  }
}

// Drop back to pool area
function handleDropToPool(evt) {
  evt.preventDefault();
  let payload = null;
  try { payload = JSON.parse(evt.dataTransfer.getData('text/plain') || null); } catch {}
  if (payload && payload.from === 'slot') {
    const sIdx = Number(payload.index);
    if (Number.isFinite(sIdx) && blanks.value[sIdx] && blanks.value[sIdx].item) {
      pool.value.push(blanks.value[sIdx].item);
      blanks.value[sIdx].item = null;
    }
  }
  draggingFromPoolIndex.value = null;
  draggingFromSlotIndex.value = null;
  dragOverIndex.value = null;
}

/* ============================
   Submit / check
   ============================ */
function submitAnswers() {
  submitting.value = true;
  attempts.value += 1;
  const currentAnswers = blanks.value.map(b => (b.item ? String(b.item.label) : ''));
  const parsedTrue = parseAnswer(props.question?.answer) || [];
  const norm = arr => arr.map(x => String(x ?? '').trim().toLowerCase());
  const cand = norm(currentAnswers);
  const truth = norm(parsedTrue);

  let correct = false;
  if (truth.length === cand.length) {
    correct = truth.every((t, i) => t === cand[i]);
  } else {
    const truthNums = parsedTrue.map(v => Number(v)).filter(n => Number.isFinite(n));
    if (truthNums.length === blanks.value.length) {
      const poolLabels = parseOptions(props.question?.options).map(p => String(p.label).trim().toLowerCase());
      correct = truthNums.every((num, i) => {
        const idx = num - 1;
        if (idx < 0 || idx >= poolLabels.length) return false;
        const expected = poolLabels[idx];
        const actual = cand[i];
        return expected === actual;
      });
    }
  }

  state.value = correct ? 'correct' : 'wrong';
  emit('answered', { correct, attempts: attempts.value, question: props.question });
  setTimeout(() => { submitting.value = false; }, 300);
}

function resetAll() {
  initFromQuestion();
  pool.value = parseOptions(props.question?.options);
  attempts.value = 0;
  state.value = 'idle';
  submitting.value = false;
}

watch(() => props.question, () => {
  initFromQuestion();
  pool.value = parseOptions(props.question?.options);
}, { immediate: true });

onMounted(() => {
  initFromQuestion();
  pool.value = parseOptions(props.question?.options);
});
</script>

<style scoped>
.fill-root { background:#fff; padding:14px; border-radius:10px; box-shadow:0 6px 18px rgba(12,18,30,0.04); font-family: Inter, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial; color:#111; }
.fill-header { margin-bottom:10px; }
.q-number { font-size:13px; color:#666; margin-bottom:6px; }
.q-title { margin:0 0 8px 0; font-size:18px; }
.q-body { display:flex; flex-direction:column; gap:12px; }
.q-text { color:#333; padding:8px 0; }
.blanks-row { display:flex; gap:12px; flex-wrap:wrap; margin-top:6px; }
.blank-slot { min-width:160px; min-height:48px; border:2px dashed rgba(0,0,0,0.08); border-radius:8px; display:flex; align-items:center; justify-content:center; padding:8px; background:#fafafa; transition: all .18s ease; }
.blank-slot.occupied { border-style:solid; background:#fff; }
.blank-slot.highlight { box-shadow:0 6px 18px rgba(14,120,233,0.08); transform: translateY(-4px); }
.slot-item { padding:8px 10px; background: linear-gradient(90deg,#f7f8fa,#fff); border-radius:8px; cursor:grab; border:1px solid #e6e6e9; }
.slot-placeholder { color:#9aa0a6; font-size:14px; }
.controls { display:flex; gap:12px; align-items:center; }
.btn-submit { padding:8px 12px; background:#0e78e9; color:#fff; border-radius:8px; border:none; cursor:pointer; }
.btn-reset { padding:6px 10px; background:#fff; border-radius:8px; border:1px solid #ddd; cursor:pointer; }
.attempts { color:#666; font-size:13px; margin-left:auto; }
.options-pool { margin-top:12px; }
.pool-list { display:flex; gap:8px; flex-wrap:wrap; margin-top:8px; }
.pool-item { padding:8px 12px; background:#f6f8fb; border-radius:8px; border:1px solid #e6eefb; cursor:grab; user-select:none; }
.feedback { min-height:24px; margin-top:8px; }
.feedback-correct { color:#0a8a3a; font-weight:700; animation: popIn .28s both; }
.feedback-wrong { color:#c23a2b; font-weight:700; animation: popShake .45s both; }
@keyframes popIn { 0%{transform:scale(.95);opacity:0} 60%{transform:scale(1.03);opacity:1} 100%{transform:scale(1);opacity:1} }
@keyframes popShake { 0%{transform:translateX(0)} 20%{transform:translateX(-8px)} 40%{transform:translateX(8px)} 60%{transform:translateX(-6px)} 80%{transform:translateX(6px)} 100%{transform:translateX(0)} }
.state-correct { box-shadow: 0 12px 30px rgba(2,160,90,0.06); border-radius:12px; }
.state-wrong .blanks-row { animation: shakeContainer .45s cubic-bezier(.36,.07,.19,.97); }
@keyframes shakeContainer { 0%{transform:translateX(0)} 20%{transform:translateX(-6px)} 40%{transform:translateX(6px)} 60%{transform:translateX(-4px)} 80%{transform:translateX(4px)} 100%{transform:translateX(0)} }
@media (max-width:800px) { .blank-slot { min-width:120px; } .pool-item { padding:6px 10px; } }
</style>