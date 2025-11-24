<template>
  <div class="calendar-root">
    <div class="header">
      <h3 class="calendar-title">打卡日历</h3>

      <div class="controls">
        <button class="btn-try" @click="onPrev" :disabled="animating || loading">上一月</button>
        <div class="month-label">{{ displayYear }} 年 {{ displayMonth }} 月</div>
        <button class="btn-try" @click="onNext" :disabled="animating || loading">下一月</button>
        <button class="btn-try" @click="reload" :disabled="loading">刷新</button>
      </div>
    </div>

    <div class="svg-wrap" ref="svgWrap">
      <!-- OLD LAYER -->
      <div class="svg-layer" :class="layerClass('old')" aria-hidden="false">
        <svg
          :viewBox="`0 0 ${viewBoxWidth} ${viewBoxHeight}`"
          preserveAspectRatio="xMidYMid meet"
          class="svg-el"
          role="img"
          aria-label="旧日历层"
        >
          <!-- 背景边界，便于看清区域 -->
          <rect x="0" y="0" :width="viewBoxWidth" :height="viewBoxHeight" fill="#111" stroke="rgba(255,255,255,0.04)" stroke-width="1" />

          <!-- Weekday labels -->
          <g class="weekday-labels" font-size="14" text-anchor="middle" font-family="Inter, Arial, Helvetica, sans-serif">
            <text v-for="(wd, i) in weekdays" :key="'h-old-'+i" :x="cellX(i) + cellSize/2" :y="paddingY - 18" fill="#ffffff">
              {{ wd }}
            </text>
          </g>

          <!-- 坦克履带 pills (只在同一行、当月内连接) -->
          <g v-for="(row, r) in oldWeeks" :key="'p-old-'+r">
            <template v-for="seg in segmentsInRow(row, r, oldCheckedSet, oldYear, oldMonth)" :key="'pseg-old-'+r+'-'+seg.startCol">
              <rect
                :x="cellX(seg.startCol) + 6"
                :y="cellY(r) + 6"
                :width="Math.max((seg.endCol - seg.startCol + 1) * cellSize - 12, cellSize - 12)"
                :height="cellSize - 12"
                rx="18" ry="18"
                :fill="tankColor"
                :stroke="tankColor"
                stroke-width="1"
              />
            </template>
          </g>

          <!-- 日号与已打卡圆 -->
          <g font-family="Inter, Arial, Helvetica, sans-serif" text-anchor="middle">
            <template v-for="(row, r) in oldWeeks" :key="'row-old-'+r">
              <template v-for="(cell, c) in row" :key="'cell-old-'+r+'-'+c">
                <g v-if="cell">
                  <circle
                    v-if="isCheckedBySetAndMonth(cell, oldCheckedSet, oldYear, oldMonth)"
                    :cx="cellX(c) + cellSize/2"
                    :cy="cellY(r) + cellSize/2"
                    :r="Math.min(cellSize/2 - 8, 20)"
                    :fill="tankColor"
                  />
                  <text
                    v-if="isSameMonth(cell, oldYear, oldMonth)"
                    :x="cellX(c) + cellSize/2"
                    :y="cellY(r) + cellSize/2 + 5"
                    fill="#ffffff"
                    :font-size="isToday(cell) ? 16 : 14"
                    font-weight="600"
                  >
                    {{ cell.getDate() }}
                  </text>
                </g>
              </template>
            </template>
          </g>

          <!-- 固定 6 行网格 -->
          <g stroke="#2b2b2b" stroke-width="1">
            <template v-for="r in 7" :key="'h-old-'+r">
              <line :x1="paddingX" :x2="paddingX + 7*cellSize" :y1="cellY(r-1)" :y2="cellY(r-1)"/>
            </template>
            <template v-for="c in 8" :key="'v-old-'+c">
              <line :x1="cellX(c-1)" :x2="cellX(c-1)" :y1="paddingY" :y2="paddingY + 6*cellSize"/>
            </template>
          </g>
        </svg>
      </div>

      <!-- NEW LAYER -->
      <div class="svg-layer" :class="layerClass('new')" v-show="newVisible || animating" aria-hidden="false">
        <svg
          :viewBox="`0 0 ${viewBoxWidth} ${viewBoxHeight}`"
          preserveAspectRatio="xMidYMid meet"
          class="svg-el"
          role="img"
          aria-label="新日历层"
        >
          <rect x="0" y="0" :width="viewBoxWidth" :height="viewBoxHeight" fill="#111" stroke="rgba(255,255,255,0.04)" stroke-width="1" />

          <g class="weekday-labels" font-size="14" text-anchor="middle" font-family="Inter, Arial, Helvetica, sans-serif">
            <text v-for="(wd, i) in weekdays" :key="'h-new-'+i" :x="cellX(i) + cellSize/2" :y="paddingY - 18" fill="#ffffff">
              {{ wd }}
            </text>
          </g>

          <g v-for="(row, r) in newWeeks" :key="'p-new-'+r">
            <template v-for="seg in segmentsInRow(row, r, newCheckedSet, targetYear, targetMonth)" :key="'pseg-new-'+r+'-'+seg.startCol">
              <rect
                :x="cellX(seg.startCol) + 6"
                :y="cellY(r) + 6"
                :width="Math.max((seg.endCol - seg.startCol + 1) * cellSize - 12, cellSize - 12)"
                :height="cellSize - 12"
                rx="18" ry="18"
                :fill="tankColor"
                :stroke="tankColor"
                stroke-width="1"
              />
            </template>
          </g>

          <g font-family="Inter, Arial, Helvetica, sans-serif" text-anchor="middle">
            <template v-for="(row, r) in newWeeks" :key="'row-new-'+r">
              <template v-for="(cell, c) in row" :key="'cell-new-'+r+'-'+c">
                <g v-if="cell">
                  <circle
                    v-if="isCheckedBySetAndMonth(cell, newCheckedSet, targetYear, targetMonth)"
                    :cx="cellX(c) + cellSize/2"
                    :cy="cellY(r) + cellSize/2"
                    :r="Math.min(cellSize/2 - 8, 20)"
                    :fill="tankColor"
                  />
                  <text
                    v-if="isSameMonth(cell, targetYear, targetMonth)"
                    :x="cellX(c) + cellSize/2"
                    :y="cellY(r) + cellSize/2 + 5"
                    fill="#ffffff"
                    :font-size="isToday(cell) ? 16 : 14"
                    font-weight="600"
                  >
                    {{ cell.getDate() }}
                  </text>
                </g>
              </template>
            </template>
          </g>

          <g stroke="#2b2b2b" stroke-width="1">
            <template v-for="r in 7" :key="'h-new-'+r">
              <line :x1="paddingX" :x2="paddingX + 7*cellSize" :y1="cellY(r-1)" :y2="cellY(r-1)"/>
            </template>
            <template v-for="c in 8" :key="'v-new-'+c">
              <line :x1="cellX(c-1)" :x2="cellX(c-1)" :y1="paddingY" :y2="paddingY + 6*cellSize"/>
            </template>
          </g>
        </svg>
      </div>
    </div>

    <div class="mt-4 info">
      <span v-if="loading">加载中…</span>
      <span v-else-if="error" class="text-red-400">错误：{{ error }}</span>
      <span v-else>已加载 {{ currentMonthCheckedCount }} 天的打卡数据（{{ displayYear }}-{{ pad(displayMonth) }}）。</span>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import axios from 'axios'

// ---------------- state ----------------
const loading = ref(false)
const error = ref(null)

const now = new Date()
const currentYear = ref(now.getFullYear())
const currentMonth = ref(now.getMonth() + 1) // 1-12

const displayYear = computed(() => currentYear.value)
const displayMonth = computed(() => currentMonth.value)

// animation / layer control
const animating = ref(false)
const direction = ref('left') // 'left' means next -> left
const oldVisible = ref(true)
const newVisible = ref(false)
const ANIM_DURATION = 420

// ------------- layout & centering -------------
const cellSize = 82              // 每格大小（可按需调整或改为响应式）
const viewBoxWidth = 700         // SVG 内坐标系宽度
const viewBoxHeight = 520        // SVG 内坐标系高度

// 动态计算 paddingX 以水平居中 7 列格子
const paddingX = Math.floor((viewBoxWidth - 7 * cellSize) / 2)
const paddingY = 46

const weekdays = ['日','一','二','三','四','五','六']

// theme
const tankColor = '#166534'

// ------------- layer data -------------
const targetYear = ref(currentYear.value)
const targetMonth = ref(currentMonth.value)

const oldWeeks = ref([])   // 6 x 7 grid of Date objects
const newWeeks = ref([])
const oldChecked = ref([]) // array of 'YYYY-MM-DD'
const newChecked = ref([])
const oldYear = ref(currentYear.value)
const oldMonth = ref(currentMonth.value)

const oldCheckedSet = computed(() => new Set(oldChecked.value))
const newCheckedSet = computed(() => new Set(newChecked.value))

// helpers
function pad(n) { return n < 10 ? `0${n}` : `${n}` }
function ymdFromDate(d) {
  if (!(d instanceof Date)) return ''
  return `${d.getFullYear()}-${pad(d.getMonth()+1)}-${pad(d.getDate())}`
}
function isoToLocalDate(str) {
  if (!str) return null
  const m = /^(\d{4})-(\d{2})-(\d{2})$/.exec(str)
  if (m) return new Date(Number(m[1]), Number(m[2]) - 1, Number(m[3]))
  const dt = new Date(str)
  return isNaN(dt.getTime()) ? null : dt
}
function isSameMonth(d, y, m) {
  return d.getFullYear() === y && (d.getMonth()+1) === m
}
function isToday(d) {
  const t = new Date()
  return d.getFullYear() === t.getFullYear() && d.getMonth() === t.getMonth() && d.getDate() === t.getDate()
}
function cellX(colIndex) { return paddingX + colIndex * cellSize }
function cellY(rowIndex) { return paddingY + rowIndex * cellSize }

// build 6-row grid
function buildWeeksFixed6(year, month) {
  const first = new Date(year, month - 1, 1)
  const firstWeekday = first.getDay()
  const startDate = new Date(year, month - 1, 1 - firstWeekday)
  const weeksArr = []
  let dt = new Date(startDate)
  for (let r = 0; r < 6; r++) {
    const week = Array(7).fill(null)
    for (let c = 0; c < 7; c++) {
      week[c] = new Date(dt.getFullYear(), dt.getMonth(), dt.getDate())
      dt.setDate(dt.getDate() + 1)
    }
    weeksArr.push(week)
  }
  return weeksArr
}

// segments only consider same-month checked days
function segmentsInRow(row, rowIndex, checkedSet, layerYear, layerMonth) {
  const segs = []
  let i = 0
  while (i < 7) {
    while (i < 7 && !(row[i] && isSameMonth(row[i], layerYear, layerMonth) && checkedSet.has(ymdFromDate(row[i])))) i++
    if (i >= 7) break
    let start = i
    let j = i + 1
    while (j < 7 && (row[j] && isSameMonth(row[j], layerYear, layerMonth) && checkedSet.has(ymdFromDate(row[j])))) j++
    let end = j - 1
    segs.push({ startCol: start, endCol: end })
    i = j
  }
  return segs
}

function isCheckedBySetAndMonth(date, setRef, y, m) {
  if (!date) return false
  if (!isSameMonth(date, y, m)) return false
  return setRef.has(ymdFromDate(date))
}

// API
function getAuthHeaders() {
  const token = localStorage.getItem('yp_token')
  return token ? { Authorization: `Bearer ${token}` } : {}
}

async function fetchCheckinsFor(year, month) {
  try {
    const headers = getAuthHeaders()
    if (!headers.Authorization) return []
    const res = await axios.get(`/api/calendar/checkins/${year}/${month}`, { headers })
    if (Array.isArray(res.data)) {
      return res.data.map(d => {
        const dt = isoToLocalDate(d) || new Date(d)
        return `${dt.getFullYear()}-${pad(dt.getMonth()+1)}-${pad(dt.getDate())}`
      })
    }
    return []
  } catch (err) {
    console.error('fetchCheckins error', err)
    throw err
  }
}

// init
async function init() {
  loading.value = true
  error.value = null
  try {
    oldWeeks.value = buildWeeksFixed6(currentYear.value, currentMonth.value)
    oldChecked.value = await fetchCheckinsFor(currentYear.value, currentMonth.value)
    oldYear.value = currentYear.value
    oldMonth.value = currentMonth.value
  } catch (err) {
    error.value = err?.response?.data?.error || err.message || '加载失败'
  } finally {
    loading.value = false
  }
}

// animation helpers
function layerClass(which) {
  if (!animating.value) return ''
  return `${direction.value === 'left' ? 'anim-left' : 'anim-right'} ${which}-layer`
}

function setToNewLayer(year, month, deltaDirection) {
  if (animating.value) return
  direction.value = deltaDirection === 1 ? 'left' : 'right'
  animating.value = true
  newVisible.value = true
  oldVisible.value = true

  targetYear.value = year
  targetMonth.value = month

  newWeeks.value = buildWeeksFixed6(year, month)

  fetchCheckinsFor(year, month).then(arr => {
    newChecked.value = arr
  }).catch(e => {
    error.value = e?.response?.data?.error || e.message || '加载失败'
  })

  setTimeout(() => {
    animating.value = false
    oldWeeks.value = newWeeks.value.slice()
    oldChecked.value = newChecked.value.slice()
    oldYear.value = year
    oldMonth.value = month
    newVisible.value = false
    currentYear.value = year
    currentMonth.value = month
  }, ANIM_DURATION)
}

function changeMonth(delta) {
  const y0 = currentYear.value, m0 = currentMonth.value
  let y = y0, m = m0 + delta
  if (m < 1) { m = 12; y -= 1 }
  if (m > 12) { m = 1; y += 1 }
  setToNewLayer(y, m, delta)
}
function onPrev() { changeMonth(-1) }
function onNext() { changeMonth(1) }

async function reload() {
  loading.value = true
  error.value = null
  try {
    const arr = await fetchCheckinsFor(currentYear.value, currentMonth.value)
    oldChecked.value = arr
  } catch (err) {
    error.value = err?.response?.data?.error || err.message || '加载失败'
  } finally {
    loading.value = false
  }
}

const currentMonthCheckedCount = computed(() => {
  return oldChecked.value.filter(s => {
    const m = s.split('-')
    if (m.length !== 3) return false
    return Number(m[0]) === oldYear.value && Number(m[1]) === oldMonth.value
  }).length
})

// lifecycle
onMounted(() => { init() })
</script>

<style scoped>
.calendar-root {
  background: #1c1c1c;
  color: #fff;
  padding: 18px;
  border-radius: 30px;
  box-shadow: 12px 12px 36px rgba(194, 194, 194, 0.7);
  display: flex;
  flex-direction: column;
  align-items: center;
  
}

.header { width: 100%; display:flex; flex-direction: column; align-items:center; gap:8px; }
.calendar-title { font-size: 22px; font-weight: 800; text-align:center; margin: 0; color: #fff; }

.controls { display:flex; gap:10px; align-items:center; justify-content:center; width:100%; margin-top: 8px; }
.month-label { font-weight:700; padding:6px 12px; border-radius:8px; background: rgba(255,255,255,0.06); color: #fff; }
.btn-try {
  background: rgba(255,255,255,0.02);
  border: 1px solid rgba(255,255,255,0.06);
  padding: 6px 10px;
  border-radius: 8px;
  font-weight:700; color:#fff; cursor:pointer;
}
.btn-try:disabled { opacity: 0.5; cursor:not-allowed; }

.svg-wrap {
  width:100%; max-width:760px; min-height:520px; height:auto; display:flex; justify-content:center; align-items:center; margin-top:18px; position:relative; overflow:hidden; padding:10px 0 6px 0;
}
@media (max-width:640px) { .svg-wrap { max-width:360px; min-height:320px; padding:6px 0; } }

.svg-layer {
  position:absolute; left:50%; top:0; transform:translateX(-50%); width:100%; max-width:700px; height:auto; will-change:transform,opacity; display:flex; justify-content:center; align-items:center;
}
.svg-el { width:100%; height:auto; display:block; }

/* animation classes */
.anim-left.old-layer { animation: old-slide-left 420ms forwards; }
.anim-left.new-layer { animation: new-slide-left 420ms forwards; }
.anim-right.old-layer { animation: old-slide-right 420ms forwards; }
.anim-right.new-layer { animation: new-slide-right 420ms forwards; }

@keyframes old-slide-left { 0%{transform:translateX(-50%);opacity:1} 100%{transform:translateX(-150%);opacity:0} }
@keyframes new-slide-left { 0%{transform:translateX(50%);opacity:0} 100%{transform:translateX(-50%);opacity:1} }
@keyframes old-slide-right { 0%{transform:translateX(-50%);opacity:1} 100%{transform:translateX(50%);opacity:0} }
@keyframes new-slide-right { 0%{transform:translateX(-150%);opacity:0} 100%{transform:translateX(-50%);opacity:1} }

.info { width:100%; text-align:center; margin-top:10px; color: rgba(255,255,255,0.88); }
</style>