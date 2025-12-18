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
        :progress="progressDataLocal"
        :save-checkin-fn="saveCheckin"
        :checkin-pending="pendingCheckinSave"
        :checkin-error="checkinSaveError"
        @correct="onChildCorrect"
        @next="onChildNext"
        @back="onFinishBack"
        @next-unit="onFinishNextUnit"
        @checkin-complete="onCheckinComplete"
      />
    </template>

    <div v-if="saveError" class="hint-box" style="margin-top:10px; color:#c23a2b;">
      进度同步失败：{{ saveError }}
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch, onMounted } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import axios from 'axios';

// 子组件
import Choice from './Choice.vue';
import Fill from './Fill.vue';
import Finish from './Finish.vue'; // 完成页

// router
const router = useRouter();
const route = useRoute();

// props from parent (StudyNew.vue)
const props = defineProps({
  questionIndex: { type: Number, default: null },
  language: { type: String, default: '' },
  courseFull: { type: String, default: '' }, // 兼容旧名
  course: { type: String, default: '' },     // StudyNew.vue 里传 :course="courseFull"
  unitId: { type: [String, Number], default: '' },
  token: { type: String, default: '' },
  progressData: { type: [Object, null], default: null },
  totalQuestionsProp: { type: Number, default: 15 }
});

// emits
const emit = defineEmits(['select-question', 'answered', 'progress-updated', 'unit-complete', 'next-clicked', 'finish-back', 'finish-next', 'checkin-saved']);

// state
const loading = ref(false);
const loadError = ref('');
const saveError = ref('');
const questionData = ref(null);
const totalQuestions = Number(props.totalQuestionsProp || 15);
const currentQuestionIndex = ref(1);
const disabledForChild = ref(false);
const pendingSave = ref(false);

// 新增：打卡相关 state
const pendingCheckinSave = ref(false);
const checkinSaveError = ref('');

// 是否已完成单元（进入 Finish.vue）
const isFinished = ref(false);

// ----------------------- helpers: component choice -----------------------
function isFillByIndex(idx) {
  if (!idx || typeof idx !== 'number') return false;
  if (idx >= 4 && idx <= 5) return true;
  if (idx >= 9 && idx <= 10) return true;
  if (idx >= 14 && idx <= 15) return true;
  return false;
}
const currentComponent = computed(() => {
  if (isFinished.value) return Finish;
  return isFillByIndex(Number(currentQuestionIndex.value)) ? Fill : Choice;
});

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
const courseFullProp = computed(() => {
  return String(props.courseFull || props.course || '');
});
const parsedCourse = computed(() => parseCourseString(courseFullProp.value));

// ----------------------- language mapping (for question GET) -----------------------
function langShortForQuestionApi() {
  const m = String(props.language || parsedCourse.value.lang || '').toLowerCase();
  const shortMap = { py: 'py', python: 'py', python3: 'py', cpp: 'cpp', 'c++': 'cpp', c: 'c', java: 'java' };
  return shortMap[m] ?? (m || 'py');
}

// ----------------------- lang and index for progress POST -----------------------
function langForProgressApi() {
  const raw = parsedCourse.value.lang ?? String(props.language || '').toLowerCase();
  const map = { py: 'python', python: 'python', cpp: 'cpp', c: 'c', java: 'java' };
  return map[raw] ?? (raw || 'python');
}

function idxForApi() {
  if (props.progressData && (typeof props.progressData.index !== 'undefined' && props.progressData.index !== null)) {
    return props.progressData.index;
  }
  if (props.progressData && (typeof props.progressData.lang !== 'undefined' && props.progressData.lang)) {
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

    const completedFlag = progressDataLocal.value?.completed ?? progressDataLocal.value?.is_completed ?? null;
    if (completedFlag === 1 || completedFlag === true || String(completedFlag) === '1') {
      isFinished.value = true;
    } else {
      isFinished.value = false;
    }
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

  const completedFlag = progressDataLocal.value?.completed ?? progressDataLocal.value?.is_completed ?? null;
  if (completedFlag === 1 || completedFlag === true || String(completedFlag) === '1') {
    isFinished.value = true;
    emit('select-question', { questionIndex: currentQuestionIndex.value });
    return;
  } else {
    isFinished.value = false;
  }

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
async function saveProgress(nextIndex, completedFlag = 0) {
  saveError.value = '';

  if (!props.unitId) {
    saveError.value = '缺少 unitId';
    return null;
  }

  const lang = langForProgressApi();

  let index = idxForApi();
  if (typeof index === 'undefined' && parsedCourse.value.index) {
    index = parsedCourse.value.index;
  }

  const body = {
    unit_id: String(props.unitId),
    current_index: nextIndex,
    completed: completedFlag ? 1 : 0,
    lang
  };

  if (typeof index !== 'undefined' && index !== null) {
    body.index = index;
  }

  try {
    pendingSave.value = true;

    const cfg = {
      withCredentials: true,
      timeout: 8000
    };
    if (props.token) {
      cfg.headers = { Authorization: `Bearer ${props.token}` };
    }

    const res = await axios.post('/api/progress', body, cfg);

    progressDataLocal.value = {
      unit_id: body.unit_id,
      current_index: body.current_index,
      completed: body.completed,
      lang: body.lang,
      index: body.index ?? null,
      table: res?.data?.table ?? null
    };

    emit('progress-updated', progressDataLocal.value);

    return progressDataLocal.value;
  } catch (err) {
    console.error('POST /api/progress error', err);
    saveError.value =
      err?.response?.data?.error ?? '保存进度失败，请检查网络或后端';
    return null;
  } finally {
    pendingSave.value = false;
  }
}

// ----------------------- 新增：saveCheckin (POST /api/checkin) -----------------------
/*
  body: { unit_id, date, color, lang, index, note? }
  返回示例： { success:true, insertedId:123, record: {...} }
*/
async function saveCheckin(payload = {}) {
  // payload 应包含 color, date(optional), note(optional)
  checkinSaveError.value = '';

  if (!props.unitId) {
    checkinSaveError.value = '缺少 unitId，无法保存打卡';
    return null;
  }

  const lang = langForProgressApi();
  let index = idxForApi();
  if (typeof index === 'undefined' && parsedCourse.value.index) {
    index = parsedCourse.value.index;
  }

  const today = new Date().toISOString().slice(0, 10);
  const body = {
    unit_id: String(props.unitId),
    date: payload.date ?? today,
    color: payload.color ?? null,
    lang,
    index: index ?? null,
    note: payload.note ?? null
  };

  try {
    pendingCheckinSave.value = true;
    const cfg = { withCredentials: true, timeout: 8000 };
    if (props.token) cfg.headers = { Authorization: `Bearer ${props.token}` };

    const res = await axios.post('/api/checkin', body, cfg);

    // emit 事件，供上层或 StudyNew.vue 监听并作出响应
    emit('checkin-saved', res?.data ?? null);

    // 可选：把打卡信息合并到本地 progressData（若需要）
    if (!progressDataLocal.value) progressDataLocal.value = {};
    progressDataLocal.value.last_checkin = res?.data?.record ?? (body);

    return res?.data ?? null;
  } catch (err) {
    console.error('POST /api/checkin error', err);
    checkinSaveError.value = err?.response?.data?.error ?? '打卡保存失败，请稍后重试';
    return null;
  } finally {
    pendingCheckinSave.value = false;
  }
}

// ----------------------- child event handlers -----------------------
async function onChildCorrect(payload) {
  const isLast = currentQuestionIndex.value === totalQuestions;

  disabledForChild.value = true;

  if (isLast) {
    // ✅ 最后一题：完成单元
    await saveProgress(totalQuestions, 1);
    isFinished.value = true;
    emit('unit-complete', { unitId: props.unitId, progress: progressDataLocal.value });
  } else {
    // ✅ 普通题：只推进进度
    await saveProgress(currentQuestionIndex.value + 1, 0);
  }

  disabledForChild.value = false;

  emit('answered', {
    correct: true,
    questionIndex: currentQuestionIndex.value
  });
}

async function onChildNext(payload) {
  const nextIdx = currentQuestionIndex.value + 1;

  emit('next-clicked', { nextIndex: nextIdx });

  if (nextIdx > totalQuestions) return;

  currentQuestionIndex.value = nextIdx;
  emit('select-question', { questionIndex: nextIdx });
  await fetchQuestion(nextIdx);
}

function onFinishBack(payload) {
  // 先向上层广播事件（保持原有行为）
  emit('finish-back', payload);

  // 然后导航到地图页面
  try {
    router.push({ path: '/map' });
  } catch (err) {
    console.warn('router.push /map failed', err);
  }
}

function onFinishNextUnit(payload) {
  // 先向上层广播事件（保持原有行为）
  emit('finish-next', payload);

  // 然后尝试导航到下一单元
  try {
    // 首先尝试从当前路由解析： /study/:course/:unit
    const currentPath = (route && route.path) ? route.path : '';
    const studyMatch = currentPath.match(/^\/study\/([^\/]+)\/(\d+)(?:\/.*)?$/);

    if (studyMatch) {
      const courseName = studyMatch[1];
      const unitNum = Number(studyMatch[2]);
      if (!Number.isFinite(unitNum)) {
        // fallback to map
        router.push({ path: '/map' });
        return;
      }
      const nextUnit = unitNum + 1;
      if (nextUnit > 150) {
        router.push({ path: '/map' });
        return;
      }
      router.push({ path: `/study/${encodeURIComponent(courseName)}/${nextUnit}` });
      return;
    }

    // 如果当前路由无法解析，再尝试使用 courseFullProp（例如 "python1"）
    const courseStr = courseFullProp.value || '';
    if (courseStr) {
      // 尝试从 progressDataLocal / props 获取当前单元编号（优先 progressDataLocal.unit_number / current_unit 等）
      let currentUnitNum = null;
      if (progressDataLocal.value) {
        // 常见字段尝试
        const cand = progressDataLocal.value.unit_number ?? progressDataLocal.value.unit ?? progressDataLocal.value.current_unit ?? progressDataLocal.value.current_index ?? null;
        if (cand !== null && typeof cand !== 'undefined') {
          const n = Number(cand);
          if (Number.isFinite(n)) currentUnitNum = n;
        }
      }

      // 如果仍然没有，从 props.questionIndex 或 currentQuestionIndex 取保底（可能不是单元号，但作为 best-effort）
      if (currentUnitNum === null) {
        // 如果 URL 没法取，尝试用 1 作为默认
        currentUnitNum = Number(props.questionIndex ?? currentQuestionIndex.value ?? 1);
      }

      let nextUnit = Number(currentUnitNum) + 1;
      if (!Number.isFinite(nextUnit)) {
        router.push({ path: '/map' });
        return;
      }
      if (nextUnit > 150) {
        router.push({ path: '/map' });
        return;
      }
      router.push({ path: `/study/${encodeURIComponent(courseStr)}/${nextUnit}` });
      return;
    }

    // 最后兜底返回地图
    router.push({ path: '/map' });

  } catch (err) {
    console.warn('onFinishNextUnit navigation failed', err);
    try { router.push({ path: '/map' }); } catch (e) {}
  }
}

// 当 Finish.vue 内部打卡完成后 emit 回来，会触发这里（如果你希望父层做额外处理）
function onCheckinComplete(data) {
  // data 是 saveCheckin 返回的 res.data
  // 目前我们只是把它 log，并可做进一步处理（比如导航提示）
  console.log('checkin completed', data);
}

// ----------------------- watchers & lifecycle -----------------------
watch(
  () => [props.courseFull, props.course, props.language, props.unitId, props.questionIndex],
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
    if (!val) return;

    const incomingIdx = val.current_index ?? val.currentIndex ?? null;
    const localIdx = progressDataLocal.value ? (progressDataLocal.value.current_index ?? progressDataLocal.value.currentIndex ?? null) : null;

    progressDataLocal.value = val;

    if (incomingIdx !== null && localIdx !== null && Number(incomingIdx) === Number(localIdx)) {
      const completedFlag = val.completed ?? val.is_completed ?? null;
      if (completedFlag === 1 || completedFlag === true || String(completedFlag) === '1') {
        isFinished.value = true;
      }
      return;
    }

    if (typeof props.questionIndex !== 'number' || props.questionIndex === null) {
      const ci = val.current_index ?? val.currentIndex ?? null;
      if (ci) {
        currentQuestionIndex.value = clampIndex(Number(ci));
        emit('select-question', { questionIndex: currentQuestionIndex.value });
        await fetchQuestion(currentQuestionIndex.value);
      }
    }

    const completedFlag = val.completed ?? val.is_completed ?? null;
    if (completedFlag === 1 || completedFlag === true || String(completedFlag) === '1') {
      isFinished.value = true;
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
.hint-box { padding:8px 12px; border-radius:8px; background: black; color:#c23a2b; margin-top:8px; }
</style>