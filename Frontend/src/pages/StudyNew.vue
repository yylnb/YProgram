<template>
  <div class="study-new-page">
    <!-- Hero: 顶部标题 / 进度 / 能量等，由 Hero 负责显示与交互 -->
    <Hero
      class="page-hero"
      :unitData="unitData"
      :selectedLangLabel="selectedLangLabel"
      :token="token"
      :progressPercent="progressPercent"
      @back-map="onBackMap"
    />

    <div class="container">
      <!-- Questions 负责题库入口、题目列表以及判断并渲染 Choice / Fill -->
      <section class="panel questions-panel">
        <Questions
          :language="language"
          :unitId="unitId"
          :course="course"
          @select-question="onSelectQuestion"
          @answered="onAnswered"
        />
      </section>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';

// 仅引入 Hero 和 Questions（Choice/Fill 由 Questions 内部判断并加载）
import Hero from './Study/Hero.vue';
import Questions from './Study/Questions.vue';

/**
 * 说明：
 * - Map.vue 在跳转到这个页面时应挂载路由 params 或 query，携带 course/unit 信息
 *   例如： /study/:course/:unit 或 /study?course=Python1&unit=3
 * - 这里我们优先读取 route.params.course & route.params.unit，然后回退到 route.query
 */

// 路由
const route = useRoute();
const router = useRouter();

// 从路由读取 course / unit（兼容 params 与 query）
const course = ref(route.params.course ?? route.query.course ?? '');
const unitId = ref(route.params.unit ?? route.query.unit ?? '');

// token（若你项目使用 token，父级或其他地方可能会传入；这里我们简单从 localStorage 读取）
const token = ref(localStorage.getItem('token') || '');

// unitData：传给 Hero 显示标题等（你可以用更完整的数据结构）
const unitData = ref({
  title: route.params.unitTitle ?? route.query.unitTitle ?? (course.value ? `${course.value} - 单元 ${unitId.value || ''}` : '学习单元')
});

// 简单根据 course 名称推断语言标签（仅作显示用途，实际以后端字段为准）
const language = computed(() => {
  const c = String(course.value || '').toLowerCase();
  if (c.includes('python')) return 'py';
  if (c.includes('cpp') || c.includes('c++')) return 'cpp';
  if (c === 'c' || c.includes(' c ')) return 'c';
  if (c.includes('java')) return 'java';
  return 'py';
});

// 供 Hero 显示的语言标签（可更友好）
const selectedLangLabel = computed(() => {
  const map = { py: 'Python', cpp: 'C++', c: 'C', java: 'Java' };
  return map[language.value] ?? language.value;
});

// 进度百分比（占位：你可以在 mounted 时请求后端填充真实值）
const progressPercent = ref(0);

// 当 Hero 发出 back-map 事件时跳回 /map
function onBackMap() {
  router.push('/map').catch(() => {});
}

// 当 Questions 选择题目时触发（你现在不需要在此处理渲染）
function onSelectQuestion(question) {
  // 这里保持最小逻辑：打印、或在需要时存储/路由跳转
  console.log('selected question from Questions.vue:', question);
}

// 当子组件提交答案/完成时触发（Questions 内部会转发 Choice/Fill 的 answered）
function onAnswered(payload) {
  // payload 可能包含：{ correct, attempts, question }
  console.log('answered payload:', payload);
  // 你可以在这里调用后端保存用户进度或触发 UI 通知
}

// 当路由发生变化（用户可能从地图内再次进入不同单元），同步 local state
onMounted(() => {
  // 如果 route 在组件挂载后更新，你也可以 watch route changes
  // 简单的占位：可以在这里请求后端获取 unit/进度信息等
});
</script>

<style scoped>
.study-new-page {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  background: #f7fafc;
  color: #111827;
  font-family: Inter, ui-sans-serif, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial;
}

/* 内容容器 */
.container {
  display: flex;
  gap: 20px;
  width: 100%;
  max-width: 1200px;
  margin: 18px auto;
  padding: 0 16px;
  box-sizing: border-box;
}

/* Panel 基础样式（让 Questions 占主要区域） */
.panel {
  background: white;
  border-radius: 10px;
  padding: 12px;
  box-shadow: 0 6px 18px rgba(12,18,30,0.04);
}

/* Questions 面板：占满主要区域 */
.questions-panel {
  width: 100%;
  min-height: 64vh;
  overflow: auto;
}

/* 响应式 */
@media (max-width: 900px) {
  .container { flex-direction: column; padding: 12px; }
  .questions-panel { width: 100%; }
}
</style>