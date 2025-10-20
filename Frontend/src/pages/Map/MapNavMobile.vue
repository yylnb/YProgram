<template>
  <header class="mapnav-root" aria-label="地图导航">
    <!-- 顶部标题 -->
    <div class="lib-hero p-6 mb-6">
      <div class="hero-title hero-left">学习地图</div>
      <div class="hero-title hero-right">闯关模式</div>
    </div>

    <!-- 控件区：电池在上，语言在下（语言左对齐） -->
    <div class="controls p-4 mb-4 flex flex-col gap-6 items-center">
       <!-- 能量面板 -->
      <div class="energy-wrap w-full flex justify-end px-4">
        <div
          class="energy-panel"
          :class="{ vip: isVip, low: isLow }"
          role="region"
          aria-label="能量面板"
          :title="energyTooltip"
          @click="onEnergyClick"
        >
          <div class="battery" aria-hidden="true">
            <div class="battery-cap"></div>
            <div class="battery-body">
              <div class="battery-fill" :style="{ width: energyPercent + '%' }"></div>
            </div>
          </div>
          <div class="energy-text">
            <template v-if="isVip">
              <div class="energy-numbers" aria-live="polite"><span class="energy-infinite">∞</span></div>
              <div class="energy-meta text-xs" style="color: rgb(251, 191, 36);">YPro会员</div>
            </template>
            <template v-else>
              <div class="energy-numbers" aria-live="polite">
                <span class="energy-value">{{ energy }}</span><span class="energy-slash">/</span><span class="energy-max">{{ maxEnergy }}</span>
              </div>
              <div class="energy-meta text-xs">
                <span v-if="energy >= maxEnergy">已满</span>
                <span v-else-if="secondsToNext !== null">下一点：{{ formatSec(secondsToNext) }}</span>
                <span v-else>恢复中…</span>
              </div>
            </template>
          </div>
        </div>
      </div>

      <!-- 语言选择 -->
      <div class="languages w-90" role="tablist" aria-label="语言选择">
        <button
          v-for="lang in languages"
          :key="lang.value"
          :class="['pill', { active: localLang === lang.value }]"
          @click="selectLanguage(lang.value)"
          role="tab"
          :aria-pressed="localLang === lang.value"
        >
          {{ lang.label }}
        </button>
      </div>

      <!-- <div class="actions w-full flex items-center gap-3 justify-between px-4">
        <div class="left-col flex items-center gap-2">
          <div v-if="!token" class="text-sm muted-desc">请先登录以同步进度并解锁关卡。</div>
          <button v-if="!token" class="btn-white" @click="openLoginModal">去登录</button>
          <button v-else class="btn-white" @click="onRefresh" :disabled="loadingProgress">
            {{ loadingProgress ? '加载中…' : '刷新进度' }}
          </button>
        </div>
      </div> -->
    </div>

    <!-- 阶段选择：两阶段控制以确保 stagger 生效 -->
    <div class="stages-wrapper w-full" ref="stagesWrapper">
      <!-- 折叠（compact）：仅显示当前项（紫色） -->
      <button
        v-if="!stagesVisible"
        class="stage-compact"
        @click="openStages"
        :aria-expanded="stagesVisible.toString()"
        aria-controls="stages-list"
        type="button"
      >
        <div class="compact-left">
          <div class="stage-title">阶段 {{ getStageLabel(localStage) }}</div>
          <div class="stage-sub">{{ currentStages[localStage]?.subtitle || '' }}</div>
        </div>
        <div class="chev" aria-hidden="true">▾</div>
      </button>

      <!-- 展开容器：用 stagesVisible 控制是否在 DOM，用 animateChildren 触发子项动画 -->
      <transition name="slide-fade">
        <div
          v-if="stagesVisible"
          id="stages-list"
          class="stages-list expanded"
          :class="{ animate: animateChildren }"
          role="tablist"
          aria-label="阶段选择"
        >
          <button
            v-for="(s, idx) in currentStages"
            :key="idx"
            @click="onSelectStage(idx)"
            :class="['stage-btn card', { active: localStage === idx }]"
            :aria-pressed="localStage === idx"
            type="button"
            :style="stageStyleForIndex(idx)"
          >
            <div class="stage-title">阶段 {{ getStageLabel(idx) }}</div>
            <div class="stage-sub text-sm">{{ s.subtitle }}</div>
          </button>
        </div>
      </transition>
    </div>

    <LoginModal v-if="showLocalLoginModal" @close="closeLocalLoginModal" @success="onLoginSuccess" />
  </header>
</template>

<script setup>
/*
  说明（实现要点）：
  - stagesVisible: 控制容器是否在 DOM（v-if）
  - animateChildren: 控制子项是否进入“目标可见态”（这样能触发从 opacity:0->1 的过渡）
  - stageStyleForIndex: 为每个按钮按 idx 生成 transition-delay，确保 stagger
  - 关闭时先把 animateChildren=false（触发子项反向动画），等待容器时长再把 stagesVisible=false（从 DOM 移除）
  - JS 会读取 CSS 变量 --stages-container-duration 和 --stages-stagger（若存在）以保持同步
*/

import { ref, computed, watch, onMounted, onBeforeUnmount, nextTick } from 'vue'
import axios from 'axios'
import LoginModal from '@/components/LoginModal.vue'
import { useUIStore } from '@/stores/ui'

const props = defineProps({
  lang: { type: String, default: 'python' },
  stage: { type: Number, default: 0 }
})
const emit = defineEmits(['update:lang','update:stage'])

const languages = [
  { value: 'python', label: 'Python' },
  { value: 'cpp', label: 'C++' },
  { value: 'java', label: 'Java' }
]

const localLang = ref(props.lang)
const localStage = ref(props.stage)
watch(() => props.lang, (v) => { localLang.value = v })
watch(() => props.stage, (v) => { localStage.value = v })

// stages states
const stagesVisible = ref(false)      // 是否在 DOM 中（container）
const animateChildren = ref(false)    // 是否触发子项的进入动画（最终态）

const stagesWrapper = ref(null)

// Default timings (ms) — 若你修改 CSS :root 变量，这里会尝试读取它们以保持同步
const DEFAULTS = {
  containerDuration: 700,   // ms
  itemDuration: 380,       // ms
  stagger: 70              // ms
}

// helper: read CSS var like '600ms' -> number ms
function readCssMsVar(name, fallback) {
  try {
    const val = getComputedStyle(document.documentElement).getPropertyValue(name)
    if (!val) return fallback
    const m = val.trim().match(/^([0-9.]+)ms$/)
    if (m) return Math.round(Number(m[1]))
    const s = val.trim().match(/^([0-9.]+)s$/)
    if (s) return Math.round(Number(s[1]) * 1000)
    return fallback
  } catch (e) {
    return fallback
  }
}

function getContainerDurationMs() {
  return readCssMsVar('--stages-container-duration', DEFAULTS.containerDuration)
}
function getStaggerMs() {
  return readCssMsVar('--stages-stagger', DEFAULTS.stagger)
}

// open: make container visible, then trigger children animation next frame
async function openStages() {
  if (stagesVisible.value) return
  stagesVisible.value = true
  await nextTick()
  // small requestAnimationFrame to ensure browser painted initial state
  requestAnimationFrame(() => {
    animateChildren.value = true
  })
}

// close: un-trigger children animation, then after containerDuration remove container from DOM
function closeStages() {
  if (!stagesVisible.value) return
  // first remove the 'animate' flag so children will animate out
  animateChildren.value = false
  const delay = getContainerDurationMs()
  setTimeout(() => {
    stagesVisible.value = false
  }, delay)
}

function onSelectStage(idx) {
  if (typeof idx !== 'number') return
  localStage.value = idx
  emit('update:stage', idx)
  // collapse with animation (closeStages handles timing)
  closeStages()
}

// style for each stage button to enforce stagger via inline transition-delay
function stageStyleForIndex(idx) {
  // when animateChildren is true we want a positive delay; otherwise 0 for quick state
  const stagger = getStaggerMs()
  const delayMs = animateChildren.value ? (idx * stagger) : 0
  // also set transition-duration for item; use CSS var if you prefer (we keep visual consistent)
  const itemDuration = readCssMsVar('--stages-item-duration', DEFAULTS.itemDuration)
  return {
    transitionDelay: `${delayMs}ms`,
    transitionDuration: `${itemDuration}ms`
  }
}

// language, energy, membership logic (kept same as before)
const energy = ref(0)
const maxEnergy = ref(30)
const secondsToNext = ref(null)
let _lastEnergyUpdateAt = null
let _energyPollTimer = null
let _tickTimer = null
let _onAuthChanged = null
const isVip = ref(false)
const loadingProgress = ref(false)
const showLocalLoginModal = ref(false)

const token = computed(() => localStorage.getItem('yp_token') || null)
const energyPercent = computed(() => {
  if (isVip.value) return 100
  if (!maxEnergy.value || maxEnergy.value === 0) return 0
  return Math.round((energy.value / maxEnergy.value) * 100)
})
const isLow = computed(() => {
  if (isVip.value) return false
  if (!maxEnergy.value || maxEnergy.value === 0) return false
  return (energy.value / maxEnergy.value) <= 0.2
})

const energyTooltip = computed(() => {
  if (!token.value) return '请登录以同步能量'
  if (isVip.value) return `会员：无限能量`
  if (energy.value >= maxEnergy.value) return `能量 ${energy.value}/${maxEnergy.value}（已满）`
  if (secondsToNext.value !== null) return `当前能量 ${energy.value}/${maxEnergy.value}，下一点在 ${formatSec(secondsToNext.value)}`
  return `当前能量 ${energy.value}/${maxEnergy.value}，恢复中…`
})

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
const currentStages = computed(() => langStages[localLang.value] || defaultStages)

function getStageLabel(idx) {
  const labels = langStageLabels[localLang.value]
  if (labels && labels[idx] !== undefined) return labels[idx]
  return String(idx + 1)
}

function selectLanguage(lang) {
  if (!lang || lang === localLang.value) return
  localLang.value = lang
  try { localStorage.setItem('yp_lang', lang) } catch (e) {}
  emit('update:lang', lang)
  try { window.dispatchEvent(new CustomEvent('language-changed', { detail: { lang, source: 'mapnav' } })) } catch (e) {}
}

function openLoginModal() {
  try {
    const ui = useUIStore()
    if (ui && typeof ui.openLogin === 'function') { ui.openLogin(); return }
  } catch (e) {}
  showLocalLoginModal.value = true
}
function closeLocalLoginModal(){ showLocalLoginModal.value = false }
async function onLoginSuccess(){
  closeLocalLoginModal()
  await fetchEnergy().catch(()=>{})
  await fetchMembership().catch(()=>{})
  try { window.dispatchEvent(new Event('auth-changed')) } catch(e){}
}

async function fetchEnergy() {
  if (!token.value) {
    energy.value = 0; maxEnergy.value = 30; secondsToNext.value = null; _lastEnergyUpdateAt = null; return
  }
  try {
    const res = await axios.get('http://localhost:5000/api/user/energy', { headers:{ Authorization:`Bearer ${token.value}` }, timeout:6000 })
    if (res && res.status === 200 && res.data) {
      const d = res.data
      energy.value = Number.isFinite(Number(d.energy)) ? Number(d.energy) : (d.energy ? Number(d.energy) : 0)
      maxEnergy.value = Number.isFinite(Number(d.maxEnergy)) ? Number(d.maxEnergy) : (d.maxEnergy ? Number(d.maxEnergy) : 5)
      if (d.last_energy_update) {
        const last = new Date(d.last_energy_update)
        if (!isNaN(last)) { _lastEnergyUpdateAt = last; computeSecondsToNextFromLastUpdate() }
        else { _lastEnergyUpdateAt = null; secondsToNext.value = null }
      } else { _lastEnergyUpdateAt = null; secondsToNext.value = null }
    }
  } catch (e) { /* ignore */ }
}

async function fetchMembership() {
  if (!token.value) { isVip.value = false; return }
  try {
    const r = await axios.get('http://localhost:5000/api/membership', { headers:{ Authorization:`Bearer ${token.value}` }, timeout:6000 })
    if (r && r.data && r.data.end_at) { isVip.value = new Date(r.data.end_at) > new Date() } else isVip.value = false
  } catch (e) { isVip.value = false }
}

function computeSecondsToNextFromLastUpdate() {
  const recoverInterval = 10*60
  if (energy.value >= maxEnergy.value) { secondsToNext.value = 0; return }
  if (!_lastEnergyUpdateAt) { secondsToNext.value = null; return }
  const now = new Date()
  const diff = Math.floor((now - _lastEnergyUpdateAt)/1000)
  const since = diff % recoverInterval
  const remain = recoverInterval - since
  secondsToNext.value = remain > 0 ? remain : 0
}

function formatSec(s){ if (s===null||s===undefined) return '--:--'; const sec = Math.max(0,Math.floor(Number(s))); const m=Math.floor(sec/60); const ss=sec%60; return `${String(m).padStart(2,'0')}:${String(ss).padStart(2,'0')}` }

function onEnergyClick() {
  if (!token.value) { openLoginModal(); return }
  try { window.alert(`能量：${energy.value}/${maxEnergy.value}`) } catch (e) {}
}

async function onRefresh() {
  loadingProgress.value = true
  try { window.dispatchEvent(new Event('auth-changed')) } catch (e) {}
  await fetchEnergy().catch(()=>{})
  await fetchMembership().catch(()=>{})
  setTimeout(()=>{ loadingProgress.value = false }, 600)
}

// keyboard / outside click handling
function onKeydown(e) {
  if (!stagesVisible.value) return
  if (e.key === 'Escape') closeStages()
}
function onDocClick(e) {
  if (!stagesVisible.value) return
  const wrapper = stagesWrapper.value
  if (!wrapper) return
  if (!wrapper.contains(e.target)) {
    closeStages()
  }
}

onMounted(() => {
  fetchEnergy().catch(()=>{})
  fetchMembership().catch(()=>{})
  if (token.value) _energyPollTimer = setInterval(()=>{ fetchEnergy().catch(()=>{}) }, 15000) // minor name diff ok
  _tickTimer = setInterval(()=>{ if (_lastEnergyUpdateAt) { computeSecondsToNextFromLastUpdate(); if (energy.value >= maxEnergy.value || secondsToNext.value === 0) fetchEnergy().catch(()=>{}) } }, 1000)

  _onAuthChanged = () => { fetchEnergy().catch(()=>{}); fetchMembership().catch(()=>{}) }
  window.addEventListener('auth-changed', _onAuthChanged)

  document.addEventListener('keydown', onKeydown)
  document.addEventListener('click', onDocClick, true)
})

onBeforeUnmount(() => {
  if (_energyPollTimer) { clearInterval(_energyPollTimer); _energyPollTimer = null }
  if (_tickTimer) { clearInterval(_tickTimer); _tickTimer = null }
  if (_onAuthChanged) window.removeEventListener('auth-changed', _onAuthChanged)

  document.removeEventListener('keydown', onKeydown)
  document.removeEventListener('click', onDocClick, true)
})
</script>

<style scoped>
/* ============ 可调变量（直接修改这三项来调节展开/项动画速度/延迟） ============ */
:root {
  --stages-container-duration: 700ms;   /* 容器展开/收起时长（ms） */
  --stages-item-duration: 380ms;       /* 单项过渡时长（ms） */
  --stages-stagger: 70ms;              /* 每项延迟基准（ms） */
}

/* 基础样式（与之前一致，略有精简） */
.mapnav-root { background-color: #000 !important; padding: 18px 12px 18px !important; display: block; }

/* 顶部标题 */
.lib-hero { position: relative; z-index: 2; height: 62px; padding: 0; background: transparent !important; border: none !important; box-shadow: none !important; }
.lib-hero::after { content: ""; position: absolute; left: 6%; right: 6%; bottom: 6px; height: 1px; background: #ffffff; opacity: 1; pointer-events: none; }
.hero-title {
  position: absolute; top: 10px; font-weight: 800; line-height: 1; font-size: 21px; height: 36px; display: flex; align-items: center; justify-content: center;
  transform: translateX(-50%); white-space: nowrap;
  background: linear-gradient(90deg, #0e78e9 0%, #c63be9 100%); -webkit-background-clip: text; background-clip: text; -webkit-text-fill-color: transparent; color: transparent;
}
.hero-left { left: 13%; } .hero-right { left: 87%; }

/* controls */
.controls { display: flex; flex-direction: column; width: 100%; align-items: center; gap: 8px; }

/* languages left-aligned, 90% width */
.languages.w-90 { width: 90%; display:flex; flex-wrap:wrap; justify-content:flex-start; gap:6px; padding-left:2%; box-sizing:border-box; }
.pill { display:inline-flex; align-items:center; justify-content:center; padding:6px 10px; font-size:13px; font-weight:700; border-radius:8px; border:1px solid #8b5cf6 !important; background:transparent; color:#fff !important; transition: all .15s ease; }
.pill.active { background: linear-gradient(180deg,#8b5cf6,#6d28d9); border-color: rgba(139,92,246,0.22); color:#fff !important; transform: translateY(-2px); box-shadow: 0 8px 22px rgba(109,40,217,0.14); }

/* energy panel */
.energy-wrap { width: 100%; }
.energy-wrap .energy-panel { margin-left: auto; margin-right: 4%; }
.energy-panel { display:flex; align-items:center; gap:6px; padding:4px 6px; border-radius:8px; border:1px solid rgba(255,255,255,0.04); background: rgba(176,176,176,0.32); color:#fff !important; user-select:none; transition: all .15s ease; }
.battery { width:36px; height:16px; position:relative; display:flex; align-items:center; }
.battery-body { width:28px; height:16px; border-radius:3px; border:2px solid rgba(255,255,255,0.12); background: rgba(255,255,255,0.08); position:relative; overflow:hidden; }
.battery-fill { position:absolute; left:0; top:0; bottom:0; width:0%; background: linear-gradient(90deg,#22c55e,#10b981); transition: width .6s ease; }
.energy-numbers { font-size:12px; } .energy-infinite { font-size:14px; color:#fbbf24; font-weight:900; }

/* compact (single current stage button) - purple and left-aligned text */
.stage-compact { width:90%; margin:0 auto; display:flex; align-items:center; justify-content:space-between; gap:10px; padding:10px 12px; border-radius:12px; background:linear-gradient(180deg,#8b5cf6,#6d28d9); color:#fff; box-sizing:border-box; transition: transform .18s ease, box-shadow .18s ease; box-shadow:0 8px 22px rgba(109,40,217,0.14); border:1px solid rgba(255,255,255,0.04); }
.stage-compact:hover { transform: translateY(-3px); box-shadow:0 10px 28px rgba(109,40,217,0.16); }
.compact-left { display:flex; flex-direction:column; align-items:flex-start; text-align:left; gap:4px; flex:1; }
.stage-compact .stage-title { font-size:15px; font-weight:800; text-align:left; color:#fff; }
.stage-compact .stage-sub { font-size:12px; color: rgba(255,255,255,0.9); }

/* expanded container (we still animate container's max-height via slide-fade) */
.stages-list.expanded { width:100%; display:flex; flex-direction:column; align-items:center; gap:10px; padding:12px 0; box-sizing:border-box; }

/* stage-btn initial state: hidden & slightly up */
.stage-btn {
  width: 90%;
  padding: 12px 14px;
  border-radius: 10px;
  border: 1px solid #8b5cf6;
  background: transparent;
  color: #fff !important;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  gap: 6px;
  transform: translateY(-8px);
  opacity: 0;
  box-sizing: border-box;
  /* final transition properties controlled via inline style for duration + delay */
}

/* hover & active visual */
.stage-btn.active { background: linear-gradient(180deg,#8b5cf6,#6d28d9); color:#fff !important; transform: translateY(0); }

/* when animateChildren=true we add class .animate on container; this selector is the final state */
.stages-list.expanded.animate .stage-btn {
  opacity: 1;
  transform: translateY(0);
  /* transition will use inline transition-duration + transition-delay we set in JS */
  transition-property: transform, opacity;
  transition-timing-function: cubic-bezier(.18,.9,.2,1);
}

/* slide-fade container enter/leave: use CSS var for container duration */
.slide-fade-enter-active, .slide-fade-leave-active {
  transition: max-height var(--stages-container-duration, 700ms) cubic-bezier(.16,.84,.24,1), opacity calc(var(--stages-container-duration,700ms)/1.4) ease;
  overflow: hidden;
}
.slide-fade-enter-from, .slide-fade-leave-to { max-height: 0; opacity: 0; }
.slide-fade-enter-to, .slide-fade-leave-from { max-height: 900px; opacity: 1; }

/* text sizes */
.stage-title { font-size: 15px; font-weight: 800; }
.stage-sub { font-size: 12px; color: #d1d5db !important; }

/* focus outlines */
.pill:focus, .btn-white:focus, .stage-btn:focus, .stage-compact:focus { outline: 3px solid rgba(139,92,246,0.18) !important; outline-offset: 2px; border-radius: 10px; }
</style>