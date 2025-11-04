<template>
  <div class="fill-root" @contextmenu.prevent>
    <header class="fill-header">
      <div class="q-number">题号：{{ displayIndex }}</div>
      <h2 class="q-title" v-html="localQuestion.title || '未命名题目'"></h2>
    </header>

    <!-- Text segments with blanks -->
    <div class="q-text" v-if="textSegments && textSegments.length">
      <template v-for="(seg, idx) in textSegments" :key="idx">
        <span class="seg-text" v-if="seg" v-html="seg"></span>

        <!-- blank slot -->
        <span
          v-if="idx < blanksCount"
          class="blank-slot"
          :class="{ 'blank-filled': !!placedAnswers[idx], 'disabled': inputDisabled }"
          :data-blank-index="idx"
          role="region"
          aria-label="'空 ' + (idx + 1)"
          @dragover.prevent
          @drop.prevent="onDropToBlankNative($event, idx)"
        >
          <template v-if="placedAnswers[idx]">
            <div
              class="placed-item"
              @pointerdown.stop.prevent="beginPointerDragFromPlaced($event, idx)"
              @dragstart.prevent="onDragStartPlaced($event, idx)"
              @click.stop.prevent="onClickPlaced(idx)"
              draggable="true"
              :aria-label="`已填入: ${placedAnswers[idx].text}`"
            >
              {{ placedAnswers[idx].text }}
            </div>
          </template>
          <template v-else>
            <span class="blank-placeholder">拖入选项</span>
          </template>
        </span>
      </template>
    </div>

    <!-- Pool -->
    <div class="pool-wrap" ref="poolWrap" data-pool-area>
      <div class="pool-header">可选项</div>
      <div class="pool-list" role="list">
        <template v-for="(item, idx) in poolItems" :key="item.uid">
          <div
            class="pool-item"
            :class="{
              'pool-placeholder': placeholderPoolIndex === idx && placeholderActive,
              'dragging-placeholder': draggingId === item.uid && draggingFrom === 'pool' && placeholderActive
            }"
            @pointerdown.prevent="beginPointerDragFromPool($event, idx)"
            @click.stop.prevent="onClickPool(idx)"
            @dragstart.prevent="onDragStartPool($event, idx)"
            draggable="true"
            role="listitem"
            :aria-label="`选项 ${item.uid}: ${item.text}`"
          >
            <!-- We keep text in DOM for accessibility, but hide it visually when placeholderActive -->
            <span class="pool-item-text">{{ item.text }}</span>
          </div>
        </template>
      </div>
    </div>

    <!-- Submit -->
    <form class="fill-form" @submit.prevent="onSubmit" aria-label="填空题表单">
      <div class="controls">
        <button type="submit" :disabled="inputDisabled" class="btn-submit">提交</button>
      </div>
    </form>

    <!-- Feedback and extras -->
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

    <div v-if="internalError" class="hint-box" style="margin-top:10px; color:#ff8b87;">
      {{ internalError }}
    </div>
  </div>
</template>

<script setup>
/*
  说明：
  - 仅将 .drag-ghost 的样式放到全局（非 scoped）style 中，其他交互逻辑不变。
  - 其余实现与之前版本一致（pointer-based ghost, pool placeholders, click auto-fill 等）。
*/

import { ref, computed, watch, onBeforeUnmount } from 'vue';

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

// local
const localQuestion = ref(props.question ? { ...props.question } : {});
const attempts = ref(0);
const state = ref('idle');
const inputDisabled = computed(() => props.disabled || state.value === 'correct');
const internalError = ref('');
const nextDisabled = ref(false);

// parsed
const textSegments = ref([]);
const poolItems = ref([]); // { uid, text }
const placedAnswers = ref([]);

// drag state
const draggingId = ref(null);
const draggingFrom = ref(null);
const draggingSourceIndex = ref(null);
const placeholderPoolIndex = ref(null);
const placeholderActive = ref(false);
const currentOverBlank = ref(null);
const poolWrap = ref(null);
const ghostEl = ref(null);
const showGhost = ref(false);

// computed
const blanksCount = computed(() => Math.max(0, textSegments.value.length - 1));
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

// helpers
function safeParseJSON(val) {
  if (val == null) return null;
  if (typeof val === 'object') return val;
  if (typeof val !== 'string') return null;
  try { return JSON.parse(val); } catch { return null; }
}

// init
function initFromQuestion(q) {
  localQuestion.value = q ? { ...q } : {};
  let ts = safeParseJSON(localQuestion.value?.text);
  if (!ts) {
    if (typeof localQuestion.value?.text === 'string') ts = [localQuestion.value.text];
    else ts = [''];
  }
  if (!Array.isArray(ts)) ts = [String(ts)];
  textSegments.value = ts.map(s => s == null ? '' : String(s));

  const bcount = Math.max(0, textSegments.value.length - 1);
  placedAnswers.value = Array(bcount).fill(null);

  let opts = safeParseJSON(localQuestion.value?.options);
  if (!opts || !Array.isArray(opts)) {
    if (typeof localQuestion.value?.options === 'string') {
      opts = localQuestion.value.options.split(/\r?\n|,/).map(x => x.trim()).filter(Boolean);
    } else opts = [];
  }
  const tstamp = Date.now();
  poolItems.value = opts.map((t, i) => ({ uid: `i${i}-${tstamp}`, text: String(t) }));

  draggingId.value = null; draggingFrom.value = null; draggingSourceIndex.value = null;
  placeholderPoolIndex.value = null; placeholderActive.value = false; currentOverBlank.value = null;
  attempts.value = 0; state.value = 'idle'; internalError.value = ''; nextDisabled.value = false;
  destroyGhost();
}

// Ghost creation (use drag-ghost class that copies pool-item visuals)
function createGhostFromText(text) {
  destroyGhost();
  const el = document.createElement('div');
  el.className = 'drag-ghost';
  el.innerText = text;
  el.style.position = 'fixed';
  el.style.top = '0px';
  el.style.left = '0px';
  el.style.pointerEvents = 'none';
  el.style.zIndex = 99999;
  document.body.appendChild(el);
  ghostEl.value = el;
  showGhost.value = true;
}
function moveGhost(x, y) {
  if (!ghostEl.value) return;
  ghostEl.value.style.transform = `translate(${x}px, ${y}px) translate(-50%, -50%)`;
}
function destroyGhost() {
  if (ghostEl.value && ghostEl.value.parentElement) ghostEl.value.parentElement.removeChild(ghostEl.value);
  ghostEl.value = null;
  showGhost.value = false;
}

// pointer handlers
function attachPointerHandlers() {
  window.addEventListener('pointermove', onPointerMove, { passive: false });
  window.addEventListener('pointerup', onPointerUp);
  window.addEventListener('pointercancel', onPointerUp);
}
function detachPointerHandlers() {
  window.removeEventListener('pointermove', onPointerMove);
  window.removeEventListener('pointerup', onPointerUp);
  window.removeEventListener('pointercancel', onPointerUp);
}

function beginPointerDragFromPool(evt, poolIndex) {
  if (inputDisabled.value) return;
  const item = poolItems.value[poolIndex];
  if (!item) return;
  draggingId.value = item.uid;
  draggingFrom.value = 'pool';
  draggingSourceIndex.value = poolIndex;
  placeholderPoolIndex.value = poolIndex;
  placeholderActive.value = true;
  createGhostFromText(item.text);
  moveGhost(evt.clientX, evt.clientY);
  attachPointerHandlers();
}

function beginPointerDragFromPlaced(evt, blankIndex) {
  if (inputDisabled.value) return;
  const item = placedAnswers.value[blankIndex];
  if (!item) return;
  draggingId.value = item.uid;
  draggingFrom.value = 'placed';
  draggingSourceIndex.value = blankIndex;
  placeholderPoolIndex.value = poolItems.value.length;
  placeholderActive.value = true;
  createGhostFromText(item.text);
  moveGhost(evt.clientX, evt.clientY);
  attachPointerHandlers();
}

function onPointerMove(evt) {
  if (!draggingId.value) return;
  try { evt.preventDefault(); } catch {}
  moveGhost(evt.clientX, evt.clientY);

  // highlight blank under pointer
  if (currentOverBlank.value != null) {
    const prev = document.querySelector(`[data-blank-index="${currentOverBlank.value}"]`);
    if (prev) prev.classList.remove('drag-over');
    currentOverBlank.value = null;
  }
  const el = document.elementFromPoint(evt.clientX, evt.clientY);
  if (!el) return;
  const blankEl = el.closest && el.closest('[data-blank-index]');
  if (blankEl) {
    const idx = Number(blankEl.getAttribute('data-blank-index'));
    blankEl.classList.add('drag-over');
    currentOverBlank.value = idx;
  }
}

function onPointerUp(evt) {
  if (!draggingId.value) {
    detachPointerHandlers(); destroyGhost(); return;
  }
  const el = document.elementFromPoint(evt.clientX, evt.clientY);
  let droppedOnBlankIndex = null;
  if (el) {
    const bEl = el.closest && el.closest('[data-blank-index]');
    if (bEl) droppedOnBlankIndex = Number(bEl.getAttribute('data-blank-index'));
  }
  const droppedOnPool = el && el.closest && !!el.closest('[data-pool-area]');

  if (draggingFrom.value === 'pool') {
    const uid = draggingId.value;
    const poolIndex = poolItems.value.findIndex(it => it.uid === uid);
    const sourceIdx = poolIndex === -1 ? draggingSourceIndex.value : poolIndex;

    if (droppedOnBlankIndex != null) {
      const item = poolItems.value[sourceIdx];
      if (item) {
        const replaced = placeIntoBlank(droppedOnBlankIndex, item);
        const idxToRemove = poolItems.value.findIndex(it => it.uid === item.uid);
        if (idxToRemove !== -1) poolItems.value.splice(idxToRemove, 1);
        if (replaced) poolItems.value.push(replaced);
      } else {
        const it2 = poolItems.value.find(it => it.uid === uid);
        if (it2) {
          placeIntoBlank(droppedOnBlankIndex, it2);
          const rem = poolItems.value.findIndex(it => it.uid === it2.uid);
          if (rem !== -1) poolItems.value.splice(rem, 1);
        }
      }
    } else if (droppedOnPool) {
      // dropped back to pool, nothing to change
    } else {
      // dropped elsewhere: restore (no-op)
    }
    placeholderPoolIndex.value = null;
    placeholderActive.value = false;
  } else if (draggingFrom.value === 'placed') {
    const uid = draggingId.value;
    let sIdx = draggingSourceIndex.value;
    if (!placedAnswers.value[sIdx] || placedAnswers.value[sIdx].uid !== uid) {
      const found = placedAnswers.value.findIndex(p => p && p.uid === uid);
      if (found !== -1) sIdx = found;
    }
    if (droppedOnBlankIndex != null) {
      if (sIdx != null && sIdx !== droppedOnBlankIndex) {
        const tmp = placedAnswers.value[droppedOnBlankIndex];
        placedAnswers.value[droppedOnBlankIndex] = placedAnswers.value[sIdx];
        placedAnswers.value[sIdx] = tmp || null;
      }
    } else if (droppedOnPool) {
      const item = placedAnswers.value[sIdx];
      if (item) {
        placedAnswers.value[sIdx] = null;
        poolItems.value.push(item);
      }
    } else {
      // restore (no-op)
    }
    placeholderPoolIndex.value = null;
    placeholderActive.value = false;
  }

  if (currentOverBlank.value != null) {
    const prev = document.querySelector(`[data-blank-index="${currentOverBlank.value}"]`);
    if (prev) prev.classList.remove('drag-over');
  }

  draggingId.value = null; draggingFrom.value = null; draggingSourceIndex.value = null;
  destroyGhost();
  detachPointerHandlers();
}

function placeIntoBlank(blankIdx, itemObj) {
  const replaced = placedAnswers.value[blankIdx];
  placedAnswers.value[blankIdx] = { uid: itemObj.uid, text: itemObj.text };
  return replaced;
}

// native drag handlers (desktop)
function onDragStartPool(e, poolIndex) {
  if (inputDisabled.value) { e.preventDefault(); return; }
  const item = poolItems.value[poolIndex];
  if (!item) { e.preventDefault(); return; }
  placeholderPoolIndex.value = poolIndex;
  placeholderActive.value = true;
  e.dataTransfer.setData('text/x-item-uid', String(item.uid));
  e.dataTransfer.effectAllowed = 'move';
}
function onDragStartPlaced(e, blankIndex) {
  if (inputDisabled.value) { e.preventDefault(); return; }
  const item = placedAnswers.value[blankIndex];
  if (!item) { e.preventDefault(); return; }
  e.dataTransfer.setData('text/x-placed-blank', String(blankIndex));
  e.dataTransfer.setData('text/x-item-uid', String(item.uid));
  e.dataTransfer.effectAllowed = 'move';
}
function onDropToBlankNative(e, blankIndex) {
  if (inputDisabled.value) return;
  const uid = e.dataTransfer.getData('text/x-item-uid');
  const srcBlank = e.dataTransfer.getData('text/x-placed-blank');
  if (!uid) return;
  const poolIdx = poolItems.value.findIndex(it => it.uid === uid);
  if (srcBlank) {
    const sIdx = Number(srcBlank);
    if (sIdx !== blankIndex) {
      const tmp = placedAnswers.value[blankIndex];
      placedAnswers.value[blankIndex] = placedAnswers.value[sIdx];
      placedAnswers.value[sIdx] = tmp || null;
    }
  } else if (poolIdx !== -1) {
    const item = poolItems.value[poolIdx];
    const replaced = placedAnswers.value[blankIndex];
    placedAnswers.value[blankIndex] = { uid: item.uid, text: item.text };
    poolItems.value.splice(poolIdx, 1);
    if (replaced) poolItems.value.push(replaced);
  }
  placeholderPoolIndex.value = null; placeholderActive.value = false;
}

// click behaviors
function onClickPool(poolIdx) {
  if (inputDisabled.value) return;
  const item = poolItems.value[poolIdx];
  if (!item) return;
  const emptyIdx = placedAnswers.value.findIndex(p => p == null);
  if (emptyIdx === -1) return;
  placedAnswers.value[emptyIdx] = { uid: item.uid, text: item.text };
  poolItems.value.splice(poolIdx, 1);
}
function onClickPlaced(blankIdx) {
  if (inputDisabled.value) return;
  const item = placedAnswers.value[blankIdx];
  if (!item) return;
  placedAnswers.value[blankIdx] = null;
  poolItems.value.push(item);
}

// answer checking
function safeCanon(raw) {
  if (raw == null) return null;
  if (Array.isArray(raw)) return raw;
  if (typeof raw === 'string') {
    try { const p = JSON.parse(raw); if (Array.isArray(p)) return p; } catch {}
    return [raw];
  }
  return [String(raw)];
}
function normalize(str) {
  if (str == null) return '';
  return String(str).trim().replace(/\s+/g, ' ').toLowerCase();
}
function checkAnswers() {
  if (blanksCount.value === 0) return false;
  const placedUids = placedAnswers.value.map(p => (p ? p.uid : null));
  if (placedUids.some(v => v == null)) return false;
  const raw = localQuestion.value?.answer;
  if (!raw) return false;
  let canonArr = null;
  if (Array.isArray(raw)) {
    if (raw.every(x => typeof x === 'string')) canonArr = raw.map(x => [normalize(x)]);
  } else if (typeof raw === 'string') {
    try {
      const p = JSON.parse(raw);
      if (Array.isArray(p) && p.every(x => typeof x === 'string')) canonArr = p.map(x => [normalize(x)]);
      else canonArr = [[normalize(raw)]];
    } catch { canonArr = [[normalize(raw)]]; }
  }
  if (canonArr && canonArr.length === placedAnswers.value.length) {
    for (let i = 0; i < canonArr.length; i++) {
      const allowed = canonArr[i];
      const u = normalize(placedAnswers.value[i].text);
      if (!allowed.some(a => normalize(a) === u)) return false;
    }
    return true;
  }
  return false;
}

// submit / next
function onSubmit() {
  if (inputDisabled.value) return;
  attempts.value += 1;
  const ok = checkAnswers();
  if (ok) {
    state.value = 'correct';
    emit('correct', { questionIndex: props.questionIndex, attempts: attempts.value });
  } else {
    state.value = 'wrong';
    setTimeout(() => { state.value = 'idle'; }, 900);
  }
}
function onNextClick() {
  if (state.value !== 'correct') return;
  nextDisabled.value = true;
  const nextIndex = props.questionIndex + 1;
  emit('next', { questionIndex: props.questionIndex, nextIndex });
  setTimeout(() => { nextDisabled.value = false; }, 600);
}

// watch
watch(() => props.question, (q) => initFromQuestion(q || {}), { immediate: true });
watch(() => props.questionIndex, () => initFromQuestion(localQuestion.value));

// cleanup
onBeforeUnmount(() => {
  destroyGhost();
  detachPointerHandlers();
});
</script>

<style scoped>
/* Dark theme whole component */
.fill-root { padding: 14px; background: #0b0b0d; border-radius: 10px; box-shadow: 0 6px 18px rgba(0,0,0,0.6); font-family: Inter, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial; color: #ffffff; }
.fill-header { display:flex; flex-direction:column; gap:6px; margin-bottom:10px; }
.q-number { font-size:13px; color:#aeb6bd; }
.q-title { margin:0; font-size:18px; color:#ffffff; }
.q-text { margin-bottom:12px; color:#e6eef8; display:flex; flex-wrap:wrap; gap:8px; align-items:center; }

/* text segments */
.seg-text { white-space:pre-wrap; color:#e6eef8; }

/* blank slot */
.blank-slot { min-width:160px; min-height:44px; display:inline-flex; align-items:center; justify-content:center; padding:6px 10px; border-radius:8px; border:1px dashed rgba(255,255,255,0.06); background:#07070a; margin:0 6px; transition:all .12s ease; color:#eaf3ff; }
.blank-slot.drag-over { border-color:#4fb0ff; box-shadow:0 10px 24px rgba(79,176,255,0.06); transform:translateY(-2px); }
.blank-slot.blank-filled { border-style:solid; border-color:rgba(79,176,255,0.14); background:rgba(255,255,255,0.02); }
.blank-placeholder { color:#98a6b3; font-size:13px; }

/* placed item */
.placed-item { padding:6px 10px; border-radius:6px; background:linear-gradient(180deg, rgba(255,255,255,0.02), rgba(255,255,255,0.01)); border:1px solid rgba(255,255,255,0.04); color:#fff; cursor:grab; user-select:none; display:inline-block; }
.placed-item:active { cursor:grabbing; }

/* Pool */
.pool-wrap { margin: 12px 0 6px; }
.pool-header { font-size:13px; color:#cfd8df; margin-bottom:6px; }
.pool-list { display:flex; flex-wrap:wrap; gap:8px; }

/* pool item: white border, deep gray background */
.pool-item {
  padding:8px 12px;
  border-radius:10px;
  background:#2e2e2e;          /* 深灰背景 */
  border:2px solid #ffffff;    /* 白色边框 */
  cursor:grab;
  user-select:none;
  box-shadow: 0 2px 8px rgba(0,0,0,0.6);
  color:#ffffff;
  transition: transform .08s ease, box-shadow .08s ease, background .08s ease;
  min-width:64px;
  text-align:center;
  display:inline-flex;
  align-items:center;
  justify-content:center;
}

/* ************** */
/* Placeholder: pure gray and hide text when active */
/* ************** */
.pool-item.pool-placeholder,
.pool-item.dragging-placeholder {
  background:#6b6b6b !important; /* 纯灰 */
  color: #ffffff;
  border:2px solid #6b6b6b !important;
}
/* hide inner text visually but keep in DOM for accessibility */
.pool-item.pool-placeholder .pool-item-text,
.pool-item.dragging-placeholder .pool-item-text {
  visibility: hidden;
}

/* pool item text element (for screen readers etc.) */
.pool-item-text { display:inline-block; }

/* form / controls */
.fill-form { display:flex; flex-direction:column; gap:10px; margin-top:8px; }
.controls { display:flex; align-items:center; gap:12px; margin-top:8px; }
.btn-submit { padding:8px 14px; background:#1677ff; color:#fff; border-radius:8px; border:none; cursor:pointer; box-shadow:0 6px 18px rgba(22,119,255,0.12); }
.btn-submit:disabled { opacity:0.5; cursor:not-allowed; }

/* feedback */
.feedback { margin-top:12px; min-height:24px; }
.feedback-correct { color:#5fe07a; font-weight:700; animation: popIn .28s ease both; }
.feedback-wrong { color:#ff8b87; font-weight:700; animation: popShake .45s cubic-bezier(.36,.07,.19,.97) both; }

.hint-box { padding:8px 12px; border-radius:8px; background:#2b0b0c; color:#ffb6b0; margin-top:8px; }
.explain-box { padding:12px; border-radius:8px; background:linear-gradient(180deg, rgba(255,255,255,0.01), rgba(255,255,255,0.00)); border:1px solid rgba(255,255,255,0.03); color:#e6f7ff; }
.btn-next { padding:8px 12px; background:#1677ff; color:#fff; border-radius:8px; border:none; cursor:pointer; }

@keyframes popIn { 0% { transform: scale(.9); opacity: 0; } 60% { transform: scale(1.05); opacity: 1; } 100% { transform: scale(1); opacity: 1; } }
@keyframes popShake { 0% { transform: translateX(0); } 20% { transform: translateX(-8px); } 40% { transform: translateX(8px); } 60% { transform: translateX(-6px); } 80% { transform: translateX(6px); } 100% { transform: translateX(0); } }

/* responsive tweaks */
@media (max-width: 640px) {
  .blank-slot { min-width: 120px; margin: 4px; }
  .pool-item { padding: 8px 10px; min-width: 56px; font-size: 14px; }
  .drag-ghost { font-size: 13px; padding: 6px 10px; }
}
</style>

<!-- GLOBAL styles (not scoped) so ghost appended to document.body can receive them -->
<style>
/* Ensure ghost has full background + border and matches pool-item visually.
   This block is global (no scoped) so the dynamically-added ghost DOM node
   will be styled correctly even though it's outside the component tree.
*/
.drag-ghost {
  position: fixed !important;
  pointer-events: none !important;
  z-index: 99999 !important;
  transform: translate(-50%,-50%) !important;
  display: inline-flex !important;
  align-items: center !important;
  justify-content: center !important;
  padding:8px 12px !important;
  border-radius:10px !important;
  background:#2e2e2e !important;        /* 深灰背景 */
  border:2px solid #ffffff !important;  /* 白色边框 */
  color:#ffffff !important;
  box-shadow: 0 14px 36px rgba(0,0,0,0.6) !important;
  font-size:14px !important;
  min-width:64px !important;
  text-align:center !important;
  pointer-events:none;
}
</style>