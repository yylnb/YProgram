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

      <!-- 题目：直接作为普通文本渲染（你的新 DB text = TEXT） -->
      <div class="q-text-plain" v-if="plainText" v-html="plainText"></div>

      <!-- 如果没有 codeSegments，则保留原先的 q-text segments + blank-slot 行为（兼容旧题） -->
      <div class="q-text" v-if="(!codeSegments || codeSegments.length === 0) && textSegments && textSegments.length">
        <template v-for="(seg, idx) in textSegments" :key="idx">
          <span class="seg-text" v-if="seg" v-html="seg"></span>

          <!-- blank slot (旧逻辑，仍支持)： -->
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

      <!-- Input / Output 区域：后端提供，可能为空。只在后端提供时显示 -->
      <div class="io-area" v-if="showInputSection || showOutputSection">
        <div class="io-row" v-if="showInputSection">
          <label class="io-label">输入（input）</label>
          <textarea
            class="io-textarea"
            :value="inputText"
            readonly
            aria-readonly="true"
            placeholder="后端未提供输入示例"
            ref="inputArea"
          ></textarea>
        </div>
        <div class="io-row" v-if="showOutputSection">
          <label class="io-label">预期输出（output）</label>
          <textarea
            class="io-textarea"
            :value="outputText"
            readonly
            aria-readonly="true"
            placeholder="后端未提供输出示例"
            ref="outputArea"
          ></textarea>
        </div>
      </div>

      <!-- 代码区域放在页面最下面，并带标题 -->
      <div class="code-section" v-if="codeSegments && codeSegments.length">
        <div class="section-title">代码</div>
        <div class="code-area" role="region" aria-label="代码片段">
          <template v-for="(seg, sidx) in codeSegments" :key="`seg-${sidx}`">
            <!-- code_block -->
            <div v-if="seg.type === 'code_block'" class="code-block" aria-hidden="false">
              <template v-for="(line, li) in seg.lines" :key="`line-${sidx}-${li}`">
                <span class="code-line-text" v-html="escapeHtml(line)"></span><br />
              </template>
            </div>

            <!-- code_inline -->
            <div v-else-if="seg.type === 'code_inline'" class="code-inline" :data-seg-index="sidx">
              <template v-for="(part, pi) in seg.parts" :key="`part-${sidx}-${pi}`">
                <span
                  v-if="part.type === 'code'"
                  class="code-part code-inline-code"
                  v-html="escapeHtml(part.text)"
                  aria-hidden="true"
                ></span>

                <span
                  v-else-if="part.type === 'slot'"
                  class="blank-slot code-blank-slot"
                  :class="{ 'blank-filled': !!placedAnswers[part.slotIndex], 'disabled': inputDisabled }"
                  :data-blank-index="part.slotIndex"
                  role="region"
                  :aria-label="`空 ${part.slotIndex + 1}`"
                  @dragover.prevent
                  @drop.prevent="onDropToBlankNative($event, part.slotIndex)"
                >
                  <template v-if="placedAnswers[part.slotIndex]">
                    <div
                      class="placed-item"
                      @pointerdown.stop.prevent="beginPointerDragFromPlaced($event, part.slotIndex)"
                      @dragstart.prevent="onDragStartPlaced($event, part.slotIndex)"
                      @click.stop.prevent="onClickPlaced(part.slotIndex)"
                      draggable="true"
                      :aria-label="`已填入: ${placedAnswers[part.slotIndex].text}`"
                    >
                      {{ placedAnswers[part.slotIndex].text }}
                    </div>
                  </template>
                  <template v-else>
                    <span class="blank-placeholder">拖入选项</span>
                  </template>
                </span>

                <span v-else class="code-part" v-html="escapeHtml(part.text ?? '')"></span>
              </template>
            </div>

            <!-- unknown segment -->
            <div v-else class="code-unknown-seg" v-html="escapeHtml(seg.content || '')"></div>
          </template>
        </div>
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
  修改说明摘要：
  - code 区放最底部并加标题
  - input/output 仅在后端字段非 null/undefined 时显示（showInputSection / showOutputSection）
  - input/output 为只读 textarea，resize 禁用，并在初始化或内容变化时自动调整高度
  - 其余拖拽和判题逻辑保持不变
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

// parsed / rendering
const plainText = ref('');            // 直接渲染 question.text 字段
const textSegments = ref([]);         // 回退：旧式段落分割（若需要）
const codeSegments = ref([]);         // 处理后的 code segments（slot 部分带 slotIndex）
const poolItems = ref([]);            // { uid, text }
const placedAnswers = ref([]);        // array sized to blanksCount
const originalOptions = ref([]);

// IO areas (只读显示)
const inputText = ref('');
const outputText = ref('');
const showInputSection = ref(false);
const showOutputSection = ref(false);

// textarea refs for auto resize
const inputArea = ref(null);
const outputArea = ref(null);

// drag state (保留原变量名)
const draggingId = ref(null);
const draggingFrom = ref(null);
const draggingSourceIndex = ref(null);
const placeholderPoolIndex = ref(null);
const placeholderActive = ref(false);
const currentOverBlank = ref(null);
const poolWrap = ref(null);

// ghost
let ghostEl = null;
const showGhost = ref(false);

// timing rule
let dragStartTime = 0;
const CLICK_TIME_THRESHOLD = 200;

// computed
const blanksCount = computed(() => {
  // 优先使用 codeSegments 中定义的 slot 数量（若存在）
  if (codeSegments.value && codeSegments.value.length) {
    let n = 0;
    for (const seg of codeSegments.value) {
      if (seg.type === 'code_inline' && Array.isArray(seg.parts)) {
        for (const p of seg.parts) {
          if (p && p.type === 'slot' && typeof p.slotIndex === 'number') n++;
        }
      }
    }
    return n;
  }
  // 回退：旧逻辑，textSegments 长度 - 1
  return Math.max(0, (textSegments.value && textSegments.value.length ? textSegments.value.length - 1 : 0));
});

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

function escapeHtml(str) {
  if (str == null) return '';
  const s = String(str);
  return s.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
}

// 递归尝试从对象中提取最有可能的文本字段（value/text/code/line）
function extractTextFromObject(obj) {
  if (obj == null) return '';
  if (typeof obj === 'string') return obj;
  if (typeof obj === 'number' || typeof obj === 'boolean') return String(obj);
  if (Array.isArray(obj)) {
    return obj.map(it => extractTextFromObject(it)).join(' ');
  }
  if (typeof obj === 'object') {
    const candidates = ['value','text','code','line','content','v','val'];
    for (const key of candidates) {
      if (key in obj && obj[key] != null) {
        if (typeof obj[key] === 'object') return extractTextFromObject(obj[key]);
        return String(obj[key]);
      }
    }
    const keys = Object.keys(obj);
    for (const k of keys) {
      if (typeof obj[k] === 'string' || typeof obj[k] === 'number' || typeof obj[k] === 'boolean') return String(obj[k]);
      if (typeof obj[k] === 'object') {
        const v = extractTextFromObject(obj[k]);
        if (v) return v;
      }
    }
    try {
      const s = JSON.stringify(obj);
      return s.length > 500 ? s.slice(0,500) + '...' : s;
    } catch (e) {
      return String(obj);
    }
  }
  return String(obj);
}

// 把 code_block 的 line 规范为纯字符串（优先取可能的 text/code/value/line 字段）
function lineToString(line) {
  if (line == null) return '';
  if (typeof line === 'string') return line;
  if (typeof line === 'number' || typeof line === 'boolean') return String(line);
  return extractTextFromObject(line);
}

// 把 code_inline 的 part 规范化成 { type: 'code'|'slot', text?, slotIndex? }
function partToNormalized(p, slotCounterRef) {
  if (p == null) return { type: 'code', text: '' };

  if (typeof p === 'string') return { type: 'code', text: p };

  if (typeof p === 'object') {
    if (p.type === 'slot' || p.slot === true || p.isSlot === true) {
      const idx = slotCounterRef && typeof slotCounterRef.v === 'number' ? slotCounterRef.v++ : 0;
      return { type: 'slot', slotIndex: idx };
    }

    if (p.type === 'code' || p.type === 'text' || p.type === 'part') {
      const t = p.text ?? p.code ?? p.value ?? p.content ?? p.line ?? null;
      return { type: 'code', text: t == null ? '' : String(t) };
    }

    if ('text' in p || 'value' in p || 'code' in p || 'content' in p) {
      const t = p.text ?? p.value ?? p.code ?? p.content;
      return { type: 'code', text: t == null ? '' : String(t) };
    }

    if ('slotIndex' in p && (p.slotIndex !== undefined && p.slotIndex !== null)) {
      return { type: 'slot', slotIndex: Number(p.slotIndex) };
    }

    const tFallback = extractTextFromObject(p);
    return { type: 'code', text: tFallback };
  }

  return { type: 'code', text: String(p) };
}

/* ---------- 自动调整 textarea 高度 ---------- */
function resizeTextarea(el) {
  if (!el) return;
  // reset then set to scrollHeight to fit content
  el.style.height = 'auto';
  const newHeight = el.scrollHeight;
  el.style.height = `${newHeight}px`;
}
function scheduleResizeIO() {
  nextTick(() => {
    resizeTextarea(inputArea.value);
    resizeTextarea(outputArea.value);
  });
}

/* ---------- 初始化题目数据（解析 text / options / code / input / output） -------------- */
function initFromQuestion(q) {
  localQuestion.value = q ? { ...q } : {};

  // 1) plainText / textSegments
  if (localQuestion.value && localQuestion.value.text != null) {
    if (typeof localQuestion.value.text === 'string') {
      plainText.value = localQuestion.value.text;
      textSegments.value = [ plainText.value ];
    } else {
      const parsed = safeParseJSON(localQuestion.value.text);
      if (Array.isArray(parsed)) {
        textSegments.value = parsed.map(s => (s == null ? '' : String(s)));
        plainText.value = textSegments.value.join('');
      } else {
        plainText.value = String(localQuestion.value.text);
        textSegments.value = [ plainText.value ];
      }
    }
  } else {
    plainText.value = '';
    textSegments.value = [''];
  }

  // 2) input / output 解析：如果原始字段为 null/undefined -> 对应区块不显示
  const rawInputRaw = (localQuestion.value && Object.prototype.hasOwnProperty.call(localQuestion.value, 'input')) ? localQuestion.value.input : undefined;
  if (rawInputRaw === null || rawInputRaw === undefined) {
    showInputSection.value = false;
    inputText.value = '';
  } else {
    showInputSection.value = true;
    const parsedInput = safeParseJSON(localQuestion.value?.input);
    if (parsedInput != null) {
      if (Array.isArray(parsedInput)) {
        inputText.value = parsedInput.map(it => (typeof it === 'object' ? JSON.stringify(it) : String(it))).join('\n');
      } else if (typeof parsedInput === 'object') {
        inputText.value = JSON.stringify(parsedInput, null, 2);
      } else {
        inputText.value = String(parsedInput);
      }
    } else {
      inputText.value = localQuestion.value?.input != null ? String(localQuestion.value.input) : '';
    }
  }

  const rawOutputRaw = (localQuestion.value && Object.prototype.hasOwnProperty.call(localQuestion.value, 'output')) ? localQuestion.value.output : undefined;
  if (rawOutputRaw === null || rawOutputRaw === undefined) {
    showOutputSection.value = false;
    outputText.value = '';
  } else {
    showOutputSection.value = true;
    const parsedOutput = safeParseJSON(localQuestion.value?.output);
    if (parsedOutput != null) {
      if (Array.isArray(parsedOutput)) {
        outputText.value = parsedOutput.map(it => (typeof it === 'object' ? JSON.stringify(it) : String(it))).join('\n');
      } else if (typeof parsedOutput === 'object') {
        outputText.value = JSON.stringify(parsedOutput, null, 2);
      } else {
        outputText.value = String(parsedOutput);
      }
    } else {
      outputText.value = localQuestion.value?.output != null ? String(localQuestion.value.output) : '';
    }
  }

  // 3) code 字段解析并构建 codeSegments（支持嵌套 line 对象）
  codeSegments.value = [];
  const rawCode = safeParseJSON(localQuestion.value?.code) ?? localQuestion.value?.code;
  if (rawCode && Array.isArray(rawCode.segments)) {
    // build segments with normalized parts and lines
    let slotGlobalCounter = 0;
    for (const seg of rawCode.segments) {
      if (!seg || !seg.type) {
        if (Array.isArray(seg)) {
          const lines = seg.map(l => lineToString(l));
          codeSegments.value.push({ type: 'code_block', lines });
        } else {
          codeSegments.value.push({ type: seg?.type || 'unknown', content: seg?.content ?? JSON.stringify(seg) });
        }
        continue;
      }

      if (seg.type === 'code_block') {
        const linesRaw = Array.isArray(seg.lines) ? seg.lines : (Array.isArray(seg.content) ? seg.content : []);
        const lines = linesRaw.map(l => lineToString(l));
        codeSegments.value.push({ type: 'code_block', lines });
      } else if (seg.type === 'code_inline') {
        const rawParts = Array.isArray(seg.parts) ? seg.parts : (Array.isArray(seg.content) ? seg.content : []);
        // normalize parts and assign global slot indices sequentially
        const parts = rawParts.map(p => {
          const normalized = partToNormalized(p, { v: slotGlobalCounter });
          if (normalized.type === 'slot') {
            normalized.slotIndex = slotGlobalCounter++;
            return normalized;
          }
          return { type: 'code', text: normalized.text ?? '' };
        });
        codeSegments.value.push({ type: 'code_inline', parts });
      } else {
        codeSegments.value.push({ type: seg.type, content: seg.content ?? (seg.lines ? seg.lines : '') });
      }
    }
    // ensure slots are globally sequential (should already be)
  } else {
    codeSegments.value = [];
  }

  // 4) pool / options
  let opts = safeParseJSON(localQuestion.value?.options);
  if (!opts || !Array.isArray(opts)) {
    if (typeof localQuestion.value?.options === 'string') {
      opts = localQuestion.value.options.split(/\r?\n|,/).map(x => x.trim()).filter(Boolean);
    } else opts = [];
  }
  originalOptions.value = opts.slice();
  const tstamp = Date.now();
  poolItems.value = opts.map((t, i) => ({ uid: `i${i}-${tstamp}`, text: String(t) }));

  // 5) prepare placedAnswers 长度等于 blanksCount（基于 code slots 优先）
  const bc = blanksCount.value;
  placedAnswers.value = Array(bc).fill(null);

  // reset drag states
  draggingId.value = null; draggingFrom.value = null; draggingSourceIndex.value = null;
  placeholderPoolIndex.value = null; placeholderActive.value = false; currentOverBlank.value = null;
  attempts.value = 0; state.value = 'idle'; internalError.value = ''; nextDisabled.value = false;

  destroyGhost();

  // after DOM updated, resize IO textareas to fit content
  scheduleResizeIO();
}

/* ---------- Ghost helpers ---------- */
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
function moveGhost(x, y) {
  if (!ghostEl) return;
  ghostEl.style.left = `${x}px`;
  ghostEl.style.top = `${y}px`;
}
function destroyGhost() {
  if (ghostEl && ghostEl.parentElement) ghostEl.parentElement.removeChild(ghostEl);
  ghostEl = null;
  showGhost.value = false;
}

/* ---------- Pointer / Drag handlers (保持你的原实现，未改动核心流程) ---------- */
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

  dragStartTime = performance.now();
  createGhostFromTextAt(item.text, evt.clientX || evt.pageX, evt.clientY || evt.pageY);
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

  dragStartTime = performance.now();
  createGhostFromTextAt(item.text, evt.clientX || evt.pageX, evt.clientY || evt.pageY);
  attachPointerHandlers();
}

function onPointerMove(evt) {
  if (!draggingId.value) return;
  try { evt.preventDefault(); } catch (e) {}
  moveGhost(evt.clientX || evt.pageX, evt.clientY || evt.pageY);

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

function onPointerUp(evt) {
  if (!draggingId.value) {
    detachPointerHandlers();
    destroyGhost();
    return;
  }
  const endTime = performance.now();
  const duration = endTime - (dragStartTime || endTime);
  const x = evt.clientX || evt.pageX;
  const y = evt.clientY || evt.pageY;

  if (ghostEl) ghostEl.style.display = 'none';
  const elAt = document.elementFromPoint(x, y);
  let droppedOnBlankIndex = null;
  if (elAt) {
    const bEl = elAt.closest && elAt.closest('[data-blank-index]');
    if (bEl) droppedOnBlankIndex = Number(bEl.getAttribute('data-blank-index'));
  }
  let droppedOnPool = false;
  if (poolWrap?.value) {
    const r = poolWrap.value.getBoundingClientRect();
    if (x >= r.left && x <= r.right && y >= r.top && y <= r.bottom) droppedOnPool = true;
  }
  if (ghostEl) ghostEl.style.display = '';

  if (duration < CLICK_TIME_THRESHOLD) {
    if (draggingFrom.value === 'pool') {
      const uid = draggingId.value;
      const idx = poolItems.value.findIndex(it => it.uid === uid);
      if (idx !== -1) {
        onClickPool(idx);
      }
    } else if (draggingFrom.value === 'placed') {
      const sIdx = draggingSourceIndex.value;
      if (placedAnswers.value[sIdx] && placedAnswers.value[sIdx].uid === draggingId.value) {
        onClickPlaced(sIdx);
      } else {
        const found = placedAnswers.value.findIndex(p => p && p.uid === draggingId.value);
        if (found !== -1) onClickPlaced(found);
      }
    }
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
      // no-op
    } else {
      // no-op
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
      // no-op
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

/* ---------- native drag handlers ---------- */
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

/* ---------- answer checking（保持原逻辑） ---------- */
function normalize(str) {
  if (str == null) return '';
  return String(str).trim().replace(/\s+/g, ' ').toLowerCase();
}
function checkAnswers() {
  if (blanksCount.value === 0) return false;
  if (placedAnswers.value.some(p => !p || !p.text)) return false;

  const raw = localQuestion.value?.answer;
  if (raw == null) return false;

  const norm = s => (s == null ? '' : String(s).trim().replace(/\s+/g, ' ').toLowerCase());
  let canonArr = null;

  if (Array.isArray(raw)) {
    if (raw.every(x => typeof x === 'number' || (/^\d+$/.test(String(x).trim())) )) {
      canonArr = raw.map(idx => {
        const i = Number(idx);
        const optText = originalOptions.value && originalOptions.value[i - 1] != null
          ? String(originalOptions.value[i - 1])
          : String(idx);
        return [ norm(optText) ];
      });
    } else {
      canonArr = raw.map(item => {
        if (Array.isArray(item)) return item.map(it => norm(it));
        return [ norm(item) ];
      });
    }
  } else if (typeof raw === 'string') {
    try {
      const p = JSON.parse(raw);
      if (Array.isArray(p)) {
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
        canonArr = [[ norm(String(p)) ]];
      }
    } catch (e) {
      if (raw.includes('|')) {
        canonArr = [ raw.split('|').map(s => norm(s)) ];
      } else {
        const maybeNums = raw.split(/[,;]/).map(s => s.trim()).filter(Boolean);
        if (maybeNums.length > 1 && maybeNums.every(x => /^\d+$/.test(x))) {
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
    const i = Number(raw);
    const optText = originalOptions.value && originalOptions.value[i - 1] != null
      ? String(originalOptions.value[i - 1])
      : String(raw);
    canonArr = [[ norm(optText) ]];
  } else {
    canonArr = [[ norm(String(raw)) ]];
  }

  if (!Array.isArray(canonArr)) return false;
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
  emit('next', {
    questionIndex: props.questionIndex,
    nextIndex: nextIndex,
    isLast: isLastQuestion.value
  });
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

// when inputText/outputText change, resize corresponding textarea
watch(inputText, () => scheduleResizeIO());
watch(outputText, () => scheduleResizeIO());

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
@media (max-width: 900px) {
  .fill-root {
    margin-left: 2.5%;
    margin-right: 2.5%;
    padding: 22px 2px;
  }
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
@media (max-width: 900px) {
  .q-number-wrap {
    width: 44px;
    height: 44px;
  }
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

/* 纯文本题目 */
.q-text-plain {
  color:#e6eef8;
  max-width:900px;
  text-align:left;
  width:100%;
  white-space:pre-wrap;
  padding:8px 12px;
  margin-bottom: 12px;
  border-radius:8px;
  background: #1c1c1c;
  border:1px solid rgba(255,255,255,0.02);
}

/* 代码与 IO 的 section 标题 */
.section-title {
  color:#cfe8ff;
  font-weight:800;
  margin:8px 0;
  font-size:14px;
  max-width:900px;
  text-align:left;
  width:100%;
}

/* 代码区域 */
.code-section { width:100%; max-width:900px; }
.code-area {
  width:100%;
  padding:15px 10px 15px 20px;
  border-radius:20px;
  background: rgba(10,10,10,0.45);
  border:1px solid rgba(255,255,255,0.03);
  color:#e6eef8;
  text-align:left;
  font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, "Roboto Mono", "Helvetica Neue", monospace;
  font-size:16px;
  /* auto height by content (div naturally grows) */
}
@media (max-width: 900px) {
  .code-area {
    padding-left: 10px;
    
  }
}

/* code_block */
.code-block { margin-bottom:8px; }
.code-line-text {
  display:inline-block;       /* inline-block 保证占位且对齐 */
  white-space: pre;           /* 保留空格 */
  line-height:1.35;
  font-family: inherit;
}

/* code_inline: parts inline, slots inline-block 保证精确对齐 */
.code-inline { display:inline; white-space:pre; font-family: inherit; }
.code-part { display:inline-block; white-space: pre; line-height:1.35; }
.code-inline-code { /* regular inline code piece */ padding:0 2px; }

/* code slot 与普通 blank-slot 保持视觉一致，但 inline 样式以消除错位 */
.code-blank-slot {
  min-width:84px;
  min-height:28px;
  display:inline-flex;        /* inline-flex 保持在文本行内但支持居中对齐 */
  align-items:center;
  justify-content:center;
  padding:2px 8px;
  border-radius:6px;
  border:1px dashed rgba(255,255,255,0.06);
  background: rgba(0,0,0,0.25);
  margin:0 4px;
  color:#eaf3ff;
}

/* q-text 回退样式（当没有 codeSegments） */
.q-text {
  margin-bottom:12px;
  color:#e6eef8;
  display:flex;
  flex-wrap:wrap;
  gap:8px;
  align-items:center;
  justify-content:center;
  max-width: 900px;
  text-align:center;
  background-color: #1c1c1c;
}
.seg-text { white-space:pre-wrap; color:#e6eef8; }

/* blank slot（旧式） */
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

/* placed item */
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

/* pool item */
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

/* Placeholder */
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

/* IO area */
.io-area { width:100%; max-width:900px; display:flex; flex-direction:column; gap:8px; align-items:stretch; margin:10px 0 10px 0; }
.io-row { display:flex; flex-direction:column; gap:6px; }
.io-label { color:#cfe8ff; font-weight:700; font-size:13px; }
.io-textarea {
  min-height:80px;
  resize:none; /* 禁止用户手动调整 */
  padding:15px 10px 15px 20px;
  border-radius:20px;
  background: rgba(0,0,0,0.35);
  border:1px solid rgba(255,255,255,0.03);
  color:#e6eef8;
  font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, "Roboto Mono", "Helvetica Neue", monospace;
  font-size: 16px;
  white-space:pre-wrap;
  overflow: hidden;
  width:100%;
  box-sizing:border-box;
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

/* feedback & left-block */
.feedback { margin-top:12px; min-height:24px; text-align:center; }
.feedback-correct { color:#7ff1b1; font-weight:800; animation: popIn .28s ease both; }
.feedback-wrong { color:#ff9b9b; font-weight:800; animation: popShake .45s cubic-bezier(.36,.07,.19,.97) both; }

.left-block {
  width:100%;
  max-width:900px;
  align-self:flex-start;
  text-align:left;
  display:flex;
  flex-direction:column;
  gap:8px;
  padding: 0 10px;
}
.hint-box { padding:8px 12px; border-radius:8px; background: rgba(255,255,255,0.02); color:#ffb4b4; margin-top:8px; border:1px solid rgba(255,255,255,0.03); text-align:left; }
.explain-box {
  padding:14px;
  border-radius:20px;
  background: rgba(0, 0, 0, 0.351);
  border:1px solid rgba(255, 255, 255, 0.273);
  color:#dbeefe;
}
.btn-next { padding:10px 14px; background:#0e78e9; color:#fff; border-radius:10px; border:none; cursor:pointer; font-weight:700; }

/* animations */
@keyframes popIn { 0% { transform: scale(.95); opacity: 0; } 60% { transform: scale(1.04); opacity: 1; } 100% { transform: scale(1); opacity: 1; } }
@keyframes popShake { 0% { transform: translateX(0); } 20% { transform: translateX(-6px); } 40% { transform: translateX(6px); } 60% { transform: translateX(-4px); } 80% { transform: translateX(4px); } 100% { transform: translateX(0); } }

.state-wrong .q-text { animation: shakeContainer .45s cubic-bezier(.36,.07,.19,.97); }
@keyframes shakeContainer { 0% { transform: translateX(0); } 20% { transform: translateX(-6px); } 40% { transform: translateX(6px); } 60% { transform: translateX(-4px); } 80% { transform: translateX(4px); } 100% { transform: translateX(0); } }

.state-correct { box-shadow: 0 14px 40px rgba(34,197,94,0.08); transition: box-shadow .3s ease; outline: 1px solid rgba(34,197,94,0.06); }

@media (max-width: 640px) {
  .code-blank-slot { min-width:72px; }
  .blank-slot { min-width:120px; margin: 4px; }
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
  background:#1c1c1c !important;
  border:2px solid #ffffff !important;
  color:#ffffff !important;
  box-shadow: 0 14px 36px rgba(0,0,0,0.6) !important;
  font-size:14px !important;
  min-width:64px !important;
  text-align:center !important;
  pointer-events:none;
}
</style>