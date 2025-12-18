<template>
  <div class="finish-root">
    <!-- ================= 未打卡：颜色选择 ================= -->
    <template v-if="checking === false && checkedToday === false">
      <h2 class="finish-title">🎨 今日打卡</h2>
      <p class="finish-desc">选择一个代表今天学习状态的颜色</p>

      <div class="today-preview" :class="checkinPhase">
        <div class="glow-ring ring-1" :style="glowStyle" />
        <div class="glow-ring ring-2" :style="glowStyle" />
        <div
          v-if="checkinPhase === 'burst'"
          class="glow-ring burst-ring"
          :style="glowStyle"
        />
        <div class="today-circle" :style="{ background: selectedColor }">
          {{ todayDate }}
        </div>
      </div>

      <div class="color-picker">
        <button
          v-for="c in colors"
          :key="c"
          class="color-dot"
          :class="{ active: selectedColor === c }"
          :style="{ background: c }"
          @click="selectedColor = c"
        />
      </div>

      <div class="custom-color">
        <label>自定义颜色</label>
        <input type="color" v-model="selectedColor" />
      </div>

      <button
        class="btn btn-primary"
        @click="submitCheckin"
        :disabled="submitting"
      >
        {{ submitting ? '提交中…' : '确认打卡' }}
      </button>

      <p v-if="errorMsg" class="error">{{ errorMsg }}</p>
    </template>

    <!-- ================= 已打卡：完成界面 ================= -->
    <template v-else-if="checking === false">
      <h2 class="finish-title">🎉 单元完成</h2>
      <p class="finish-desc">你已经完成了本单元的全部学习内容</p>

      <div class="finish-cards">
        <div class="finish-card">
          <span class="card-label">语言</span>
          <span class="card-value">{{ languageLabel }}</span>
        </div>

        <div class="finish-card">
          <span class="card-label">题目数量</span>
          <span class="card-value">{{ totalQuestions }}</span>
        </div>

        <div class="finish-card success">
          <span class="card-label">今日状态</span>
          <span class="card-value">已打卡</span>
        </div>
      </div>

      <div class="finish-actions">
        <button class="btn btn-secondary" @click="onBack">
          返回学习地图
        </button>
        <button class="btn btn-primary" @click="onNextUnit">
          继续下一个单元 →
        </button>
      </div>
    </template>

    <!-- ================= 加载中 ================= -->
    <template v-else>
      <p class="finish-desc">检查今日打卡状态中…</p>
    </template>
  </div>
</template>


<script setup>
import { ref, computed, onMounted } from 'vue'
import axios from 'axios'

const props = defineProps({
  unitId: { type: [String, Number], required: true },
  language: { type: String, default: '' },
  totalQuestions: { type: Number, default: 0 }
})

const emit = defineEmits(['back', 'next-unit'])

const checking = ref(true)
const checkedToday = ref(false)
const submitting = ref(false)
const selectedColor = ref('#4cd964')
const errorMsg = ref('')

// 🔥 新增：打卡动画阶段
const checkinPhase = ref('idle') 
// idle | submitting | burst | done

const colors = [
  '#4cd964', '#2ecc71', '#1abc9c',
  '#3498db', '#2980b9',
  '#9b59b6', '#8e44ad',
  '#f1c40f', '#f39c12',
  '#e67e22', '#e74c3c',
  '#ecf0f1'
]

const todayDate = new Date().getDate()

const glowStyle = computed(() => ({
  boxShadow: `0 0 40px ${selectedColor.value}`,
  borderColor: selectedColor.value
}))

async function fetchTodayCheckin() {
  try {
    const res = await axios.get('/api/calendar/checkins/today', { withCredentials: true })
    checkedToday.value = !!res.data?.checked
  } finally {
    checking.value = false
  }
}

async function submitCheckin() {
  if (submitting.value) return

  errorMsg.value = ''
  submitting.value = true
  checkinPhase.value = 'submitting'

  try {
    const res = await axios.post(
      '/api/calendar/checkin/manual',
      { color: selectedColor.value },
      { withCredentials: true }
    )

    if (res.data?.ok) {
      // 🔥 进入爆发阶段
      checkinPhase.value = 'burst'

      // 等待动画完成再切界面
      setTimeout(() => {
        checkedToday.value = true
        checkinPhase.value = 'done'
      }, 1200)
    } else {
      errorMsg.value = res.data?.message || '打卡失败'
      checkinPhase.value = 'idle'
    }
  } catch (err) {
    errorMsg.value = err?.response?.data?.message || '网络错误'
    checkinPhase.value = 'idle'
  } finally {
    submitting.value = false
  }
}

const languageLabel = computed(() => {
  const m = String(props.language).toLowerCase()
  const map = { py: 'Python', python: 'Python', cpp: 'C++', c: 'C', java: 'Java' }
  return map[m] ?? props.language
})

function onBack() {
  emit('back', { unitId: props.unitId })
}
function onNextUnit() {
  emit('next-unit', { unitId: props.unitId })
}

onMounted(fetchTodayCheckin)
</script>

<style scoped>
.finish-root {
  padding: 22px 300px 130px 300px;
  margin-top: 10px;
  margin-left: 15%;
  margin-right: 15%;
  background: #1c1c1c;
  border-radius: 30px;
  text-align: center;
  box-shadow: 12px 12px 36px rgba(194, 194, 194, 0.7);
}
@media (max-width: 1200px) {
  .finish-root {
    margin-left: 2.5%;
    margin-right: 2.5%;
    padding: 22px 20px 130px 20px;
  }
}

.finish-title {
  font-size: 24px;
  font-weight: 600;
  color: white;
  margin-bottom: 12px;
}

.finish-desc {
  font-size: 14px;
  color: rgba(255,255,255,0.85);
  margin-bottom: 20px;
}

/* ===== 今日颜色预览 ===== */

.today-preview {
  position: relative;
  width: 140px;
  height: 140px;
  margin: 0 auto 24px;
}

.today-circle {
  position: relative;
  z-index: 3;
  width: 88px;
  height: 88px;
  border-radius: 50%;
  margin: 26px auto;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 28px;
  font-weight: 600;
  color: black;
  transition: transform 0.3s ease;
}

.glow-ring {
  position: absolute;
  top: 50%;
  left: 50%;
  width: 88px;
  height: 88px;
  border-radius: 50%;
  transform: translate(-50%, -50%);
  border: 2px solid;
  opacity: 0;
}

.ring-1 {
  animation: pulse 2.8s infinite;
}
.ring-2 {
  animation: pulse 2.8s infinite 1.4s;
}

@keyframes pulse {
  0% { transform: translate(-50%, -50%) scale(1); opacity: 0.6; }
  100% { transform: translate(-50%, -50%) scale(2.2); opacity: 0; }
}

/* ===== 提交蓄力抖动 ===== */

.today-preview.submitting .today-circle {
  animation: shake 0.4s infinite;
}

@keyframes shake {
  0% { transform: translateX(0); }
  25% { transform: translateX(-1px); }
  50% { transform: translateX(1px); }
  75% { transform: translateX(-1px); }
  100% { transform: translateX(0); }
}

/* ===== 爆发光晕 ===== */

.burst-ring {
  animation: burst 1.2s ease-out forwards;
  border-width: 4px;
}

@keyframes burst {
  0% {
    transform: translate(-50%, -50%) scale(1);
    opacity: 0.9;
  }
  100% {
    transform: translate(-50%, -50%) scale(3.2);
    opacity: 0;
  }
}
/* ===== 颜色选择 ===== */

.color-picker {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 12px;
  margin-bottom: 16px;
}

.color-dot {
  width: 28px;
  height: 28px;
  border-radius: 50%;
  border: none;
  cursor: pointer;
}

.color-dot.active {
  box-shadow: 0 0 0 2px white;
}

/* ===== 自定义颜色 ===== */

.custom-color {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  margin-bottom: 24px;
  color: rgba(255,255,255,0.8);
}

.custom-color input {
  background: none;
  border: none;
  cursor: pointer;
}

.hex {
  font-family: monospace;
  font-size: 12px;
}

/* ===== 按钮 ===== */

.btn {
  padding: 10px 20px;
  border-radius: 999px;
  border: none;
  cursor: pointer;
  white-space: nowrap;
}

.btn-primary {
  background: white;
  color: black;
}

.btn-secondary {
  background: transparent;
  color: white;
  border: 1px solid rgba(255,255,255,0.25);
}

.error {
  margin-top: 12px;
  color: #e74c3c;
}

/* ===== 完成界面成就卡片 ===== */

.finish-cards {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 14px;
  margin: 28px 0 32px;
}

.finish-card {
  background: rgba(255,255,255,0.04);
  border-radius: 14px;
  padding: 14px 8px;
  text-align: center;
  box-shadow: inset 0 0 0 1px rgba(255,255,255,0.08);
}

.finish-card.success {
  background: rgba(76, 217, 100, 0.15);
  box-shadow: inset 0 0 0 1px rgba(76,217,100,0.6),
              0 0 18px rgba(76,217,100,0.4);
}

.card-label {
  display: block;
  font-size: 12px;
  color: rgba(255,255,255,0.7);
  margin-bottom: 6px;
}

.card-value {
  font-size: 16px;
  font-weight: 600;
  color: white;
}

/* ===== 行为按钮区域 ===== */

.finish-actions {
  display: flex;
  gap: 16px;
  justify-content: center;
  margin-top: 12px;
}

.finish-actions .btn-primary {
  padding: 12px 26px;
  font-weight: 600;
}

.finish-actions .btn-secondary {
  opacity: 0.85;
}

</style>