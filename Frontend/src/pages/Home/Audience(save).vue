<template>
  <div ref="rootEl">
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
  </div>
</template>

<script setup>
/* Audience: 负责 audience 区块的 reveal 与图片 lazy 功能（作用域限定在本组件内） */
import { ref, onMounted, onBeforeUnmount } from 'vue'

const rootEl = ref(null)
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
  const root = rootEl.value || document
  const reveals = Array.from((root).querySelectorAll('.audience-section .reveal'))
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
  const root = rootEl.value || document
  const reveals = Array.from((root).querySelectorAll('.audience-section .reveal'))
  if (!reveals.length) return
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
  if ('IntersectionObserver' in window) {
    const bottomOffset = Math.round((1 - TRIGGER_MARGIN) * 100); const rootMargin = `0px 0px -${bottomOffset}% 0px`
    io = new IntersectionObserver(() => { updateRevealByDOMCheck() }, { root: null, rootMargin, threshold: [0, 0.05, 0.2] })
    reveals.forEach(el => io.observe(el))
  }
  window.addEventListener('scroll', onScroll, { passive: true }); window.addEventListener('resize', onScroll, { passive: true })
}

onMounted(() => {
  initRevealObserver()
  if (!ticking) { ticking = true; rafId = window.requestAnimationFrame(updateRevealByDOMCheck) }
})
onBeforeUnmount(() => {
  if (io) { try { io.disconnect() } catch (e) {} ; io = null }
  window.removeEventListener('scroll', onScroll); window.removeEventListener('resize', onScroll)
  if (rafId) { cancelAnimationFrame(rafId); rafId = null }
})
</script>

<style scoped>
/* Audience 局部样式（从原 Home.vue 中抽取） */
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
</style>