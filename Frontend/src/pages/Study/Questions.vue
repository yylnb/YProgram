<template>
  <div>
    <template v-if="loading">
      正在加载题目…
    </template>

    <template v-else-if="loadError">
      <div style="color:var(--danger,#c0392b)">{{ loadError }}</div>
    </template>

    <template v-else>
      <component
        :is="currentComponent"
        :question="questionData"
        :questionIndex="currentQuestionIndex"
        :language="language"
        :unitId="unitId"
        :token="token"
        :disabled="disabledForChild"
        :totalQuestions="totalQuestions"
        @correct="onChildCorrect"
        @next="onChildNext"
      />
    </template>

    <div v-if="saveError" class="hint-box" style="margin-top:10px; color:#c23a2b;">
      进度同步失败：{{ saveError }}
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch, onMounted } from 'vue';
import axios from 'axios';

// 子组件
import Choice from './Choice.vue';
import Fill from './Fill.vue';

// props from parent (StudyNew.vue)
const props = defineProps({
  questionIndex: { type: Number, default: null },
  language: { type: String, default: '' },
  courseFull: { type: String, default: '' }, // e.g. "python1"
  unitId: { type: [String, Number], default: '' },
  token: { type: String, default: '' },
  // optional parent-provided progressData (will be merged/used)
  progressData: { type: [Object, null], default: null }
});

const emit = defineEmits(['select-question', 'answered', 'progress-updated', 'unit-complete']);

// state
const loading = ref(false);
const loadError = ref('');
const saveError = ref('');
const questionData = ref(null);
const totalQuestions = 15;
const currentQuestionIndex = ref(1);
const disabledForChild = ref(false);
const pendingSave = ref(false);

// ----------------------- helpers: component choice -----------------------
function isFillByIndex(idx) {
  if (!idx || typeof idx !== 'number') return false;
  if (idx >= 4 && idx <= 5) return true;
  if (idx >= 9 && idx <= 10) return true;
  if (idx >= 14 && idx <= 15) return true;
  return false;
}
const currentComponent = computed(() => (isFillByIndex(Number(currentQuestionIndex.value)) ? Fill : Choice));

// ----------------------- parse courseFull -----------------------
function parseCourseString(str) {
  const s = String(str || '').trim();
  if (!s) return { lang: null, index: null };
  const alphaMatch = s.match(/^[A-Za-z_]+/);
  const numMatch = s.match(/(\d+)$/);
  return {
    lang: alphaMatch ? alphaMatch[0].toLowerCase() : null,
    index: numMatch ? numMatch[1] : null
  };
}
const parsedCourse = computed(() => parseCourseString(props.courseFull));

// ----------------------- language mapping (for question GET) -----------------------
// For asking question endpoint, backend expects short code (e.g. 'py','cpp','c','java').
// This map converts common inputs to short code.
function langShortForQuestionApi() {
  // try to use props.language if it's already a short code
  const m = String(props.language || parsedCourse.value.lang || '').toLowerCase();
  const shortMap = { py: 'py', python: 'py', python3: 'py', cpp: 'cpp', 'c++': 'cpp', c: 'c', java: 'java' };
  return shortMap[m] ?? (m || 'py'); // fallback to 'py'
}

// ----------------------- lang and index for progress POST -----------------------
function langForProgressApi() {
  // backend accepts lang like 'python' or 'python_1'; we'll pass base language (e.g. 'python')
  // prefer parsedCourse.lang (e.g. 'python' extracted from courseFull), else map short code
  const raw = parsedCourse.value.lang ?? String(props.language || '').toLowerCase();
  const map = { py: 'python', python: 'python', cpp: 'cpp', c: 'c', java: 'java' };
  return map[raw] ?? (raw || 'python');
}

function idxForApi() {
  // priority:
  // 1) props.progressData.index (if parent provided progressData that includes 'index')
  // 2) props.progressData?.index (same)
  // 3) parsedCourse.index (from courseFull like 'python1')
  // 4) fallback undefined (we won't send index if truly unknown)
  if (props.progressData && (typeof props.progressData.index !== 'undefined' && props.progressData.index !== null)) {
    return props.progressData.index;
  }
  if (props.progressData && (typeof props.progressData.lang !== 'undefined' && props.progressData.lang)) {
    // some backends may put lang like 'python_1' - try to extract trailing number
    const m = String(props.progressData.lang).match(/_(\d+)$/);
    if (m) return m[1];
  }
  if (parsedCourse.value.index) return parsedCourse.value.index;
  return undefined;
}

// ----------------------- fetch progress (GET /api/progress/:unitId) -----------------------
const progressDataLocal = ref(props.progressData ?? null);

async function fetchProgress() {
  progressDataLocal.value = props.progressData ?? null;
  saveError.value = '';
  if (!props.unitId) return;
  const lang = langForProgressApi();
  const idx = idxForApi();
  const params = {};
  if (lang) params.lang = lang;
  if (typeof idx !== 'undefined') params.index = idx;

  try {
    const url = `/api/progress/${encodeURIComponent(String(props.unitId))}`;
    const cfg = { params, withCredentials: true, timeout: 8000 };
    if (props.token) cfg.headers = { Authorization: `Bearer ${props.token}` };
    const res = await axios.get(url, cfg);
    progressDataLocal.value = res?.data ?? null;
  } catch (err) {
    console.warn('fetchProgress error', err);
    progressDataLocal.value = props.progressData ?? null;
  }
}

// ----------------------- load question (GET /api/question/:form/:lang/:index/:q_id) -----------------------
function clampIndex(n) {
  let num = Number(n);
  if (!Number.isFinite(num) || Number.isNaN(num)) num = 1;
  num = Math.round(num);
  if (num < 1) num = 1;
  if (num > totalQuestions) num = totalQuestions;
  return num;
}

async function determineIndexAndLoad() {
  // priority: explicit props.questionIndex -> progressDataLocal.current_index -> default 1
  const fromProp = (typeof props.questionIndex === 'number' && !Number.isNaN(props.questionIndex)) ? Number(props.questionIndex) : null;
  let fromProgress = null;
  if (progressDataLocal.value) {
    const ci = progressDataLocal.value.current_index ?? progressDataLocal.value.currentIndex ?? null;
    if (ci !== null && typeof ci !== 'undefined') {
      const n = Number(ci);
      if (!Number.isNaN(n)) fromProgress = n;
    }
  }

  if (fromProp !== null) currentQuestionIndex.value = clampIndex(fromProp);
  else if (fromProgress !== null) currentQuestionIndex.value = clampIndex(fromProgress);
  else currentQuestionIndex.value = 1;

  emit('select-question', { questionIndex: currentQuestionIndex.value });
  await fetchQuestion(currentQuestionIndex.value);
}

async function fetchQuestion(qid) {
  loadError.value = '';
  questionData.value = null;
  if (!qid) {
    loadError.value = '题号无效';
    return;
  }

  loading.value = true;
  try {
    const form = isFillByIndex(Number(qid)) ? 'fill' : 'choice';
    const langShort = langShortForQuestionApi();
    // index for question table selection: try progressDataLocal.index -> parsedCourse.index -> 1
    const idx = (progressDataLocal.value && (typeof progressDataLocal.value.index !== 'undefined' && progressDataLocal.value.index !== null))
      ? progressDataLocal.value.index
      : (parsedCourse.value.index ?? 1);

    const url = `/api/question/${encodeURIComponent(form)}/${encodeURIComponent(langShort)}/${encodeURIComponent(String(idx))}/${encodeURIComponent(String(qid))}`;
    const cfg = { withCredentials: true, timeout: 8000 };
    if (props.token) cfg.headers = { Authorization: `Bearer ${props.token}` };
    const res = await axios.get(url, cfg);

    const payload = res?.data ?? null;
    if (!payload) {
      loadError.value = '后端未返回题目数据';
      questionData.value = null;
    } else {
      const q = payload.data ? payload.data : payload;
      questionData.value = { ...q };
    }
  } catch (err) {
    console.error('fetchQuestion error', err);
    if (err?.response?.status === 404) loadError.value = '题目未找到 (404)';
    else if (err?.response?.status === 401) loadError.value = '未登录或无权限 (401)';
    else {
      const msg = err?.response?.data?.error ?? err?.message ?? '加载题目失败，请检查后端或网络';
      loadError.value = msg;
    }
    questionData.value = null;
  } finally {
    loading.value = false;
  }
}

// ----------------------- save progress (POST /api/progress) -----------------------
async function saveProgress(nextIndex) {
  saveError.value = '';
  if (!props.unitId) {
    saveError.value = '缺少 unitId，无法保存进度';
    return null;
  }

  const lang = langForProgressApi(); // e.g. 'python'
  let idx = idxForApi();
  // if still undefined try parsedCourse.index
  if (typeof idx === 'undefined' && parsedCourse.value.index) idx = parsedCourse.value.index;

  const body = {
    unit_id: String(props.unitId),
    current_index: nextIndex,
    completed: nextIndex > totalQuestions ? 1 : 0,
    lang: lang
  };
  // ensure we include index if available (important when a language has multiple tables)
  if (typeof idx !== 'undefined' && idx !== null) body.index = idx;

  try {
    pendingSave.value = true;
    const url = `/api/progress`;
    const cfg = { withCredentials: true, timeout: 8000 };
    if (props.token) cfg.headers = { Authorization: `Bearer ${props.token}` };
    const res = await axios.post(url, body, cfg);
    const pd = res?.data ?? null;
    // build a lightweight progressData for local use
    progressDataLocal.value = {
      current_index: nextIndex,
      completed: body.completed,
      lang: body.lang,
      index: typeof body.index !== 'undefined' ? body.index : null,
      table: pd?.table ?? null
    };
    emit('progress-updated', progressDataLocal.value);
    saveError.value = '';
    return progressDataLocal.value;
  } catch (err) {
    console.error('saveProgress POST error', err);
    if (err?.response?.data?.error) saveError.value = err.response.data.error;
    else saveError.value = '保存进度失败（网络/服务器）';
    return null;
  } finally {
    pendingSave.value = false;
  }
}

// ----------------------- child event handlers -----------------------
// Child will emit 'correct' only when user answers correctly.
// We then attempt to save progress (nextIndex = current + 1) but wait for the child's 'next' to actually change UI.
async function onChildCorrect(payload) {
  // payload may include attempts
  const nextIdx = clampIndex(currentQuestionIndex.value + 1);

  // optionally disable child while saving
  disabledForChild.value = true;
  await saveProgress(nextIdx); // save will include 'index' now when available
  disabledForChild.value = false;

  // notify upper layer that question was answered correctly
  emit('answered', { correct: true, attempts: payload?.attempts ?? 1, questionIndex: currentQuestionIndex.value, progress: progressDataLocal.value });
}

// Child emits 'next' when user clicks Next (only available after correct)
async function onChildNext(payload) {
  let nextIdx = null;
  if (payload && typeof payload.nextIndex === 'number') nextIdx = clampIndex(payload.nextIndex);
  else nextIdx = clampIndex(currentQuestionIndex.value + 1);

  if (nextIdx > totalQuestions) {
    // ensure completed saved
    await saveProgress(nextIdx);
    emit('unit-complete', { unitId: props.unitId, progress: progressDataLocal.value });
    return;
  }

  currentQuestionIndex.value = nextIdx;
  emit('select-question', { questionIndex: nextIdx });
  await fetchQuestion(nextIdx);
}

// ----------------------- watchers & lifecycle -----------------------
watch(
  () => [props.courseFull, props.language, props.unitId, props.questionIndex],
  async () => {
    loading.value = true;
    loadError.value = '';
    await fetchProgress();
    await determineIndexAndLoad();
    loading.value = false;
  },
  { immediate: true, deep: true }
);

watch(
  () => props.progressData,
  async (val) => {
    if (val) {
      progressDataLocal.value = val;
      // sync if parent updated progressData and no explicit questionIndex was provided
      if (typeof props.questionIndex !== 'number' || props.questionIndex === null) {
        const ci = val.current_index ?? val.currentIndex ?? null;
        if (ci) {
          currentQuestionIndex.value = clampIndex(Number(ci));
          emit('select-question', { questionIndex: currentQuestionIndex.value });
          await fetchQuestion(currentQuestionIndex.value);
        }
      }
    }
  },
  { immediate: false }
);

onMounted(async () => {
  // initial load handled by watcher with immediate:true
});
</script>

<style scoped>
div { font-family: Inter, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial; }
.hint-box { padding:8px 12px; border-radius:8px; background: #fff6f6; color:#c23a2b; margin-top:8px; }
</style>