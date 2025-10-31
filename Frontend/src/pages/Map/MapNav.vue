<template>
  <header class="mapnav-root" aria-label="地图导航">
    <div class="lib-hero p-6 mb-6">
      <div class="hero-title hero-left">学习地图</div>
      <div class="hero-title hero-right">闯关模式</div>
    </div>

    <div class="controls p-4 mb-4 flex flex-wrap gap-4 items-center">
      <div class="languages flex gap-2 items-center" role="tablist" aria-label="课程选择">
        <button
          v-for="course in courses"
          :key="course.value"
          :class="['pill', { active: localCourse === course.value }]"
          @click="selectCourse(course.value)"
          role="tab"
          :aria-pressed="localCourse === course.value"
        >
          {{ course.label }}
        </button>
      </div>

      <div class="flex-1"></div>

      <div class="actions flex items-center gap-3">
        <div v-if="!token" class="text-sm muted-desc">请先登录以同步进度并解锁关卡。</div>
        <button v-if="!token" class="btn-white" @click="openLoginModal">去登录</button>
        <button v-else class="btn-white" @click="onRefresh" :disabled="loadingProgress">
          {{ loadingProgress ? '加载中…' : '刷新进度' }}
        </button>

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
              <div class="energy-meta text-xs">YPro会员</div>
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
    </div>

    <div class="stages-list mb-6 flex gap-4 flex-wrap" role="tablist" aria-label="阶段选择">
      <button
        v-for="(s, idx) in currentStages"
        :key="idx"
        @click="selectStage(idx)"
        :class="['stage-btn card', { active: localStage === idx }]"
        :aria-pressed="localStage === idx"
      >
        <div class="stage-title">阶段 {{ getStageLabel(idx) }}</div>
        <div class="stage-sub text-sm">{{ s.subtitle }}</div>
      </button>
    </div>

    <LoginModal v-if="showLocalLoginModal" @close="closeLocalLoginModal" @success="onLoginSuccess" />
  </header>
</template>

<script setup>
import { ref, computed, watch, onMounted, onBeforeUnmount } from 'vue'
import axios from 'axios'
import LoginModal from '@/components/LoginModal.vue'
import { useUIStore } from '@/stores/ui'

const props = defineProps({
  course: { type: String, default: 'python1' },
  stage: { type: Number, default: 0 }
})
const emit = defineEmits(['update:course','update:stage'])

const courses = [
  { value: 'python1', label: 'Python' },
  { value: 'cpp1', label: 'C++' },
  { value: 'java1', label: 'Java' }
]

const localCourse = ref(props.course)
const localStage = ref(props.stage)

watch(() => props.course, (v) => { localCourse.value = v })
watch(() => props.stage, (v) => { localStage.value = v })

// energy / membership state
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

const courseStageLabels = {
  python1: ['A','B','C','D','E'],
  cpp1: ['F','G','H','I','J'],
  java1: ['K','L','M','N','O']
}
const courseStages = {
  python1: [
    { subtitle: '入门基础：变量、类型与输出（Python 风格）' },
    { subtitle: '流程控制与列表/字典' },
    { subtitle: '函数、模块与文件操作（实践）' },
    { subtitle: '面向对象与异步入门（async/await）' },
    { subtitle: '实战项目：小爬虫与数据处理' }
  ],
  cpp1: [
    { subtitle: '基础语法与编译流程（C++ 特性）' },
    { subtitle: '指针、引用与内存管理' },
    { subtitle: 'STL 容器与算法' },
    { subtitle: '类与模板编程' },
    { subtitle: '实战项目：算法题与性能优化' }
  ],
  java1: [
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
const currentStages = computed(() => courseStages[localCourse.value] || defaultStages)

function getStageLabel(idx) {
  const labels = courseStageLabels[localCourse.value]
  if (labels && labels[idx] !== undefined) return labels[idx]
  return String(idx + 1) 
}

function selectCourse(course) {
  if (!course || course === localCourse.value) return
  localCourse.value = course
  try { localStorage.setItem('yp_course', course) } catch (e) {}
  emit('update:course', course)
  try { window.dispatchEvent(new CustomEvent('course-changed', { detail: { course, source: 'mapnav' } })) } catch (e) {}
}

function selectStage(idx) {
  if (typeof idx !== 'number' || idx === localStage.value) return
  localStage.value = idx
  try { localStorage.setItem('yp_stage', String(idx)) } catch (e) {}
  emit('update:stage', idx)
  try { window.dispatchEvent(new CustomEvent('stage-changed', { detail: { stage: idx, source: 'mapnav' } })) } catch (e) {}
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
    const r = await axios.get('http://localhost:5000/api/user/membership', { headers:{ Authorization:`Bearer ${token.value}` }, timeout:6000 })
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

onMounted(() => {
  // 优先从 localStorage 恢复用户选择（若存在）
  try {
    const storedCourse = localStorage.getItem('yp_course')
    if (storedCourse && typeof storedCourse === 'string') { localCourse.value = storedCourse }
  } catch (e) {}

  try {
    const storedStage = localStorage.getItem('yp_stage')
    if (storedStage !== null) {
      const n = Number(storedStage)
      if (!isNaN(n)) localStage.value = n
    }
  } catch (e) {}

  fetchEnergy().catch(()=>{})
  fetchMembership().catch(()=>{})
  if (token.value) _energyPollTimer = setInterval(()=>{ fetchEnergy().catch(()=>{}) }, 15000)
  _tickTimer = setInterval(()=>{ if (_lastEnergyUpdateAt) { computeSecondsToNextFromLastUpdate(); if (energy.value >= maxEnergy.value || secondsToNext.value === 0) fetchEnergy().catch(()=>{}) } }, 1000)

  _onAuthChanged = () => { fetchEnergy().catch(()=>{}); fetchMembership().catch(()=>{}) }
  window.addEventListener('auth-changed', _onAuthChanged)
})

onBeforeUnmount(() => {
  if (_energyPollTimer) { clearInterval(_energyPollTimer); _energyPollTimer = null }
  if (_tickTimer) { clearInterval(_tickTimer); _tickTimer = null }
  if (_onAuthChanged) window.removeEventListener('auth-changed', _onAuthChanged)
})
</script>

<style scoped>
/* 强制黑底、白字，且覆盖任何全局冲突 */
.mapnav-root {
  background-color: #000 !important;
  /* color: #fff !important; */
  padding: 18px 16px 12px !important;
  position: relative;
}

/* hero 标题定位与样式 */
.lib-hero {
  position: relative; 
  z-index: 2; 
  height: 92px; 
  padding: 0; 
  background: transparent !important; 
  border: none !important; 
  box-shadow: none !important; 
}

/* 白色 1px 条带：位于标题与下面按钮之间 */
.lib-hero::after {
  content: "";
  position: absolute;
  left: 33%;
  right: 33%;
  bottom: 6px; /* 微调位置，确保位于标题下方并在 buttons 上方 */
  height: 1px;
  background: #ffffff;
  opacity: 1;
  pointer-events: none;
}

/* 渐变文字：线性渐变 + WebKit 背景裁切（主流浏览器支持） */
.hero-title {
  position: absolute;
  top: 18px;
  font-weight: 800;
  line-height: 1;
  font-size: 40px;
  height: 56px;
  display: flex;
  align-items: center;
  justify-content: center;
  transform: translateX(-50%);
  white-space: nowrap;

  /* --- 渐变文字相关 --- */
  background: linear-gradient(90deg, #0e78e9 0%, #c63be9 100%);
  -webkit-background-clip: text; /* 必需（Chrome、Safari） */
  -webkit-text-fill-color: transparent; /* 必需（Chrome、Safari） */

  /* 为 Firefox 提供兼容（较新 Firefox 支持 background-clip:text without prefix） */
  background-clip: text;
  color: transparent; /* 回退到透明以配合 background-clip */
}
.hero-left { left: 35%; }
.hero-right { left: 65%; }

/* controls layout */
.controls { z-index:2; display:flex; gap:12px; align-items:center; }

/* pills */
.pill {
  display: inline-flex !important;
  align-items: center;
  justify-content: center;
  padding: 8px 12px;
  border-radius: 999px;
  cursor: pointer;
  font-weight: 700;
  background: transparent !important;
  color: #fff !important;
  border: 1px solid #8b5cf6 !important;
  transition: transform .12s ease, box-shadow .12s ease, color .12s, background .12s;
  opacity: 1 !important;
}
.pill:not(.active):hover {
  background: linear-gradient(180deg, #f1eaff, #f7eefe) !important;
  color: #1f0346 !important;
  border-color: rgba(139,92,246,0.18) !important;
  box-shadow: 0 8px 20px rgba(139,92,246,0.06) !important;
  transform: translateY(-3px)
}
.pill.active {
  background: linear-gradient(180deg,#8b5cf6,#6d28d9) !important;
  color: #fff !important;
  border-color: rgba(255,255,255,0.06) !important;
  box-shadow: 0 10px 28px rgba(109,40,217,0.18) !important;
  transform: translateY(-3px)
}

/* stage buttons: ensure child elements get color changes on hover/active */
.stage-btn {
  display:flex;
  flex-direction:column;
  gap:6px;
  min-width: 180px;
  align-items:flex-start;
  padding:12px;
  opacity: 1 !important;
  border-radius: 12px;
  background: transparent !important;
  color: #fff !important;
  border: 1px solid #8b5cf6 !important;
  transition: background .12s ease, color .12s ease, box-shadow .12s ease, transform .12s ease;
}

/* hover: background 浅紫 AND 明确设置子元素颜色 */
.stage-btn:not(.active):hover {
  background: linear-gradient(180deg, #f1eaff, #f7eefe) !important;
  border-color: rgba(139,92,246,0.12) !important;
  box-shadow: 0 12px 30px rgba(139,92,246,0.06) !important;
  transform: translateY(-5px);
}
.stage-btn:not(.active):hover .stage-title,
.stage-btn:not(.active):hover .stage-sub {
  color: #1f0346 !important;
}

/* active: exact gradient + enforce white text on children */
.stage-btn.active {
  background: linear-gradient(180deg,#8b5cf6,#6d28d9) !important;
  color: #fff !important;
  border-color: rgba(139,92,246,0.22) !important;
  transform: translateY(-6px);
  box-shadow: 0 18px 48px rgba(109,40,217,0.14) !important;
}
.stage-btn.active .stage-title,
.stage-btn.active .stage-sub {
  color: #fff !important;
}

/* stage child elements default */
.stage-title { font-weight: 800; color: #fff !important; }
.stage-sub { font-size: 13px; color: #d1d5db !important; }

/* energy panel and misc (kept dark/white) */
.energy-panel { display:flex; align-items:center; gap:10px; padding:6px 8px; border-radius:10px; cursor:pointer; user-select:none; transition: transform .12s ease, box-shadow .12s ease; background: rgba(176, 176, 176, 0.321) !important; border: 1px solid rgba(255,255,255,0.04) !important; color: #fff !important; }
.energy-panel:hover { transform: translateY(-2px) !important; box-shadow: 0 10px 20px rgba(255,255,255,0.02) !important; }
.battery { position: relative; width: 46px; height: 22px; display:flex; align-items:center; overflow: hidden; box-sizing: border-box; }
.battery-body { width: 36px; height: 22px; border-radius: 4px; border: 2px solid rgba(255,255,255,0.12); position: relative; background: rgba(255,255,255,0.08); overflow:hidden; }
/* 默认电池填充（绿色） */
.battery-fill { position:absolute; left:0; top:0; bottom:0; width:0%; transition: width 0.6s ease; background: linear-gradient(90deg,#22c55e,#10b981); }

/* 低电量（非 VIP 且 <=20%）时改成红色渐变 */
.energy-panel.low .battery-fill { background: linear-gradient(90deg,#ef4444,#f97316); }

/* VIP：电池与文字变金色 */
.energy-panel.vip .battery-body { border-color: rgba(212,175,55,0.25); background: rgba(212,175,55,0.06); }
.energy-panel.vip .battery-fill { background: linear-gradient(90deg,#D4AF37,#FBBF24); }
.energy-panel.vip .energy-text { color: #D4AF37 !important; }
.energy-panel.vip .energy-numbers { color: #D4AF37 !important; }
.energy-panel.vip .energy-infinite { color: #D4AF37 !important; }

/* 非 VIP：文字强制黑色（按钮/面板仍保持暗色背景），电池填充保持绿色（或 low 时的红色） */
.energy-panel:not(.vip) .energy-text { color: #ffffff !important; }
.energy-panel:not(.vip) .energy-numbers { color: #ffffff !important; }

/* infinite 符号在 VIP 下更醒目 */
.energy-infinite { font-size:18px; color:#fbbf24; font-weight:900; }

/* focus */
.pill:focus, .btn-white:focus, .stage-btn:focus { outline: 3px solid rgba(139,92,246,0.18) !important; outline-offset: 2px; border-radius: 10px; }

 /* --------------------------- */
 /* PAD (641px — 1023px) 调整   */
 /* --------------------------- */
@media (min-width: 641px) and (max-width: 1023px) {
  .lib-hero { height: 78px; }
  .hero-title { font-size: 32px; height: 44px; top: 14px; }
  .lib-hero::after { left: 18%; right: 18%; bottom: 6px; }
  .hero-left { left: 30%; }
  .hero-right { left: 70%; }

  .controls { gap:10px; }

  .pill { padding: 6px 10px; font-size: 14px; border-width: 1px; }
  .pill:not(.active):hover { transform: translateY(-2px) }

  .stage-btn { min-width: 150px; padding: 10px; gap: 5px; border-radius: 10px; }
  .stage-title { font-size: 18px; }
  .stage-sub { font-size: 12px; }

  .stages-list { gap: 12px; }

  .energy-panel { padding: 5px 7px; gap: 8px; }
  .battery { width: 40px; height: 20px; }
  .battery-body { width: 32px; height: 20px; border-radius: 4px; }
  .energy-numbers { font-size: 12px; }
  .energy-infinite { font-size: 16px; }
}
</style>