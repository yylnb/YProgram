<template>
  <div class="finish-root">
    <!-- 标题 -->
    <h2 class="finish-title">🎉 单元完成</h2>

    <!-- 描述 -->
    <p class="finish-desc">
      恭喜你完成了本单元的全部学习内容！
    </p>

    <!-- 统计信息 -->
    <div class="finish-stats">
      <div class="stat-item">
        <span class="label">语言</span>
        <span class="value">{{ languageLabel }}</span>
      </div>
      <div class="stat-item">
        <span class="label">题目数量</span>
        <span class="value">{{ totalQuestions }}</span>
      </div>
      <div class="stat-item">
        <span class="label">学习状态</span>
        <span
          class="value"
          :class="{ success: isCompleted, danger: !isCompleted }"
        >
          {{ isCompleted ? '已打卡' : '未打卡' }}
        </span>
      </div>
    </div>

    <!-- 操作按钮 -->
    <div class="finish-actions">
      <button class="btn btn-secondary" @click="onBack">
        返回学习地图
      </button>

      <button class="btn btn-primary" @click="onNextUnit">
        继续下一个单元
      </button>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue';

const props = defineProps({
  unitId: { type: [String, Number], required: true },
  language: { type: String, default: '' },
  totalQuestions: { type: Number, default: 0 },
  progress: { type: Object, default: null }
});

const emit = defineEmits(['back', 'next-unit']);

// 是否已完成（后端打卡成功）
const isCompleted = computed(() => {
  const v = props.progress?.completed ?? props.progress?.is_completed ?? null;
  return v === 1 || v === true || String(v) === '1';
});

// 语言显示文案
const languageLabel = computed(() => {
  const m = String(props.language || '').toLowerCase();
  const map = {
    py: 'Python',
    python: 'Python',
    cpp: 'C++',
    c: 'C',
    java: 'Java'
  };
  return map[m] ?? (props.language || '—');
});

function onBack() {
  emit('back', {
    unitId: props.unitId,
    progress: props.progress
  });
}

function onNextUnit() {
  emit('next-unit', {
    unitId: props.unitId,
    progress: props.progress
  });
}
</script>

<style scoped>
.finish-root {
  max-width: 520px;
  margin: 0 auto;
  padding: 32px 24px;
  background: #0b0b0b;
  border-radius: 16px;
  box-shadow: 0 0 0 1px rgba(255, 255, 255, 0.06),
              0 12px 30px rgba(0, 0, 0, 0.6);
  text-align: center;
}

.finish-title {
  font-size: 24px;
  font-weight: 600;
  margin-bottom: 12px;
}

.finish-desc {
  font-size: 14px;
  opacity: 0.85;
  margin-bottom: 28px;
}

.finish-stats {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 12px;
  margin-bottom: 28px;
}

.stat-item {
  background: #121212;
  border-radius: 12px;
  padding: 12px 8px;
}

.stat-item .label {
  display: block;
  font-size: 12px;
  opacity: 0.6;
  margin-bottom: 4px;
  color: #fff;
}

.stat-item .value {
  font-size: 14px;
  font-weight: 500;
  color: #fff;  
}

.stat-item .value.success {
  color: #4cd964;
}

.stat-item .value.danger {
  color: #e74c3c;
}

.finish-actions {
  display: flex;
  justify-content: center;
  gap: 16px;
}

.btn {
  padding: 10px 18px;
  border-radius: 999px;
  font-size: 14px;
  cursor: pointer;
  border: none;
}

.btn-primary {
  background: white;
  color: black;
}

.btn-secondary {
  background: transparent;
  color: white;
  border: 1px solid rgba(255, 255, 255, 0.25);
}

.btn:hover {
  opacity: 0.9;
}
</style>