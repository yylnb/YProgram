<template>
  <div class="map-root">
    <!-- 顶部介绍（Library 风格） -->
    <header class="lib-hero p-6 mb-6">
      <h1 class="text-2xl font-extrabold mb-2">学习地图 · 闯关模式</h1>
      <p class="text-gray-600">选择语言 · 挑战闯关 · 同步进度并解锁下一关</p>
    </header>

    <!-- 控件栏（语言 pill + 操作 + 能量） -->
    <div class="controls p-4 mb-6 flex flex-wrap gap-4 items-center">
      <div class="languages flex gap-2 items-center">
        <button
          v-for="lang in languages"
          :key="lang.value"
          :class="['pill', { active: selectedLang === lang.value }]"
          @click="selectLanguage(lang.value)"
          role="tab"
          :aria-pressed="selectedLang === lang.value"
        >
          {{ lang.label }}
        </button>
      </div>

      <div class="flex-1"></div>

      <div class="actions flex items-center gap-3">
        <div v-if="!token" class="text-sm text-gray-600">请先登录以同步进度并解锁关卡。</div>
        <button v-if="!token" class="btn-white" @click="openLoginModal">去登录</button>
        <button v-else class="btn-white" @click="refreshProgress" :disabled="loadingProgress">
          {{ loadingProgress ? '加载中…' : '刷新进度' }}
        </button>

        <!-- 能量面板 -->
        <div class="energy-panel" :class="{ vip: isVip }" role="region" aria-label="能量面板" :title="energyTooltip" @click="onEnergyClick">
          <div class="battery" aria-hidden="true">
            <div class="battery-cap"></div>
            <div class="battery-body">
              <div class="battery-fill" :style="{ width: energyPercent + '%' }"></div>
            </div>
          </div>
          <div class="energy-text">
            <template v-if="isVip">
              <div class="energy-numbers" aria-live="polite"><span class="energy-infinite">∞</span></div>
              <div class="energy-meta text-xs text-gray-500">无限能量（会员）</div>
            </template>
            <template v-else>
              <div class="energy-numbers" aria-live="polite">
                <span class="energy-value">{{ energy }}</span><span class="energy-slash">/</span><span class="energy-max">{{ maxEnergy }}</span>
              </div>
              <div class="energy-meta text-xs text-gray-500">
                <span v-if="energy >= maxEnergy">已满</span>
                <span v-else-if="secondsToNext !== null">下一点：{{ formatSec(secondsToNext) }}</span>
                <span v-else>恢复中…</span>
              </div>
            </template>
          </div>
        </div>

      </div>
    </div>

    <!-- 阶段选择（pill 样式的阶段卡片） -->
    <div class="stages-list mb-6 flex gap-4 flex-wrap">
      <button
        v-for="(s, idx) in currentStages"
        :key="idx"
        @click="selectStage(idx)"
        :class="['stage-btn card', { active: selectedStage === idx }]"
        :aria-pressed="selectedStage === idx"
      >
        <div class="stage-title">阶段 {{ getStageLabel(idx) }}</div>
        <div class="stage-sub text-sm">{{ s.subtitle }}</div>
      </button>
    </div>

    <!-- 地图区域（card） -->
    <div class="stage-map card p-6">
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
    </div>

    <!-- LoginModal 回退 -->
    <LoginModal v-if="showLocalLoginModal" @close="closeLocalLoginModal" @success="onLoginSuccess" />
  </div>
</template>

<script setup>
/* Map.vue — UI 已采用 Library 风格。
   功能说明：包含语言选择、stage 切换、progress refresh（agg + fallback）、能量与会员、节点布局、事件监听与清理。
*/

import { ref, reactive, computed, onMounted, onBeforeUnmount, watch } from 'vue'
import axios from 'axios'
import { useRouter } from 'vue-router'
import LoginModal from '@/components/LoginModal.vue'
import { useUIStore } from '@/stores/ui'

// -------------------- state --------------------
const languages = [
  { value: 'python', label: 'Python' },
  { value: 'cpp', label: 'C++' },
  { value: 'java', label: 'Java' }
]

// language selection
const selectedLang = ref('python')

// progress cache & map
const progressCache = reactive({})
const progressMap = reactive({})
const loadingProgress = ref(false)

// stage selection
const selectedStage = ref(0)

// layout
const canvasHeight = ref(950)
const verticalSpacing = 100
const svgVW = ref(1000)
const svgVH = ref(600)

// ui store & router
let ui = null
try { ui = useUIStore() } catch (e) { ui = null }
const router = useRouter()

// modal fallback
const showLocalLoginModal = ref(false)

// energy / vip
const energy = ref(0)
const maxEnergy = ref(30)
const secondsToNext = ref(null)
let _lastEnergyUpdateAt = null
let _energyPollTimer = null
let _tickTimer = null
const isVip = ref(false)
const loadingProgressTimer = ref(false)

// event listener refs
let _onStorage = null
let _onLanguageChanged = null
let _onAuthChanged = null

// -------------------- computed --------------------
const token = computed(() => localStorage.getItem('yp_token') || null)

const energyPercent = computed(() => {
  if (isVip.value) return 100
  if (!maxEnergy.value || maxEnergy.value === 0) return 0
  return Math.round((energy.value / maxEnergy.value) * 100)
})

const energyTooltip = computed(() => {
  if (!token.value) return '请登录以同步能量'
  if (isVip.value) return `会员：无限能量`
  if (energy.value >= maxEnergy.value) return `能量 ${energy.value}/${maxEnergy.value}（已满）`
  if (secondsToNext.value !== null) return `当前能量 ${energy.value}/${maxEnergy.value}，下一点在 ${formatSec(secondsToNext.value)}`
  return `当前能量 ${energy.value}/${maxEnergy.value}，恢复中…`
})

// stages meta
const langStageLabels = {
  python: ['A','B','C','D','E'],
  cpp: ['F','G','H','I','J'],
  java: ['K','L','M','N','O']
}

const langStages = {
  python: [
    { subtitle: '入门基础：变量、类型与输出（Python 风格）' },
    { subtitle: '流程控制与列表/字典' },
    { subtitle: '函数、模块与文件操作（实践）' },
    { subtitle: '面向对象与异步入门（async/await）' },
    { subtitle: '实战项目：小爬虫与数据处理' }
  ],
  cpp: [
    { subtitle: '基础语法与编译流程（C++ 特性）' },
    { subtitle: '指针、引用与内存管理' },
    { subtitle: 'STL 容器与算法' },
    { subtitle: '类与模板编程' },
    { subtitle: '实战项目：算法题与性能优化' }
  ],
  java: [
    { subtitle: 'Java 基础：类、方法与编译运行' },
    { subtitle: '集合框架与异常处理' },
    { subtitle: '多线程与并发基础' },
    { subtitle: '面向对象进阶与设计模式' },
    { subtitle: '实战项目：Web 服务与小项目' }
  ]
}

const defaultStages = [
  { subtitle: "入门基础：语法与输出" },
  { subtitle: "流程控制与数据结构" },
  { subtitle: "函数、模块与文件" },
  { subtitle: "面向对象与异步" },
  { subtitle: "实战项目练习" }
]

const currentStages = computed(() => langStages[selectedLang.value] || defaultStages)

// -------------------- nodes layout computed --------------------
const nodesPositions = computed(() => {
  const baseUnitStart = selectedStage.value * 10 + 1
  const arr = []
  const count = 10
  const gap = verticalSpacing
  const topOffset = 40
  for (let i = 0; i < count; i++) {
    const localNumber = baseUnitStart + i
    const unitKey = `${selectedLang.value}-${localNumber}`
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

// -------------------- helper functions --------------------
function getStageLabel(idx) {
  const labels = langStageLabels[selectedLang.value]
  if (labels && labels[idx] !== undefined) return labels[idx]
  return String(idx + 1)
}

function simpleTitle(localNumber) {
  const idx = ((localNumber - 1) % 10) + 1
  return `第 ${idx} 关`
}

function nodeStateClass(localNumber) {
  if (isUnitCompleted(localNumber)) return 'state-completed'
  if (isUnitUnlocked(localNumber)) return 'state-unlocked'
  return 'state-locked'
}

function isUnitCompleted(localNumber) {
  const p = progressMap[String(localNumber)]
  return !!(p && (p.completed === 1 || p.completed === true || p.completed === '1'))
}

function isUnitUnlocked(localNumber) {
  const id = Number(localNumber)
  if (id === 1) return true
  if (!token.value) return false
  const prev = progressMap[String(id - 1)]
  return !!(prev && (prev.completed === 1 || prev.completed === true || prev.completed === '1'))
}

async function onNodeClick(node) {
  if (!isUnitUnlocked(node.localNumber)) {
    if (!token.value) { openLoginModal(); return }
    showInlineMessage('该单元尚未解锁，请先完成前一关。')
    return
  }
  try {
    router.push({ name: "Study", params: { unitId: String(node.localNumber), lang: selectedLang.value } })
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

function openLoginModal() {
  try { window.dispatchEvent(new Event('open-login-modal')) } catch (e) {}
  try { if (ui && typeof ui.openLogin === 'function') { ui.openLogin(); return } } catch (e) {}
  showLocalLoginModal.value = true
}
function closeLocalLoginModal() { showLocalLoginModal.value = false }

async function onLoginSuccess() {
  try {
    await refreshProgress()
    await fetchEnergy()
    await fetchMembership()
  } catch (e) {}
}

// -------------------- refreshProgress (agg + fallback) --------------------
async function refreshProgress(langParam) {
  const lang = (typeof langParam === 'string') ? langParam : selectedLang.value
  const t = localStorage.getItem('yp_token')
  if (!t) {
    Object.keys(progressMap).forEach(k => delete progressMap[k])
    progressCache[lang] = {}
    return
  }

  loadingProgress.value = true
  try {
    try {
      const res = await axios.get('http://localhost:5000/api/progress', {
        headers: { Authorization: `Bearer ${t}` },
        params: { lang },
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
        progressCache[lang] = pm
        Object.keys(progressMap).forEach(k => delete progressMap[k])
        Object.keys(pm).forEach(k => { progressMap[k] = pm[k] })
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
          const r = await axios.get(`http://localhost:5000/api/progress/${u}`, {
            headers: { Authorization: `Bearer ${t}` },
            params: { lang },
            timeout: 4000
          })
          if (r && r.status === 200) pm2[String(u)] = r.data || null
        } catch (e) { pm2[String(u)] = null }
      }))
    }
    progressCache[lang] = pm2
    Object.keys(progressMap).forEach(k => delete progressMap[k])
    Object.keys(pm2).forEach(k => { progressMap[k] = pm2[k] })
  } finally {
    loadingProgress.value = false
  }
}

// -------------------- energy & membership --------------------
async function fetchEnergy() {
  if (!token.value) {
    energy.value = 0
    maxEnergy.value = 30
    secondsToNext.value = null
    _lastEnergyUpdateAt = null
    return
  }
  try {
    const res = await axios.get('http://localhost:5000/api/user/energy', {
      headers: { Authorization: `Bearer ${token.value}` },
      timeout: 6000
    })
    if (res && res.status === 200 && res.data) {
      const d = res.data
      energy.value = Number.isFinite(Number(d.energy)) ? Number(d.energy) : (d.energy ? Number(d.energy) : 0)
      maxEnergy.value = Number.isFinite(Number(d.maxEnergy)) ? Number(d.maxEnergy) : (d.maxEnergy ? Number(d.maxEnergy) : 5)
      if (d.last_energy_update) {
        const last = new Date(d.last_energy_update)
        if (!isNaN(last)) {
          _lastEnergyUpdateAt = last
          computeSecondsToNextFromLastUpdate()
        } else {
          _lastEnergyUpdateAt = null
          secondsToNext.value = null
        }
      } else {
        _lastEnergyUpdateAt = null
        secondsToNext.value = null
      }
    }
  } catch (e) {
    // ignore
  }
}

async function fetchMembership() {
  if (!token.value) {
    isVip.value = false
    return
  }
  try {
    const res = await axios.get('http://localhost:5000/api/membership', {
      headers: { Authorization: `Bearer ${token.value}` },
      timeout: 6000
    })
    if (res && res.data && res.data.end_at) {
      const end = new Date(res.data.end_at)
      isVip.value = end > new Date()
    } else {
      isVip.value = false
    }
  } catch (e) {
    isVip.value = false
  }
}

function computeSecondsToNextFromLastUpdate() {
  const recoverInterval = 10 * 60 // 秒
  if (energy.value >= maxEnergy.value) {
    secondsToNext.value = 0
    return
  }
  if (!_lastEnergyUpdateAt) {
    secondsToNext.value = null
    return
  }
  const now = new Date()
  const diffSeconds = Math.floor((now - _lastEnergyUpdateAt) / 1000)
  const sinceLastTick = diffSeconds % recoverInterval
  const remain = recoverInterval - sinceLastTick
  secondsToNext.value = remain > 0 ? remain : 0
}

function formatSec(s) {
  if (s === null || s === undefined) return '--:--'
  const sec = Math.max(0, Math.floor(Number(s)))
  const m = Math.floor(sec / 60)
  const ss = sec % 60
  return `${String(m).padStart(2, '0')}:${String(ss).padStart(2,'0')}`
}

// -------------------- lifecycle & timers & listeners --------------------
onMounted(() => {
  // init language from localStorage
  try {
    const saved = localStorage.getItem('yp_lang')
    const allow = ['python', 'cpp', 'c', 'java', 'html', 'css', 'js']
    if (saved && allow.includes(saved)) selectedLang.value = saved
    else selectedLang.value = 'python'
  } catch (e) { selectedLang.value = 'python' }

  // listeners
  _onStorage = (ev) => {
    if (ev && ev.key === 'yp_lang') {
      const newLang = ev.newValue || 'python'
      selectedLang.value = newLang
      if (progressCache[newLang]) {
        Object.keys(progressMap).forEach(k => delete progressMap[k])
        const pm = progressCache[newLang] || {}
        Object.keys(pm).forEach(k => { progressMap[k] = pm[k] })
      } else {
        Object.keys(progressMap).forEach(k => delete progressMap[k])
      }
      if (token.value) refreshProgress(newLang).catch(()=>{})
    }
  }
  _onLanguageChanged = (ev) => {
    const newLang = ev && ev.detail && ev.detail.lang ? ev.detail.lang : null;
    if (!newLang) return;
    if (ev.detail && ev.detail.source === 'map') return;
    if (newLang === selectedLang.value) return;
    selectedLang.value = newLang;
    if (progressCache[newLang]) {
      Object.keys(progressMap).forEach(k => delete progressMap[k])
      const pm = progressCache[newLang] || {}
      Object.keys(pm).forEach(k => { progressMap[k] = pm[k] })
    } else {
      Object.keys(progressMap).forEach(k => delete progressMap[k])
    }
    if (token.value) refreshProgress(newLang).catch(()=>{})
  }
  _onAuthChanged = () => { refreshProgress().catch(()=>{}) }

  window.addEventListener('storage', _onStorage)
  window.addEventListener('language-changed', _onLanguageChanged)
  window.addEventListener('auth-changed', _onAuthChanged)

  // initial load
  if (token.value) {
    refreshProgress().catch(()=>{})
    fetchEnergy().catch(()=>{})
    fetchMembership().catch(()=>{})
    _energyPollTimer = setInterval(() => { fetchEnergy().catch(()=>{}) }, 15000)
  } else {
    Object.keys(progressMap).forEach(k => delete progressMap[k])
    progressCache[selectedLang.value] = {}
  }

  _tickTimer = setInterval(() => {
    if (_lastEnergyUpdateAt) {
      computeSecondsToNextFromLastUpdate()
      if (energy.value >= maxEnergy.value || secondsToNext.value === 0) {
        fetchEnergy().catch(()=>{})
      }
    }
  }, 1000)
})

onBeforeUnmount(() => {
  window.removeEventListener('storage', _onStorage)
  window.removeEventListener('language-changed', _onLanguageChanged)
  window.removeEventListener('auth-changed', _onAuthChanged)

  if (_energyPollTimer) { clearInterval(_energyPollTimer); _energyPollTimer = null }
  if (_tickTimer) { clearInterval(_tickTimer); _tickTimer = null }
})

// keep progressMap in sync when selectedLang changes
watch(selectedLang, (newLang) => {
  if (progressCache[newLang]) {
    Object.keys(progressMap).forEach(k => delete progressMap[k])
    const pm = progressCache[newLang] || {}
    Object.keys(pm).forEach(k => { progressMap[k] = pm[k] })
  } else {
    Object.keys(progressMap).forEach(k => delete progressMap[k])
  }
})

// ------------------ 修复：确保 template 使用的函数存在 ------------------

// 切换语言（模板中 selectLanguage('python') 使用）
function selectLanguage(lang) {
  if (typeof lang !== 'string') return
  const allow = languages.map(l => l.value)
  if (!allow.includes(lang)) return
  if (lang === selectedLang.value) return

  // 更新本地 state
  selectedLang.value = lang
  try { localStorage.setItem('yp_lang', lang) } catch (e) {}

  // 快速用缓存更新进度映射以避免闪烁
  const cached = progressCache[lang]
  if (cached) {
    Object.keys(progressMap).forEach(k => delete progressMap[k])
    Object.keys(cached).forEach(k => { progressMap[k] = cached[k] })
  } else {
    Object.keys(progressMap).forEach(k => delete progressMap[k])
  }

  // 拉取云端进度（如果已登录）
  if (token.value) {
    refreshProgress(lang).catch(()=>{})
  }

  // 通知同页其它组件（保留原有行为）
  try { window.dispatchEvent(new CustomEvent('language-changed', { detail: { lang, source: 'map' } })) } catch (e) {}
}

// 切换阶段（模板中 selectStage(idx) 使用）
function selectStage(idx) {
  if (typeof idx !== 'number') return
  selectedStage.value = idx
  // 若登录则刷新进度
  if (token.value) refreshProgress().catch(()=>{})
}

</script>

<style scoped>
/* 参考 Library.vue 的视觉风格并调整用于 Map 页面 */
.map-root {
  --primary: #843f8d;
  --primary-600: #5e195f;
  --card-border: rgba(132,63,141,0.12);
  --muted: #6b4b66;
  --text-strong: #33122E;
  --glass-shadow: 0 14px 40px rgba(61,22,61,0.06);
  padding: 70px 12px 80px;
  min-height: calc(100vh - 0px);
  position: relative;
  z-index: 1;
  box-sizing: border-box;
}

/* background hint like Library (optional image path) */
.map-root::before {
  content: "";
  position: fixed;
  inset: 0;
  z-index: 0;
  pointer-events: none;
  background-color: #f6eefb;
  background-repeat: no-repeat;
  background-position: top center;
  background-size: cover;
}

/* hero header */
.lib-hero {
  position: relative;
  z-index: 2;
  border-radius: 12px;
  padding: 18px 22px;
  background: linear-gradient(180deg, rgba(132,63,141,0.14), rgba(132,63,141,0.06));
  border: 1px solid var(--card-border);
  backdrop-filter: blur(12px) saturate(120%);
  box-shadow: var(--glass-shadow);
  color: var(--text-strong);
}

/* controls */
.controls { z-index:2; display:flex; gap:12px; align-items:center; }

/* language pills */
.languages { display:flex; gap:8px; align-items:center; }
.pill {
  padding: 8px 12px;
  border-radius: 999px;
  cursor: pointer;
  font-weight: 700;
  background: linear-gradient(180deg, rgba(255,255,255,0.02), rgba(255,255,255,0.01));
  color: var(--text-strong);
  border: 1px solid rgba(255,255,255,0.04);
  transition: transform .12s ease, box-shadow .12s ease, color .12s;
}
.pill:hover { transform: translateY(-2px); box-shadow: 0 8px 18px rgba(0,0,0,0.06); }
.pill.active {
  background: linear-gradient(180deg, var(--primary), var(--primary-600));
  color: #ffffff;
  border-color: rgba(255,255,255,0.12);
}

/* card base (used for stage buttons and map area) */
.card {
  cursor: default;
  transition: transform 260ms cubic-bezier(.2,.9,.2,1), box-shadow 260ms cubic-bezier(.2,.9,.2,1), border-color 180ms;
  border: 1px solid rgba(132,63,141,0.08);
  background: linear-gradient(180deg, rgba(132,63,141,0.06), rgba(255,255,255,0.02));
  padding: 14px;
  border-radius: 12px;
  backdrop-filter: blur(12px) saturate(120%);
  box-shadow: 0 10px 30px rgba(61,22,61,0.04);
  color: var(--text-strong);
}
.card:hover { transform: translateY(-6px); box-shadow: 0 36px 80px rgba(132,63,141,0.12); }

/* stage buttons as card-like pills */
.stage-btn { display:flex; flex-direction:column; gap:6px; min-width: 180px; align-items:flex-start; padding:12px; }
.stage-btn.active { background: linear-gradient(180deg, rgba(132,63,141,0.12), rgba(255,255,255,0.04)); border-color: rgba(132,63,141,0.22); transform: translateY(-6px); }

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

/* energy panel */
.energy-panel {
  display:flex;
  align-items:center;
  gap:10px;
  padding:6px 8px;
  border-radius:10px;
  cursor:pointer;
  user-select:none;
  transition: transform .12s ease, box-shadow .12s ease;
}
.energy-panel:hover { transform: translateY(-2px); box-shadow: 0 10px 20px rgba(2,6,23,0.06); }

.battery { 
  position: relative; 
  width: 46px; 
  height: 22px; 
  display:flex; 
  align-items:center;
  overflow: hidden;
  box-sizing: border-box;
}
.battery-cap { position: absolute; right: 0; width: 4px; height: 10px; background: rgba(0,0,0,0.12); border-radius:2px; top:6px; transform: translateX(40%); }
.battery-body { width: 36px; height: 22px; border-radius: 4px; border: 2px solid rgba(15,23,42,0.08); position: relative; background: linear-gradient(180deg,#fff,#f3f4f6); overflow:hidden; }
.battery-fill { position:absolute; left:0; top:0; bottom:0; width:0%; transition: width 0.6s ease; background: linear-gradient(90deg,#34d399,#10b981); }
.energy-panel.vip .battery-fill { background: linear-gradient(90deg,#facc15,#eab308); }

.energy-text { display:flex; flex-direction:column; line-height:1; }
.energy-numbers { font-weight:800; font-size:13px; color:#0b1220; }
.energy-infinite { font-size:18px; color:#d97706; font-weight:900; }
.energy-slash { margin: 0 6px; color:#6b7280; }
.energy-meta { margin-top:2px; color:#6b7280; font-weight:700; font-size:11px; }

/* small responsive */
@media (max-width: 900px) {
  .nodes-container { min-height: 760px; }
  .unit-node { width: 140px; }
  svg { display: none; }
  .battery { width: 36px; height: 18px; }
  .energy-numbers { font-size:12px; }
}

/* focus accessibility */
.pill:focus, .btn-white:focus, .unit-node:focus {
  outline: 3px solid rgba(132,63,141,0.12);
  outline-offset: 2px;
  border-radius: 10px;
}
</style>