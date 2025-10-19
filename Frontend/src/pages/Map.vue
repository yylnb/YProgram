<template>
  <div class="map-root">
    <!-- NAV（负责语言、能量、登录、阶段选择） -->
    <MapNav
      v-model:lang="selectedLang"
      v-model:stage="selectedStage"
    />

    <!-- 地图区（负责拉取进度、节点布局、跳转） -->
    <MapStairs
      :selectedLang="selectedLang"
      :selectedStage="selectedStage"
    />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import MapNav from './Map/MapNav.vue'
import MapStairs from './Map/MapStairs.vue'

const selectedLang = ref('python')
const selectedStage = ref(0)

// 极少量初始化：参考原先行为，从 localStorage 读取语言（保留最小职责）
onMounted(() => {
  try {
    const saved = localStorage.getItem('yp_lang')
    const allow = ['python','cpp','c','java','html','css','js']
    if (saved && allow.includes(saved)) selectedLang.value = saved
  } catch (e) { /* ignore */ }
})
</script>

<style scoped>
</style>
