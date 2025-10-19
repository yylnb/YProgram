<!-- NavMobile.vue -->
<template>
  <nav ref="navRef" class="floating-nav mobile" role="navigation" aria-hidden="false">
    <!-- morphing capsule: capsule 本体包含 brand（绝对定位）与 menu（隐藏/展开） -->
    <button
      class="capsule"
      :class="{ open: isOpen }"
      @click.stop="onToggle"
      :aria-expanded="isOpen.toString()"
      aria-label="打开导航"
    >
      <span class="brand">YProgram</span>

      <!-- 菜单放在同一个 capsule 内；折叠时通过 max-height/opacity 隐藏 -->
      <ul class="menu" aria-hidden="!isOpen">
        <li
          v-for="item in items"
          :key="item.to"
          class="menu-item"
          @click.stop="onItemClick(item)"
        >
          <RouterLink :to="item.to" class="menu-link">{{ item.label }}</RouterLink>
        </li>
      </ul>
    </button>
  </nav>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue'
import { useRouter } from 'vue-router'

const props = defineProps({
  items: { type: Array, default: () => [
    { to: '/', label: '首页' },
    { to: '/map', label: '我的学习' },
    { to: '/library', label: '资料库' },
    { to: '/friends', label: '我的好友' },
    { to: '/profile', label: '个人信息' }
  ] }
})
const emit = defineEmits(['navigate'])

const isOpen = ref(false)
const navRef = ref(null)
const router = useRouter()

function onToggle() {
  isOpen.value = !isOpen.value
}
function close() { isOpen.value = false }

function onItemClick(item) {
  emit('navigate', item)
  close()
}

// 点击页面其它位置收起
function onDocClick(e) {
  if (!navRef.value) return
  if (!navRef.value.contains(e.target)) close()
}

onMounted(() => {
  document.addEventListener('click', onDocClick)
  router.afterEach(() => close())
})

onBeforeUnmount(() => {
  document.removeEventListener('click', onDocClick)
})
</script>

<style scoped>
/* ========== 容器定位 ========== */
.floating-nav.mobile {
  position: fixed;
  top: 12px;
  left: 50%;
  transform: translateX(-50%);
  z-index: 1400;
  width: 100%;
  display: flex;
  justify-content: center;
  pointer-events: auto;
}

/* ==== morphing capsule（唯一变形元素） ==== */
.capsule {
  /* 初始为横向胶囊 */
  display: block;
  position: relative;    /* 让 brand 绝对定位在此 */
  height: 56px;          /* 折叠高度 */
  width: 160px;          /* 折叠宽度 */
  padding: 14px 14px 12px; /* 顶部 padding 为 brand 的锚点预留空间（与 brand top 对齐） */
  border-radius: 999px;
  border: 1px solid rgba(16,24,40,0.04);
  background: rgba(255,255,255,0.96);
  box-shadow: 0 8px 26px rgba(16,24,40,0.10);
  backdrop-filter: blur(6px);
  -webkit-backdrop-filter: blur(6px);
  cursor: pointer;
  user-select: none;
  transition:
    width 360ms cubic-bezier(.2,.9,.2,1),
    height 360ms cubic-bezier(.2,.9,.2,1),
    padding 360ms cubic-bezier(.2,.9,.2,1),
    border-radius 360ms ease,
    box-shadow 300ms ease,
    background 300ms ease;
  z-index: 1500;
  overflow: hidden; /* 隐藏 menu 在折叠时内容 */
  text-align: center;
}

/* ========== BRAND（绝对定位、无 transition 导致的位移） ==========
   我们把 brand 固定在 capsule 内的一个像素位置（top:14px），
   并且不对 brand 做 vertical 相关的 transition，确保在 capsule morph 时 brand 不会抖动/移动。 */
.brand {
  position: absolute;
  left: 50%;
  top: 14px; /* 固定锚点（与 capsule padding-top 对齐） */
  transform: translateX(-50%);
  display: inline-block;
  font-weight: 800;
  font-size: 1rem;
  letter-spacing: 0.2px;
  background: linear-gradient(90deg, #0e78e9 0%, #ed3aed 100%);
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
  color: inherit;
  white-space: nowrap;
  pointer-events: none;
  /* 不对 vertical/position 做动画，避免位移 */
  transition: none;
  z-index: 2;
}

/* ========== MENU（在 capsule 内展开，但不会影响 brand） ==========
   折叠时通过 max-height/opacity 隐藏展开内容；展开后 capsule morph 为矩形并显示菜单 */
.menu {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
  list-style: none;
  width: 100%;
  display: grid;
  grid-template-columns: repeat(3, 1fr); /* 3 列 -> 2 行展示（5 项为 3 + 2） */
  gap: 8px;
  align-items: center;
  justify-items: center;

  /* 隐藏技巧：max-height 与 opacity */
  max-height: 0;
  opacity: 0;
  padding-top: 0;
  transition:
    max-height 360ms cubic-bezier(.2,.9,.2,1),
    opacity 220ms ease 60ms,
    padding-top 260ms ease;
  overflow: hidden;
}

/* 菜单项 */
.menu-item {
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 8px 10px;
  border-radius: 10px;
  transition: background 160ms ease, transform 160ms ease;
  min-height: 44px;
}
.menu-link {
  text-decoration: none;
  color: var(--text-dark, #111827);
  font-weight: 600;
  display: inline-block;
  width: 100%;
  text-align: center;
}

/* 交互效果 */
.menu-item:hover,
.menu-item:active {
  transform: translateY(-3px);
  background: linear-gradient(90deg, rgba(37,99,235,0.06), rgba(147,51,234,0.04));
}

/* ========== 打开态：capsule 自身直接变大成矩形，menu 在内部展开 ==========
   注意：brand 固定 top 不变，capsule padding-top 保持与 brand top 一致（避免位移） */
.capsule.open {
  width: min(420px, calc(100vw - 32px));
  height: auto;
  padding: 14px 16px 12px; /* 顶部 padding 保持 14px（与 brand top 对齐） */
  border-radius: 12px;
  background: rgba(255,255,255,0.98);
  box-shadow: 0 18px 40px rgba(16,24,40,0.18);
}

/* 打开后 menu 可见：释放 max-height */
.capsule.open .menu {
  max-height: 360px; /* 根据内容可调整 */
  opacity: 1;
  padding-top: 32px; /* 在 brand 下方留出空间，让 menu 与 brand 有垂直间距 */
}

/* 小屏容错：窄屏使用 2 列 */
@media (max-width: 360px) {
  .menu {
    grid-template-columns: repeat(2, 1fr);
  }
}

/* 桌面隐藏移动组件（避免冲突） */
@media (min-width: 641px) {
  .floating-nav.mobile { display: none; }
}

/* 无动画首选者降级 */
@media (prefers-reduced-motion: reduce) {
  .capsule,
  .menu {
    transition: none !important;
  }
}
</style>