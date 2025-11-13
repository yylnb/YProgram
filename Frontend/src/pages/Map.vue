<template>
  <div class="map-root">
    <!-- NAV：根据 isMobile 切换 MapNav 或 MapNavMobile -->
    <component
      :is="navComponent"
      v-model:lang="selectedLang"
      v-model:stage="selectedStage"
    />

    <!-- 地图区（保持不变） -->
    <MapStairs
      :selectedLang="selectedLang"
      :selectedStage="selectedStage"
    />
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onBeforeUnmount, defineAsyncComponent } from 'vue'
import MapNav from './Map/MapNav.vue'
import MapStairs from './Map/MapStairs.vue'

/*
  我把 MapNavMobile 做成异步组件（懒加载），这样只有在移动端才会下载它，减小桌面端包体。
  如果你希望总是静态导入，可以改成：
    import MapNavMobile from './Map/MapNavMobile.vue'
*/
const MapNavMobile = defineAsyncComponent(() => import('./Map/MapNavMobile.vue'))

const selectedLang = ref('python')
const selectedStage = ref(0)

// 是否为移动端（<= 640px）
// 我用 matchMedia('(max-width: 640px)')，和你要求一致：<=640 为 mobile，>640 为 pad/computer
const isMobile = ref(false)
let mql = null

function updateIsMobileFromMql(e) {
  isMobile.value = !!e.matches
}

onMounted(() => {
  // 初始化：读取本地语言（保留原有行为）
  try {
    const saved = localStorage.getItem('yp_lang')
    const allow = ['python','cpp','c','java','html','css','js']
    if (saved && allow.includes(saved)) selectedLang.value = saved
  } catch (e) { /* ignore */ }

  // matchMedia 监听
  if (typeof window !== 'undefined' && 'matchMedia' in window) {
    mql = window.matchMedia('(max-width: 640px)')
    // set initial
    isMobile.value = !!mql.matches
    // add listener (现代浏览器支持 addEventListener on MediaQueryList, fallback to addListener)
    if (typeof mql.addEventListener === 'function') {
      mql.addEventListener('change', updateIsMobileFromMql)
    } else if (typeof mql.addListener === 'function') {
      mql.addListener(updateIsMobileFromMql)
    }
  } else {
    // 若环境没有 window（SSR），默认按非移动端处理
    isMobile.value = false
  }
})

onBeforeUnmount(() => {
  if (mql) {
    if (typeof mql.removeEventListener === 'function') {
      mql.removeEventListener('change', updateIsMobileFromMql)
    } else if (typeof mql.removeListener === 'function') {
      mql.removeListener(updateIsMobileFromMql)
    }
  }
})

// 根据 isMobile 选择要挂载的组件
const navComponent = computed(() => {
  return isMobile.value ? MapNavMobile : MapNav
})
</script>

<style scoped>
.map-root{
  background: black;
  min-height: 250vh;
}
</style>