<template>
  <div class="home-root">
    <!-- FluidCursor 放在这里，保证覆盖全页面 -->
    <FluidCursor v-if="showCursor" />

    <!-- HERO（全屏） -->
    <section class="hero-section">
      <div class="hero-bg-static" aria-hidden="true"></div>

      <div class="hero-inner">
        <h1 class="hero-title reveal">YProgram</h1>
        <p class="hero-sub reveal">人人都能上手的编程学习平台</p>

        <div class="hero-actions">
          <a href="/map" class="btn-main">开始学习</a>

          <div v-if="isLogged" class="flex gap-4">
            <button class="btn-secondary" @click="goProfile">个人：{{ userDisplayName }}</button>
            <button class="btn-secondary" @click="logout">登出</button>
          </div>

          <div v-else>
            <button class="btn-secondary" @click="ui.openLogin()">登录 / 注册</button>
          </div>
        </div>
      </div>
    </section>

    <!-- 省略中间若干受众区块（保持你原来的展示） -->
    <!-- 1. 学生 -->
    <section class="audience-section audience-student" data-overlay="dark" aria-label="学生">
      <picture class="bg-picture" aria-hidden="true">
        <source data-srcset="/student-480.jpg 480w, /student-800.jpg 800w, /student-1200.jpg 1200w"
                sizes="(max-width:640px) 480px, (max-width:1024px) 800px, 1200px" />
        <img
          class="bg-image"
          alt="学生背景"
          loading="lazy"
          src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw=="
          data-src="/student.jpg"
          data-srcset="/student-480.jpg 480w, /student-800.jpg 800w, /student-1200.jpg 1200w"
        />
      </picture>

      <div class="audience-inner">
        <div class="reveal-text">
          <h2 class="audience-title reveal">🎓 学生</h2>
          <p class="audience-subtitle reveal">怎么学都学不会？</p>
          <p class="audience-subtitle reveal">海量题库、别出心裁的刷题方式，帮你稳拿高分。</p>
        </div>

        <a href="/map" class="btn-explore">去体验</a>
      </div>
    </section>

    <!-- 2. 求职者 -->
    <section class="audience-section audience-jobhunter" data-overlay="dark" aria-label="求职者">
      <picture class="bg-picture" aria-hidden="true">
        <source data-srcset="/jobhunter-480.jpg 480w, /jobhunter-800.jpg 800w, /jobhunter-1200.jpg 1200w"
                sizes="(max-width:640px) 480px, (max-width:1024px) 800px, 1200px" />
        <img
          class="bg-image"
          alt="求职者背景"
          loading="lazy"
          src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw=="
          data-src="/jobhunter.jpg"
          data-srcset="/jobhunter-480.jpg 480w, /jobhunter-800.jpg 800w, /jobhunter-1200.jpg 1200w"
        />
      </picture>

      <div class="audience-inner">
        <div class="reveal-text">
          <h2 class="audience-title reveal">🔎 求职者</h2>
          <p class="audience-subtitle reveal">找工作怕技能不够？</p>
          <p class="audience-subtitle reveal">帮助你从投简历到拿 Offer 更自信。</p>
        </div>

        <a href="/map" class="btn-explore">去体验</a>
      </div>
    </section>

    <!-- 3. 就业者（worker） -->
    <section class="audience-section audience-worker" data-overlay="dark" aria-label="就业者">
      <picture class="bg-picture" aria-hidden="true">
        <source data-srcset="/worker-480.jpg 480w, /worker-800.jpg 800w, /worker-1200.jpg 1200w"
                sizes="(max-width:640px) 480px, (max-width:1024px) 800px, 1200px" />
        <img
          class="bg-image"
          alt="就业者背景"
          loading="lazy"
          src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw=="
          data-src="/worker.jpg"
          data-srcset="/worker-480.jpg 480w, /worker-800.jpg 800w, /worker-1200.jpg 1200w"
        />
      </picture>

      <div class="audience-inner">
        <div class="reveal-text">
          <h2 class="audience-title reveal">💼 就业者</h2>
          <p class="audience-subtitle reveal">工作中困难无法解决？</p>
          <p class="audience-subtitle reveal">尝试使用编程工具，帮助你创新性提高效率。</p>
        </div>

        <a href="/map" class="btn-explore">去体验</a>
      </div>
    </section>

    <!-- 4. 长者 -->
    <section class="audience-section audience-elderly" data-overlay="dark" aria-label="长者">
      <picture class="bg-picture" aria-hidden="true">
        <source data-srcset="/elderly-480.jpg 480w, /elderly-800.jpg 800w, /elderly-1200.jpg 1200w"
                sizes="(max-width:640px) 480px, (max-width:1024px) 800px, 1200px" />
        <img
          class="bg-image"
          alt="长者背景"
          loading="lazy"
          src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw=="
          data-src="/elderly.jpg"
          data-srcset="/elderly-480.jpg 480w, /elderly-800.jpg 800w, /elderly-1200.jpg 1200w"
        />
      </picture>

      <div class="audience-inner">
        <div class="reveal-text">
          <h2 class="audience-title reveal">🧓 长者</h2>
          <p class="audience-subtitle reveal">有点跟不上时代？</p>
          <p class="audience-subtitle reveal">从入门到趣味项目、循序渐进，让你也能与时俱进。</p>
        </div>

        <a href="/map" class="btn-explore">去体验</a>
      </div>
    </section>

    <!-- 5. 幼儿 -->
    <section class="audience-section audience-children" data-overlay="dark" aria-label="幼儿">
      <picture class="bg-picture" aria-hidden="true">
        <source data-srcset="/children-480.jpg 480w, /children-800.jpg 800w, /children-1200.jpg 1200w"
                sizes="(max-width:640px) 480px, (max-width:1024px) 800px, 1200px" />
        <img
          class="bg-image"
          alt="幼儿背景"
          loading="lazy"
          src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw=="
          data-src="/children.jpg"
          data-srcset="/children-480.jpg 480w, /children-800.jpg 800w, /children-1200.jpg 1200w"
        />
      </picture>

      <div class="audience-inner">
        <div class="reveal-text">
          <h2 class="audience-title reveal">🧸 幼儿</h2>
          <p class="audience-subtitle reveal">从小培养学习兴趣？</p>
          <p class="audience-subtitle reveal">有趣的可视化编程与交互，让孩子在游戏中学会逻辑与创造。</p>
        </div>

        <a href="/map" class="btn-explore">去体验</a>
      </div>
    </section>

    <!-- features carousel (你的已有模块，未改动) -->
    <section class="features-section" aria-label="网站特色">
      <div class="features-inner">
        <h2 class="features-heading reveal">✨ 我们的特色</h2>
        <p class="features-sub reveal">专为不同年龄与场景设计的学习体验</p>

        <div
          ref="carouselRef"
          class="carousel"
          @pointerdown.prevent="onPointerDown"
          @pointerup="onPointerUp"
          @pointercancel="onPointerUp"
          @pointerleave="onPointerLeave"
          @mouseenter="pauseAutoPlay"
          @mouseleave="resumeAutoPlay"
          @touchstart.prevent="onPointerDown"
          @touchend="onPointerUp"
        >
          <button class="carousel-nav left" @click="prev" aria-label="上一项">‹</button>

          <div class="carousel-track" :style="{ '--count': carouselItems.length }">
            <div
              v-for="(item, i) in carouselItems"
              :key="item.id"
              class="card"
              :class="{ 'is-center': i === currentIndex }"
              :style="cardStyle(i)"
              @click="onCardClick(i)"
              role="button"
              tabindex="0"
            >
              <div class="card-media" :aria-hidden="true">
                <img v-if="item.img" :src="item.img" :alt="item.title" />
              </div>
              <div class="card-body">
                <h3 class="card-title">{{ item.title }}</h3>
                <p class="card-desc">{{ item.desc }}</p>
              </div>
            </div>
          </div>

          <button class="carousel-nav right" @click="next" aria-label="下一项">›</button>
        </div>

      </div>
    </section>

    <!-- =================== DEMO: 联动模块（根据 carousel 当前项切换内容） =================== -->
    <section class="demo-section" aria-label="联动示例/3秒上手">
      <div class="demo-inner">
        <!-- 左侧 -->
        <div class="demo-left">
          <h2 class="demo-title reveal">{{ demoHeading }}</h2>
          <p class="demo-sub reveal">{{ demoSub }}</p>

          <!-- Runner: 现在只使用最简单的 textarea 编辑器 -->
          <div v-if="showRunner" class="runner-block">
            <div class="demo-controls">
              <label class="demo-label">
                语言：
                <select v-model="demoLang" @change="onLangChange">
                  <option value="python">Python</option>
                  <option value="cpp">C++</option>
                </select>
              </label>

              <div class="examples-list">
                <span class="example-note">示例：</span>
                <button v-for="ex in examplesForLang" :key="ex.id" class="example-btn" @click="loadExample(ex)">
                  {{ ex.title }}
                </button>
              </div>
            </div>

            <div class="demo-editor">
              <!-- 简单 textarea 编辑器（与 demoCode 直接绑定） -->
              <textarea v-model="demoCode" :disabled="isRunning" aria-label="代码编辑器"></textarea>
            </div>

            <div class="progress-bar" v-if="isRunning">
              <div class="progress-fill" :style="{ width: progress + '%' }"></div>
            </div>

            <div class="demo-actions">
              <button class="btn-main" @click="runDemo" :disabled="isRunning">
                <span v-if="!isRunning">运行 3 秒演示</span>
                <span v-else>运行中… {{ progressDisplay }}</span>
              </button>

              <button class="btn-secondary" @click="resetDemo" :disabled="isRunning">重置示例</button>
            </div>

            <div class="demo-output" aria-live="polite">
              <div class="output-label">输出（stdout）：</div>
              <pre class="output-area">{{ lastStdout }}</pre>

              <div class="output-label">错误输出（stderr）：</div>
              <pre class="output-area error">{{ lastStderr }}</pre>
            </div>
          </div>

          <!-- 否则：feature-readonly 展示 -->
          <div v-else class="feature-examples-block">
            <div v-if="featureExamplesForActive.length">
              <div v-for="(ex, idx) in featureExamplesForActive" :key="ex.id" class="feature-example">
                <h3 style="margin:0 0 6px 0;">{{ ex.title }}</h3>
                <pre style="white-space:pre-wrap; background:#0f172a08; padding:10px; border-radius:8px; border:1px solid rgba(15,23,42,0.04)">{{ ex.code }}</pre>
              </div>
            </div>
            <div v-else>
              <p>我们为该项准备了专属示例，敬请期待～</p>
            </div>
          </div>
        </div>

        <!-- 右侧 -->
        <div class="demo-right">
          <div class="demo-hint">
            <h3>{{ rightHintTitle }}</h3>
            <p>{{ rightHintText }}</p>
            <ul v-if="rightHintList && rightHintList.length">
              <li v-for="(li, i) in rightHintList" :key="i">{{ li }}</li>
            </ul>
          </div>
        </div>
      </div>
    </section>
    <!-- =================== DEMO END =================== -->

  </div>
</template>

<script setup>
/* eslint-disable no-undef */
import { ref, computed, onMounted, onBeforeUnmount, nextTick, watch } from 'vue'
import { useRouter } from 'vue-router'
import { useUIStore } from '../stores/ui'
import FluidCursor from '../components/ui/fluid-cursor/FluidCursor.vue'

const router = useRouter()
const ui = useUIStore()

// ---------------- 保留原有用户/身份逻辑（不改动） ----------------
const storedToken = ref(localStorage.getItem('yp_token') || null)
const storedUser = ref(null)
try { storedUser.value = localStorage.getItem('yp_user') ? JSON.parse(localStorage.getItem('yp_user')) : null } catch (e) { storedUser.value = null }
const isLogged = computed(() => !!storedToken.value)
const userDisplayName = computed(() => storedUser.value?.username || '用户')
function logout() {
  localStorage.removeItem('yp_token'); localStorage.removeItem('yp_user'); storedToken.value = null; storedUser.value = null; router.push('/')
}
function goProfile() { router.push('/profile') }
function windowOpenHandler(){ try { ui.openLogin && ui.openLogin() } catch(e){} }
function handleAuthChanged(){ storedToken.value = localStorage.getItem('yp_token') || null; try { storedUser.value = localStorage.getItem('yp_user') ? JSON.parse(localStorage.getItem('yp_user')) : null } catch(e){ storedUser.value = null } }

/* -------------------- reveal / image lazy（保持不变） --------------------*/
const TRIGGER_MARGIN = 0.10
const TEXT_DELAY = 0.18
const IMAGE_DELAY = 0.09
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
function ensureImageLoaded(img) {
  if (!img) return; if (img.dataset.loaded === '1') return
  const src = img.getAttribute('data-src'); const srcset = img.getAttribute('data-srcset')
  if (src) img.src = src; if (srcset) img.srcset = srcset
  img.dataset.loaded = '1'
  img.addEventListener('load', () => img.classList.add('image-loaded'), { once: true })
}
function preloadNextSectionImage(section) {
  if (!section) return
  const next = section.nextElementSibling
  if (!next || !next.classList) return
  const img = next.querySelector('.bg-image'); if (img) ensureImageLoaded(img)
}
function showReveal(el, direction) {
  if (!el) return
  const translate = direction === 'down' ? '20px' : '-20px'
  el.style.setProperty('--reveal-translate', translate); el.style.setProperty('--reveal-delay', `${TEXT_DELAY}s`)
  el.classList.add('reveal--active')
  const section = el.closest('.audience-section')
  if (section) {
    const img = section.querySelector('.bg-image')
    if (img) { ensureImageLoaded(img); img.style.setProperty('--img-delay', `${IMAGE_DELAY}s`); img.classList.add('image-visible') }
    preloadNextSectionImage(section)
  }
}
function hideReveal(el) {
  if (!el) return
  el.classList.remove('reveal--active'); el.style.removeProperty('--reveal-translate'); el.style.removeProperty('--reveal-delay')
  const section = el.closest('.audience-section')
  if (section) {
    const img = section.querySelector('.bg-image')
    if (img) { img.classList.remove('image-visible'); img.style.removeProperty('--img-delay') }
  }
}
function updateRevealByDOMCheck() {
  const reveals = Array.from(document.querySelectorAll('.reveal'))
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
  const rootEl = document.querySelector('.home-root') || document.documentElement
  const reveals = Array.from(document.querySelectorAll('.reveal'))
  if (!reveals.length) { rootEl.classList.add('js-enabled'); return }
  reveals.forEach(el => {
    const r = el.getBoundingClientRect()
    const intersects = r.bottom > 0 && r.top < (window.innerHeight || document.documentElement.clientHeight)
    if (intersects) {
      el.classList.add('reveal--active')
      const section = el.closest('.audience-section')
      if (section) {
        const img = section.querySelector('.bg-image')
        if (img) { ensureImageLoaded(img); img.classList.add('image-visible'); preloadNextSectionImage(section) }
      }
    } else el.classList.remove('reveal--active')
  })
  rootEl.classList.add('js-enabled')
  if ('IntersectionObserver' in window) {
    const bottomOffset = Math.round((1 - TRIGGER_MARGIN) * 100); const rootMargin = `0px 0px -${bottomOffset}% 0px`
    io = new IntersectionObserver((entries) => { updateRevealByDOMCheck() }, { root: null, rootMargin, threshold: [0, 0.05, 0.2] })
    reveals.forEach(el => io.observe(el))
  }
  window.addEventListener('scroll', onScroll, { passive: true }); window.addEventListener('resize', onScroll, { passive: true })
}
onMounted(() => {
  window.addEventListener('open-login-modal', windowOpenHandler)
  window.addEventListener('auth-changed', handleAuthChanged)
  window.addEventListener('storage', handleAuthChanged)
  initRevealObserver()
  if (!ticking) { ticking = true; rafId = window.requestAnimationFrame(updateRevealByDOMCheck) }
})
onBeforeUnmount(() => {
  window.removeEventListener('open-login-modal', windowOpenHandler)
  window.removeEventListener('auth-changed', handleAuthChanged)
  window.removeEventListener('storage', handleAuthChanged)
  if (io) { try { io.disconnect() } catch (e) {} ; io = null }
  window.removeEventListener('scroll', onScroll); window.removeEventListener('resize', onScroll)
  if (rafId) { cancelAnimationFrame(rafId); rafId = null }
})

/* -------------------- carousel 保留（几乎不变） -------------------- */
const carouselRef = ref(null)
const carouselItems = [
  { id: 1, title: '情景化教学', desc: '通过真实场景引入问题，让编程更加实用。', img: '' },
  { id: 2, title: '在线测评', desc: '不用下载任何软件，随时随地学编程。', img: '' },
  { id: 3, title: '交互任务', desc: '改变传统打代码式枯燥学习，采用选择题等多种题型。', img: '' },
  { id: 4, title: '每日打卡任务', desc: '每天积累10分钟，从量变到质变。', img: '' },
  { id: 5, title: '闯关式学习', desc: '学习进步可视化，让学习更有成就感。', img: '' },
  { id: 6, title: '好友助力', desc: '邀请好友一起学，学习更有动力。', img: '' }
]
const count = computed(() => carouselItems.length)
const currentIndex = ref(Math.floor(carouselItems.length / 2))
const isInteracting = ref(false)
let autoPlayTimer = null
let pointerActive = false
let startX = 0
let lastX = 0
let accumulatedDx = 0
const CARD_GAP = 260
const VISIBLE_OFFSET = 3
function cardStyle(i) {
  const idx = i; const center = currentIndex.value; const offset = idx - center; const absOff = Math.abs(offset)
  if (absOff > VISIBLE_OFFSET) {
    const tx = (offset > 0 ? 1 : -1) * CARD_GAP * VISIBLE_OFFSET * 0.8
    const scale = Math.max(0.6 - (absOff - VISIBLE_OFFSET) * 0.05, 0.5)
    return { transform: `translateX(${tx}px) translateZ(-${120 + (absOff - VISIBLE_OFFSET) * 40}px) scale(${scale}) rotateY(${(offset > 0 ? -8 : 8)}deg)`, zIndex: String(100 - absOff), opacity: '0.08', pointerEvents: 'none' }
  }
  const tx = offset * CARD_GAP; const tz = -Math.abs(offset) * 40; const scale = 1 - Math.abs(offset) * 0.12
  const rotateY = offset * -6; const zIndex = 200 - absOff; const opacity = 1 - Math.abs(offset) * 0.12
  return { transform: `translateX(${tx}px) translateZ(${tz}px) scale(${scale}) rotateY(${rotateY}deg)`, zIndex: String(zIndex), opacity: String(opacity), transition: 'transform 520ms cubic-bezier(.2,.9,.2,1), opacity 420ms ease' }
}
function startAutoPlay() { stopAutoPlay(); autoPlayTimer = setInterval(() => { if (!isInteracting.value) next() }, 2800) }
function stopAutoPlay() { if (autoPlayTimer) { clearInterval(autoPlayTimer); autoPlayTimer = null } }
function pauseAutoPlay() { isInteracting.value = true }
function resumeAutoPlay() { isInteracting.value = false }
function prev() { currentIndex.value = (currentIndex.value - 1 + count.value) % count.value }
function next() { currentIndex.value = (currentIndex.value + 1) % count.value }
function onPointerDown(e) {
  pointerActive = true; isInteracting.value = true; stopAutoPlay()
  startX = e.type.startsWith('touch') ? e.touches?.[0]?.clientX || e.clientX : e.clientX
  lastX = startX; accumulatedDx = 0
  try { if (e.target.setPointerCapture) e.target.setPointerCapture(e.pointerId); document.addEventListener('pointermove', onPointerMove); document.addEventListener('touchmove', onPointerMove, { passive: false }) } catch (err) {}
}
function onPointerMove(e) {
  if (!pointerActive) return
  const clientX = e.type.startsWith('touch') ? (e.touches && e.touches[0] ? e.touches[0].clientX : e.clientX) : e.clientX
  accumulatedDx += clientX - lastX; lastX = clientX
  if (e.cancelable) e.preventDefault()
}
function onPointerUp(e) {
  if (!pointerActive) return
  pointerActive = false; isInteracting.value = false; resumeAutoPlay()
  try { document.removeEventListener('pointermove', onPointerMove); document.removeEventListener('touchmove', onPointerMove) } catch (err) {}
  const threshold = Math.min(window.innerWidth * 0.12, CARD_GAP / 2)
  if (accumulatedDx > threshold) prev(); else if (accumulatedDx < -threshold) next()
  accumulatedDx = 0
}
function onPointerLeave(e) { if (pointerActive) onPointerUp(e) }
function onCardClick(i) { if (i !== currentIndex.value) currentIndex.value = i }
onMounted(() => { nextTick(() => { startAutoPlay() }) })
onBeforeUnmount(() => { stopAutoPlay() })

/* =================== DEMO: 简化版编辑器 + 预置示例 =================== */

/* demo 状态（保留名字以兼容模板） */
const demoLang = ref('python')
const demoCode = ref(`# Python 示例：打印问候\nprint("Hello from YProgram!")\n`)
const demoStdin = ref('')
const lastStdout = ref('')
const lastStderr = ref('')
const isRunning = ref(false)
const progress = ref(0)
const progressDisplay = computed(() => `${Math.round(progress.value)}%`)

/* 预置示例 */
const EXAMPLES = [
  { id: 'py-print', lang: 'python', title: '打印', code: `# 输出一行文字\nprint("Hello, YProgram!")\n` },
  { id: 'py-loop', lang: 'python', title: '循环', code: `# 循环打印 5 次\nfor i in range(5):\n    print("第", i, "次")\n` },
  { id: 'py-algo', lang: 'python', title: '简单算法（列表求和）', code: `# 求一个列表中所有数字的和\nnums = [1,2,3,4,5]\nprint(sum(nums))\n` },
  { id: 'py-if', lang: 'python', title: '条件判断', code: `# 条件判断示例\nx = 10\nif x % 2 == 0:\n    print("x 是偶数")\nelse:\n    print("x 是奇数")\n` },

  { id: 'cpp-print', lang: 'cpp', title: '打印', code: `#include <iostream>\nusing namespace std;\nint main(){ cout << "Hello, YProgram!" << \"\\n\"; return 0; }\n` },
  { id: 'cpp-loop', lang: 'cpp', title: '循环', code: `#include <iostream>\nusing namespace std;\nint main(){ for(int i=0;i<5;i++) cout << "第 " << i << " 次\\n"; return 0; }\n` },
  { id: 'cpp-algo', lang: 'cpp', title: '简单算法（求和）', code: `#include <bits/stdc++.h>\nusing namespace std;\nint main(){ vector<int> v={1,2,3,4,5}; cout << accumulate(v.begin(), v.end(), 0) << \"\\n\"; return 0; }\n` },
  { id: 'cpp-if', lang: 'cpp', title: '条件判断', code: `#include <iostream>\nusing namespace std;\nint main(){ int x=10; if(x%2==0) cout<<\"x 是偶数\\n\"; else cout<<\"x 是奇数\\n\"; return 0; }\n` }
]
const examplesForLang = computed(() => EXAMPLES.filter(e => e.lang === demoLang.value))

/* featureExamples map（保持你原来的映射） */
const featureExamples = { 0: ['py-loop','py-if'], 1: ['py-print','py-algo'], 2: ['py-loop','cpp-loop'], 3: ['py-if','cpp-if'], 4: ['py-algo','cpp-algo'], 5: ['py-print','cpp-print'] }
const activeFeature = computed(() => { const idx = Number(currentIndex.value || 0); return carouselItems[idx] || carouselItems[0] })
const showRunner = computed(() => { return activeFeature.value && (activeFeature.value.title === '在线测评' || activeFeature.value.id === 2) })
const demoHeading = computed(() => { return showRunner.value ? '3 秒上手 · 试运行示例' : `${activeFeature.value?.title || ''} · 示例演示` })
const demoSub = computed(() => { return showRunner.value ? '无需配置，在线运行 Python / C++ 小示例，立刻看到结果。' : (activeFeature.value?.desc || '') })

const rightHintTitle = computed(() => { if (showRunner.value) return '为什么 3 秒演示？'; return `探索：${activeFeature.value?.title || ''}` })
const rightHintText = computed(() => {
  if (showRunner.value) return '快速得到输出，感受从写到运行的闭环：你会发现入门并不难。'
  switch (activeFeature.value?.id) {
    case 1: return '情景化教学：把问题放到真实场景，学得更自然。'
    case 2: return '在线测评：无缝连接题库与评测，实时反馈。'
    case 3: return '交互任务：动手做小任务，提升实践能力。'
    case 4: return '每日打卡：坚持才能看到进步，我们帮你记录。'
    case 5: return '闯关式学习：通过关卡设计激励学习。'
    default: return ''
  }
})
const rightHintList = computed(() => {
  if (showRunner.value) return ['支持 Python / C++（与后端沙箱一致）', '执行受限（超时与资源限制）以保证平台安全', '示例可直接替换成你的代码，方便体验']
  switch (activeFeature.value?.id) {
    case 0: return ['真实场景驱动问题', '案例导向，立刻上手']
    case 2: return ['任务驱动设计', '多种题型：选择/填空/代码']
    case 3: return ['短时见效，每天 10 分钟', '自动记录学习轨迹']
    case 4: return ['逐步解锁更难关卡', '成就系统激励学习']
    case 5: return ['合作学习，互相督促', '排行榜与奖励机制']
    default: return []
  }
})
const featureExamplesForActive = computed(() => {
  const idx = Number(currentIndex.value || 0); const ids = featureExamples[idx] || []
  return ids.map(id => EXAMPLES.find(e => e.id === id)).filter(Boolean)
})

/* ---------- 简化后的编辑器相关函数 ---------- */
function onLangChange() {
  // 如果用户没有修改过内容（仍为示例），切换语言时载入该语言的首个示例
  const userEdited = demoCode.value && !EXAMPLES.some(ex => ex.code === demoCode.value)
  if (!userEdited) {
    const first = EXAMPLES.find(e => e.lang === demoLang.value)
    if (first) { demoCode.value = first.code; demoStdin.value = first.stdin || '' }
  }
}

function loadExample(ex) {
  demoLang.value = ex.lang
  demoCode.value = ex.code || ''
  demoStdin.value = ex.stdin || ''
}

/* ---------- Demo 运行 / 进度（保持并完善） ---------- */
let _demoProgressTimer = null
let _demoRunStart = 0
function startProgress(minMs = 3000) {
  clearProgress()
  progress.value = 0
  _demoRunStart = Date.now()
  const start = _demoRunStart
  _demoProgressTimer = setInterval(() => {
    const elapsed = Date.now() - start
    if (elapsed < minMs) progress.value = Math.min(80, Math.round((elapsed / minMs) * 80))
    else { const extra = Math.min(15, Math.floor((elapsed - minMs) / 100)); progress.value = Math.min(95, 80 + extra) }
  }, 120)
}
function clearProgress() { if (_demoProgressTimer) { clearInterval(_demoProgressTimer); _demoProgressTimer = null } }
function completeProgress() { progress.value = 100; clearProgress(); setTimeout(() => { progress.value = 0 }, 420) }

async function runDemo(minDelay = 3000) {
  if (isRunning.value) return
  isRunning.value = true; lastStdout.value = ''; lastStderr.value = ''; progress.value = 0

  // 直接使用 demoCode（textarea 里的内容）
  const payload = { lang: demoLang.value, code: demoCode.value, ...(demoStdin.value ? { stdin: demoStdin.value } : {}) }

  startProgress(minDelay); _demoRunStart = Date.now()
  const controller = new AbortController(); const FETCH_TIMEOUT = 12000
  const timeoutId = setTimeout(() => controller.abort(), FETCH_TIMEOUT)

  try {
    const resp = await fetch('/api/exec', {
      method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(payload), signal: controller.signal
    })
    let data = {}
    try { data = await resp.json() } catch (jsonErr) { data = { error: 'invalid-json-response', stderr: await resp.text().catch(() => '') } }
    const elapsed = Date.now() - _demoRunStart; const remain = Math.max(0, minDelay - elapsed)
    if (remain > 0) await new Promise(r => setTimeout(r, remain))
    lastStdout.value = data.stdout || ''
    lastStderr.value = data.stderr || (data.error ? String(data.error) : '')
  } catch (err) {
    const elapsed2 = Date.now() - _demoRunStart; const remain2 = Math.max(0, minDelay - elapsed2)
    if (remain2 > 0) await new Promise(r => setTimeout(r, remain2))
    if (err.name === 'AbortError') { lastStdout.value = ''; lastStderr.value = '请求超时或已中止 (timeout)' }
    else { lastStdout.value = ''; lastStderr.value = err.message || String(err) }
  } finally {
    clearTimeout(timeoutId); completeProgress()
    setTimeout(() => { isRunning.value = false }, 220)
  }
}

function resetDemo() {
  if (isRunning.value) return
  const first = EXAMPLES.find(e => e.lang === demoLang.value)
  demoCode.value = first ? first.code : ''
  demoStdin.value = first ? (first.stdin || '') : ''
  lastStdout.value = ''; lastStderr.value = ''; progress.value = 0
}

/* ---------- 当 carousel currentIndex 变化时联动 demo（简化版） ---------- */
watch(currentIndex, (nv, ov) => {
  if (showRunner.value) {
    setTimeout(() => {
      // 尝试从 featureExamples 中挑选与当前语言匹配的示例
      const ids = featureExamples[Number(currentIndex.value)] || []
      if (ids && ids.length) {
        const ex = EXAMPLES.find(e => ids.includes(e.id) && e.lang === demoLang.value) || EXAMPLES.find(e => e.lang === demoLang.value)
        if (ex) loadExample(ex)
      }
    }, 220)
  }

  // 预加载对应的受众区图片
  const sections = Array.from(document.querySelectorAll('.audience-section'))
  const idx = Number(currentIndex.value || 0)
  const targetSection = sections[idx] || null
  if (targetSection) {
    const img = targetSection.querySelector('.bg-image'); if (img) ensureImageLoaded(img)
  }
})

/* ---------- 当 showRunner 变为 true ：载入示例（简化版） ---------- */
watch(showRunner, (v) => {
  if (v) {
    // 如果当前没有用户编辑过 demoCode，就载入一个合适的示例
    const ids = featureExamples[Number(currentIndex.value)] || []
    const ex = EXAMPLES.find(e => ids.includes(e.id) && e.lang === demoLang.value) || EXAMPLES.find(e => e.lang === demoLang.value)
    if (ex) loadExample(ex)
  }
})

/* -------------------- Fluid Cursor效果组件 --------------------*/
const showCursor = ref(false)
onMounted(() => {
  setTimeout(() => {
    showCursor.value = true
  }, 300)
})

</script>

<style scoped>
/* （样式保持你原来的样式 — 仅作了最小化必要兼容） */

/* ---------- 基础 & reset ---------- */
.home-root { width:100%; overflow-x:hidden; box-sizing:border-box; background:#fff; }

/* ---------- HERO ---------- */
.hero-section {
  width:100%;
  min-height:100vh;
  position:relative;
  display:flex;
  align-items:center;
  justify-content:center;
  text-align:center;
  padding:4rem 2.5rem;
  overflow:hidden;
}
.hero-bg-static { position:absolute; inset:0; z-index:0; background: linear-gradient(180deg, #f8fbff 0%, #ffffff 60%); }
.hero-inner { position:relative; z-index:3; max-width:1280px; width:100%; }

.hero-title {
  font-size:4.25rem; line-height:1; font-weight:800; margin-bottom:0.6rem;
  background: linear-gradient(90deg, #0ea5e9 0%, #7c3aed 100%);
  -webkit-background-clip: text; background-clip: text; color: transparent;
}
@media (min-width:768px) { .hero-title { font-size:6rem; } }
.hero-sub { color:#475569; font-size:1.125rem; margin-bottom:1.75rem; }
@media (min-width:768px) { .hero-sub { font-size:1.5rem; } }

.btn-main {
  display:inline-block; padding:18px 42px; border-radius:9999px; font-weight:600;
  color:white; background: linear-gradient(90deg,#0ea5e9 0%, #7c3aed 100%);
  box-shadow: 0 10px 30px rgba(124,58,237,0.18); transition: transform .18s, box-shadow .18s;
  text-decoration:none;
}
.btn-main:hover { transform: translateY(-4px); box-shadow: 0 18px 42px rgba(124,58,237,0.22); }
.btn-secondary { display:inline-block; padding:14px 26px; border-radius:9999px; font-weight:500;
  background: rgba(255,255,255,0.85); backdrop-filter: blur(6px); border:1px solid rgba(15,23,42,0.06); color:#0f172a; transition: transform .12s;
}
.btn-secondary:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(2,6,23,0.06); }

/* Audience sections（每块占满屏幕） */
.audience-section {
  width:100%; height:100vh; min-height:100vh; position:relative; display:flex; align-items:center;
  justify-content:center; text-align:center; padding:3.5rem; overflow:hidden; box-sizing:border-box;
}
.bg-picture { position:absolute; inset:0; z-index:0; pointer-events:none; }
.bg-picture .bg-image { width:100%; height:100%; object-fit:cover; display:block; opacity:0; transform: scale(1.03);
  transition: opacity 360ms ease, transform 360ms ease; transition-delay: var(--img-delay, 0s); }
.bg-picture .bg-image.image-visible { opacity:1; transform: scale(1); }

.audience-section[data-overlay="dark"]::before {
  content:""; position:absolute; inset:0; z-index:2; pointer-events:none;
  background: linear-gradient(180deg, rgba(0,0,0,0.36), rgba(0,0,0,0.12));
}
.audience-section[data-overlay="light"]::before {
  content:""; position:absolute; inset:0; z-index:2; pointer-events:none;
  background: linear-gradient(180deg, rgba(255,255,255,0.85), rgba(255,255,255,0.4));
}

.audience-inner { position:relative; z-index:3; max-width:1100px; width:100%; color:#fff; }
.audience-title { font-size:2.25rem; font-weight:700; margin-bottom:0.4rem; color:inherit; }
.audience-subtitle { font-size:1.05rem; margin-bottom:1rem; color:inherit; opacity:0.95; }
@media (min-width:768px) { .audience-title { font-size:3.5rem; } .audience-subtitle { font-size:1.25rem; } }

.btn-explore {
  display:inline-block; padding:12px 24px; border-radius:12px; font-weight:600;
  background: rgba(255,255,255,0.92); color:#0f172a; border:1px solid rgba(15,23,42,0.06);
  text-decoration:none; transition: transform .12s, box-shadow .12s; z-index:4;
}
.btn-explore:hover { transform: translateY(-3px); box-shadow: 0 8px 22px rgba(2,6,23,0.06); }

.reveal { opacity:1; transform:none; clip-path:none; transition: opacity 420ms cubic-bezier(.2,.9,.2,1), transform 420ms cubic-bezier(.2,.9,.2,1), clip-path 420ms cubic-bezier(.2,.9,.2,1); }
.home-root.js-enabled .reveal { opacity:0; transform: translateY(var(--reveal-translate, 20px)); clip-path: inset(0 0 100% 0); transition-delay: var(--reveal-delay, 0s); }
.home-root.js-enabled .reveal.reveal--active { opacity:1; transform: translateY(0); clip-path: inset(0 0 0 0); transition-delay: var(--reveal-delay, 0s); }

/* features carousel */
.features-section { width:100%; padding: 6rem 2rem; background: linear-gradient(180deg, #ffffff 0%, #fbfbff 100%); display:block; box-sizing:border-box; }
.features-inner { max-width:1200px; margin:0 auto; text-align:center; position:relative; }
.features-heading { font-size:2rem; font-weight:700; margin-bottom:0.25rem; color:#0f172a; }
.features-sub { color:#64748b; margin-bottom:1.25rem; }

.carousel { position:relative; margin-top: 1.25rem; height: 420px; perspective: 1400px; display:flex; align-items:center; justify-content:center; user-select:none; touch-action: pan-y; }
.carousel-track { position:relative; width:100%; height:100%; display:flex; align-items:center; justify-content:center; transform-style: preserve-3d; will-change: transform; overflow: visible; }
.card { position:absolute; width: 320px; max-width: 38vw; min-width: 260px; height: 360px; border-radius: 18px; background: linear-gradient(180deg,#ffffff,#f6f7ff); box-shadow: 0 20px 40px rgba(2,6,23,0.08); display:flex; flex-direction:column; align-items:flex-start; justify-content:flex-end; padding:18px; box-sizing:border-box; cursor:pointer; transition: transform 520ms cubic-bezier(.2,.9,.2,1), opacity 420ms ease, box-shadow 420ms ease; backface-visibility: hidden; }
.card.is-center { box-shadow: 0 30px 60px rgba(2,6,23,0.12); }
.card-media { position:absolute; inset:0; border-radius:18px; overflow:hidden; }
.card-media img { width:100%; height:100%; object-fit:cover; display:block; filter: saturate(1.02) contrast(0.98); }
.card-body { position:relative; z-index:3; color:#0f172a; text-align:left; width:100%; }
.card-title { font-size:1.15rem; font-weight:700; margin-bottom:8px; }
.card-desc { font-size:0.95rem; color:#334155; }
.carousel-nav { position:absolute; top:50%; width:44px; height:44px; border-radius:9999px; background:rgba(255,255,255,0.85); display:flex; align-items:center; justify-content:center; border:1px solid rgba(15,23,42,0.06); transform: translateY(-50%); cursor:pointer; z-index:999; font-size:22px; line-height:1; }
.carousel-nav.left { left:12px; } .carousel-nav.right { right:12px; }

/* DEMO */
.demo-section { width:100%; padding:64px 20px; background: linear-gradient(180deg,#fbfcff 0,#ffffff 100%); box-sizing:border-box; }
.demo-inner { max-width:1100px; margin:0 auto; display:flex; gap:24px; align-items:flex-start; }
.demo-left { flex:1 1 640px; } .demo-right { flex:0 0 320px; }

.demo-title { font-size:1.75rem; font-weight:800; margin-bottom:0.25rem; color:#0f172a; } .demo-sub { color:#475569; margin-bottom:1rem; }

.demo-controls { display:flex; gap:12px; align-items:center; margin-bottom:12px; flex-wrap:wrap; }
.demo-label { display:flex; gap:8px; align-items:center; color:#334155; }
.demo-label select { padding:8px 10px; border-radius:8px; border:1px solid rgba(15,23,42,0.06); background:white; }

.examples-list { display:flex; gap:8px; align-items:center; flex-wrap:wrap; margin-left:8px; }
.example-note { color:#475569; margin-right:8px; }
.example-btn { padding:8px 12px; border-radius:999px; border: 1px solid rgba(15,23,42,0.06); background: white; cursor:pointer; font-weight:600; color:#0f172a; }
.example-btn:hover { transform: translateY(-3px); box-shadow: 0 8px 20px rgba(2,6,23,0.04); }

/* Code editor textarea (简化版) */
.demo-editor textarea {
  width:100%;
  min-height:160px;
  border-radius:12px;
  border:1px solid rgba(15,23,42,0.06);
  padding:12px;
  font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, 'Roboto Mono', monospace;
  font-size:14px;
  resize:vertical;
  box-sizing:border-box;
  background:white;
}

/* progress */
.progress-bar { width:100%; height:8px; background:rgba(2,6,23,0.04); border-radius:99px; overflow:hidden; margin-top:8px; }
.progress-fill { height:100%; background: linear-gradient(90deg,#0ea5e9,#7c3aed); width:0%; transition: width 120ms linear; }

.demo-hint { background: linear-gradient(180deg,#ffffff,#fbfdff); border-radius:12px; padding:16px; box-shadow:0 14px 32px rgba(2,6,23,0.04); }
.demo-hint h3 { margin:0 0 8px 0; font-size:1.05rem; } .demo-hint p { margin:0 0 8px 0; color:#475569; } .demo-hint ul { margin:6px 0 0 18px; color:#475569; }

.output-label { font-weight:700; color:#0f172a; margin-top:8px; margin-bottom:6px; }
.output-area { background:#0f172a10; border-radius:8px; padding:12px; min-height:56px; white-space:pre-wrap; color:#0f172a; border:1px solid rgba(15,23,42,0.04); }
.output-area.error { color:#b91c1c; background:#fff1f2; border-color: rgba(185,28,28,0.06); }

.feature-example { margin-bottom:14px; }

@media (max-width:1024px) {
  .demo-inner { flex-direction:column; }
  .demo-right { order:2; width:100%; }
  .demo-left { width:100%; }
}

:root, .home-root, .hero-section, .audience-section { box-sizing: border-box; }
</style>