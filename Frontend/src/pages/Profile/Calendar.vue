<template>
  <div class="card p-6 calendar-root">
    <div class="header mb-4 flex items-center justify-between">
      <div>
        <h3 class="text-lg font-semibold mb-1">打卡日历</h3>
        <div class="text-sm text-gray-600">
          今日能量：<strong>{{ energyStatus.cost_today }}</strong> / {{ energyStatus.threshold }}
          <span v-if="energyStatus.reached" class="ml-2 text-green-600">（已达标）</span>
          <span v-else class="ml-2 text-gray-500">（未达标）</span>
        </div>
      </div>

      <div class="controls inline-flex items-center gap-2">
        <button class="btn-try" @click="changeMonth(-1)">上一月</button>
        <div class="month-label">{{ displayYear }} 年 {{ displayMonth }} 月</div>
        <button class="btn-try" @click="changeMonth(1)">下一月</button>
        <button class="btn-try" @click="reload" :disabled="loading">刷新</button>
      </div>
    </div>

    <div class="calendar-wrap">
      <!-- 使用全局注册的 VCalendar -->
      <VCalendar
        is-expanded
        :attributes="attrs"
        :title-position="'center'"
      />
    </div>

    <div class="mt-4 text-sm text-gray-600">
      <span v-if="loading">加载中…</span>
      <span v-else-if="error" class="text-red-600">错误：{{ error }}</span>
      <span v-else>已加载 {{ checkedDates.length }} 天的打卡数据。</span>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import axios from 'axios'

/**
 * Calendar.vue
 * 说明：
 * - 打开页面时会自动尝试创建当天打卡（后端会基于 energy_daily 判断是否满足 >=20）
 * - 然后加载当前月份的打卡记录并在日历上高亮显示
 *
 * 依赖后端路由（按你已有的约定）：
 * GET  /api/calendar/energy                    -> { cost_today, last_update, reached, threshold }
 * POST /api/calendar/checkin/manual            -> 尝试为今天插入打卡（若能量不足返回 400）
 * GET  /api/calendar/checkins/:year/:month     -> ['YYYY-MM-DD', ...]
 *
 * 授权：从 localStorage.yp_token 获取 Bearer token
 */

// state
const loading = ref(false)
const error = ref(null)
const checkedDates = ref([]) // array of 'YYYY-MM-DD' strings from backend
const energyStatus = ref({ cost_today: 0, last_update: null, reached: false, threshold: 20 })

// month/year state (默认当前月份)
const now = new Date()
const currentYear = ref(now.getFullYear())
const currentMonth = ref(now.getMonth() + 1) // 1-12

const displayYear = computed(() => currentYear.value)
const displayMonth = computed(() => currentMonth.value)

// helper: convert 'YYYY-MM-DD' -> Date at local midnight to avoid timezone shift
function isoToLocalDate(str) {
  if (!str) return null
  // 如果格式是 'YYYY-MM-DD'，按组件解析，避免 new Date('YYYY-MM-DD') 的跨环境解析差异
  const m = /^(\d{4})-(\d{2})-(\d{2})$/.exec(str)
  if (m) {
    const y = Number(m[1]), mo = Number(m[2]), d = Number(m[3])
    return new Date(y, mo - 1, d) // 本地时区的当天 00:00
  }
  // 兜底：如果传来其他 ISO 字符串，仍然尝试构造 Date（但优先使用上面分解）
  const dt = new Date(str)
  if (!isNaN(dt.getTime())) return dt
  return null
}

// axios instance with auth header helper
function getAuthHeaders() {
  const token = localStorage.getItem('yp_token')
  return token ? { Authorization: `Bearer ${token}` } : {}
}

// attributes for VCalendar
const attrs = computed(() => {
  // convert checkedDates to Date objects
  const dates = checkedDates.value.map(d => isoToLocalDate(d))
  return [
    {
      key: 'checked',
      dates,
      dot: { color: 'green' },
      popover: { label: '已打卡 ✅' }
    },
    {
      key: 'today',
      dates: new Date(),
      highlight: {
        color: '#2563eb',
        fillMode: 'outline'
      },
      popover: { label: '今天' }
    }
  ]
})

// 获取当前月份的打卡数据
async function fetchCheckins(year, month) {
  try {
    loading.value = true
    error.value = null
    const headers = getAuthHeaders()
    if (!headers.Authorization) {
      // 未登录：清空数据并返回
      checkedDates.value = []
      energyStatus.value = { cost_today: 0, last_update: null, reached: false, threshold: 20 }
      loading.value = false
      return
    }

    const res = await axios.get(`/api/calendar/checkins/${year}/${month}`, { headers })
    // 期望 res.data 为 ['YYYY-MM-DD', ...]
    checkedDates.value = Array.isArray(res.data) ? res.data : []
  } catch (err) {
    console.error('fetchCheckins error', err)
    error.value = err?.response?.data?.error || err.message || '加载打卡失败'
  } finally {
    loading.value = false
  }
}

// 获取今天/当前能量状态（展示用）
async function fetchEnergyStatus() {
  try {
    const headers = getAuthHeaders()
    if (!headers.Authorization) {
      energyStatus.value = { cost_today: 0, last_update: null, reached: false, threshold: 20 }
      return
    }
    const res = await axios.get('/api/calendar/energy', { headers })
    energyStatus.value = res.data || energyStatus.value
  } catch (err) {
    console.error('fetchEnergyStatus error', err)
    // 不把小错误暴露给用户太多
  }
}

// 自动尝试为今天生成打卡（无须手动点击）
// 如果能量 >= threshold，后端会插入 checkin_records
async function tryAutoCheckinToday() {
  try {
    const headers = getAuthHeaders()
    if (!headers.Authorization) return
    // 调用后端的 manual checkin 接口，若能量不足后端会返回 400——我们可以忽略该错误
    await axios.post('/api/calendar/checkin/manual', {}, { headers })
    // 若成功或已存在，后端会返回 ok:true or created:true
  } catch (err) {
    // 400 表示能量不足，我们不用当作致命错误
    if (err && err.response && err.response.status === 400) {
      // 忽略：今日能量不足
      return
    }
    console.error('tryAutoCheckinToday error', err)
  }
}

// 主流程：打开日历时先尝试自动打卡 -> 再读 energy -> 再拉当月数据
async function initForCurrentMonth() {
  error.value = null
  loading.value = true
  try {
    const year = currentYear.value
    const month = currentMonth.value
    // 1) 尝试自动打卡（如果能量足够，后端会插入）
    await tryAutoCheckinToday()
    // 2) 更新能量展示
    await fetchEnergyStatus()
    // 3) 拉取当月打卡
    await fetchCheckins(year, month)
  } catch (err) {
    console.error('initForCurrentMonth error', err)
    error.value = err?.message || '初始化失败'
  } finally {
    loading.value = false
  }
}

// 翻页：上一月 / 下一月
function changeMonth(delta) {
  let y = currentYear.value
  let m = currentMonth.value + delta
  if (m < 1) { m = 12; y -= 1 }
  if (m > 12) { m = 1; y += 1 }
  currentYear.value = y
  currentMonth.value = m
  // 拉取对应月份
  fetchCheckins(y, m)
}

// 手动刷新（页面右上）
async function reload() {
  await initForCurrentMonth()
}

// 组件挂载时自动初始化（也会触发自动打卡）
onMounted(() => {
  initForCurrentMonth()
})
</script>

<style scoped>
.calendar-root { padding: 0; }
.header .month-label {
  font-weight: 700;
  padding: 6px 10px;
  border-radius: 8px;
  background: #f3f4f6;
  margin: 0 8px;
}
.calendar-wrap {
  /* v-calendar 自身会负责尺寸，这里给个最小高度以避免闪烁 */
  min-height: 360px;
}

/* 基本按钮样式（与项目其他样式保持一致） */
.btn-try {
  background: #fff;
  border: 1px solid rgba(15,23,42,0.06);
  padding: 6px 10px;
  border-radius: 8px;
  font-weight: 700;
  cursor: pointer;
}
.btn-try:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

/* 卡片基础样式（与 Profile.vue 的 .card 保持一致） */
.card {
  background: white;
  border-radius: 12px;
  box-shadow: 0 10px 30px rgba(2,6,23,0.06);
  padding: 12px;
}
</style>
