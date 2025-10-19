<template>
  <div>
    <!-- HERO（全屏） -->
    <section class="hero-section">
      <!-- 使用 WavyBackground 组件作为背景 -->
      <WavyBackground class="hero-wavy" v-if="showWavy" />
      <div class="hero-inner">
        <h1 class="hero-title reveal">YProgram</h1>
        <p class="hero-sub reveal">人人都能上手的编程学习平台</p>

        <div class="hero-actions">
          <a href="/map" class="btn-main">开始学习</a>

          <div v-if="isLogged" class="auth-actions">
            <button class="btn-secondary" @click="goProfile">个人：{{ userDisplayName }}</button>
            <button class="btn-secondary" @click="logout">登出</button>
          </div>

          <div v-else class="auth-actions">
            <button class="btn-secondary" @click="openLogin">登录 / 注册</button>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
/* eslint-disable no-undef */
/* Hero.vue: 用 WavyBackground 组件作为背景（假设你已把 WavyBackground.vue 放在 components/ui） */
import { ref, computed, onMounted, onBeforeUnmount, nextTick } from 'vue'
import { useRouter } from 'vue-router'
import { useUIStore } from '../../stores/ui'
import WavyBackground from '../../components/ui/wavy-background/WavyBackground.vue' // <- 如路径不同请调整

/* ---------------- auth / profile（保持你原来的逻辑） ---------------- */
const router = useRouter()
const ui = useUIStore()

const storedToken = ref(localStorage.getItem('yp_token') || null)
const storedUser = ref(null)
try { storedUser.value = localStorage.getItem('yp_user') ? JSON.parse(localStorage.getItem('yp_user')) : null } catch (e) { storedUser.value = null }
const isLogged = computed(() => !!storedToken.value)
const userDisplayName = computed(() => storedUser.value?.username || '用户')

function logout() {
  localStorage.removeItem('yp_token'); localStorage.removeItem('yp_user'); storedToken.value = null; storedUser.value = null; router.push('/')
}
function goProfile() { router.push('/profile') }
function openLogin() { try { ui.openLogin && ui.openLogin() } catch (e) {} }
function windowOpenHandler(){ try { ui.openLogin && ui.openLogin() } catch(e){} }
function handleAuthChanged(){ storedToken.value = localStorage.getItem('yp_token') || null; try { storedUser.value = localStorage.getItem('yp_user') ? JSON.parse(localStorage.getItem('yp_user')) : null } catch(e){ storedUser.value = null } }

/* -------------------- reveal（Hero 区块内的 .reveal 管理） --------------------*/
const TRIGGER_MARGIN = 0.10
const TEXT_DELAY = 0.18
let io = null
let rafId = null
let ticking = false
const lastScrollY = ref(typeof window !== 'undefined' ? window.scrollY : 0)

function isVisibleAtMargin(el, margin = TRIGGER_MARGIN) {
  if (!el || !el.getBoundingClientRect) return false
  const r = el.getBoundingClientRect(); const vh = window.innerHeight || document.documentElement.clientHeight
  const intersects = r.bottom > 0 && r.top < vh; if (!intersects) return false
  const topTrigger = r.top <= vh * (1 - margin) && r.bottom > 0
  const bottomTrigger = r.bottom >= vh * margin && r.top < vh
  return topTrigger || bottomTrigger
}
function showReveal(el, direction) {
  if (!el) return
  const translate = direction === 'down' ? '20px' : '-20px'
  el.style.setProperty('--reveal-translate', translate); el.style.setProperty('--reveal-delay', `${TEXT_DELAY}s`)
  el.classList.add('reveal--active')
}
function hideReveal(el) {
  if (!el) return
  el.classList.remove('reveal--active'); el.style.removeProperty('--reveal-translate'); el.style.removeProperty('--reveal-delay')
}
function updateRevealByDOMCheck() {
  const reveals = Array.from(document.querySelectorAll('.hero-section .reveal'))
  const currentScroll = window.scrollY || 0
  const direction = currentScroll > lastScrollY.value ? 'down' : 'up'
  reveals.forEach(el => {
    if (isVisibleAtMargin(el, TRIGGER_MARGIN)) showReveal(el, direction)
    else hideReveal(el)
  })
  lastScrollY.value = currentScroll; ticking = false
}
function onScroll() { if (!ticking) { ticking = true; rafId = window.requestAnimationFrame(updateRevealByDOMCheck) } }
function initRevealObserver() {
  const reveals = Array.from(document.querySelectorAll('.hero-section .reveal'))
  if (!reveals.length) return
  reveals.forEach(el => {
    const r = el.getBoundingClientRect()
    const intersects = r.bottom > 0 && r.top < (window.innerHeight || document.documentElement.clientHeight)
    if (intersects) el.classList.add('reveal--active')
    else el.classList.remove('reveal--active')
  })
  if ('IntersectionObserver' in window) {
    const bottomOffset = Math.round((1 - TRIGGER_MARGIN) * 100); const rootMargin = `0px 0px -${bottomOffset}% 0px`
    io = new IntersectionObserver((entries) => { updateRevealByDOMCheck() }, { root: null, rootMargin, threshold: [0, 0.05, 0.2] })
    reveals.forEach(el => io.observe(el))
  }
  window.addEventListener('scroll', onScroll, { passive: true }); window.addEventListener('resize', onScroll, { passive: true })
}

/* -------------------- Fluid Cursor 显示（延迟开启，避免首帧卡顿） -------------------- */
const showCursor = ref(false)
const showWavy = ref(false)

/* -------------------- 生命周期 -------------------- */
onMounted(() => {
  window.addEventListener('open-login-modal', windowOpenHandler)
  window.addEventListener('auth-changed', handleAuthChanged)
  window.addEventListener('storage', handleAuthChanged)

  initRevealObserver()
  if (!ticking) { ticking = true; rafId = window.requestAnimationFrame(updateRevealByDOMCheck) }

  // 延迟显示 cursor
  setTimeout(() => { showCursor.value = true }, 300)
  setTimeout(() => { showWavy.value = true }, 100)
})
onBeforeUnmount(() => {
  window.removeEventListener('open-login-modal', windowOpenHandler)
  window.removeEventListener('auth-changed', handleAuthChanged)
  window.removeEventListener('storage', handleAuthChanged)
  if (io) { try { io.disconnect() } catch (e) {} ; io = null }
  window.removeEventListener('scroll', onScroll); window.removeEventListener('resize', onScroll)
  if (rafId) { cancelAnimationFrame(rafId); rafId = null }
})
</script>

<style scoped>
/* --------------------------
   HERO 基础（mobile-first）
   三档： <=640px | 641-1024px | >=1025px
   --------------------------*/

/* 基础容器 */
.hero-section {
  width: 100%;
  min-height: 100vh;
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
  padding: 3rem 1.25rem; /* mobile-first */
  overflow: hidden;
  background: transparent;
}

/* Wavy 背景覆盖 */
.hero-wavy {
  position: absolute;
  inset: 0;
  z-index: 0;
  pointer-events: none;
  width: 100%;
  height: 100%;
}

/* 内部容器 */
.hero-inner {
  position: relative;
  z-index: 3;
  max-width: 1100px;
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
}

/* ---------- mobile (<= 640px) ---------- */
.hero-title {
  font-size: 3.2rem;
  line-height: 1.02;
  font-weight: 800;
  margin: 0 0 0.4rem 0;
  background: linear-gradient(90deg, #0e78e9 0%, #ed3aed 100%);
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
}

.hero-sub {
  color: rgba(255,255,255,0.92);
  font-size: 1.05rem;
  margin: 0 0 1.6rem 0;
  max-width: 88%;
}

/* 按钮（mobile：竖直堆叠，触控友好） */
.hero-actions {
  display: flex;
  flex-direction: column;
  gap: 12px;
  width: 100%;
  align-items: center;
  justify-content: center;
}

.btn-main {
  display: inline-block;
  padding: 14px 28px;
  border-radius: 9999px;
  font-weight: 600;
  color: white;
  background: linear-gradient(90deg,#0e78e9 0%, #ed3aed 100%);
  box-shadow: 0 8px 22px rgba(124,58,237,0.14);
  transition: transform .18s, box-shadow .18s;
  text-decoration: none;
  width: calc(100% - 48px); /* 留白使按钮不过宽 */
  max-width: 420px;
}
.btn-main:hover { 
  transform: translateY(-3px); 
  box-shadow: 0 14px 36px rgba(124,58,237,0.18); 
  background: linear-gradient(0deg,#0e78e9 0%, #ed3aed 100%);
}

.btn-secondary {
  display: inline-block;
  padding: 12px 20px;
  border-radius: 9999px;
  font-weight: 500;
  background: rgba(255,255,255,0.92);
  backdrop-filter: blur(6px);
  border: 1px solid rgba(15,23,42,0.06);
  color: #0f172a;
  transition: transform .12s;
  width: auto;
  white-space: nowrap; /* 关键属性：禁止换行 */
}
.btn-secondary:hover { 
  transform: translateY(-2px); 
  box-shadow: 0 8px 20px rgba(2,6,23,0.04);
  background: rgb(213, 213, 213);
  white-space: nowrap;
}

/* 小屏时把 auth-actions 放在 actions 中间（和按钮一起） */
.auth-actions { display: flex; flex-direction: column; gap: 10px; align-items: center; }

/* Reveal helper (Hero 局部) */
.reveal { opacity:1; transform:none; clip-path:none; transition: opacity 420ms cubic-bezier(.2,.9,.2,1), transform 420ms cubic-bezier(.2,.9,.2,1), clip-path 420ms cubic-bezier(.2,.9,.2,1); }
.home-root.js-enabled .reveal { opacity:0; transform: translateY(var(--reveal-translate, 20px)); clip-path: inset(0 0 100% 0); transition-delay: var(--reveal-delay, 0s); }
.home-root.js-enabled .reveal.reveal--active { opacity:1; transform: translateY(0); clip-path: inset(0 0 0 0); transition-delay: var(--reveal-delay, 0s); }

/* ---------- tablet (641px - 1024px) ---------- */
@media (min-width: 641px) and (max-width: 1024px) {
  .hero-section { padding: 4rem 2rem; }
  .hero-inner { max-width: 1200px; }

  .hero-title {
    font-size: 4.8rem;
    margin-bottom: 0.5rem;
  }
  .hero-sub {
    font-size: 1.25rem;
    margin-bottom: 2rem;
    max-width: 80%;
  }

  /* hero-actions: 横排但可换行 */
  .hero-actions {
    width: auto;
    flex-direction: row;
    gap: 12px;
    align-items: center;
    justify-content: center;
    flex-wrap: wrap; /* 允许换行，避免重叠 */
  }

  .btn-main {
    padding: 16px 34px;
    width: auto;
    min-width: 160px;
  }
  .btn-secondary {
    padding: 12px 20px;
    width: auto;
    min-width: 120px;
  }
  .auth-actions { flex-direction: row; gap: 8px; }
}

/* ---------- desktop (>= 1025px) ---------- */
@media (min-width: 1025px) {
  .hero-section { padding: 6rem 3.5rem; }
  .hero-inner { max-width: 1280px; }

  .hero-title {
    font-size: 6rem;
    margin-bottom: 0.6rem;
  }
  .hero-sub {
    color: rgba(255,255,255,0.85);
    font-size: 1.5rem;
    margin-bottom: 4rem;
    max-width: 72%;
  }

  /* hero-actions 横排 */
  .hero-actions {
    flex-direction: row;
    gap: 18px;
    align-items: center;
    justify-content: center;
  }

  .btn-main {
    padding: 18px 42px;
    box-shadow: 0 10px 30px rgba(124,58,237,0.18);
    width: auto;
  }
  .btn-secondary {
    padding: 14px 26px;
    margin-top: 0;
    width: auto;
  }
  .auth-actions { flex-direction: row; gap: 12px; }
}

/* 可访问性：减少动画 */
@media (prefers-reduced-motion: reduce) {
  * { transition: none !important; animation: none !important; }
}
</style>