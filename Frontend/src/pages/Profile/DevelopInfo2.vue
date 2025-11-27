<template>
  <div class="develop-info-root">

    <!-- 开发者信息 -->
    <section class="section-block">
      <h2 class="section-title">开发者信息</h2>

      <div class="dev-row">
        <div
          v-for="dev in developers"
          :key="dev.id"
          class="dev-card"
          @click="toggleDetail(dev.id)"
          role="button"
          :aria-pressed="activeId === dev.id"
        >
          <img :src="avatarFor(dev)" class="dev-avatar" :alt="dev.name + ' 头像'" />
          <!-- name 和 role 同一行 -->
          <div class="name-role">
            <span class="dev-name">{{ dev.name }}</span>
            <span class="dev-role">· {{ dev.role }}</span>
          </div>
        </div>
      </div>

      <!-- 点击展开的详细信息（expand 动画） -->
      <transition name="expand">
        <div v-if="activeDev" class="detail-box" ref="detailBox">
          <div class="detail-top">
            <img :src="avatarFor(activeDev)" class="avatar-lg" :alt="activeDev.name + ' 头像'"/>
            <div class="detail-meta">
              <h3 class="detail-name">{{ activeDev.name }}</h3>
              <p class="detail-role">{{ activeDev.role }}</p>
              <p class="detail-desc" v-if="activeDev.desc">{{ activeDev.desc }}</p>
            </div>
          </div>

          <!-- 联系方式 / 社交 列表：前面有图标，可点击打开 -->
          <ul class="contact-list" v-if="activeDev.contacts && activeDev.contacts.length">
            <li v-for="c in activeDev.contacts" :key="c.type + c.label" class="contact-item">
              <a :href="c.url" target="_blank" rel="noopener" class="contact-link">
                <span class="icon" v-html="svgIcon(c.type)"></span>
                <span class="contact-label">{{ c.label }}</span>
              </a>
            </li>
          </ul>

        </div>
      </transition>
    </section>

    <!-- 特别感谢 -->
    <section class="section-block">
      <h2 class="section-title">特别感谢</h2>

      <div class="thanks-row">
        <div
          v-for="t in thanks"
          :key="t.id"
          class="thanks-card"
        >
          <div class="thanks-avatar-wrapper">
            <img :src="avatarFor(t)" class="thx-avatar" :alt="t.name + ' 头像'" />

            <!-- 悬停展示详细信息 -->
            <div class="hover-info">
              <div class="hover-title">{{ t.name }}</div>
              <div class="hover-note">{{ t.note }}</div>
            </div>
          </div>
          <div class="nickname">{{ t.name }}</div>
        </div>
      </div>
    </section>

    <!-- 联系我们 -->
    <section class="section-block">
      <h2 class="section-title">联系我们</h2>
      <p class="contact-text">
        如果你在使用过程中发现 Bug、功能异常或有新的建议，
        欢迎随时通过邮件联系我们：<br />
        <span class="email">support@yourdomain.com</span>
      </p>

      <!-- 版本号 -->
      <p class="version">版本：1.0.0</p>
    </section>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'

/* ------------------------
   数据区：每个开发者可包含 contacts 列表
   请根据需要替换为真实链接
   ------------------------ */

const developers = ref([
  {
    id: 'dev-leon',
    name: 'Leon Yeung',
    role: '前端工程师',
    desc: '负责任何你能想到的方面。',
    avatar: new URL('@/assets/avatars/LeonYeung.jpg', import.meta.url).href,
    contacts: [
      { type: 'email', label: 'leon@example.com', url: 'mailto:leon@example.com' },
      { type: 'github', label: 'github.com/leon', url: 'https://github.com/leon' },
      { type: 'x', label: '@leon', url: 'https://x.com/leon' },
      { type: 'website', label: '个人网站', url: 'https://your-website.example.com' }
    ]
  },
  {
    id: 'dev-chatgpt',
    name: 'ChatGPT',
    role: 'AI 助手',
    desc: '基于大型语言模型提供文档与代码辅助。',
    avatar: new URL('@/assets/avatars/ChatGPT.png', import.meta.url).href,
    contacts: [
      // ChatGPT 示例增加一个可打开的网址（可替换）
      { type: 'website', label: 'openai.com', url: 'https://openai.com/' }
    ]
  }
])

const thanks = ref([
  {
    id: 't-gemini',
    name: 'Gemini',
    note: '部分理念与模型灵感来源。',
    avatar: new URL('@/assets/avatars/gemini.png', import.meta.url).href,
  },
  {
    id: 't-oss',
    name: '开源社区',
    note: '大量 UI、交互、工具灵感均来自开源生态贡献者。',
    avatar: new URL('@/assets/avatars/opensource.png', import.meta.url).href,
  }
])

/* ------------------------
   头像生成：优先图片 → 否则字母头像
   ------------------------ */

function avatarFor(item) {
  if (item?.avatar) return item.avatar

  const name = item?.name || '?'
  const initials = name
    .split(/\s+/)
    .map(s => s.charAt(0).toUpperCase())
    .slice(0, 2)
    .join('')

  const bg = '#555'
  const fg = '#fff'

  const svg = `
    <svg xmlns='http://www.w3.org/2000/svg' width='240' height='240'>
      <rect width='100%' height='100%' fill='${bg}' rx='120'/>
      <text x='50%' y='52%' text-anchor='middle'
        font-family='Arial' font-size='96' fill='${fg}'
        dominant-baseline='middle'>${initials}</text>
    </svg>
  `
  return `data:image/svg+xml;utf8,${encodeURIComponent(svg)}`
}

/* ------------------------
   详情展开逻辑
   ------------------------ */
const activeId = ref(null)
const activeDev = computed(() =>
  developers.value.find(d => d.id === activeId.value)
)

function toggleDetail(id) {
  activeId.value = activeId.value === id ? null : id
}

/* ------------------------
   图标（内联 SVG）：返回字符串（用于 v-html）
   支持 type: 'email'|'github'|'x'|'website'
   如需其它图标，告诉我我可以再加入
   ------------------------ */
function svgIcon(type) {
  switch (type) {
    case 'email':
      return `<svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
        <path d="M3 8.5v7A2.5 2.5 0 0 0 5.5 18h13A2.5 2.5 0 0 0 21 15.5v-7" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
        <path d="M21 8.5l-9 6-9-6" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
      </svg>`
    case 'github':
      return `<svg width="18" height="18" viewBox="0 0 24 24" aria-hidden="true" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
        <path d="M12 .5C5.73.5.75 5.48.75 11.77c0 4.86 3.16 8.98 7.55 10.44.55.1.75-.24.75-.53 0-.26-.01-1.12-.02-2.02-3.07.67-3.72-1.48-3.72-1.48-.5-1.28-1.22-1.62-1.22-1.62-.99-.68.07-.67.07-.67 1.09.08 1.66 1.12 1.66 1.12.97 1.66 2.55 1.18 3.17.9.1-.7.38-1.18.69-1.45-2.45-.28-5.03-1.22-5.03-5.42 0-1.2.43-2.18 1.12-2.95-.11-.28-.49-1.4.11-2.92 0 0 .92-.3 3.02 1.12a10.35 10.35 0 0 1 2.75-.37c.93 0 1.87.13 2.75.38 2.09-1.42 3.01-1.12 3.01-1.12.61 1.53.23 2.65.11 2.93.7.77 1.12 1.75 1.12 2.95 0 4.21-2.59 5.13-5.05 5.4.39.33.74.98.74 1.98 0 1.43-.01 2.58-.01 2.93 0 .29.19.64.76.53 4.39-1.46 7.55-5.58 7.55-10.44C23.25 5.48 18.27.5 12 .5z"/>
      </svg>`
    case 'x':
      // 简化的 X 图标（代表 Twitter/X）
      return `<svg width="18" height="18" viewBox="0 0 24 24" aria-hidden="true" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
        <path d="M23 3.01a10.9 10.9 0 0 1-3.14.86A4.92 4.92 0 0 0 22.4.36a9.86 9.86 0 0 1-3.13 1.2 4.92 4.92 0 0 0-8.4 4.49A13.97 13.97 0 0 1 1.64.88a4.92 4.92 0 0 0 1.52 6.56 4.86 4.86 0 0 1-2.23-.62v.06a4.92 4.92 0 0 0 3.95 4.82 4.9 4.9 0 0 1-2.21.09 4.92 4.92 0 0 0 4.6 3.41A9.86 9.86 0 0 1 1 19.54 13.94 13.94 0 0 0 7.55 21c9.05 0 14.01-7.5 14.01-14 0-.21 0-.42-.02-.63A10 10 0 0 0 23 3.01z"/>
      </svg>`
    case 'website':
      return `<svg width="18" height="18" viewBox="0 0 24 24" aria-hidden="true" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M12 2a10 10 0 1 0 0 20 10 10 0 0 0 0-20z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
        <path d="M2 12h20" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
        <path d="M12 2c3.5 4 3.5 14 0 20" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
      </svg>`
    default:
      return `<svg width="18" height="18" viewBox="0 0 24 24" aria-hidden="true" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
        <circle cx="12" cy="12" r="10"/>
      </svg>`
  }
}
</script>

<style scoped>
.develop-info-root {
  width: 100%;
  padding: 20px;
  background: #1c1c1c;
  color: white;
  box-sizing: border-box;
  border-radius: 30px;
  box-shadow: 12px 12px 36px rgba(194, 194, 194, 0.7);
}

.section-block {
  margin-bottom: 40px;
}

/* 标题 */
.section-title {
  font-size: 22px;
  font-weight: 600;
  margin-bottom: 16px;
}

/* 开发者排列 */
.dev-row {
  display: flex;
  gap: 24px;
}

/* 使头像与昵称垂直列方向居中对齐 */
.dev-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;

  cursor: pointer;
  width: 160px;
  transition: transform 0.15s ease;
  text-align: center;
  padding: 10px;
  border-radius: 12px;
}
.dev-card:hover {
  transform: translateY(-6px);
  background: rgba(255,255,255,0.02);
}

/* name 和 role 同一行 */
.name-role {
  display: flex;
  gap: 8px;
  align-items: baseline;
  margin-top: 10px;
}
.dev-name {
  font-weight: 700;
  font-size: 16px;
  color: #fff;
}
.dev-role {
  font-size: 13px;
  color: rgba(255,255,255,0.7);
}

/* 特别感谢排列 */
.thanks-row {
  display: flex;
  gap: 24px;
}

/* 使特别感谢卡片里的头像与昵称垂直居中 */
.thanks-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 120px;
  text-align: center;
  position: relative;
}

/* 头像样式（圆形） */
.dev-avatar {
  width: 96px;
  height: 96px;
  border-radius: 50%;
  object-fit: cover;
  border: 2px solid rgba(255,255,255,0.04);
  box-shadow: 0 6px 18px rgba(0,0,0,0.6);
}
.avatar-lg {
  width: 120px;
  height: 120px;
  border-radius: 50%;
  object-fit: cover;
  border: 2px solid rgba(255,255,255,0.04);
  box-shadow: 0 8px 24px rgba(0,0,0,0.6);
}
.thx-avatar {
  width: 56px;
  height: 56px;
  border-radius: 50%;
  object-fit: cover;
}

/* 昵称 */
.nickname {
  margin-top: 8px;
  font-size: 16px;
}

/* 悬停提示 */
.hover-info {
  display: none;
  position: absolute;
  top: 0;
  left: 110px;
  width: 220px;
  padding: 10px;
  background: rgba(60, 60, 60, 0.95);
  border-radius: 8px;
  text-align: left;
  z-index: 20;
  box-shadow: 0 8px 24px rgba(0,0,0,0.6);
}
.thanks-avatar-wrapper:hover .hover-info {
  display: block;
}

.hover-title {
  font-weight: 600;
  margin-bottom: 6px;
}

/* 点击展开的开发者详细信息 */
.detail-box {
  margin-top: 16px;
  padding: 14px;
  background: #1b1b1b;
  border-radius: 10px;
  overflow: hidden;
}

/* detail 顶部布局 */
.detail-top {
  display: flex;
  gap: 14px;
  align-items: center;
}
.detail-meta { min-width: 0; }
.detail-name {
  font-size: 18px;
  font-weight: 700;
  margin: 0;
}
.detail-role {
  opacity: 0.8;
  margin: 6px 0 8px 0;
}
.detail-desc {
  margin: 8px 0 12px 0;
  color: rgba(255,255,255,0.9);
}

/* 联系方式列表 */
.contact-list {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
}
.contact-item {
  background: rgba(255,255,255,0.02);
  border: 1px solid rgba(255,255,255,0.03);
  padding: 8px 10px;
  border-radius: 8px;
}
.contact-link {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  color: #fff;
  text-decoration: none;
  font-size: 14px;
}
.contact-link:hover { text-decoration: underline; }
.icon { display:inline-flex; width:18px; height:18px; color: #cbd5e1; }

/* 联系我们 */
.contact-text {
  line-height: 1.6;
  margin-top: 10px;
}

.email {
  color: #52b3ff;
  font-weight: 600;
}

/* 版本号样式 */
.version {
  margin-top: 10px;
  color: rgba(255,255,255,0.75);
  font-size: 13px;
}

/* expand 动画：结合 opacity + max-height 做平滑展开收起 */
.expand-enter-active,
.expand-leave-active {
  transition: opacity 240ms ease, transform 240ms ease, max-height 240ms ease;
}
.expand-enter-from {
  opacity: 0;
  transform: translateY(-6px);
  max-height: 0;
}
.expand-enter-to {
  opacity: 1;
  transform: translateY(0);
  max-height: 500px;
}
.expand-leave-from {
  opacity: 1;
  transform: translateY(0);
  max-height: 500px;
}
.expand-leave-to {
  opacity: 0;
  transform: translateY(-6px);
  max-height: 0;
}

/* responsiveness */
@media (max-width: 640px) {
  .dev-row { flex-wrap: wrap; }
  .dev-card { width: 46%; }
  .thanks-card { width: 46%; }
  .detail-top { flex-direction: column; align-items: center; text-align:center; }
  .hover-info { left: 50%; transform: translateX(-50%); top: 110%; }
}
</style>