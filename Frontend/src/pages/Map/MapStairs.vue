<template>
  <section class="stage-map card p-6" aria-label="地图区域">
    <h2 class="text-lg font-semibold mb-4">阶段 {{ getStageLabel(selectedStageInternal) }} · 闯关线路</h2>

    <div class="map-canvas relative" :style="{ height: canvasHeight + 'px' }">
      <svg
        v-if="fullPath"
        class="absolute inset-0 w-full h-full pointer-events-none"
        :viewBox="`0 0 ${svgVW} ${svgVH}`"
        preserveAspectRatio="none"
      >
        <!-- 背景整条路径（原始颜色） -->
        <path :d="fullPath" fill="none" stroke="rgba(255,255,255,0.3)" stroke-width="6" stroke-linecap="round" stroke-linejoin="round" />
        <!-- 进度路径（从第1单元到当前学习单元）——绿色 -->
        <path v-if="progressPath" :d="progressPath" fill="none" stroke="rgba(34,197,94,0.95)" stroke-width="6" stroke-linecap="round" stroke-linejoin="round" />
      </svg>

      <div class="nodes-container relative">
        <div
          v-for="(node, idx) in nodesPositions"
          :key="node.unitKey"
          class="node-wrapper"
          :style="{
            position: 'absolute',
            left: node.x + '%',
            top: node.y + 'px',
            transform: 'translate(-50%, -50%)'
          }"
        >
          <button
            :class="[
              'unit-node',
              nodeStateClass(node.localNumber),
              { 'is-pressed': pressedNodeKey === node.unitKey }
            ]"
            @click="onNodeClick(node)"
            @mousedown="onPress(node)"
            @mouseup="onRelease"
            @mouseleave="onRelease"
            @touchstart.prevent="onPress(node)"
            @touchend="onRelease"
            :disabled="!isUnitUnlocked(node.localNumber)"
            :aria-label="`单元 ${node.localIndex}（${baseLang}）`"
          >
            <div class="node-inner">
              <div class="node-number">单元 {{ node.localIndex }}</div>
              <div class="node-sub text-xs">{{ simpleTitle(node.localNumber) }}</div>
            </div>

            <div class="node-badge" v-if="isUnitCompleted(node.localNumber)">✓</div>
            <div class="node-lock" v-else-if="!isUnitUnlocked(node.localNumber) && token">🔒</div>
          </button>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, computed, watch, onMounted, onBeforeUnmount } from 'vue'
import axios from 'axios'
import { useRouter } from 'vue-router'

/*
  FIX SUMMARY:
  - Use course id (e.g. "python1") as primary identifier when fetching/syncing progress.
  - Pass both course and base lang to backend (`params: { course, lang }`) for compatibility.
  - Listen to 'yp_course' storage key & 'course-changed' event and refresh using full course id.
  - Keep backward compatibility with 'yp_lang' / 'language-changed' (fallback).
*/

const props = defineProps({
  // support both new and legacy props:
  selectedCourse: { type: String, default: null }, // preferred (e.g. "python1")
  selectedLang: { type: String, default: null },   // fallback (e.g. "python")
  selectedStage: { type: Number, required: true }
})

const router = useRouter()

// local progress map managed by MapStairs（组件自管）
const progressMap = ref({}) // { unitId: { completed: 1, ... } }
const progressCache = ref({}) // simple per-course cache
const loadingProgress = ref(false)

// pressed state for visual pressed effect
const pressedNodeKey = ref(null)

// layout
const canvasHeight = ref(950)
const verticalSpacing = 100
const svgVW = ref(1000)
const svgVH = ref(600)

// computed token (用于显示 lock)
const token = computed(() => localStorage.getItem('yp_token') || null)

// -----------------------------
// selectedStage internal (mirrors prop but also listens to storage/event changes)
// -----------------------------
const selectedStageInternal = ref(props.selectedStage != null ? props.selectedStage : Number(localStorage.getItem('yp_stage') || 0))
watch(() => props.selectedStage, (v) => {
  if (typeof v === 'number') selectedStageInternal.value = v
})

// -----------------------------
// course handling
// -----------------------------
// activeCourse: prefer selectedCourse prop, then selectedLang (append '1' if needed), then localStorage, then default
const activeCourse = computed(() => {
  if (props.selectedCourse) return props.selectedCourse
  if (props.selectedLang) {
    // if caller provided 'python' convert to 'python1' to be consistent
    return String(props.selectedLang).endsWith('1') ? props.selectedLang : `${props.selectedLang}1`
  }
  try {
    const stored = localStorage.getItem('yp_course')
    if (stored) return stored
  } catch (e) {}
  return 'python1'
})
// baseLang derived from course id: "python1" -> "python"
const baseLang = computed(() => {
  const c = activeCourse.value || ''
  return c.replace(/\d+$/, '') || c
})

// -----------------------------
// nodesPositions depends on selectedStageInternal & activeCourse
// -----------------------------
const nodesPositions = computed(() => {
  const baseUnitStart = Number(selectedStageInternal.value) * 10 + 1
  const arr = []
  const count = 10
  const gap = verticalSpacing
  const topOffset = 40
  for (let i = 0; i < count; i++) {
    const localNumber = baseUnitStart + i
    // unitKey uses full course ID so different courses don't collide
    const unitKey = `${activeCourse.value}-${localNumber}` // FIX: include course
    const y = topOffset + i * gap
    const x = (i % 3 === 0) ? 28 : ((i % 3 === 1) ? 72 : 50)
    arr.push({
      unitKey,
      localNumber,
      localIndex: i + 1,
      x, y
    })
  }
  canvasHeight.value = topOffset + (count - 1) * gap + 120
  svgVH.value = Math.max(canvasHeight.value, 600)
  return arr
})

// -----------------------------
// svg path helpers
// -----------------------------
function buildPathFromPoints(pts) {
  if (!pts || pts.length === 0) return ''
  if (pts.length === 1) return `M ${pts[0].x} ${pts[0].y}`
  let d = `M ${pts[0].x} ${pts[0].y}`
  for (let i = 1; i < pts.length; i++) {
    const prev = pts[i - 1]
    const curr = pts[i]
    const cx = (prev.x + curr.x) / 2
    const cy = (prev.y + curr.y) / 2
    d += ` Q ${prev.x} ${prev.y} ${cx} ${cy}`
    d += ` T ${curr.x} ${curr.y}`
  }
  return d
}

const fullPath = computed(() => {
  const nodes = nodesPositions.value
  if (!nodes || nodes.length === 0) return ''
  const vw = svgVW.value
  const vh = svgVH.value
  const points = nodes.map(n => ({ x: (n.x / 100) * vw, y: (n.y / canvasHeight.value) * vh }))
  return buildPathFromPoints(points)
})

const progressPath = computed(() => {
  const nodes = nodesPositions.value
  if (!nodes || nodes.length === 0) return ''
  // 找到第一个未完成的节点索引（视为当前在学）；如果都完成则到最后一个
  let curIdx = nodes.findIndex(n => !isUnitCompleted(n.localNumber))
  if (curIdx === -1) curIdx = nodes.length - 1
  // 保证至少有 2 个点，否则不绘制
  const vw = svgVW.value
  const vh = svgVH.value
  const points = nodes.map(n => ({ x: (n.x / 100) * vw, y: (n.y / canvasHeight.value) * vh }))
  const slicePts = points.slice(0, curIdx + 1)
  if (slicePts.length === 0) return ''
  return buildPathFromPoints(slicePts)
})

// -----------------------------
// unit state helpers
// -----------------------------
function isUnitCompleted(localNumber) {
  const p = progressMap.value[String(localNumber)]
  return !!(p && (p.completed === 1 || p.completed === true || p.completed === '1'))
}
function isUnitUnlocked(localNumber) {
  const id = Number(localNumber)
  if (id === 1) return true
  if (!token.value) return false
  const prev = progressMap.value[String(id - 1)]
  return !!(prev && (prev.completed === 1 || prev.completed === true || prev.completed === '1'))
}
function nodeStateClass(localNumber) {
  if (isUnitCompleted(localNumber)) return 'state-completed'
  if (isUnitUnlocked(localNumber)) return 'state-unlocked'
  return 'state-locked'
}
function getStageLabel(idx) {
  // 使用 course 相关的标签（优先 course id）
  const labels = {
    python1: ['A','B','C','D','E'],
    cpp1: ['F','G','H','I','J'],
    java1: ['K','L','M','N','O'],
    // backward compat
    python: ['A','B','C','D','E'],
    cpp: ['F','G','H','I','J'],
    java: ['K','L','M','N','O']
  }
  const key = activeCourse.value ? activeCourse.value : baseLang.value
  const l = labels[key] || labels[baseLang.value] || null
  if (l && l[idx] !== undefined) return l[idx]
  return String(idx+1)
}
function simpleTitle(localNumber) {
  const idx = ((localNumber - 1) % 10) + 1
  return `第 ${idx} 关`
}

// -----------------------------
// pressed handlers
// -----------------------------
function onPress(node) {
  if (!isUnitUnlocked(node.localNumber)) return
  pressedNodeKey.value = node.unitKey
}
function onRelease() {
  pressedNodeKey.value = null
}

// -----------------------------
// navigation on click
// -----------------------------
async function onNodeClick(node) {
  if (!isUnitUnlocked(node.localNumber)) {
    if (!token.value) { // 触发全局打开登录（供 Nav 或其他处理）
      try { window.dispatchEvent(new Event('open-login-modal')) } catch(e){}
      return
    }
    showInlineMessage('该单元尚未解锁，请先完成前一关。')
    return
  }
  try {
    // quick visual release before navigate
    pressedNodeKey.value = null
    router.push({ name: "Study", params: { unitId: String(node.localNumber), lang: baseLang.value } })
  } catch (e) {}
}

function showInlineMessage(text) {
  const id = 'map-inline-msg'
  let el = document.getElementById(id)
  if (!el) {
    el = document.createElement('div')
    el.id = id
    el.style.position = 'fixed'
    el.style.left = '50%'
    el.style.bottom = '28px'
    el.style.transform = 'translateX(-50%)'
    el.style.background = 'rgba(20,20,25,0.95)'
    el.style.color = 'white'
    el.style.padding = '10px 14px'
    el.style.borderRadius = '10px'
    el.style.zIndex = 9999
    el.style.transition = 'opacity .3s'
    document.body.appendChild(el)
  }
  el.textContent = text
  el.style.opacity = '1'
  setTimeout(() => { if (el) el.style.opacity = '0' }, 2200)
}

// -----------------------------
// progress fetching (FIX: use course id as primary param)
// -----------------------------
// NOTE: this function now expects `courseId` (e.g. "python1").
// It will send both `course` and `lang` to backend as params for compatibility.
async function refreshProgressForCourse(courseId) {
  const base = (courseId || '').replace(/\d+$/, '') || courseId || baseLang.value
  const t = localStorage.getItem('yp_token')
  if (!t) {
    progressMap.value = {}
    progressCache.value[courseId] = {}
    return
  }
  loadingProgress.value = true
  try {
    // Try bulk fetch first. Send both course and lang so backend can use either.
    try {
      const res = await axios.get('http://localhost:5000/api/progress', {
        headers: { Authorization: `Bearer ${t}` },
        params: { course: courseId, lang: base },
        timeout: 8000
      })
      if (res && res.status === 200 && res.data) {
        const pm = {}
        const data = res.data
        if (Array.isArray(data)) data.forEach(r => { if (r && r.unit_id !== undefined) pm[String(r.unit_id)] = r })
        else if (typeof data === 'object') {
          if (data.unit_id !== undefined) pm[String(data.unit_id)] = data
          else Object.keys(data).forEach(k => pm[k] = data[k])
        }
        progressCache.value[courseId] = pm
        progressMap.value = { ...pm }
        return
      }
    } catch (e) {
      // fallback below
    }

    // fallback: per-unit fetch (also pass both params)
    const total = 50, concurrency = 6
    const pm2 = {}
    for (let i = 1; i <= total; i += concurrency) {
      const batch = []
      for (let j = i; j < i + concurrency && j <= total; j++) batch.push(j)
      await Promise.all(batch.map(async u => {
        try {
          const r = await axios.get(`http://localhost:5000/api/progress/${u}`, {
            headers: { Authorization: `Bearer ${t}` },
            params: { course: courseId, lang: base },
            timeout: 4000
          })
          if (r && r.status === 200) pm2[String(u)] = r.data || null
        } catch (e) { pm2[String(u)] = null }
      }))
    }
    progressCache.value[courseId] = pm2
    progressMap.value = { ...pm2 }
  } finally {
    loadingProgress.value = false
  }
}

// -----------------------------
// events & storage handling (FIX: use yp_course & course-changed properly)
// -----------------------------
function handleAuthChanged() { refreshProgressForCourse(activeCourse.value).catch(()=>{}) }

function onStorage(ev) {
  if (!ev) return
  // course changed in another tab -> refresh using full course id
  if (ev.key === 'yp_course') {
    const newCourse = ev.newValue || null
    if (newCourse) {
      refreshProgressForCourse(newCourse).catch(()=>{})
    }
  }
  // backward compat: old key
  if (ev.key === 'yp_lang') {
    const newLang = ev.newValue || null
    if (newLang) {
      const courseMaybe = newLang.endsWith('1') ? newLang : `${newLang}1`
      refreshProgressForCourse(courseMaybe).catch(()=>{})
    }
  }
  // stage changed in another tab
  if (ev.key === 'yp_stage') {
    const v = ev.newValue
    const n = Number(v)
    if (!isNaN(n)) selectedStageInternal.value = n
  }
}

function onCourseChanged(ev) {
  const c = ev && ev.detail && ev.detail.course ? ev.detail.course : null
  if (!c) return
  refreshProgressForCourse(c).catch(()=>{})
}

function onStageChanged(ev) {
  const s = ev && ev.detail && typeof ev.detail.stage !== 'undefined' ? Number(ev.detail.stage) : null
  if (s !== null && !isNaN(s)) selectedStageInternal.value = s
}

// compatibility with older event name
function onLanguageChanged(ev) {
  const newLang = ev && ev.detail && ev.detail.lang ? ev.detail.lang : null
  if (!newLang) return
  const courseMaybe = newLang.endsWith('1') ? newLang : `${newLang}1`
  refreshProgressForCourse(courseMaybe).catch(()=>{})
}

// -----------------------------
// initial mount & watches
// -----------------------------
onMounted(() => {
  // Initial load: use activeCourse.value (which may come from prop or localStorage)
  refreshProgressForCourse(activeCourse.value).catch(()=>{})

  window.addEventListener('auth-changed', handleAuthChanged)
  window.addEventListener('storage', onStorage)
  window.addEventListener('course-changed', onCourseChanged)
  window.addEventListener('stage-changed', onStageChanged)
  window.addEventListener('language-changed', onLanguageChanged) // backward compat

  // watch activeCourse change (derived from props/localStorage) -> refresh
  const stopWatch = watch(activeCourse, (val, oldVal) => {
    if (val && val !== oldVal) {
      refreshProgressForCourse(val).catch(()=>{})
    }
  })

  onBeforeUnmount(() => {
    stopWatch()
  })
})

onBeforeUnmount(() => {
  window.removeEventListener('auth-changed', handleAuthChanged)
  window.removeEventListener('storage', onStorage)
  window.removeEventListener('course-changed', onCourseChanged)
  window.removeEventListener('stage-changed', onStageChanged)
  window.removeEventListener('language-changed', onLanguageChanged)
})

// also respond when parent props change explicitly
watch(() => props.selectedCourse, (v) => {
  if (v) refreshProgressForCourse(v).catch(()=>{})
})
watch(() => props.selectedLang, (v) => {
  if (v) {
    const c = String(v).endsWith('1') ? v : `${v}1`
    refreshProgressForCourse(c).catch(()=>{})
  }
})

</script>

<style scoped>
/* 容器：黑底白字 */
.stage-map {
  background: #000;        /* 黑底 */
  margin-top: 1px;
  color: #ffffff;          /* 默认白字 */
  box-shadow: none;
  border: 1px solid rgba(255,255,255,0.04);
}

/* 标题 */
.stage-map h2 { color: #ffffff; }

/* map canvas */
.map-canvas {
  position: relative;
  min-height: 520px;
  height: auto;
  background: linear-gradient(180deg, rgba(255,255,255,0.02), rgba(255,255,255,0.01));
  border-radius: 8px;
  padding: 12px;
}

/* nodes container & nodes */
.nodes-container {
  position: relative;
  width: 100%;
  height: 100%;
  min-height: 600px;
  padding: 20px 12px;
  box-sizing: border-box;
}

/* node wrapper 保持大小自适应 */
.node-wrapper { width: 180px; height: 5%; pointer-events: auto; }

/* 节点：放大一点，光芒，悬停上移，按下填充并放大 */
.unit-node {
  position: relative;
  z-index: 3;
  display:flex;
  flex-direction:column;
  align-items:center;
  justify-content:center;
  padding: 14px;
  width: 180px;                  /* 比之前大一点 */
  border-radius: 14px;
  background: linear-gradient(180deg, #071027, #0b1220);
  border: 1px solid rgba(255,255,255,0.04);
  cursor: pointer;
  transition:
    transform .16s cubic-bezier(.2,.9,.2,1),
    box-shadow .16s cubic-bezier(.2,.9,.2,1),
    background .12s ease,
    border-color .12s ease;
  text-align:center;
  color: #e6eef8;
  will-change: transform, box-shadow, background;
}

/* hover 向上位移（只在非禁用时有效） */
.unit-node:not(:disabled):hover {
  transform: translateY(-10px) scale(1.02);
}

/* disabled 状态 */
.unit-node:disabled { cursor:not-allowed; opacity:0.7; transform:none; box-shadow:none; }

/* 内部文本 */
.node-inner { display:flex; flex-direction:column; gap:6px; align-items:center; }
.node-number { font-weight:800; color:#ffffff; font-size: 16px; }
.node-sub { color:#bfc8d6; font-size: 12px; }

/* badge / lock */
.node-badge {
  position: absolute;
  right: 8px;
  top: 8px;
  background: rgba(34,197,94,0.14);
  color: #0f5132;
  padding: 6px 8px;
  border-radius: 8px;
  font-weight:800;
  border: 1px solid rgba(34,197,94,0.12);
  z-index:5;
}
.node-lock {
  position: absolute;
  right: 8px;
  top: 8px;
  font-size: 18px;
  z-index:5;
  color: rgba(255,255,255,0.88);
}

/* states with glow (光芒) */
/* completed -> green glow */
.state-completed {
  border-color: rgba(34,197,94,0.9);
  background: linear-gradient(90deg, rgba(34, 197, 94, 0.238), rgba(34,197,94,0.01));
  box-shadow:
    0 14px 32px rgba(34, 197, 94, 0.238),
    0 0 36px rgba(34,197,94,0.06);
  transform: translateY(-6px);
}

/* unlocked -> purple/blue glow */
.state-unlocked {
  border-color: rgba(99,102,241,0.95);
  background: linear-gradient(90deg, rgba(99, 101, 241, 0.49), rgba(124,58,237,0.02));
  box-shadow:
    0 14px 32px rgba(99, 101, 241, 0.49),
    0 0 40px rgba(124,58,237,0.06);
}

/* locked -> subtle pale glow so still readable in dark */
.state-locked {
  border-color: rgba(255, 255, 255, 0);
  opacity: 0.9;
  box-shadow:
    0 10px 24px rgba(0,0,0,0.6),
    0 0 12px rgba(255,255,255,0.02);
  filter: grayscale(10%);
}

/* 按下（点击）样式：按状态填充颜色并放大 */
.unit-node.is-pressed {
  transform: translateY(-10px) scale(1.09) !important;
}

/* pressed 填充色更明显：按不同状态用更强的背景 */
.state-completed.is-pressed {
  background: linear-gradient(180deg, #0b3b1f, #06321a);
  border-color: rgba(34,197,94,1);
  box-shadow:
    0 22px 48px rgba(34,197,94,0.18),
    0 0 60px rgba(34,197,94,0.12);
}
.state-unlocked.is-pressed {
  background: linear-gradient(180deg, #1b2a67, #5812d9);
  border-color: rgba(99,102,241,1);
  box-shadow:
    0 22px 48px rgba(99,102,241,0.16),
    0 0 68px rgba(124,58,237,0.12);
}
.state-locked.is-pressed {
  background: linear-gradient(180deg, #111217, #0b0d10);
  border-color: rgba(255,255,255,0.06);
  box-shadow:
    0 18px 36px rgba(0,0,0,0.7),
    0 0 28px rgba(255,255,255,0.02);
}

/* small responsive */
@media (max-width: 900px) {
  .nodes-container { min-height: 760px; }
  .node-wrapper { width: 150px; }
  .unit-node { width: 150px; padding: 12px; }
  /* svg { display: none; } */
}

/* 说明文字 */
.note-text {
  color: rgba(255,255,255,0.68);
}

/* map inline message（确保暗色下可读） */
#map-inline-msg {
  font-size: 14px;
  letter-spacing: 0.2px;
}

/* focus 可访问样式 */
.unit-node:focus {
  outline: none;
  box-shadow: 0 10px 36px rgba(99,102,241,0.14);
}
</style>