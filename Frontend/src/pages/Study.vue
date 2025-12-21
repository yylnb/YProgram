<template>
  <div class="study-new-page">
    <!-- Hero: 顶部标题 / 进度 / 能量等，由 Hero 负责显示与交互 -->
    <Hero
      class="page-hero"
      :unitData="unitData"
      :selectedLangLabel="selectedLangLabel"
      :token="token"
      :progressPercent="progressPercent"
      :progressData="progressData"
      @back-map="onBackMap"
    />

    <div class="container">
      <!-- Questions 负责题库入口、题目列表以及判断并渲染 Choice / Fill -->
      <section class="panel questions-panel">
        <Questions
          :language="language"
          :unitId="unitId"
          :course="courseFull"
          :progressData="progressData"
          @select-question="onSelectQuestion"
          @answered="onAnswered"
          @progress-updated="onQuestionsProgressUpdated"
          @unit-complete="onQuestionsUnitComplete"
          @next-clicked="onQuestionsNextClicked"
        />
      </section>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import axios from 'axios';

// 仅引入 Hero 和 Questions（Choice/Fill 由 Questions 内部判断并加载）
import Hero from './Study/Hero.vue';
import Questions from './Study/Questions.vue';

// 路由
const route = useRoute();
const router = useRouter();

// helper: 从路由（params/query）取值（优先 params）
function readRouteValue(name, fallbackName) {
  return route.params?.[name] ?? route.query?.[name] ?? (fallbackName ? route.params?.[fallbackName] ?? route.query?.[fallbackName] ?? '' : '');
}

// 原始 course 字符串（例如 "python1"）。优先 params.course，再看 query.course
const courseFull = ref(String(readRouteValue('course', 'course') ?? ''));

// 解析 courseFull 到 language key 和 index
const courseLangKey = ref('');
const courseIndex = ref('');
function parseCourseString(str) {
  const s = String(str || '').trim();
  if (!s) {
    courseLangKey.value = '';
    courseIndex.value = '';
    return;
  }
  const alphaMatch = s.match(/^[A-Za-z_]+/);
  const numMatch = s.match(/(\d+)$/);
  courseLangKey.value = alphaMatch ? alphaMatch[0].toLowerCase() : s.toLowerCase();
  courseIndex.value = numMatch ? numMatch[1] : '';
}
parseCourseString(courseFull.value);

// unitId：注意你的 router.push 使用的是 params.unitId
const unitId = ref(String(readRouteValue('unitId', 'unit') ?? ''));

// token（若你项目使用 token，父级或其他地方可能会传入；这里我们简单从 localStorage 读取）
const token = ref(localStorage.getItem('token') || '');

// unitData：传给 Hero 显示标题等（你可以用更完整的数据结构）
const unitData = ref({
  title: route.params.unitTitle ?? route.query.unitTitle ?? (courseFull.value ? `${courseFull.value} · 单元 ${unitId.value || ''}` : '学习单元')
});

// 简单根据 language key 推断 language（仅作显示用途，实际以后端字段为准）
const language = computed(() => {
  const c = String(courseLangKey.value || '').toLowerCase();
  if (!c) return 'py';
  if (c.includes('python')) return 'py';
  if (c.includes('cpp') || c.includes('c++') || c === 'cpp') return 'cpp';
  if (c === 'c' || c.includes(' c ')) return 'c';
  if (c.includes('java')) return 'java';
  return c;
});

// 供 Hero 显示的语言标签（可更友好）
const selectedLangLabel = computed(() => {
  const map = { py: 'Python', cpp: 'C++', c: 'C', java: 'Java' };
  return map[language.value] ?? (courseLangKey.value ? courseLangKey.value.charAt(0).toUpperCase() + courseLangKey.value.slice(1) : language.value);
});

// 进度数据（原始对象来自后端，或者 null）
const progressData = ref(null);

// 进度百分比（给 Hero 快速展示）：默认 0；当后端返回 completed 或 current_index 时做简单映射
const progressPercent = ref(0);

// 常量：题目总数（与 Questions.vue 保持一致）
const TOTAL_QUESTIONS = 15;

// 当 Hero 发出 back-map 事件时跳回 /map
function onBackMap() {
  router.push('/map').catch(() => {});
}

// 当 Questions 选择题目时触发（你现在不需要在此处理渲染）
// 现在我们也把选择题号映射为 progressPercent（可选）
function onSelectQuestion(question) {
  console.log('selected question from Questions.vue:', question);
  let idx = null;
  if (question && typeof question.questionIndex === 'number') idx = question.questionIndex;
  else if (typeof question === 'number') idx = question;
  else if (question && question.currentIndex) idx = Number(question.currentIndex);

  if (idx !== null && !Number.isNaN(Number(idx))) {
    const n = Number(idx);
    progressPercent.value = Math.min(99, Math.max(0, Math.round((n / TOTAL_QUESTIONS) * 100)));
  }
}

// 当子组件提交答案/完成时触发（Questions 内部会转发 Choice/Fill 的 answered）
function onAnswered(payload) {
  console.log('answered payload:', payload);
  // 如果 Questions 把 progress 放在 payload.progress 中，请同步（但不切题，切题由 Questions 控制）
  if (payload && payload.progress) {
    updateProgressFromPayload(payload.progress);
    progressData.value = payload.progress;
  }
}

// 统一由后端或权威对象来更新 progressData / progressPercent
function updateProgressFromPayload(pd) {
  if (!pd) return;
  progressData.value = pd;

  // 优先使用后端 percent 字段
  if (typeof pd.percent !== 'undefined' && pd.percent !== null) {
    const p = Number(pd.percent);
    if (!Number.isNaN(p)) {
      progressPercent.value = Math.max(0, Math.min(100, Math.round(p)));
      return;
    }
  }

  // completed -> 100%
  if (pd.completed) {
    progressPercent.value = 100;
    return;
  }

  // 使用 current_index 映射到百分比（0-99）
  const ci = pd.current_index ?? pd.currentIndex ?? null;
  if (ci !== null && typeof ci !== 'undefined') {
    const num = Number(ci);
    if (!Number.isNaN(num)) {
      const raw = Math.round((num / TOTAL_QUESTIONS) * 100);
      progressPercent.value = pd.completed ? 100 : Math.min(99, Math.max(0, raw));
      return;
    }
  }

  // fallback
  progressPercent.value = 0;
}

// 当 Questions 通过 API 拉取到后端进度并 emit('progress-updated', pd)
function onQuestionsProgressUpdated(pd) {
  console.log('Questions -> parent progress-updated:', pd);
  if (pd) updateProgressFromPayload(pd);
}

// 当用户在 Questions 中点击“下一题”时（Questions 已 emit('next-clicked', {...})）
// 我们在此把该“下一题”事件的进度信息下发给 Hero（短暂同步 UI），但不替代 Questions 的跳题逻辑
function onQuestionsNextClicked(payload) {
  // payload: { nextIndex, progress }
  console.log('收到 next-clicked:', payload);
  const nextIdx = payload && typeof payload.nextIndex === 'number' ? payload.nextIndex : null;

  if (payload && payload.progress) {
    // 优先使用 Questions 带回的 progress（可能已经是保存后的对象）
    updateProgressFromPayload(payload.progress);
    progressData.value = payload.progress;
    return;
  }

  // 若没有 progress 对象，则用 nextIndex 做临时映射用于 Hero 显示
  if (nextIdx !== null) {
    const pd = {
      current_index: nextIdx,
      completed: nextIdx > TOTAL_QUESTIONS ? 1 : 0
    };
    progressData.value = pd;
    progressPercent.value = pd.completed ? 100 : Math.min(99, Math.round((nextIdx / TOTAL_QUESTIONS) * 100));
  }
}

// 当 Questions 发出 unit-complete（全部题完成）
function onQuestionsUnitComplete(payload) {
  console.log('unit complete:', payload);
  if (payload && payload.progress) {
    updateProgressFromPayload(payload.progress);
    progressData.value = payload.progress;
  } else {
    progressPercent.value = 100;
    if (progressData.value) progressData.value.completed = 1;
  }

  // 可选：若你想在单元完成后自动回地图，取消下面注释
  // router.push('/map').catch(()=>{});
}

// 构建请求参数并拉取进度
async function fetchProgressForUnit() {
  // unitId 必须存在
  if (!unitId.value) {
    progressData.value = null;
    progressPercent.value = 0;
    return;
  }

  // 组装 query params：只在有值时包含 lang/index
  const params = {};
  if (courseLangKey.value) params.lang = courseLangKey.value;
  if (courseIndex.value) params.index = courseIndex.value;

  const headers = {};
  if (token.value) headers['Authorization'] = `Bearer ${token.value}`;

  try {
    const url = `/api/progress/${encodeURIComponent(unitId.value)}`;
    const res = await axios.get(url, { params, headers });
    // 后端可能返回 null 或者进度对象
    const pd = res && res.data ? res.data : null;
    progressData.value = pd;

    // 统一用 updateProgressFromPayload 来计算 progressPercent
    updateProgressFromPayload(pd);

  } catch (err) {
    // 请求失败：如果是 401（未授权），可以考虑跳转登录或保持为空
    console.error('fetchProgressForUnit error:', err && err.response ? err.response.status : err);
    if (err && err.response && err.response.status === 401) {
      // 可选：若未登录，则跳转到登录页（注释掉以免强制跳转）
      // router.push('/login').catch(()=>{});
    }
    progressData.value = null;
    progressPercent.value = 0;
  }
}

// 当路由发生变化（用户可能从地图内再次进入不同单元），同步 local state 并重新抓取进度
watch(
  () => [route.params, route.query],
  () => {
    courseFull.value = String(readRouteValue('course', 'course') ?? '');
    unitId.value = String(readRouteValue('unitId', 'unit') ?? '');
    parseCourseString(courseFull.value);

    unitData.value = {
      ...unitData.value,
      title: route.params.unitTitle ?? route.query.unitTitle ?? (courseFull.value ? `${courseFull.value} · 单元 ${unitId.value || ''}` : '学习单元')
    };

    // 重新拉取进度
    fetchProgressForUnit();
  },
  { deep: true }
);

// 挂载时拉取进度
onMounted(() => {
  fetchProgressForUnit();
});
</script>

<style scoped>
.study-new-page {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  background: black;
  color: #111827;
  font-family: Inter, ui-sans-serif, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial;
}

/* 内容容器 */
.container {
  display: flex;
  gap: 20px;
  width: 100%;
  margin: auto;
  box-sizing: border-box;
}

/* Panel 基础样式（让 Questions 占主要区域） */
.panel {
  background: black;
  box-shadow: 0 6px 18px rgba(12,18,30,0.04);
}

/* Questions 面板：占满主要区域 */
.questions-panel {
  width: 100%;
  min-height: 85vh;
  overflow: auto;
}

/* 响应式 */
/* @media (max-width: 900px) {
  .container { flex-direction: column; padding: 12px; }
  .questions-panel { width: 100%; }
} */
</style>