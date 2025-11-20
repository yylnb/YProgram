<template>
  <div class="profile-root">
    <div class="profile-inner">
      <div class="flex items-center justify-between mb-6">
        <h2 class="text-2xl font-bold">个人信息</h2>

        <div v-if="isLogged" class="flex items-center gap-3">
          <button class="btn" @click="logout">登出</button>
        </div>
      </div>

      <div v-if="!isLogged" class="card p-6 text-center">
        <p class="mb-4">你尚未登录。请先登录后查看个人信息。</p>
        <button class="btn" @click="goHome">去登录</button>
      </div>

      <div v-else class="grid grid-cols-1 gap-6">
        <!-- 基本信息 -->
        <Basic :profile="profile" :token-exp="tokenExp" />

        <!-- 日历（你已有） -->
        <Calendar />

        <!-- 会员 -->
        <Membership :profile="profile" />

        <!-- 收藏题目 -->
        <QuestionFavorites />
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'

import Basic from './Profile/Basic.vue'
import Calendar from './Profile/Calendar.vue' // 已有
import Membership from './Profile/Membership.vue'
import QuestionFavorites from './Profile/QuestionFavorites.vue'

const router = useRouter()

const storedToken = ref(localStorage.getItem('yp_token') || null)
const storedUserRaw = localStorage.getItem('yp_user')
let parsedUser = null
try { parsedUser = storedUserRaw ? JSON.parse(storedUserRaw) : null } catch(e){ parsedUser = null }
const profile = ref(parsedUser || { id: null, username: '', created_at: null })
const tokenExp = ref(null)
const isLogged = computed(() => !!storedToken.value)

function logout(){
  localStorage.removeItem('yp_token')
  localStorage.removeItem('yp_user')
  storedToken.value = null
  router.push('/')
}
function goHome(){ router.push('/') }

function parseJwt(token){
  try{
    const parts = token.split('.')
    if(parts.length < 2) return {}
    const payload = parts[1].replace(/-/g,'+').replace(/_/g,'/')
    const json = decodeURIComponent(atob(payload).split('').map(c => '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2)).join(''))
    return JSON.parse(json)
  }catch(e){ return {} }
}

onMounted(() => {
  // 如果 localStorage 存了 token，尽量填充 profile 与 tokenExp（但不覆盖后端真实用户数据）
  if ((!profile.value || !profile.value.username) && storedToken.value) {
    const payload = parseJwt(storedToken.value)
    profile.value = { id: payload.id || null, username: payload.username || payload.name || '', created_at: payload.created_at || null }
    if (payload.exp) tokenExp.value = new Date(payload.exp*1000).toLocaleString()
  } else {
    if (storedToken.value) {
      const payload = parseJwt(storedToken.value)
      if (payload.exp) tokenExp.value = new Date(payload.exp*1000).toLocaleString()
    }
  }
})
</script>

<style scoped>
.profile-root {
  display:flex;
  justify-content:center;
  padding:28px 12px;
  min-height: calc(100vh - 64px);
  box-sizing:border-box;
}
.profile-inner { width:100%; max-width:980px; }

/* 保留少量全局通用样式，子组件可以复用或覆盖 */
.card {
  background:white;
  border-radius:12px;
  box-shadow:0 10px 30px rgba(2,6,23,0.06);
  padding:12px;
}
.btn {
  background: linear-gradient(90deg,#2563eb,#7c3aed);
  color: white;
  padding:8px 12px;
  border-radius:8px;
  border: none;
  cursor: pointer;
  font-weight:700;
}
</style>