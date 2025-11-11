<template>
  <div class="fill-root" @contextmenu.prevent>
    <!-- Header: 与 Choice.vue 风格一致（圆形题号 + 标题同一行） -->
    <header class="fill-header choice-header">
      <div class="q-number-wrap">
        <div class="q-number">{{ displayIndex }}</div>
      </div>
      <h2 class="q-title" v-html="localQuestion.title || '未命名题目'"></h2>
    </header>

    <!-- 中心容器：问题文本、可选项池、提交按钮均居中 -->
    <div class="fill-center">
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

      <!-- Feedback and extras (居中显示的简短反馈) -->
      <div class="feedback" aria-live="polite">
        <div v-if="state === 'correct'" class="feedback-correct">✅ 回答正确</div>
        <div v-else-if="state === 'wrong'" class="feedback-wrong">❌ 回答错误，请再试一次</div>
      </div>

      <!-- 下面区域：改动点 —— 把 hint / explanation / next 按钮 放入 .left-block 以左对齐显示 -->
      <!-- left-block 宽度与 q-text 最大宽度一致，保持在页面中居中但内部内容左对齐 -->
      <div class="left-block">
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
    </div>
  </div>
</template>

<script setup>
/*
  完整实现（按你的新规则）:

  - A 方案（优先 blank -> pool -> restore） 保留
  - 计时法：在 pointerdown 记录时间；pointerup 时按时长 (< CLICK_TIME_THRESHOLD => 使用点击逻辑；>= => 使用拖拽逻辑)
  - 在判断落点时临时隐藏 ghost（避免 ghost 覆盖导致 elementFromPoint 误判）
  - 更可靠的落点判定：先查 closest('[data-blank-index]')，若无则判断坐标是否在 poolWrap 的 bounding rect 内 -> pool
  - 创建 ghost 时立刻设置 left/top 到 pointer 坐标，避免左上角闪动
  - 清理和占位行为保持（占位为纯灰、放下补位、点击自动填入、从 placed 拖出时 pool 显示占位等）
*/

import { ref, computed, watch, onBeforeUnmount, nextTick } from 'vue';

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
const originalOptions = ref([]); // 新增：保留题目原始 options 文本（用于索引型答案映射）

// drag state
const draggingId = ref(null);             // uid
const draggingFrom = ref(null);           // 'pool' | 'placed'
const draggingSourceIndex = ref(null);    // original source index
const placeholderPoolIndex = ref(null);
const placeholderActive = ref(false);
const currentOverBlank = ref(null);
const poolWrap = ref(null);

// ghost element reference (plain variable - DOM node appended to body)
let ghostEl = null;
const showGhost = ref(false);

// timing rule
let dragStartTime = 0;
const CLICK_TIME_THRESHOLD = 200; // ms — 小于则视作短时（用点击逻辑），否则用拖拽逻辑

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

// init from question
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
  originalOptions.value = opts.slice(); // 保存原始选项文本，后续用于将索引答案映射成文本
  const tstamp = Date.now();
  poolItems.value = opts.map((t, i) => ({ uid: `i${i}-${tstamp}`, text: String(t) }));

  // reset state
  draggingId.value = null; draggingFrom.value = null; draggingSourceIndex.value = null;
  placeholderPoolIndex.value = null; placeholderActive.value = false; currentOverBlank.value = null;
  attempts.value = 0; state.value = 'idle'; internalError.value = ''; nextDisabled.value = false;
  destroyGhost();
}

/* ---------- Ghost helpers ---------- */
// Create ghost and immediately set left/top to pointer coords to avoid 0,0 flash
function createGhostFromTextAt(text, x, y) {
  destroyGhost();
  const el = document.createElement('div');
  el.className = 'drag-ghost';
  el.innerText = text;
  el.style.position = 'fixed';
  el.style.left = `${x}px`;
  el.style.top = `${y}px`;
  el.style.transform = 'translate(-50%, -50%)';
  el.style.pointerEvents = 'none';
  el.style.zIndex = 99999;
  document.body.appendChild(el);
  ghostEl = el;
  showGhost.value = true;
}
// Move ghost
function moveGhost(x, y) {
  if (!ghostEl) return;
  // use left/top updates (avoid transform-only issues)
  ghostEl.style.left = `${x}px`;
  ghostEl.style.top = `${y}px`;
}
// Destroy ghost
function destroyGhost() {
  if (ghostEl && ghostEl.parentElement) ghostEl.parentElement.removeChild(ghostEl);
  ghostEl = null;
  showGhost.value = false;
}

/* ---------- Pointer handlers ---------- */
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

// begin dragging from pool
function beginPointerDragFromPool(evt, poolIndex) {
  if (inputDisabled.value) return;
  const item = poolItems.value[poolIndex];
  if (!item) return;
  draggingId.value = item.uid;
  draggingFrom.value = 'pool';
  draggingSourceIndex.value = poolIndex;
  placeholderPoolIndex.value = poolIndex;
  placeholderActive.value = true;

  // start timing
  dragStartTime = performance.now();

  // create ghost at pointer pos immediately (avoid 0,0)
  createGhostFromTextAt(item.text, evt.clientX || evt.pageX, evt.clientY || evt.pageY);

  attachPointerHandlers();
}

// begin dragging from placed
function beginPointerDragFromPlaced(evt, blankIndex) {
  if (inputDisabled.value) return;
  const item = placedAnswers.value[blankIndex];
  if (!item) return;
  draggingId.value = item.uid;
  draggingFrom.value = 'placed';
  draggingSourceIndex.value = blankIndex;
  // show placeholder at pool tail
  placeholderPoolIndex.value = poolItems.value.length;
  placeholderActive.value = true;

  dragStartTime = performance.now();

  createGhostFromTextAt(item.text, evt.clientX || evt.pageX, evt.clientY || evt.pageY);

  attachPointerHandlers();
}

// pointer move
function onPointerMove(evt) {
  if (!draggingId.value) return;
  try { evt.preventDefault(); } catch (e) {}
  moveGhost(evt.clientX || evt.pageX, evt.clientY || evt.pageY);

  // highlight blank under pointer
  if (currentOverBlank.value != null) {
    const prev = document.querySelector(`[data-blank-index="${currentOverBlank.value}"]`);
    if (prev) prev.classList.remove('drag-over');
    currentOverBlank.value = null;
  }
  const el = document.elementFromPoint(evt.clientX || evt.pageX, evt.clientY || evt.pageY);
  if (!el) return;
  const blankEl = el.closest && el.closest('[data-blank-index]');
  if (blankEl) {
    const idx = Number(blankEl.getAttribute('data-blank-index'));
    blankEl.classList.add('drag-over');
    currentOverBlank.value = idx;
  }
}

// pointer up -> decide by timing: short => click logic; long => A scheme (drag logic)
function onPointerUp(evt) {
  if (!draggingId.value) {
    detachPointerHandlers();
    destroyGhost();
    return;
  }
  const endTime = performance.now();
  const duration = endTime - (dragStartTime || endTime);
  // save pointer coords
  const x = evt.clientX || evt.pageX;
  const y = evt.clientY || evt.pageY;

  // Temporarily hide ghost to avoid elementFromPoint hitting it.
  if (ghostEl) ghostEl.style.display = 'none';

  // compute drop target using elementFromPoint (after ghost hidden)
  const elAt = document.elementFromPoint(x, y);
  let droppedOnBlankIndex = null;
  if (elAt) {
    const bEl = elAt.closest && elAt.closest('[data-blank-index]');
    if (bEl) droppedOnBlankIndex = Number(bEl.getAttribute('data-blank-index'));
  }

  // compute droppedOnPool by bounding rect check (more robust)
  let droppedOnPool = false;
  if (poolWrap?.value) {
    const r = poolWrap.value.getBoundingClientRect();
    if (x >= r.left && x <= r.right && y >= r.top && y <= r.bottom) droppedOnPool = true;
  }

  // Restore ghost visibility (we'll destroy later)
  if (ghostEl) ghostEl.style.display = '';

  // If short duration -> use click logic (as you requested)
  if (duration < CLICK_TIME_THRESHOLD) {
    if (draggingFrom.value === 'pool') {
      // find current pool index by uid (if still present)
      const uid = draggingId.value;
      const idx = poolItems.value.findIndex(it => it.uid === uid);
      if (idx !== -1) {
        // simulate click fill
        onClickPool(idx);
      }
    } else if (draggingFrom.value === 'placed') {
      // simulate click placed -> return to pool
      const sIdx = draggingSourceIndex.value;
      // ensure sIdx valid
      if (placedAnswers.value[sIdx] && placedAnswers.value[sIdx].uid === draggingId.value) {
        onClickPlaced(sIdx);
      } else {
        // if not matching (maybe swapped), try find by uid
        const found = placedAnswers.value.findIndex(p => p && p.uid === draggingId.value);
        if (found !== -1) onClickPlaced(found);
      }
    }
    // cleanup
    placeholderPoolIndex.value = null;
    placeholderActive.value = false;
    if (currentOverBlank.value != null) {
      const prev = document.querySelector(`[data-blank-index="${currentOverBlank.value}"]`);
      if (prev) prev.classList.remove('drag-over');
    }
    draggingId.value = null; draggingFrom.value = null; draggingSourceIndex.value = null;
    destroyGhost();
    detachPointerHandlers();
    return;
  }

  // ELSE: duration >= threshold -> true drag logic (A scheme)
  if (draggingFrom.value === 'pool') {
    const uid = draggingId.value;
    // locate current pool index of item (safe)
    const poolIndex = poolItems.value.findIndex(it => it.uid === uid);
    const sourceIdx = poolIndex === -1 ? draggingSourceIndex.value : poolIndex;

    if (droppedOnBlankIndex != null) {
      const item = poolItems.value[sourceIdx];
      if (item) {
        const replaced = placeIntoBlank(droppedOnBlankIndex, item);
        // remove from pool by uid
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
      // dropped on pool area -> interpret as return to pool (do nothing because pool item still exists)
      // Optionally, we could insert at placeholderPoolIndex; current behavior leaves item in place and placeholder removed.
    } else {
      // dropped elsewhere -> restore (no-op)
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

  // remove blank highlight if any
  if (currentOverBlank.value != null) {
    const prev = document.querySelector(`[data-blank-index="${currentOverBlank.value}"]`);
    if (prev) prev.classList.remove('drag-over');
  }

  // final cleanup
  draggingId.value = null; draggingFrom.value = null; draggingSourceIndex.value = null;
  destroyGhost();
  detachPointerHandlers();
}

/* ---------- native drag handlers (desktop support) ---------- */
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

/* ---------- Click behaviors ---------- */
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

/* ---------- answer checking ---------- */
function normalize(str) {
  if (str == null) return '';
  return String(str).trim().replace(/\s+/g, ' ').toLowerCase();
}
function checkAnswers() {
  // if zero blanks -> cannot be correct
  if (blanksCount.value === 0) return false;

  // all blanks must be filled
  if (placedAnswers.value.some(p => !p || !p.text)) return false;

  const raw = localQuestion.value?.answer;
  if (raw == null) return false;

  // normalize helper
  const norm = s => (s == null ? '' : String(s).trim().replace(/\s+/g, ' ').toLowerCase());

  // build canonical array: array-of-arrays, each inner array = allowed strings for that blank
  let canonArr = null;

  // If answer is an array (already parsed)
  if (Array.isArray(raw)) {
    // handle numeric/index answers -> map to originalOptions (1-based assumed)
    if (raw.every(x => typeof x === 'number' || (/^\d+$/.test(String(x).trim())) )) {
      // map numeric indices to option texts (support 1-based indices)
      canonArr = raw.map(idx => {
        const i = Number(idx);
        const optText = originalOptions.value && originalOptions.value[i - 1] != null
          ? String(originalOptions.value[i - 1])
          : String(idx); // fallback to the index string if no option text
        return [ norm(optText) ];
      });
    } else {
      // treat each raw item as allowed text (or alternatives)
      canonArr = raw.map(item => {
        if (Array.isArray(item)) return item.map(it => norm(it));
        return [ norm(item) ];
      });
    }
  } else if (typeof raw === 'string') {
    // try parse JSON if string-encoded
    try {
      const p = JSON.parse(raw);
      if (Array.isArray(p)) {
        // recursively reuse logic: p is array
        if (p.every(x => typeof x === 'number' || (/^\d+$/.test(String(x).trim())) )) {
          canonArr = p.map(idx => {
            const i = Number(idx);
            const optText = originalOptions.value && originalOptions.value[i - 1] != null
              ? String(originalOptions.value[i - 1])
              : String(idx);
            return [ norm(optText) ];
          });
        } else {
          canonArr = p.map(item => (Array.isArray(item) ? item.map(it => norm(it)) : [norm(item)]));
        }
      } else {
        // not an array after parse, treat as single canonical text
        canonArr = [[ norm(String(p)) ]];
      }
    } catch (e) {
      // not JSON -> maybe single text or pipe-separated alternatives
      if (raw.includes('|')) {
        canonArr = [ raw.split('|').map(s => norm(s)) ];
      } else {
        // if raw looks like "1,2" treat as indices
        const maybeNums = raw.split(/[,;]/).map(s => s.trim()).filter(Boolean);
        if (maybeNums.length > 1 && maybeNums.every(x => /^\d+$/.test(x))) {
          // treat as array of indices
          canonArr = maybeNums.map(idx => {
            const i = Number(idx);
            const optText = originalOptions.value && originalOptions.value[i - 1] != null
              ? String(originalOptions.value[i - 1])
              : String(idx);
            return [ norm(optText) ];
          });
        } else {
          canonArr = [[ norm(raw) ]];
        }
      }
    }
  } else if (typeof raw === 'number') {
    // single numeric index -> map to option text
    const i = Number(raw);
    const optText = originalOptions.value && originalOptions.value[i - 1] != null
      ? String(originalOptions.value[i - 1])
      : String(raw);
    canonArr = [[ norm(optText) ]];
  } else {
    // fallback: convert to string
    canonArr = [[ norm(String(raw)) ]];
  }

  // now canonArr is array-of-arrays (allowed normalized strings)
  if (!Array.isArray(canonArr)) return false;

  // if count mismatch, cannot be correct (must match number of blanks)
  if (canonArr.length !== placedAnswers.value.length) return false;

  for (let i = 0; i < canonArr.length; i++) {
    const allowed = canonArr[i] || [''];
    const u = norm(placedAnswers.value[i].text);
    const matched = allowed.some(alt => norm(alt) === u);
    if (!matched) return false;
  }
  return true;
}

/* ---------- submit / next ---------- */
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

/* ---------- utilities ---------- */
function placeIntoBlank(blankIdx, itemObj) {
  const replaced = placedAnswers.value[blankIdx];
  placedAnswers.value[blankIdx] = { uid: itemObj.uid, text: itemObj.text };
  return replaced;
}

/* ---------- watchers & lifecycle ---------- */
watch(() => props.question, (q) => initFromQuestion(q || {}), { immediate: true });
watch(() => props.questionIndex, () => initFromQuestion(localQuestion.value));
onBeforeUnmount(() => {
  destroyGhost();
  detachPointerHandlers();
});
</script>

<style scoped>
/* Dark theme whole component - 更贴近 Choice.vue 的黑底风格 */
.fill-root {
  padding: 22px;
  margin-top: 10px;
  margin-left: 15%;
  margin-right: 15%;
  background: #1c1c1c;
  border-radius: 30px;
  color: #fff;
  box-shadow: 12px 12px 36px rgba(194, 194, 194, 0.7);
  font-family: Inter, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial;
}

/* Header: 横排（题号 + 标题）—— 使用 Choice.vue 风格 */
.choice-header {
  display:flex;
  flex-direction:row;
  align-items:center;
  gap:12px;
  margin-bottom:16px;
  padding-left:12px;
}
.q-number-wrap {
  width:56px;
  height:56px;
  border-radius:50%;
  display:flex;
  align-items:center;
  justify-content:center;
  background: linear-gradient(135deg,#ff7a18 0%, #af002d 50%, #6a11cb 100%);
  box-shadow: 0 6px 18px rgba(0,0,0,0.6), inset 0 -6px 18px rgba(255,255,255,0.04);
}
.q-number {
  font-size:18px;
  font-weight:800;
  color:#fff;
  line-height:1;
}
.q-title {
  margin:0;
  font-size:18px;
  color:#fff;
  font-weight:700;
}

/* 中心容器：所有交互元素居中对齐 */
.fill-center {
  display:flex;
  flex-direction:column;
  align-items:center;
  justify-content:flex-start;
  gap:12px;
  padding: 6px 14px;
}

/* q-text 保持行内空位布局，但整体居中 */
.q-text {
  margin-bottom:12px;
  color:#e6eef8;
  display:flex;
  flex-wrap:wrap;
  gap:8px;
  align-items:center;
  justify-content:center; /* 居中所有段与空位 */
  max-width: 900px;
  text-align:center;
}

/* ---------- 新增：left-block 用于左对齐显示 hints/explain/next ---------- */
/* 这个容器宽度与 q-text 的 max-width 一致，align-self: flex-start 使其左贴到容器左侧 */
.left-block {
  width:100%;
  max-width:900px;
  align-self:flex-start;   /* 关键：在垂直排列的父容器中左对齐 */
  text-align:left;         /* 内容左对齐 */
  display:flex;
  flex-direction:column;
  gap:8px;
}

/* text segments */
.seg-text { white-space:pre-wrap; color:#e6eef8; }

/* blank slot */
.blank-slot {
  min-width:160px;
  min-height:44px;
  display:inline-flex;
  align-items:center;
  justify-content:center;
  padding:6px 10px;
  border-radius:8px;
  border:2px solid rgba(255,255,255,0.06);
  background: rgba(0,0,0,0.35);
  margin:0 6px;
  transition:all .12s ease;
  color:#eaf3ff;
}
.blank-slot.drag-over { border-color:#4fb0ff; box-shadow:0 10px 24px rgba(79,176,255,0.06); transform:translateY(-2px); }
.blank-slot.blank-filled { border-style:solid; border-color:rgba(79,176,255,0.14); background:rgba(255,255,255,0.02); }
.blank-placeholder { color:#98a6b3; font-size:13px; }

/* placed item (可拖动) */
.placed-item {
  padding:6px 10px;
  border-radius:6px;
  background:linear-gradient(180deg, rgba(255,255,255,0.02), rgba(255,255,255,0.01));
  border:2px solid rgba(255,255,255,0.04);
  color:#fff;
  cursor:grab;
  user-select:none;
  display:inline-block;
}
.placed-item:active { cursor:grabbing; }

/* Pool */
.pool-wrap { margin: 12px 0 6px; width:100%; display:flex; flex-direction:column; align-items:center; }
.pool-header { font-size:13px; color:#cfd8df; margin-bottom:6px; text-align:center; }
.pool-list { display:flex; flex-wrap:wrap; gap:8px; justify-content:center; max-width:900px; }

/* pool item: 使用 Choice.vue 风格的按钮感受——白边、深背景 */
.pool-item {
  padding:8px 12px;
  border-radius:12px;
  background: rgba(255,255,255,0.02);
  border:2px solid #fff;
  cursor:grab;
  user-select:none;
  box-shadow: 0 6px 18px rgba(0,0,0,0.6);
  color:#fff;
  transition: transform .12s ease, box-shadow .12s ease, background .12s ease;
  min-width:84px;
  text-align:center;
  display:inline-flex;
  align-items:center;
  justify-content:center;
  font-weight:700;
}
.pool-item:hover { transform: translateY(-4px); box-shadow: 0 12px 26px rgba(0,0,0,0.65); }

/* Placeholder: pure gray and hide text when active */
.pool-item.pool-placeholder,
.pool-item.dragging-placeholder {
  background:#6b6b6b !important;
  color:#ffffff;
  border:2px solid #6b6b6b !important;
}
.pool-item.pool-placeholder .pool-item-text,
.pool-item.dragging-placeholder .pool-item-text {
  visibility: hidden;
}

/* form / controls: 提交按钮居中 */
.fill-form { display:flex; flex-direction:column; gap:10px; margin-top:8px; width:100%; align-items:center; }
.controls { display:flex; align-items:center; gap:12px; margin-top:8px; justify-content:center; }
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
.btn-submit:disabled { opacity:0.5; cursor:not-allowed; }

/* feedback */
.feedback { margin-top:12px; min-height:24px; text-align:center; }
.feedback-correct { color:#7ff1b1; font-weight:800; animation: popIn .28s ease both; }
.feedback-wrong { color:#ff9b9b; font-weight:800; animation: popShake .45s cubic-bezier(.36,.07,.19,.97) both; }

.hint-box { padding:8px 12px; border-radius:8px; background: rgba(255,255,255,0.02); color:#ffb4b4; margin-top:8px; border:1px solid rgba(255,255,255,0.03); text-align:left; }
.explain-box { padding:12px; border-radius:8px; background: rgba(255,255,255,0.02); border:1px solid rgba(255,255,255,0.04); color:#dbeefe; text-align:left; }
.btn-next { padding:10px 14px; background:#0e78e9; color:#fff; border-radius:10px; border:none; cursor:pointer; font-weight:700; }

/* animations */
@keyframes popIn { 0% { transform: scale(.95); opacity: 0; } 60% { transform: scale(1.04); opacity: 1; } 100% { transform: scale(1); opacity: 1; } }
@keyframes popShake { 0% { transform: translateX(0); } 20% { transform: translateX(-6px); } 40% { transform: translateX(6px); } 60% { transform: translateX(-4px); } 80% { transform: translateX(4px); } 100% { transform: translateX(0); } }

/* 错误时整体抖动 */
.state-wrong .q-text { animation: shakeContainer .45s cubic-bezier(.36,.07,.19,.97); }
@keyframes shakeContainer { 0% { transform: translateX(0); } 20% { transform: translateX(-6px); } 40% { transform: translateX(6px); } 60% { transform: translateX(-4px); } 80% { transform: translateX(4px); } 100% { transform: translateX(0); } }

/* 答对时视觉（微光效果） */
.state-correct { box-shadow: 0 14px 40px rgba(34,197,94,0.08); transition: box-shadow .3s ease; outline: 1px solid rgba(34,197,94,0.06); }

/* responsive tweaks */
@media (max-width: 640px) {
  .blank-slot { min-width: 120px; margin: 4px; }
  .pool-item { padding: 8px 10px; min-width: 56px; font-size: 14px; }
}
</style>

<!-- GLOBAL styles (not scoped) so ghost appended to document.body can receive them -->
<style>
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
  background:#2e2e2e !important;
  border:2px solid #ffffff !important;
  color:#ffffff !important;
  box-shadow: 0 14px 36px rgba(0,0,0,0.6) !important;
  font-size:14px !important;
  min-width:64px !important;
  text-align:center !important;
  pointer-events:none;
}
</style>