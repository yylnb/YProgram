<template>
  <div class="card p-6 calendar-root">
    <div class="header mb-6">
      <h3 class="calendar-title">打卡日历</h3>
      <div class="controls mt-3">
        <button class="btn-try" @click="onPrev" :disabled="animating || loading">上一月</button>
        <div class="month-label">{{ displayYear }} 年 {{ displayMonth }} 月</div>
        <button class="btn-try" @click="onNext" :disabled="animating || loading">下一月</button>
        <button class="btn-try" @click="reload" :disabled="loading">刷新</button>
      </div>
    </div>

    <div class="svg-wrap" ref="svgWrap">
      <!-- 两层 SVG：old 与 new。通过 animating + direction 控制平移动画 -->
      <div class="svg-layer" :class="layerClass('old')" v-if="oldVisible">
        <svg :width="svgWidth" :height="svgHeight" viewBox="0 0 700 520" preserveAspectRatio="xMidYMid meet">
          <g class="weekday-labels" font-size="14" fill="#374151" text-anchor="middle" font-family="Inter, Arial, Helvetica, sans-serif">
            <text v-for="(wd, i) in weekdays" :key="'h-old-'+i" :x="cellX(i) + cellSize/2" :y="paddingY - 18">
              {{ wd }}
            </text>
          </g>

          <!-- Pills (连线) -->
          <g v-for="(row, r) in oldWeeks" :key="'p-old-'+r">
            <template v-for="seg in segmentsInRow(row, r, oldCheckedSet)" :key="'pseg-old-'+r+'-'+seg.startCol">
              <rect
                :x="cellX(seg.startCol) + 6"
                :y="cellY(r) + 6"
                :width="Math.max((seg.endCol - seg.startCol + 1) * cellSize - 12, cellSize - 12)"
                :height="cellSize - 12"
                rx="27" ry="27"
                :fill="tankColor"
                :stroke="tankColor"
                stroke-width="1"
              />
            </template>
          </g>

          <!-- Day numbers & checked circle -->
          <g font-family="Inter, Arial, Helvetica, sans-serif" text-anchor="middle">
            <template v-for="(row, r) in oldWeeks" :key="'row-old-'+r">
              <template v-for="(cell, c) in row" :key="'cell-old-'+r+'-'+c">
                <g v-if="cell">
                  <circle v-if="isCheckedBySet(cell, oldCheckedSet)"
                          :cx="cellX(c) + cellSize/2"
                          :cy="cellY(r) + cellSize/2"
                          :r="Math.min(cellSize/2 - 8, 20)"
                          :fill="tankFgColor"/>
                  <text
                    :x="cellX(c) + cellSize/2"
                    :y="cellY(r) + cellSize/2 + 5"
                    :fill="isCheckedBySet(cell, oldCheckedSet) ? '#fff' : (isSameMonth(cell, currentYear.value, currentMonth.value) ? '#111827' : '#9ca3af')"
                    :font-size="isToday(cell) ? 16 : 14"
                    font-weight="500"
                  >
                    {{ cell.getDate() }}
                  </text>
                </g>
              </template>
            </template>
          </g>

          <!-- grid lines -->
          <g stroke="#e6e7ea" stroke-width="1">
            <template v-for="r in 6" :key="'h-old-'+r">
              <line :x1="paddingX" :x2="paddingX + 7*cellSize" :y1="cellY(r-1)" :y2="cellY(r-1)"/>
            </template>
            <template v-for="c in 8" :key="'v-old-'+c">
              <line :x1="cellX(c-1)" :x2="cellX(c-1)" :y1="paddingY" :y2="paddingY + 5*cellSize"/>
            </template>
          </g>
        </svg>
      </div>

      <div class="svg-layer" :class="layerClass('new')" v-if="newVisible">
        <svg :width="svgWidth" :height="svgHeight" viewBox="0 0 700 520" preserveAspectRatio="xMidYMid meet">
          <g class="weekday-labels" font-size="14" fill="#374151" text-anchor="middle" font-family="Inter, Arial, Helvetica, sans-serif">
            <text v-for="(wd, i) in weekdays" :key="'h-new-'+i" :x="cellX(i) + cellSize/2" :y="paddingY - 18">
              {{ wd }}
            </text>
          </g>

          <!-- Pills for new -->
          <g v-for="(row, r) in newWeeks" :key="'p-new-'+r">
            <template v-for="seg in segmentsInRow(row, r, newCheckedSet)" :key="'pseg-new-'+r+'-'+seg.startCol">
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
                  <circle v-if="isCheckedBySet(cell, newCheckedSet)"
                          :cx="cellX(c) + cellSize/2"
                          :cy="cellY(r) + cellSize/2"
                          :r="Math.min(cellSize/2 - 8, 20)"
                          :fill="tankFgColor"/>
                  <text
                    :x="cellX(c) + cellSize/2"
                    :y="cellY(r) + cellSize/2 + 5"
                    :fill="isCheckedBySet(cell, newCheckedSet) ? '#fff' : (isSameMonth(cell, targetYear.value, targetMonth.value) ? '#111827' : '#9ca3af')"
                    :font-size="isToday(cell) ? 16 : 14"
                    font-weight="500"
                  >
                    {{ cell.getDate() }}
                  </text>
                </g>
              </template>
            </template>
          </g>

          <!-- grid lines -->
          <g stroke="#e6e7ea" stroke-width="1">
            <template v-for="r in 6" :key="'h-newg-'+r">
              <line :x1="paddingX" :x2="paddingX + 7*cellSize" :y1="cellY(r-1)" :y2="cellY(r-1)"/>
            </template>
            <template v-for="c in 8" :key="'v-newg-'+c">
              <line :x1="cellX(c-1)" :x2="cellX(c-1)" :y1="paddingY" :y2="paddingY + 5*cellSize"/>
            </template>
          </g>
        </svg>
      </div>
    </div>

    <div class="mt-4 info text-sm text-gray-600">
      <span v-if="loading">加载中…</span>
      <span v-else-if="error" class="text-red-600">错误：{{ error }}</span>
      <span v-else>已加载 {{ checkedCount }} 天的打卡数据（{{ displayYear }}-{{ pad(displayMonth) }}）。</span>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import axios from 'axios'

// ------------------ state ------------------
const loading = ref(false)
const error = ref(null)

// month/year shown (base)
const now = new Date()
const currentYear = ref(now.getFullYear())
const currentMonth = ref(now.getMonth() + 1) // 1-12

const displayYear = computed(() => currentYear.value)
const displayMonth = computed(() => currentMonth.value)

// animation / layer control
const animating = ref(false)
const direction = ref('left') // 'left' means new slides in from right and pushes left? We'll define as: next -> 'left', prev -> 'right'
const oldVisible = ref(true)
const newVisible = ref(false)

// content for layers
const oldWeeks = ref([])   // array of 5 rows
const newWeeks = ref([])

const oldChecked = ref([]) // array of 'YYYY-MM-DD'
const newChecked = ref([])

// target month values used to decide coloring in new layer
const targetYear = ref(currentYear.value)
const targetMonth = ref(currentMonth.value)

// constants (layout)
const cellSize = 82
const paddingX = 14
const paddingY = 46
const weekdays = ['日','一','二','三','四','五','六']

const svgWidth = 700
const svgHeight = 520

const tankColor = '#166534'    // 深绿色（履带）
const tankFgColor = '#166534'  // circle fill for checked days (white number on top)

// computed sets for quick lookup
const oldCheckedSet = computed(() => new Set(oldChecked.value))
const newCheckedSet = computed(() => new Set(newChecked.value))
const checkedCount = computed(() => {
  // count of checked in currently displayed (old) layer ideally — show union of current month checked
  return Array.from(new Set(oldChecked.value.concat(newChecked.value))).length
})

// utility
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

// grid helpers
function cellX(colIndex) { return paddingX + colIndex * cellSize }
function cellY(rowIndex) { return paddingY + rowIndex * cellSize }

// build a fixed-5-week grid that includes previous/next month days so layout stable
function buildWeeksFixed(year, month) {
  // month 1-12
  const first = new Date(year, month - 1, 1)
  const last = new Date(year, month, 0)
  const firstWeekday = first.getDay() // 0-6
  const days = last.getDate()

  // we want exactly 5 rows. Calculate the date that will occupy row0,col0 (Sunday of first row)
  // startDate = first day - firstWeekday (could be previous month)
  const startDate = new Date(year, month - 1, 1 - firstWeekday)
  const weeksArr = []
  let dt = new Date(startDate) // copy

  for (let r = 0; r < 5; r++) {
    const week = Array(7).fill(null)
    for (let c = 0; c < 7; c++) {
      week[c] = new Date(dt.getFullYear(), dt.getMonth(), dt.getDate())
      dt.setDate(dt.getDate() + 1)
    }
    weeksArr.push(week)
  }

  // If the month would require 6 rows to display (rare when month spans 6 weeks),
  // this will cut off the last week. We intentionally fix at 5 rows per your request.
  return weeksArr
}

// compute segments for a row given a checked set (only connect when date exists and present in set)
function segmentsInRow(row, rowIndex, checkedSet) {
  const segs = []
  let i = 0
  while (i < 7) {
    while (i < 7 && !(row[i] && checkedSet.has(ymdFromDate(row[i])))) i++
    if (i >= 7) break
    let start = i
    let j = i + 1
    while (j < 7 && (row[j] && checkedSet.has(ymdFromDate(row[j])))) j++
    let end = j - 1
    segs.push({ startCol: start, endCol: end })
    i = j
  }
  return segs
}

// check helpers for template usage
function isCheckedBySet(date, setRef) {
  if (!date) return false
  return setRef.has(ymdFromDate(date))
}

// ---------------- API ----------------
function getAuthHeaders() {
  const token = localStorage.getItem('yp_token')
  return token ? { Authorization: `Bearer ${token}` } : {}
}

async function fetchCheckinsFor(year, month) {
  try {
    const headers = getAuthHeaders()
    if (!headers.Authorization) return []
    const res = await axios.get(`/api/calendar/checkins/${year}/${month}`, { headers })
    if (Array.isArray(res.data)) return res.data.map(d => {
      const dt = isoToLocalDate(d) || new Date(d)
      return `${dt.getFullYear()}-${pad(dt.getMonth()+1)}-${pad(dt.getDate())}`
    })
    return []
  } catch (err) {
    console.error('fetchCheckins error', err)
    throw err
  }
}

// initial load
async function init() {
  loading.value = true
  error.value = null
  try {
    oldWeeks.value = buildWeeksFixed(currentYear.value, currentMonth.value)
    oldChecked.value = await fetchCheckinsFor(currentYear.value, currentMonth.value)
  } catch (err) {
    error.value = err?.response?.data?.error || err.message || '加载失败'
  } finally {
    loading.value = false
  }
}

// ---------- animation control ----------
const ANIM_DURATION = 420 // ms

function layerClass(which) {
  if (!animating.value) return '' // no extra classes when not animating
  return `${direction.value === 'left' ? 'anim-left' : 'anim-right'} ${which}-layer`
}

function setToNewLayer(year, month, deltaDirection) {
  // prepare newWeeks & newChecked, set animation direction
  direction.value = deltaDirection === 1 ? 'left' : 'right' // next -> left, prev -> right
  animating.value = true
  newVisible.value = true
  oldVisible.value = true
  targetYear.value = year
  targetMonth.value = month

  // compute newWeeks immediately (so numbers available for animation)
  newWeeks.value = buildWeeksFixed(year, month)

  // fetch checked data in background; set newChecked when ready
  fetchCheckinsFor(year, month).then(arr => {
    newChecked.value = arr
  }).catch(e => {
    // non-fatal, show error
    error.value = e?.response?.data?.error || e.message || '加载失败'
  })

  // start animation timer; after animation finish, swap layers
  setTimeout(() => {
    // end animation
    animating.value = false
    // make new become old
    oldWeeks.value = newWeeks.value.slice()
    oldChecked.value = newChecked.value.slice()
    newVisible.value = false
    // update main month/year
    currentYear.value = year
    currentMonth.value = month
  }, ANIM_DURATION)
}

function changeMonth(delta) {
  if (animating.value) return
  const y0 = currentYear.value, m0 = currentMonth.value
  let y = y0, m = m0 + delta
  if (m < 1) { m = 12; y -= 1 }
  if (m > 12) { m = 1; y += 1 }
  // trigger animation & background fetch
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

// lifecycle
onMounted(() => {
  init()
})

// Expose a few refs used by template computed (targetYear/Month potentially used)
const targetYearRef = targetYear
const targetMonthRef = targetMonth
</script>

<style scoped>
.calendar-root {
  padding: 18px;
  display: flex;
  flex-direction: column;
  align-items: center;
}

/* 标题居中放大 */
.calendar-title {
  font-size: 22px;
  font-weight: 800;
  text-align: center;
  color: #0f172a;
}

/* 控制条 */
.controls {
  display: flex;
  gap: 10px;
  align-items: center;
  justify-content: center;
  margin-top: 8px;
}
.month-label {
  font-weight: 700;
  padding: 6px 12px;
  border-radius: 8px;
  background: #f3f4f6;
}
.btn-try {
  background: #fff;
  border: 1px solid rgba(15,23,42,0.06);
  padding: 6px 10px;
  border-radius: 8px;
  font-weight: 700;
  cursor: pointer;
}
.btn-try:disabled { opacity: 0.6; cursor: not-allowed; }

/* svg wrapper: 固定尺寸 & 居中 */
.svg-wrap {
  width: 100%;
  max-width: 760px;
  height: 520px;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-top: 18px;
  position: relative;
  overflow: hidden;
}

/* layers stack */
.svg-layer {
  position: absolute;
  left: 50%;
  top: 0;
  transform: translateX(-50%);
  width: 700px;
  height: 520px;
  will-change: transform, opacity;
}

/* animation classes: we implement both left and right anim behaviors.
   - anim-left on old: move left out
   - anim-left on new: start right and move to center
   - anim-right on old: move right out
   - anim-right on new: start left and move to center
*/
.anim-left.old-layer {
  animation: old-slide-left 420ms forwards;
}
.anim-left.new-layer {
  animation: new-slide-left 420ms forwards;
}
.anim-right.old-layer {
  animation: old-slide-right 420ms forwards;
}
.anim-right.new-layer {
  animation: new-slide-right 420ms forwards;
}

@keyframes old-slide-left {
  0% { transform: translateX(-50%); opacity: 1; }
  100% { transform: translateX(-150%); opacity: 0; } /* move left */
}
@keyframes new-slide-left {
  0% { transform: translateX(50%); opacity: 0; }
  100% { transform: translateX(-50%); opacity: 1; } /* move into center (translateX(-50%) centers) */
}

@keyframes old-slide-right {
  0% { transform: translateX(-50%); opacity: 1; }
  100% { transform: translateX(50%); opacity: 0; } /* move right */
}
@keyframes new-slide-right {
  0% { transform: translateX(-150%); opacity: 0; }
  100% { transform: translateX(-50%); opacity: 1; } /* move into center */
}

/* info text */
.info {
  width: 100%;
  text-align: center;
  margin-top: 8px;
}

/* card */
.card {
  background: white;
  border-radius: 12px;
  box-shadow: 0 10px 30px rgba(2,6,23,0.06);
  padding: 16px;
  width: 100%;
}

/* small screens: scale down wrapper */
@media (max-width: 640px) {
  .svg-wrap { max-width: 360px; height: 280px; }
  .svg-layer { width: 360px; height: 280px; transform: translateX(-50%); }
  /* reduce font sizes by letting svg scale via viewBox */
}
</style>