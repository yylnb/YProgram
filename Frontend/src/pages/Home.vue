<template>
  <div class="home-root">
    <!-- FluidCursor 放这里以覆盖全页面 -->
    <!-- <FluidCursor v-if="showCursor" /> -->
    <Hero />

    <!-- 根据设备类型切换 Audience 组件 -->
    <AudienceMobile v-if="isMobile" />
    <AudienceComputer v-else />

    <Feature />
  </div>
</template>

<script setup>
import Hero from './Home/Hero.vue'
import Feature from './Home/Feature.vue'
import FluidCursor from '../components/ui/fluid-cursor/FluidCursor.vue'

import AudienceMobile from './Home/AudienceMobile.vue'
import AudienceComputer from './Home/AudienceComputer.vue'

// 让 FluidCursor 延迟显示，避免首页加载时卡顿
import { ref, onMounted, onBeforeUnmount } from 'vue'

const showCursor = ref(false)
onMounted(() => {
  setTimeout(() => { showCursor.value = true }, 300)
})

// === 设备判断逻辑（只影响 Audience） ===
const isMobile = ref(false)

function checkIsMobile() {
  isMobile.value = window.innerWidth <= 768
}

onMounted(() => {
  checkIsMobile()
  window.addEventListener('resize', checkIsMobile)
})

onBeforeUnmount(() => {
  window.removeEventListener('resize', checkIsMobile)
})
</script>

<style scoped>
/* Home 只保留最基本的页面根样式（其他样式都在子组件里） */
.home-root {
  width: 100%;
  overflow-x: hidden;
  box-sizing: border-box;
}
:root, .home-root {
  box-sizing: border-box;
}
</style>