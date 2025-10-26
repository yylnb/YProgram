<template>
  <div class="study-new-page">
    <!-- 页面标头：Hero 负责显示页面 title / breadcrumbs / quick filters 等 -->
    <Hero class="page-hero" />

    <div class="container">
      <!-- 左侧：题目入口列表 / 筛选 -->
      <aside class="panel left-panel">
        <Questions
          :language="language"
          :unitId="unitId"
          @select-question="onSelectQuestion"
          @change-language="val => language = val"
        />
      </aside>

      <!-- 右侧：题目展示区（根据题目类型切换子组件） -->
      <main class="panel right-panel">
        <component
          :is="activeComponent"
          v-if="selectedQuestion"
          :question="selectedQuestion"
          :language="language"
          @answered="onAnswered"
        />
        <div v-else class="empty-placeholder">
          请选择左侧题目开始练习
        </div>
      </main>
    </div>
  </div>
</template>

<script setup>
/**
 * StudyNew.vue
 * - 总入口：负责顶层布局与子组件切换
 * - 依赖子组件：Hero.vue, Questions.vue, Choice.vue, Fill.vue
 * - 仅保留最少逻辑：选题、根据题目 type 切换 component、传递 language
 *
 * 你可以在 Questions.vue 内实现题目列表查询和筛选逻辑，
 * 并通过 $emit('select-question', questionObject) 将所选题目传回这里。
 *
 * 子组件约定：
 * - selectedQuestion 对象至少包含字段：type ( 'choice' | 'fill' )，其它由子组件自行解析
 * - Choice.vue 接收 props: question, language
 * - Fill.vue 接收 props: question, language
 */

import { ref, computed } from 'vue';

// 子组件（实际文件路径按你项目调整）
import Hero from './Study/Hero.vue';
import Questions from './Study/Questions.vue';
import Choice from './Study/Choice.vue';
import Fill from './Study/Fill.vue';

const language = ref('py'); // 默认语言，可由 Questions.vue 修改
const unitId = ref(null);   // 当前单元（由 Questions.vue 管理）
const selectedQuestion = ref(null);

// 当 Questions 选择题目时触发
function onSelectQuestion(question) {
  selectedQuestion.value = question || null;
  // 如果 question 中包含 language/unit 等，也可以同步回顶层
  if (question?.language) language.value = question.language;
  if (question?.unit_id) unitId.value = question.unit_id;
}

// 根据 selectedQuestion.type 决定加载哪个子组件
const activeComponent = computed(() => {
  if (!selectedQuestion.value) return null;
  const t = (selectedQuestion.value.type || '').toLowerCase();
  if (t === 'choice' || t === 'que_choice' ) return Choice;
  if (t === 'fill' || t === 'que_fill') return Fill;
  // 默认回退：如果题目带有 options 则视为选择题
  if (selectedQuestion.value.options) return Choice;
  return Choice;
});

// 接收子组件 answered 事件（示例：用于局部统计或上报后端）
function onAnswered(payload) {
  // payload = { correct: boolean, attempts: number, question: {...} }
  // minimal implementation: console log — 具体上报由你实现
  console.log('answered:', payload);
  // 你可以在这里调用后端接口保存用户的作答记录 / 进度
}
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

/* 左侧列表面板 */
.panel {
  background: white;
  border-radius: 10px;
  padding: 12px;
  box-shadow: 0 6px 18px rgba(12,18,30,0.04);
}

.left-panel {
  width: 320px;
  min-height: 64vh;
  overflow: auto;
}

/* 右侧题目展示区 */
.right-panel {
  flex: 1;
  min-height: 64vh;
  overflow: auto;
  padding: 20px;
}

/* 占位文字 */
.empty-placeholder {
  display:flex;
  align-items:center;
  justify-content:center;
  height:100%;
  color:#6b7280;
  font-size:16px;
}

/* 响应式：窄屏时左侧折叠 */
@media (max-width: 900px) {
  .container { flex-direction: column; padding: 12px; }
  .left-panel { width: 100%; order: 2; }
  .right-panel { order: 1; }
}
</style>