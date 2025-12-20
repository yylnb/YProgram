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
                <!-- iconObj = iconFor(c.type) -->
                <img :src="iconFor(c.type).src"
                    :class="['icon-img', { 'icon-filtered': iconFor(c.type).filtered }]"
                    :alt="c.type + ' 图标'"
                />
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
        <span class="email">leonyeungee@qq.com</span>
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
    role: '首席开发者',
    desc: '负责任何你能想到的方面。',
    avatar: new URL('@/assets/avatars/LeonYeung.jpg', import.meta.url).href,
    contacts: [
      { type: 'qqmail', label: 'yylleon0604@qq.com', url: 'https://wx.mail.qq.com'},
      { type: 'gmail', label: 'leonyeungee@gmail.com', url: 'https://mail.google.com'},
      { type: 'github', label: 'yylnb', url: 'https://github.com/yylnb' },
      { type: 'x', label: '@LeonYeungg', url: 'https://x.com/LeonYeungg' },
      { type: 'website', label: '个人网站', url: 'https://ypro.online' },
    ]
  },
  {
    id: 'dev-chatgpt',
    name: 'ChatGPT',
    role: 'AI 助手',
    desc: '负责提供技术指导、代码生成支持。',
    avatar: new URL('@/assets/avatars/ChatGPT.png', import.meta.url).href,
    contacts: [
      { type: 'chatgpt', label: 'chatgpt.com', url: 'https://chatgpt.com' }
    ]
  }
])

const thanks = ref([
  {
    id: 't-gemini',
    name: 'Gemini',
    note: '部分灵感来源',
    avatar: new URL('@/assets/avatars/gemini.png', import.meta.url).href,
  },
  {
    id: 't-oss',
    name: 'Zhang',
    note: '',
    avatar: new URL('@/assets/avatars/zh.jpg', import.meta.url).href,
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
   图标改为使用仓库内图片文件（iconMap）
   请把对应文件放到 src/assets/icons/
   email.svg, github.svg, x.svg, website.svg, default.svg
   ------------------------ */
const iconMap = {
  qqmail: { src: new URL('@/assets/icons/qqmail.png', import.meta.url).href, filtered: false },
  gmail: { src: new URL('@/assets/icons/gmail.png', import.meta.url).href, filtered: false },
  github: { src: new URL('@/assets/icons/github.png', import.meta.url).href, filtered: false },
  x: { src: new URL('@/assets/icons/x.png', import.meta.url).href, filtered: false },
  website: { src: new URL('@/assets/icons/website.png', import.meta.url).href, filtered: false },
  chatgpt: { src: new URL('@/assets/icons/chatgpt.png', import.meta.url).href, filtered: true },
  default: { src: new URL('@/assets/icons/default.svg', import.meta.url).href, filtered: true }
}

function iconFor(type) {
  return iconMap[type] || iconMap.default
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
}

/* 使特别感谢卡片里的头像与昵称垂直居中 */
.thanks-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100px;
  text-align: center;
  position: relative;
}
/* .thanks-card:hover{
    transform: translateY(-4px);
    transition: transform 0.15s ease;
} */
.thanks-card:hover .hover-info {
  display: block;
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
  box-shadow: 0 8px 20px rgba(255, 255, 255, 0.61);
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
  font-size: 12px;
}

/* 悬停提示 */
.hover-info {
  display: none;
  position: absolute;
  top: -50px;
  left: 80px;
  width: 220px;
  padding: 10px;
  background: rgb(255, 255, 255);
  border-radius: 8px;
  text-align: left;
  z-index: 999;
  box-shadow: 0 8px 24px rgba(170, 170, 170, 0.6);
}
/* .thanks-avatar-wrapper:hover .hover-info {
  display: block;
} */

.hover-title {
  font-weight: 600;
  margin-bottom: 6px;
  color: black;
}
.hover-note{
    color: black;
}
/* 点击展开的开发者详细信息 */
.detail-box {
  margin-top: 16px;
  padding: 14px;
  background: rgba(10, 10, 10, 0.77);
  border-radius: 10px;
  overflow: hidden;
  border: white 1px solid;
  padding: 40px 30px 40px 30px;
}

/* detail 顶部布局 */
.detail-top {
  display: flex;
  gap: 14px;
  margin-bottom: 20px;
  align-items: center;
}
.detail-name {
  font-size: 18px;
  font-weight: 700;
  margin: 0 0 0 20px;
}
.detail-role {
  opacity: 0.8;
  font-size: 14px;
  margin: 6px 0 8px 30px;
}
.detail-desc {
  margin: 8px 0 12px 30px;
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
  border: 1px solid rgba(87, 87, 87, 0.407);
  padding: 8px 10px;
  border-radius: 8px;
  transition: transform 0.15s ease;
}
.contact-item:hover {
  background: rgba(255,255,255,0.04);
  transform: translateY(-2px);
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

/* 图标图片样式 */
.icon-img {
  width: 18px;
  height: 18px;
  display: inline-block;
  object-fit: contain;
  border-radius: 50%;
}
.icon-img.icon-filtered { filter: invert(1) brightness(2); }

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
  .hover-info { width: 150px; left: 50%; transform: translateX(-50%); top: 110%; }
}
</style>