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
  更新说明（与 MapNav 一致）：
  - 只使用 yp_current (主记录 { course, stage }) 与 yp_select (每门课对应阶段映射)
  - MapStairs 作为消费者：优先读取 yp_current，读到后设置 currentCourse 和 selectedStageInternal 并 refreshProgress
  - 监听 storage / course-changed / stage-changed / language-changed 等事件以同步
*/

const props = defineProps({
  selectedCourse: { type: String, default: null },
  selectedLang: { type: String, default: null },
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
// stage internal sync (use yp_current priority)
const selectedStageInternal = ref(
  typeof props.selectedStage === 'number' ? props.selectedStage : Number(localStorage.getItem('yp_stage') || 0)
)
watch(() => props.selectedStage, (v) => {
  if (typeof v === 'number') selectedStageInternal.value = v
})

// -----------------------------
// helpers: normalize course id like "python" -> "python1", "python1" -> "python1"
function normalizeCourse(course) {
  if (!course) return null
  try {
    course = String(course).trim()
    const m = course.match(/^(python|cpp|java)(\d+)?$/i)
    if (m) {
      const name = m[1].toLowerCase()
      const idx = m[2] ? m[2] : '1'
      return `${name}${idx}`
    }
    return course.toLowerCase()
  } catch (e) {
    return String(course).toLowerCase()
  }
}

// storage JSON helpers
function readJsonKey(key) {
  try {
    const v = localStorage.getItem(key)
    if (!v) return null
    return JSON.parse(v)
  } catch (e) { return null }
}
function writeJsonKey(key, obj) {
  try { localStorage.setItem(key, JSON.stringify(obj)) } catch (e) {}
}

// yp_select helpers (mapping course -> stage)
function loadSelectMap() {
  const p = readJsonKey('yp_select')
  if (p && typeof p === 'object') return p
  return {}
}

// yp_current helper
function loadCurrent() {
  const c = readJsonKey('yp_current')
  if (c && c.course) return { course: normalizeCourse(c.course), stage: Number.isFinite(Number(c.stage)) ? Number(c.stage) : 0 }
  return null
}

// -----------------------------
// currentCourse: canonical course id used for rendering (component-level source)
const currentCourse = ref('python1') // will be initialized on mount

// keep derived baseLang (for routing / label)
const baseLang = computed(() => {
  const c = currentCourse.value || 'python1'
  return c.replace(/\d+$/, '') || c
})

// -----------------------------
// nodesPositions depends on selectedStageInternal & currentCourse
const nodesPositions = computed(() => {
  const baseUnitStart = Number(selectedStageInternal.value) * 10 + 1
  const arr = []
  const count = 12
  const gap = verticalSpacing
  const topOffset = 80
  for (let i = 0; i < count; i++) {
    const localNumber = baseUnitStart + i
    // unitKey uses full course ID so different courses don't collide
    const unitKey = `${currentCourse.value}-${localNumber}`
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
// svg helpers (unchanged)
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
  let curIdx = nodes.findIndex(n => !isUnitCompleted(n.localNumber))
  if (curIdx === -1) curIdx = nodes.length - 1
  const vw = svgVW.value
  const vh = svgVH.value
  const points = nodes.map(n => ({ x: (n.x / 100) * vw, y: (n.y / canvasHeight.value) * vh }))
  const slicePts = points.slice(0, curIdx + 1)
  if (slicePts.length === 0) return ''
  return buildPathFromPoints(slicePts)
})

// -----------------------------
// unit helpers (unchanged)
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

// -----------------------------
// stage label mapping — use currentCourse as key
function getStageLabel(idx) {
  const labels = {
    python1: ['A','B','C','D','E'],
    cpp1: ['F','G','H','I','J'],
    java1: ['K','L','M','N','O'],
    // compatibility
    python: ['A','B','C','D','E'],
    cpp: ['F','G','H','I','J'],
    java: ['K','L','M','N','O']
  }
  const key = currentCourse.value ? currentCourse.value : baseLang.value
  const l = labels[key] || labels[baseLang.value] || null
  if (l && l[idx] !== undefined) return l[idx]
  return String(idx + 1)
}
function simpleTitle(localNumber) {
  const idx = ((localNumber - 1) % 10) + 1
  return `第 ${idx} 关`
}

// -----------------------------
// pressed handlers
function onPress(node) {
  if (!isUnitUnlocked(node.localNumber)) return
  pressedNodeKey.value = node.unitKey
}
function onRelease() { pressedNodeKey.value = null }

// -----------------------------
// navigation on click
async function onNodeClick(node) {
  if (!isUnitUnlocked(node.localNumber)) {
    if (!token.value) {
      try { window.dispatchEvent(new Event('open-login-modal')) } catch(e){}
      return
    }
    showInlineMessage('该单元尚未解锁，请先完成前一关。')
    return
  }
  try {
    pressedNodeKey.value = null
    router.push({ name: "Study", params: { course: currentCourse.value, unitId: String(node.localNumber)} })
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
// progress fetching (use currentCourse; keep sending both course & lang)
async function refreshProgressForCourse(courseId) {
  const course = normalizeCourse(courseId || currentCourse.value || 'python1')
  const base = (course || '').replace(/\d+$/, '') || course
  const idx = (() => {
    const m = String(course).match(/(\d+)$/)
    return m ? m[1] : null
  })()
  const t = localStorage.getItem('yp_token')
  if (!t) {
    progressMap.value = {}
    progressCache.value[course] = {}
    return
  }
  loadingProgress.value = true
  try {
    try {
      const params = { course, lang: base }
      if (idx) params.index = idx
      const res = await axios.get('/api/progress', {
        headers: { Authorization: `Bearer ${t}` },
        params,
        timeout: 8000
      })
      if (res && res.status === 200 && res.data) {
        const pm = {}
        const data = res.data
        if (Array.isArray(data)) {
          data.forEach(r => {
            if (r && r.unit_id !== undefined) pm[String(r.unit_id)] = r
          })
        } else if (typeof data === 'object') {
          if (data.unit_id !== undefined) pm[String(data.unit_id)] = data
          else Object.keys(data).forEach(k => pm[k] = data[k])
        }
        progressCache.value[course] = pm
        progressMap.value = { ...pm }
        return
      }
    } catch (e) {
      // bulk fetch failed — fallback to per-unit
    }

    const total = 50, concurrency = 6
    const pm2 = {}
    const paramsBase = { course, lang: base }
    if (idx) paramsBase.index = idx

    for (let i = 1; i <= total; i += concurrency) {
      const batch = []
      for (let j = i; j < i + concurrency && j <= total; j++) batch.push(j)
      await Promise.all(batch.map(async u => {
        try {
          const r = await axios.get(`/api/progress/${u}`, {
            headers: { Authorization: `Bearer ${t}` },
            params: paramsBase,
            timeout: 4000
          })
          if (r && r.status === 200) {
            if (r.data && typeof r.data === 'object' && r.data.unit_id !== undefined) {
              pm2[String(u)] = r.data
            } else {
              pm2[String(u)] = r.data || null
            }
          }
        } catch (e) { pm2[String(u)] = null }
      }))}
    progressCache.value[course] = pm2
    progressMap.value = { ...pm2 }
  } finally {
    loadingProgress.value = false
  }
}

// -----------------------------
// events & storage handling (synchronize currentCourse immediately)
function handleAuthChanged() { refreshProgressForCourse(currentCourse.value).catch(()=>{}) }

function onStorage(ev) {
  if (!ev) return
  // yp_current changed -> update currentCourse & selectedStageInternal and refresh progress
  if (ev.key === 'yp_current') {
    const cur = loadCurrent()
    if (cur && cur.course) {
      currentCourse.value = cur.course
      selectedStageInternal.value = Number.isFinite(Number(cur.stage)) ? cur.stage : 0
      refreshProgressForCourse(currentCourse.value).catch(()=>{})
    }
  }

  // yp_select changed -> if mapping contains current course, update selectedStageInternal
  if (ev.key === 'yp_select') {
    const map = loadSelectMap()
    if (map && typeof map[currentCourse.value] !== 'undefined') {
      const s = Number(map[currentCourse.value]) || 0
      if (!isNaN(s) && s !== selectedStageInternal.value) {
        selectedStageInternal.value = s
        // also refresh progress because stage influences nodesPositions / progressPath
        refreshProgressForCourse(currentCourse.value).catch(()=>{})
      }
    }
  }
}

// event listeners for custom events
function onCourseChanged(ev) {
  const c = ev && ev.detail && ev.detail.course ? ev.detail.course : null
  const s = (ev && ev.detail && typeof ev.detail.stage !== 'undefined') ? Number(ev.detail.stage) : null
  if (!c) return
  const n = normalizeCourse(c)
  currentCourse.value = n
  if (s !== null && !isNaN(s)) selectedStageInternal.value = s
  // ensure persisted as yp_current is authoritative (write only if event source is local UI)
  try { /* we don't override persistent store here—MapNav already writes yp_current */ } catch(e) {}
  refreshProgressForCourse(n).catch(()=>{})
}
function onStageChanged(ev) {
  const s = ev && ev.detail && typeof ev.detail.stage !== 'undefined' ? Number(ev.detail.stage) : null
  const c = ev && ev.detail && ev.detail.course ? normalizeCourse(ev.detail.course) : null
  if (s === null || isNaN(s)) return
  if (c) {
    // if event carries course, use it
    currentCourse.value = c
    selectedStageInternal.value = s
  } else {
    selectedStageInternal.value = s
  }
  refreshProgressForCourse(currentCourse.value).catch(()=>{})
}

// backward compat event
function onLanguageChanged(ev) {
  const newLang = ev && ev.detail && ev.detail.lang ? ev.detail.lang : null
  if (!newLang) return
  const c = String(newLang).endsWith('1') ? newLang : `${newLang}1`
  currentCourse.value = normalizeCourse(c)
  // try load stage from yp_select
  const map = loadSelectMap()
  if (map && typeof map[currentCourse.value] !== 'undefined') {
    selectedStageInternal.value = Number(map[currentCourse.value]) || 0
  }
  refreshProgressForCourse(currentCourse.value).catch(()=>{})
}

// -----------------------------
// mount / unmount / watches
onMounted(() => {
  // initialize currentCourse: priority:
  // 1. yp_current -> { course, stage }
  // 2. props.selectedCourse or props.selectedLang
  // 3. yp_select first key or fallback to 'python1'
  const cur = loadCurrent()
  if (cur && cur.course) {
    currentCourse.value = cur.course
    selectedStageInternal.value = Number.isFinite(Number(cur.stage)) ? cur.stage : (props.selectedStage || 0)
  } else if (props.selectedCourse) {
    currentCourse.value = normalizeCourse(props.selectedCourse)
    // attempt to load saved stage for this course from yp_select
    const map = loadSelectMap()
    if (map && typeof map[currentCourse.value] !== 'undefined') {
      selectedStageInternal.value = Number(map[currentCourse.value]) || Number(props.selectedStage || 0)
    } else {
      selectedStageInternal.value = Number.isFinite(Number(props.selectedStage)) ? props.selectedStage : 0
    }
  } else if (props.selectedLang) {
    currentCourse.value = normalizeCourse(props.selectedLang)
    const map = loadSelectMap()
    if (map && typeof map[currentCourse.value] !== 'undefined') {
      selectedStageInternal.value = Number(map[currentCourse.value]) || 0
    } else {
      selectedStageInternal.value = Number.isFinite(Number(props.selectedStage)) ? props.selectedStage : 0
    }
  } else {
    const map = loadSelectMap()
    const keys = Object.keys(map || {})
    if (keys.length > 0) {
      currentCourse.value = normalizeCourse(keys[0])
      selectedStageInternal.value = Number(map[currentCourse.value]) || 0
    } else {
      currentCourse.value = 'python1'
      selectedStageInternal.value = Number.isFinite(Number(props.selectedStage)) ? props.selectedStage : 0
    }
  }

  // initial refresh
  refreshProgressForCourse(currentCourse.value).catch(()=>{})

  window.addEventListener('auth-changed', handleAuthChanged)
  window.addEventListener('storage', onStorage)
  window.addEventListener('course-changed', onCourseChanged)
  window.addEventListener('stage-changed', onStageChanged)
  window.addEventListener('language-changed', onLanguageChanged)

  // watch props changes explicitly (sync if parent updates)
  watch(() => props.selectedCourse, (v) => {
    if (v) {
      const n = normalizeCourse(v)
      if (n !== currentCourse.value) {
        currentCourse.value = n
        // attempt to use yp_select mapping for stage
        const map = loadSelectMap()
        if (map && typeof map[n] !== 'undefined') {
          selectedStageInternal.value = Number(map[n]) || 0
        }
        refreshProgressForCourse(n).catch(()=>{})
      }
    }
  })
  watch(() => props.selectedLang, (v) => {
    if (v) {
      const n = normalizeCourse(v)
      if (n !== currentCourse.value) {
        currentCourse.value = n
        const map = loadSelectMap()
        if (map && typeof map[n] !== 'undefined') {
          selectedStageInternal.value = Number(map[n]) || 0
        }
        refreshProgressForCourse(n).catch(()=>{})
      }
    }
  })
})

onBeforeUnmount(() => {
  window.removeEventListener('auth-changed', handleAuthChanged)
  window.removeEventListener('storage', onStorage)
  window.removeEventListener('course-changed', onCourseChanged)
  window.removeEventListener('stage-changed', onStageChanged)
  window.removeEventListener('language-changed', onLanguageChanged)
})
</script>

<style scoped>
/* 容器：黑底白字 */
.stage-map {
  background: #1c1c1c;
  margin-top: 30px;
  margin-left: 10%;
  margin-right: 10%;
  color: #ffffff;          /* 默认白字 */
  border-radius: 30px;
  box-shadow: 12px 12px 36px rgba(194, 194, 194, 0.7);
}

/* 标题 */
.stage-map h2 { color: #ffffff; }

/* map canvas */
.map-canvas {
  position: relative;
  min-height: 520px;
  height: auto;
  /* background: linear-gradient(180deg, rgba(255,255,255,0.02), rgba(255,255,255,0.01)); */
  background: #1c1c1c;
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