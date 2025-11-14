<template>
  <div>
    <!-- 导航组件 -->
    <Nav />

    <!-- 页面内容 -->
    <main>
      <transition name="page" mode="out-in">
        <RouterView />
      </transition>
    </main>

    <!-- 全局登录模态，由 Pinia 控制 -->
    <LoginModal v-if="ui.showLoginModal" />
  </div>
</template>

<script setup>
import { onMounted, onBeforeUnmount, ref} from 'vue'
import Nav from './components/Nav.vue'
import LoginModal from './components/LoginModal.vue'
import { useUIStore } from './stores/ui'

// get ui store
const ui = useUIStore()

// 当其他组件 dispatch window event 时，打开登录弹窗
function onOpenLoginEvent() {
  try { ui.openLogin() } catch (e) { /* ignore */ }
}

onMounted(() => {
  window.addEventListener('open-login-modal', onOpenLoginEvent)
})
onBeforeUnmount(() => {
  window.removeEventListener('open-login-modal', onOpenLoginEvent)
})

// FluidCursor效果组件
const enableCursor = true
const isClient = ref(false)
onMounted(() => { isClient.value = true })
</script>

<style scoped>
body { margin: 0; font-family: 'Inter', sans-serif; }
</style>

<style>
/* 全局页面过渡: page-enter、page-leave-to 等 */
.page-enter-active, .page-leave-active {
  transition: opacity 480ms ease, transform 480ms cubic-bezier(.2,.9,.2,1);
}
.page-enter-from { opacity: 0; transform: translateX(14px); }   /* 进入时从右侧淡入 */
.page-enter-to   { opacity: 1; transform: translateX(0); }
.page-leave-from { opacity: 1; transform: translateX(0); }
.page-leave-to   { opacity: 0; transform: translateX(-14px); }   /* 离场时向左淡出 */

html, body {
  overflow-x: hidden;   /* 禁止横向滚动条 */
  /*scrollbar-gutter: stable;  保留右侧位置，避免布局抖动 */
  background-color: black;
}

/* .fluid-cursor-root { pointer-events: none; z-index: 9999; position: fixed; inset: 0; } */
</style>