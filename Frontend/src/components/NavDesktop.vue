<!-- NavDesktop.vue -->
<template>
  <nav
    ref="navRef"
    class="floating-nav"
    :class="{ open: isOpen }"
    role="navigation"
    :aria-expanded="isOpen.toString()"
    @click.stop="onToggle"
  >
    <div class="brand" aria-hidden="true">YProgram</div>

    <ul class="menu" @click.stop>
      <li
        v-for="item in items"
        :key="item.to"
        class="menu-item"
        @click="onItemClick(item)"
      >
        <RouterLink :to="item.to" class="menu-link">{{ item.label }}</RouterLink>
      </li>
    </ul>
  </nav>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount, watch } from 'vue'
import { useRouter } from 'vue-router'

const props = defineProps({
  items: { type: Array, default: () => [] }
})
const emit = defineEmits(['navigate'])

const isOpen = ref(false)
const navRef = ref(null)
const router = useRouter()

function onToggle() {
  isOpen.value = !isOpen.value
}

function close() {
  isOpen.value = false
}

function onItemClick(item) {
  // 让 RouterLink 处理路由跳转，emit 事件供父组件使用
  emit('navigate', item)
  close()
}

// 点击页面其它位置收起导航
function onDocClick(e) {
  if (!navRef.value) return
  if (!navRef.value.contains(e.target)) close()
}

onMounted(() => {
  document.addEventListener('click', onDocClick)
  // 路由切换时收起
  router.afterEach(() => close())
})

onBeforeUnmount(() => {
  document.removeEventListener('click', onDocClick)
})
</script>

<style scoped>
/* ---------- 桌面版样式 ---------- */

/* 容器与伪元素背景（毛玻璃胶囊） */
.floating-nav {
  position: fixed;
  top: 18px;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  align-items: center;
  justify-content: center; /* 折叠时 brand 居中 */
  gap: 1rem;
  height: 56px;
  min-width: 160px;
  width: 200px;              /* 折叠时宽度（略大，避免 brand 被裁） */
  padding: 0 12px;
  background: transparent;
  border-radius: 999px;
  box-shadow: 0 10px 30px rgba(16,24,40,0.12);
  transition:
    width 320ms cubic-bezier(.2,.9,.2,1),
    box-shadow 280ms,
    justify-content 260ms ease,
    padding 260ms ease;
  z-index: 1200;
  cursor: pointer;
  user-select: none;
  overflow: visible;
  isolation: isolate;
  border: 1px solid rgba(16,24,40,0.04);
}

.floating-nav::before {
  content: "";
  position: absolute;
  inset: 0;
  border-radius: inherit;
  background: rgba(255,255,255,0.94);
  box-shadow: 0 10px 30px rgba(16,24,40,0.12);
  backdrop-filter: blur(6px);
  -webkit-backdrop-filter: blur(6px);
  border: 1px solid rgba(16,24,40,0.04);
  z-index: 1;
  pointer-events: none;
  transition: backdrop-filter 300ms, box-shadow 280ms, background 300ms;
}

/* 展开时 */
.floating-nav.open,
.floating-nav:hover {
  width: min(50vw, 860px);
  justify-content: space-between;
  padding: 8px 18px;
  box-shadow: 0 14px 40px rgba(16,24,40,0.15);
}
.floating-nav.open::before,
.floating-nav:hover::before {
  backdrop-filter: blur(8px);
  -webkit-backdrop-filter: blur(8px);
  box-shadow: 0 14px 40px rgba(16,24,40,0.15);
}

/* 品牌文字 */
.floating-nav .brand {
  position: relative;
  z-index: 3; /* 高于 menu，避免被遮挡 */
  display: inline-flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  font-weight: 800;
  font-size: 1rem;
  letter-spacing: 0.2px;
  background: linear-gradient(90deg, #0e78e9 0%, #ed3aed 100%);
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
  white-space: nowrap;
  padding: 0 8px;
  pointer-events: none;
  /* 保持最小宽度以确保完全显示 */
  min-width: 110px;
}

/* 菜单容器（桌面默认隐藏） */
.floating-nav .menu {
  position: relative;
  z-index: 2; /* 低于 brand（brand z-index:3） */
  display: flex;
  gap: 0.8rem;
  align-items: center;
  margin-left: 8px;
  opacity: 0;
  transform: translateX(8px);
  pointer-events: none;
  transition: opacity 280ms ease, transform 280ms ease;
  flex: 1 1 auto;
  justify-content: flex-end;

  white-space: nowrap;
  flex-wrap: nowrap;
  overflow: hidden;
  min-width: 0;
}

/* 折叠时确保 menu 不遮挡 brand */
.floating-nav:not(.open) .menu {
  z-index: 2;
  pointer-events: none;
  opacity: 0;
  transform: translateX(8px);
}

/* 展开时显示菜单 */
.floating-nav.open .menu,
.floating-nav:hover .menu {
  z-index: 2;
  opacity: 1;
  transform: translateX(0);
  pointer-events: auto;
  overflow: visible;
}

/* 菜单项与链接 */
.floating-nav .menu-item {
  list-style: none;
  padding: 6px 12px;
  border-radius: 8px;
  transition: transform 180ms ease, background 180ms ease, opacity 220ms ease;
  transform: translateY(6px);
  opacity: 0;
  flex: 0 0 auto;
}
.floating-nav.open .menu-item,
.floating-nav:hover .menu-item {
  transform: translateY(0);
  opacity: 1;
}
.floating-nav .menu-link {
  text-decoration: none;
  color: var(--text-dark, #111827);
  font-weight: 600;
  display: inline-block;
}

/* 单项 hover 效果 */
.floating-nav .menu-item:hover {
  transform: translateY(-3px);
  background: linear-gradient(90deg, rgba(37,99,235,0.06), rgba(147,51,234,0.04));
}

/* 缩小屏幕也作为容错（但主要使用 Desktop.vue 在大屏） */
@media (max-width: 640px) {
  .floating-nav { display: none; }
}

/* Tablet-specific fixes: 641px — 1024px */
@media (min-width: 641px) and (max-width: 1024px) {
  /* 1) 更友好的展开宽度：用更大的视口比例并设置更高上限 */
  .floating-nav.open,
  .floating-nav:hover {
    width: min(78vw, 980px); /* 比桌面略窄，但比原先更宽，减少溢出 */
    padding: 10px 20px;
  }

  /* 3) 每个 menu-item 给定一个 min-width，防止过窄导致重叠或文字换行成不美观 */
  .floating-nav .menu-item {
    min-width: 90px; /* 可根据文字长度调整到 100~140px */
    flex: 0 1 auto;   /* 允许收缩但不强制为 0 宽 */
  }

  /* 4) 或者使用 CSS grid 让菜单按列优化分布（自动适配列数） */
  .floating-nav .menu.grid-auto {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
    gap: 10px;
    width: 100%;
  }

  /* 5) 如果你希望 brand 保持原位，确保 z-index/position 保持不变 */
  .floating-nav .brand {
    z-index: 3;
    min-width: 120px; /* 确保品牌区域不被压扁 */
  }
}

/* 较小桌面/大手机→ 平板的补充：当宽度接近临界值时，降低 item 的 transition delay */
@media (max-width: 1024px) {
  .floating-nav .menu-item:nth-child(1) { transition-delay: 0ms; }
  .floating-nav .menu-item:nth-child(2) { transition-delay: 30ms; }
  .floating-nav .menu-item:nth-child(3) { transition-delay: 60ms; }
  .floating-nav .menu-item:nth-child(4) { transition-delay: 90ms; }
  .floating-nav .menu-item:nth-child(5) { transition-delay: 120ms; }
}
</style>