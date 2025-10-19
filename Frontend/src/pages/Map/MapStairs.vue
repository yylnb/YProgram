<template>
  <section class="stage-map card p-6" aria-label="地图区域">
    <h2 class="text-lg font-semibold mb-4">阶段 {{ getStageLabel(selectedStage) }} · 闯关线路</h2>

    <div class="map-canvas relative" :style="{ height: canvasHeight + 'px' }">
      <svg
        v-if="svgPath"
        class="absolute inset-0 w-full h-full pointer-events-none"
        :viewBox="`0 0 ${svgVW} ${svgVH}`"
        preserveAspectRatio="none"
      >
        <path :d="svgPath" fill="none" stroke="rgba(132,63,141,0.12)" stroke-width="6" stroke-linecap="round" stroke-linejoin="round" />
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
            :class="['unit-node', nodeStateClass(node.localNumber)]"
            @click="onNodeClick(node)"
            :disabled="!isUnitUnlocked(node.localNumber)"
            :aria-label="`单元 ${node.localIndex}（${selectedLang}）`"
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

    <p class="mt-4 text-sm text-gray-600">
      说明：节点按上下曲折排列，已完成显示 ✓，未解锁显示锁。解锁策略由服务器端 progress 控制（按语言区分）。
    </p>
  </section>
</template>

<script setup>
import { ref, computed, watch, onMounted, onBeforeUnmount } from 'vue'
import axios from 'axios'
import { useRouter } from 'vue-router'

const props = defineProps({
  selectedLang: { type: String, required: true },
  selectedStage: { type: Number, required: true }
})

const router = useRouter()

// local progress map managed by MapStairs（组件自管）
const progressMap = ref({}) // { unitId: { completed: 1, ... } }
const progressCache = ref({}) // simple per-lang cache
const loadingProgress = ref(false)

// layout
const canvasHeight = ref(950)
const verticalSpacing = 100
const svgVW = ref(1000)
const svgVH = ref(600)

// computed token (用于显示 lock)
const token = computed(() => localStorage.getItem('yp_token') || null)

// nodesPositions（基于 selectedStage 与 selectedLang，本组件自行计算）
const nodesPositions = computed(() => {
  const baseUnitStart = props.selectedStage * 10 + 1
  const arr = []
  const count = 10
  const gap = verticalSpacing
  const topOffset = 40
  for (let i = 0; i < count; i++) {
    const localNumber = baseUnitStart + i
    const unitKey = `${props.selectedLang}-${localNumber}`
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

// svgPath 依据 nodesPositions 计算
const svgPath = computed(() => {
  const nodes = nodesPositions.value
  if (!nodes || nodes.length === 0) return ''
  const vw = svgVW.value
  const vh = svgVH.value
  const points = nodes.map(n => ({ x: (n.x / 100) * vw, y: (n.y / canvasHeight.value) * vh }))
  let d = `M ${points[0].x} ${points[0].y}`
  for (let i = 1; i < points.length; i++) {
    const prev = points[i - 1]
    const curr = points[i]
    const cx = (prev.x + curr.x) / 2
    const cy = (prev.y + curr.y) / 2
    d += ` Q ${prev.x} ${prev.y} ${cx} ${cy}`
    d += ` T ${curr.x} ${curr.y}`
  }
  return d
})

// helper functions for local progress logic
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
  const labels = { python:['A','B','C','D','E'], cpp:['F','G','H','I','J'], java:['K','L','M','N','O'] }
  const l = labels[props.selectedLang]
  if (l && l[idx] !== undefined) return l[idx]
  return String(idx+1)
}
function simpleTitle(localNumber) {
  const idx = ((localNumber - 1) % 10) + 1
  return `第 ${idx} 关`
}

// node click 跳转（组件自管）
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
    router.push({ name: "Study", params: { unitId: String(node.localNumber), lang: props.selectedLang } })
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
    el.style.background = 'rgba(15,23,42,0.9)'
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

// 进度拉取（组件自管）：尝试一次批量拉取，失败后走并发单元 fallback（与原逻辑一致）
async function refreshProgressForLang(lang) {
  const t = localStorage.getItem('yp_token')
  if (!t) {
    progressMap.value = {}
    progressCache.value[lang] = {}
    return
  }
  loadingProgress.value = true
  try {
    try {
      const res = await axios.get('http://localhost:5000/api/progress', { headers:{ Authorization:`Bearer ${t}` }, params:{ lang }, timeout:8000 })
      if (res && res.status === 200 && res.data) {
        const pm = {}
        const data = res.data
        if (Array.isArray(data)) data.forEach(r => { if (r && r.unit_id !== undefined) pm[String(r.unit_id)] = r })
        else if (typeof data === 'object') {
          if (data.unit_id !== undefined) pm[String(data.unit_id)] = data
          else Object.keys(data).forEach(k => pm[k] = data[k])
        }
        progressCache.value[lang] = pm
        progressMap.value = { ...pm }
        return
      }
    } catch (e) {
      // fallback below
    }

    const total = 50, concurrency = 6
    const pm2 = {}
    for (let i = 1; i <= total; i += concurrency) {
      const batch = []
      for (let j = i; j < i + concurrency && j <= total; j++) batch.push(j)
      await Promise.all(batch.map(async u => {
        try {
          const r = await axios.get(`http://localhost:5000/api/progress/${u}`, { headers:{ Authorization:`Bearer ${t}` }, params:{ lang }, timeout:4000 })
          if (r && r.status === 200) pm2[String(u)] = r.data || null
        } catch (e) { pm2[String(u)] = null }
      }))
    }
    progressCache.value[lang] = pm2
    progressMap.value = { ...pm2 }
  } finally {
    loadingProgress.value = false
  }
}

// 监听器：当外部（Nav 或其它）触发 auth-changed 或 language-changed 时刷新
function onAuthChanged() { refreshProgressForLang(props.selectedLang).catch(()=>{}) }
function onStorage(ev) {
  if (ev && ev.key === 'yp_lang') {
    const newLang = ev.newValue || 'python'
    refreshProgressForLang(newLang).catch(()=>{})
  }
}
function onLanguageChanged(ev) {
  const newLang = ev && ev.detail && ev.detail.lang ? ev.detail.lang : null
  if (!newLang) return
  if (ev.detail && ev.detail.source === 'mapnav') return
  refreshProgressForLang(newLang).catch(()=>{})
}

onMounted(() => {
  // 初次加载 progress
  refreshProgressForLang(props.selectedLang).catch(()=>{})

  // 事件监听
  window.addEventListener('auth-changed', onAuthChanged)
  window.addEventListener('storage', onStorage)
  window.addEventListener('language-changed', onLanguageChanged)
})

onBeforeUnmount(() => {
  window.removeEventListener('auth-changed', onAuthChanged)
  window.removeEventListener('storage', onStorage)
  window.removeEventListener('language-changed', onLanguageChanged)
})

// 当 selectedLang 更改（父组件通过 v-model 更新时），自动刷新本组件的数据
watch(() => props.selectedLang, (newLang) => {
  if (newLang) refreshProgressForLang(newLang).catch(()=>{})
})
</script>

<style scoped>
.stage-map { margin-top: 8px; }

/* map canvas */
.map-canvas { position: relative; min-height: 520px; height: auto; }

/* nodes container & nodes */
.nodes-container { position: relative; width: 100%; height: 100%; min-height: 600px; padding: 20px 12px; box-sizing: border-box; }

.node-wrapper { width: 160px; height: auto; pointer-events: auto; }
.unit-node {
  position: relative;
  z-index: 3;
  display:flex;
  flex-direction:column;
  align-items:center;
  justify-content:center;
  padding: 12px;
  width: 160px;
  border-radius: 14px;
  background: linear-gradient(180deg,#fbfdff,#ffffff);
  border: 1px solid rgba(15,23,42,0.06);
  box-shadow: 0 10px 26px rgba(2,6,23,0.04);
  cursor: pointer;
  transition: transform .12s ease, box-shadow .12s ease;
  text-align:center;
}
.unit-node:disabled { cursor:not-allowed; opacity:0.8; transform:none; box-shadow:none; }

.node-inner { display:flex; flex-direction:column; gap:6px; align-items:center; }
.node-number { font-weight:800; color:#07102a; }
.node-sub { color:#475569; }

/* badge / lock */
.node-badge { position: absolute; right: 8px; top: 8px; background: rgba(34,197,94,0.12); color: #166534; padding: 6px 8px; border-radius: 8px; font-weight:800; border: 1px solid rgba(16,185,129,0.12); z-index:5; }
.node-lock { position: absolute; right: 8px; top: 8px; font-size: 18px; z-index:5; }

/* states */
.state-completed { border-color: #16a34a; background: linear-gradient(90deg, rgba(16,185,129,0.06), rgba(16,185,129,0.02)); transform: translateY(-6px); box-shadow: 0 22px 48px rgba(16,185,129,0.06); }
.state-unlocked { border-color: rgba(37,99,235,0.9); background: linear-gradient(180deg, rgba(37,99,235,0.04), rgba(124,58,237,0.02)); }
.state-locked { border-color: rgba(15,23,42,0.06); opacity: 0.82; }

/* small responsive */
@media (max-width: 900px) {
  .nodes-container { min-height: 760px; }
  .unit-node { width: 140px; }
  svg { display: none; }
}
</style>