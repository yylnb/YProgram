<template>
  <div class="home-root">
    <!-- FluidCursor 放这里以覆盖全页面 -->
    <!-- <FluidCursor v-if="showCursor" /> -->
    <Hero />
    <Audience />
    <Feature />
  </div>
</template>

<script setup>
import Hero from './Home/Hero.vue'
import Audience from './Home/Audience.vue'
import Feature from './Home/Feature.vue'
import FluidCursor from '../components/ui/fluid-cursor/FluidCursor.vue'


// 让 FluidCursor 延迟显示，避免首页加载时卡顿
import { ref, onMounted } from 'vue'
const showCursor = ref(false)
onMounted(() => {
  setTimeout(() => { showCursor.value = true }, 300)
})
</script>

<style scoped>
/* Home 只保留最基本的页面根样式（其他样式都在子组件里） */
.home-root { width:100%; overflow-x:hidden; box-sizing:border-box;}
:root, .home-root { box-sizing: border-box; }
</style>