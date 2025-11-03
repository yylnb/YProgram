<template>
  <div class="fill-root">
    <header class="fill-header">
      <div class="q-number">题号：{{ displayIndex }}</div>
      <h2 class="q-title" v-html="localQuestion.title || '未命名题目'"></h2>
    </header>

    <!-- Render text with blanks between segments -->
    <div class="q-text" v-if="textSegments && textSegments.length">
      <template v-for="(seg, idx) in textSegments" :key="idx">
        <span class="seg-text" v-if="seg">{{ seg }}</span>
        <!-- If not last segment, render a blank slot -->
        <span
          v-if="idx < blanksCount"
          class="blank-slot"
          :class="{ 'blank-filled': !!placedAnswers[idx], 'disabled': inputDisabled }"
          @dragover.prevent="onDragOverBlank($event, idx)"
          @dragenter.prevent="onDragEnterBlank($event, idx)"
          @dragleave="onDragLeaveBlank($event, idx)"
          @drop.prevent="onDropToBlank($event, idx)"
          tabindex="0"
          @keydown.enter.prevent="onClickBlank(idx)"
          :aria-label="'空 ' + (idx + 1)"
          role="button"
        >
          <template v-if="placedAnswers[idx]">
            <div class="placed-item" :draggable="!inputDisabled" @dragstart="onDragStartPlaced($event, idx)">
              {{ placedAnswers[idx].text }}
              <button class="btn-remove" @click.stop="removeFromBlank(idx)" aria-label="移除">✕</button>
            </div>
          </template>
          <template v-else>
            <span class="blank-placeholder">拖入选项或点击填充</span>
          </template>
        </span>
      </template>
    </div>

    <!-- Pool of choices -->
    <div class="pool-wrap" v-if="poolItems && poolItems.length">
      <div class="pool-header">可选项</div>
      <div class="pool-list" role="list">
        <div
          v-for="item in visiblePool"
          :key="item.id"
          class="pool-item"
          :draggable="!inputDisabled"
          @dragstart="onDragStartPool($event, item)"
          @click="onClickPool(item)"
          role="listitem"
          :aria-label="`选项 ${itemIndexLabel(item)}: ${item.text}`"
        >
          {{ item.text }}
        </div>
      </div>
    </div>

    <form class="fill-form" @submit.prevent="onSubmit" aria-label="填空题表单">
      <!-- keep textarea fallback for single blank or non-drag mode (compatibility) -->
      <template v-if="blanksCount === 0">
        <textarea
          v-model="fallbackText"
          :disabled="inputDisabled"
          class="fill-textarea"
          placeholder="在此输入答案"
          rows="3"
        ></textarea>
      </template>

      <div class="controls">
        <button type="submit" :disabled="inputDisabled" class="btn-submit">提交</button>
        <button type="button" @click="reset" class="btn-reset" :disabled="inputDisabled && state === 'correct'">重试</button>
        <div class="attempts">次数：{{ attempts }}</div>
      </div>
    </form>

    <div class="feedback" aria-live="polite">
      <div v-if="state === 'correct'" class="feedback-correct">✅ 回答正确</div>
      <div v-else-if="state === 'wrong'" class="feedback-wrong">❌ 回答错误，请再试一次</div>
    </div>

    <div v-if="currentHint" class="hint-box" style="margin-top:10px;">
      <strong>提示：</strong>
      <div v-html="currentHint"></div>
    </div>

    <div v-if="state === 'correct'" class="explain-box" style="margin-top:12px;">
      <div v-if="localQuestion.explanation" class="explanation" v-html="localQuestion.explanation"></div>
      <div style="margin-top:10px; display:flex; gap:8px; align-items:center;">
        <button class="btn-next" @click="onNextClick" :disabled="nextDisabled">
          {{ isLastQuestion ? '完成单元' : '下一题' }}
        </button>
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
const attempts = ref(0);
const state = ref('idle'); // 'idle' | 'correct' | 'wrong'
const inputDisabled = computed(() => props.disabled || state.value === 'correct');
const internalError = ref('');
const nextDisabled = ref(false);

// parsed data
const textSegments = ref([]); // array of text segments
const poolItems = ref([]); // { id: number, text: string }
const placedAnswers = ref([]); // array indexed by blank idx, value = {id, text} or null
const fallbackText = ref('');

// compute blanksCount from textSegments: blanks = segments.length - 1 (if segments exist)
const blanksCount = computed(() => Math.max(0, textSegments.value.length - 1));

// attempts/hints
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

// displayIndex
const displayIndex = computed(() => {
  if (props.questionIndex) return props.questionIndex;
  if (localQuestion.value?.q_id) return localQuestion.value.q_id;
  if (localQuestion.value?.id) return localQuestion.value.id;
  return '-';
});

const isLastQuestion = computed(() => {
  const t = Number(props.totalQuestions) || 15;
  return Number(props.questionIndex) >= t;
});

// utilities
function safeParseJSON(val) {
  if (val == null) return null;
  if (typeof val === 'object') return val;
  if (typeof val !== 'string') return null;
  try {
    return JSON.parse(val);
  } catch (e) {
    return null;
  }
}

// initialize parsed structures from question
function initFromQuestion(q) {
  localQuestion.value = q ? { ...q } : {};
  // parse textSegments
  let ts = safeParseJSON(localQuestion.value?.text);
  if (!ts) {
    // if it's a plain string, we put single segment -> no blanks
    if (typeof localQuestion.value?.text === 'string') {
      ts = [localQuestion.value.text];
    } else {
      ts = [''];
    }
  }
  // ensure array
  if (!Array.isArray(ts)) ts = [String(ts)];
  // convert non-string to string
  ts = ts.map(s => (s == null ? '' : String(s)));
  textSegments.value = ts;

  // prepare blanks array (segments length - 1)
  const bcount = Math.max(0, ts.length - 1);
  placedAnswers.value = Array(bcount).fill(null);

  // parse options
  let opts = safeParseJSON(localQuestion.value?.options);
  if (!opts || !Array.isArray(opts)) {
    // if options is a single string split by newline or comma
    if (typeof localQuestion.value?.options === 'string') {
      const s = localQuestion.value.options;
      opts = s.split(/\r?\n|,/).map(x => x.trim()).filter(Boolean);
    } else {
      opts = [];
    }
  }
  // normalize options to objects with 1-based id (so answer [1,2] maps cleanly)
  poolItems.value = opts.map((t, i) => ({ id: i + 1, text: String(t) }));

  // fallback text area if no blanks
  if (bcount === 0 && localQuestion.value?.answer) {
    // prefill if answer is simple string
    if (typeof localQuestion.value.answer === 'string') fallbackText.value = localQuestion.value.answer;
  }

  // reset attempts & state
  attempts.value = 0;
  state.value = 'idle';
  internalError.value = '';
  nextDisabled.value = false;
}

// visible pool (not already placed)
const visiblePool = computed(() => {
  const usedIds = new Set(placedAnswers.value.filter(Boolean).map(x => x.id));
  return poolItems.value.filter(it => !usedIds.has(it.id));
});

// drag/drop handlers
function onDragStartPool(evt, item) {
  if (inputDisabled.value) { evt.preventDefault(); return; }
  evt.dataTransfer.setData('application/x-option-id', String(item.id));
  // effect
  evt.dataTransfer.effectAllowed = 'move';
}
function onDragStartPlaced(evt, blankIndex) {
  if (inputDisabled.value) { evt.preventDefault(); return; }
  const placed = placedAnswers.value[blankIndex];
  if (!placed) { evt.preventDefault(); return; }
  // encode source blank index as -index (so receiver can swap/return)
  evt.dataTransfer.setData('application/x-option-id', String(placed.id));
  evt.dataTransfer.setData('application/x-source-blank', String(blankIndex));
  evt.dataTransfer.effectAllowed = 'move';
}

function onDragOverBlank(evt, idx) {
  if (inputDisabled.value) { return; }
  evt.dataTransfer.dropEffect = 'move';
}
function onDragEnterBlank(evt, idx) {
  if (inputDisabled.value) return;
  evt.currentTarget.classList.add('drag-over');
}
function onDragLeaveBlank(evt, idx) {
  evt.currentTarget.classList.remove('drag-over');
}

function onDropToBlank(evt, idx) {
  if (inputDisabled.value) return;
  evt.currentTarget.classList.remove('drag-over');
  const dataId = evt.dataTransfer.getData('application/x-option-id');
  const sourceBlank = evt.dataTransfer.getData('application/x-source-blank');
  if (!dataId) return;
  const optionId = Number(dataId);
  if (Number.isNaN(optionId)) return;
  // find option object from poolItems or placedAnswers
  const optFromPool = poolItems.value.find(it => it.id === optionId);
  const optFromPlaced = placedAnswers.value.find(p => p && p.id === optionId);
  const optionObj = optFromPool || optFromPlaced;
  if (!optionObj) return;

  // If dragged from another blank (swap)
  if (sourceBlank !== '' && sourceBlank !== undefined && sourceBlank !== null) {
    const sIdx = Number(sourceBlank);
    if (!Number.isNaN(sIdx) && sIdx !== idx) {
      // swap placedAnswers[sIdx] and placedAnswers[idx]
      const tmp = placedAnswers.value[idx];
      placedAnswers.value[idx] = placedAnswers.value[sIdx];
      placedAnswers.value[sIdx] = tmp;
      return;
    }
  }

  // If target blank already contains something, return that to pool (or swap)
  if (placedAnswers.value[idx]) {
    // put existing back to pool (we simply null it and the pool computed will show it)
    // and place new one
    placedAnswers.value[idx] = { id: optionObj.id, text: optionObj.text };
  } else {
    // place new one
    placedAnswers.value[idx] = { id: optionObj.id, text: optionObj.text };
  }
}

function removeFromBlank(idx) {
  if (inputDisabled.value) return;
  placedAnswers.value[idx] = null;
}

function onClickPool(item) {
  if (inputDisabled.value) return;
  // fill first empty blank
  const firstEmpty = placedAnswers.value.findIndex(p => p == null);
  if (firstEmpty === -1) {
    // if none empty, replace the last one
    placedAnswers.value[placedAnswers.value.length - 1] = { id: item.id, text: item.text };
  } else {
    placedAnswers.value[firstEmpty] = { id: item.id, text: item.text };
  }
}

function onClickBlank(idx) {
  // clicking blank tries to focus or open selection - here we pick next pool item
  if (inputDisabled.value) return;
  const next = visiblePool.value[0];
  if (next) {
    placedAnswers.value[idx] = { id: next.id, text: next.text };
  }
}

// helper label
function itemIndexLabel(item) {
  // return numeric id or index label
  return String(item.id);
}

// check answers logic
function parseExpectedOrder(raw) {
  // if raw is array of numbers -> expected ids
  if (raw == null) return null;
  if (Array.isArray(raw) && raw.every(i => typeof i === 'number')) return raw;
  // if string json
  if (typeof raw === 'string') {
    try {
      const p = JSON.parse(raw);
      if (Array.isArray(p) && p.every(i => typeof i === 'number')) return p;
    } catch (e) {}
  }
  return null;
}

function checkAnswers() {
  // if blanksCount === 0: compare fallbackText with canonical answers (reuse earlier normalize)
  if (blanksCount.value === 0) {
    const s = normalize(fallbackText.value);
    if (!localQuestion.value?.answer) return false;
    // fallback to simple string match (case-insensitive, whitespace-normalized)
    const canon = String(localQuestion.value.answer).trim();
    return normalize(canon) === s;
  }

  // gather placed ids in order (length = blanksCount)
  const placedIds = placedAnswers.value.map(p => (p ? p.id : null));
  // if any empty -> not correct
  if (placedIds.some(v => v == null)) return false;

  // if expected order provided as numeric id array
  const expected = parseExpectedOrder(localQuestion.value?.answer);
  if (expected && expected.length === placedIds.length) {
    // expected might be 1-based ids -> compare directly
    for (let i = 0; i < expected.length; i++) {
      if (Number(expected[i]) !== Number(placedIds[i])) return false;
    }
    return true;
  }

  // else fallback: compare texts (normalize) to canonicalAnswers (if any)
  const userTexts = placedAnswers.value.map(p => normalize(p.text));
  // try to parse canonical answers via earlier format (supporting arrays/strings)
  // we'll reuse a small local parseSimilar to original parseCanonicalAnswers
  const raw = localQuestion.value?.answer;
  if (raw == null) return false;
  let canonArr = null;
  if (Array.isArray(raw)) {
    // raw = [1,2] OR ['a','b'] etc. if elements are strings then treat as texts
    if (raw.every(x => typeof x === 'string')) canonArr = raw.map(x => [normalize(x)]);
    if (raw.every(x => typeof x === 'number')) {
      // numeric but we didn't return earlier (length mismatch) -> false
      return false;
    }
  } else if (typeof raw === 'string') {
    try {
      const p = JSON.parse(raw);
      if (Array.isArray(p)) {
        if (p.every(x => typeof x === 'number')) return (p.map(String).join(',')) === (placedIds.map(String).join(','));
        if (p.every(x => typeof x === 'string')) canonArr = p.map(x => [normalize(x)]);
      } else {
        // single string -> maybe single blank
        canonArr = [[normalize(raw)]];
      }
    } catch (e) {
      // raw string not json
      canonArr = [[normalize(raw)]];
    }
  }

  if (canonArr && canonArr.length === userTexts.length) {
    for (let i = 0; i < canonArr.length; i++) {
      const allowed = canonArr[i];
      const u = userTexts[i];
      if (!allowed.some(a => normalize(a) === u)) return false;
    }
    return true;
  }

  // final fallback: not correct
  return false;
}

// normalize helper
function normalize(str) {
  if (str == null) return '';
  return String(str).trim().replace(/\s+/g, ' ').toLowerCase();
}

// submit handler
function onSubmit() {
  if (inputDisabled.value) return;
  attempts.value += 1;
  const correct = checkAnswers();
  if (correct) {
    state.value = 'correct';
    emit('correct', { questionIndex: props.questionIndex, attempts: attempts.value });
  } else {
    state.value = 'wrong';
    setTimeout(() => { state.value = 'idle'; }, 900);
  }
}

// reset
function reset() {
  // clear placed answers and fallback text, attempts, state
  placedAnswers.value = Array(blanksCount.value).fill(null);
  fallbackText.value = '';
  attempts.value = 0;
  state.value = 'idle';
  internalError.value = '';
  nextDisabled.value = false;
}

// next click
function onNextClick() {
  if (state.value !== 'correct') return;
  nextDisabled.value = true;
  const nextIndex = props.questionIndex + 1;
  emit('next', { questionIndex: props.questionIndex, nextIndex });
  setTimeout(() => { nextDisabled.value = false; }, 600);
}

// watch props.question
watch(() => props.question, (q) => {
  initFromQuestion(q || {});
}, { immediate: true });

watch(() => props.questionIndex, () => {
  reset();
});
</script>

<style scoped>
.fill-root { padding: 14px; background: #fff; border-radius: 10px; box-shadow: 0 6px 18px rgba(12,18,30,0.04); font-family: Inter, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial; color: #111; }
.fill-header { display:flex; flex-direction:column; gap:6px; margin-bottom:10px; }
.q-number { font-size:13px; color:#666; }
.q-title { margin:0; font-size:18px; }
.q-text { margin-bottom:12px; color:#333; display:flex; flex-wrap:wrap; gap:8px; align-items:center; }

/* segments & blanks */
.seg-text { white-space:pre-wrap; }
.blank-slot { min-width:160px; min-height:40px; display:inline-flex; align-items:center; justify-content:center; padding:6px 10px; border-radius:8px; border:1px dashed #d6dbe3; background:#fbfdff; margin:0 4px; transition:all .15s ease; position:relative; }
.blank-slot.drag-over { border-color:#0e78e9; box-shadow:0 6px 14px rgba(14,120,233,0.08); transform:translateY(-2px); }
.blank-slot.blank-filled { border-style:solid; border-color:#dceefc; background:#f7fbff; }
.blank-slot.disabled { opacity:0.6; pointer-events:none; }

.blank-placeholder { color:#9aa6b2; font-size:13px; }

/* placed item inside blank */
.placed-item { display:inline-flex; align-items:center; gap:8px; padding:6px 10px; border-radius:6px; background:#fff; border:1px solid #e6eefc; box-shadow: 0 2px 6px rgba(12,18,30,0.03); cursor:grab; user-select:none; }
.placed-item:active { cursor:grabbing; }
.btn-remove { margin-left:6px; border:none; background:transparent; color:#c23a2b; cursor:pointer; font-size:12px; }

/* pool */
.pool-wrap { margin: 12px 0 6px; }
.pool-header { font-size:13px; color:#444; margin-bottom:6px; }
.pool-list { display:flex; flex-wrap:wrap; gap:8px; }
.pool-item { padding:8px 12px; border-radius:10px; background:#f1f6ff; border:1px solid #e1efff; cursor:pointer; user-select:none; box-shadow: 0 2px 6px rgba(12,18,30,0.02); transition:transform .12s ease, box-shadow .12s ease; }
.pool-item:active { transform:translateY(1px); }
.pool-item[draggable="true"] { cursor:grab; }
.pool-item:focus { outline: 2px solid rgba(14,120,233,0.14); outline-offset:2px; }

/* form */
.fill-form { display:flex; flex-direction:column; gap:10px; margin-top:8px; }
.fill-textarea { width:100%; padding:8px 10px; border-radius:8px; border:1px solid #ddd; resize:vertical; min-height:80px; }

.controls { display:flex; align-items:center; gap:12px; margin-top:8px; }
.btn-submit { padding:8px 14px; background:#0e78e9; color:#fff; border-radius:8px; border:none; cursor:pointer; }
.btn-reset { padding:6px 10px; background:#fff; border:1px solid #ddd; border-radius:8px; cursor:pointer; }
.attempts { color:#666; font-size:13px; margin-left:auto; }

.feedback { margin-top:12px; min-height:24px; }
.feedback-correct { color:#0a8a3a; font-weight:700; animation: popIn .28s ease both; }
.feedback-wrong { color:#c23a2b; font-weight:700; animation: popShake .45s cubic-bezier(.36,.07,.19,.97) both; }

.hint-box { padding:8px 12px; border-radius:8px; background: #fff6f6; color:#c23a2b; margin-top:8px; }
.explain-box { padding:12px; border-radius:8px; background:#f7f9fc; border:1px solid #eef2f7; color:#0b3b58; }
.btn-next { padding:8px 12px; background:#0e78e9; color:#fff; border-radius:8px; border:none; cursor:pointer; }

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
</style>