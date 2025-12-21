<!-- Nav.vue -->
<template>
  <component
    v-if="currentComp"
    :is="currentComp"
    :items="items"
    @navigate="onNavigate"
  />
  <!-- 占位：在极少数环境下（SSR）先渲染一个占位避免闪烁 -->
  <div v-else class="nav-placeholder" aria-hidden="true"></div>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount, defineAsyncComponent } from 'vue'

/* 你可以在这里修改导航项，或从父组件传入 props（示例里内置 items） */
const items = [
  { to: '/', label: '首页' },
  { to: '/map', label: '学习地图' },
  { to: '/library', label: '资料库' },
  { to: '/friends', label: '我的好友' },
  { to: '/profile', label: '个人信息' }
]

const MOBILE_QUERY = '(max-width: 640px)'

const isMobile = ref(false)
const currentComp = ref(null)

// 异步加载两个实现（按需打包）
const DesktopComp = defineAsyncComponent(() => import('./NavDesktop.vue'))
const MobileComp = defineAsyncComponent(() => import('./NavMobile.vue'))

let mql = null
function handleChange(e) {
  isMobile.value = e.matches
  currentComp.value = isMobile.value ? MobileComp : DesktopComp
}

onMounted(() => {
  if (typeof window !== 'undefined' && 'matchMedia' in window) {
    mql = window.matchMedia(MOBILE_QUERY)
    handleChange(mql)
    if (typeof mql.addEventListener === 'function') {
      mql.addEventListener('change', handleChange)
    } else if (typeof mql.addListener === 'function') {
      mql.addListener(handleChange)
    }
  } else {
    // SSR fallback: 默认为桌面组件（服务器端无法判断）
    currentComp.value = DesktopComp
  }
})

onBeforeUnmount(() => {
  if (!mql) return
  if (typeof mql.removeEventListener === 'function') {
    mql.removeEventListener('change', handleChange)
  } else if (typeof mql.removeListener === 'function') {
    mql.removeListener(handleChange)
  }
})

/* 代理事件：如果需要向更上层广播，可以改成 emit */
function onNavigate(payload) {
  // 目前只是将事件记录/占位。若需向上层 emit，请使用 defineEmits 并触发。
  // emit('navigate', payload)
  // console.log('navigate ->', payload)
}
</script>

<style scoped>
.nav-placeholder {
  position: fixed;
  top: 18px;
  left: 50%;
  transform: translateX(-50%);
  width: 160px;
  height: 56px;
  border-radius: 999px;
  /* 视觉占位（可删） */
}
</style>