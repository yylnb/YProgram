<template>
  <div class="modal-backdrop fixed inset-0 z-50 flex items-center justify-center p-6" @keydown.esc="close" tabindex="0">
    <div class="modal w-full max-w-md rounded-2xl overflow-hidden shadow-lg bg-white" role="dialog" aria-modal="true" aria-labelledby="login-title">
      <div class="p-6">
        <div class="flex justify-between items-center mb-4">
          <h3 id="login-title" class="text-lg font-bold text-slate-900">登录 / 注册</h3>
          <button class="close-btn text-gray-400 hover:text-gray-700" @click="close" aria-label="关闭弹窗">✕</button>
        </div>

        <form @submit.prevent="handleSubmit" class="space-y-4">
          <div>
            <label class="text-sm text-gray-700 mb-1 block">用户名</label>
            <input v-model="username" type="text" class="input" placeholder="例如：xiaoming" autocomplete="username" />
          </div>

          <div>
            <label class="text-sm text-gray-700 mb-1 block">密码</label>
            <div class="relative">
              <input :type="showPassword ? 'text' : 'password'" v-model="password" class="input pr-12" placeholder="你的密码" autocomplete="current-password" />
              <button type="button" class="text-sm absolute right-2 top-2.5 text-gray-500 hover:text-gray-700" @click="showPassword = !showPassword" :aria-pressed="showPassword">
                {{ showPassword ? '隐藏' : '显示' }}
              </button>
            </div>
          </div>

          <div>
            <label class="text-sm text-gray-700 mb-1 block">邀请你的朋友（选填）</label>
            <input v-model="inviteFriend" type="text" class="input" placeholder="填写被邀请人的用户名（若存在将赠送 1 个月会员）" />
            <div v-if="inviteHint" class="text-xs text-gray-400 mt-1">{{ inviteHint }}</div>
          </div>

          <div>
            <button type="submit" class="primary-btn w-full" :disabled="loading">
              <span v-if="!loading">登录 / 注册</span>
              <span v-else>处理中…</span>
            </button>
          </div>

          <div v-if="error" class="mt-2 text-sm text-red-600 px-3 py-2 rounded bg-red-50 border border-red-100">
            {{ error }}
          </div>

          <div v-if="info" class="mt-2 text-sm text-green-700 px-3 py-2 rounded bg-green-50 border border-green-100">
            {{ info }}
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, watch } from 'vue'
import axios from 'axios'
import { useUIStore } from '../stores/ui' // 注意路径与你项目相符

const ui = useUIStore()

const username = ref('')
const password = ref('')
const inviteFriend = ref('')
const inviteHint = ref('')
const loading = ref(false)
const error = ref('')
const info = ref('')
const showPassword = ref(false)

watch(inviteFriend, (v) => {
  if (!v) inviteHint.value = ''
  else inviteHint.value = '将尝试为该用户名赠送 1 个月会员（仅在本次为新用户注册时生效）'
})

function resetForm() {
  username.value = ''
  password.value = ''
  inviteFriend.value = ''
  inviteHint.value = ''
  showPassword.value = false
  error.value = ''
  info.value = ''
}

function close() {
  resetForm()
  try { ui.closeLogin() } catch (e) { /* ignore */ }
}

// helper: apply token globally to axios (helps avoid 401 for other axios calls)
function applyTokenToAxios(token) {
  if (token) {
    axios.defaults.headers.common['Authorization'] = `Bearer ${token}`;
  } else {
    delete axios.defaults.headers.common['Authorization'];
  }
}

/**
 * 主流程：
 * - 先尝试 login（POST /api/login）
 * - 若 login 成功 -> 写 localStorage + apply axios default header + dispatch auth-changed + 结束
 * - 若 login 失败 -> 直接尝试 register（POST /api/register）
 *   - 注册成功后（新用户），若 inviteFriend 有值则调用 POST /api/invite（用注册得到的 token）
 */
async function handleSubmit() {
  error.value = ''
  info.value = ''
  if (!username.value || !password.value) {
    error.value = '用户名和密码不能为空'
    return
  }
  loading.value = true

  try {
    // 尝试登录
    try {
      const res = await axios.post('http://localhost:5000/api/login', { username: username.value, password: password.value })
      if (res && res.data && res.data.token) {
        const token = res.data.token
        localStorage.setItem('yp_token', token)
        localStorage.setItem('yp_user', JSON.stringify(res.data.user || {}))
        applyTokenToAxios(token)
        window.dispatchEvent(new Event('auth-changed'))
        info.value = '登录成功'
        ui.closeLogin()
        resetForm()
        return
      } else {
        throw new Error('登录返回异常')
      }
    } catch (loginErr) {
      // 登录失败 -> fallthrough 到注册
    }

    // 尝试注册
    try {
      const r = await axios.post('http://localhost:5000/api/register', { username: username.value, password: password.value })
      if (r && r.data && r.data.token) {
        const token = r.data.token
        localStorage.setItem('yp_token', token)
        localStorage.setItem('yp_user', JSON.stringify(r.data.user || {}))
        applyTokenToAxios(token)
        window.dispatchEvent(new Event('auth-changed'))
        info.value = '注册并登录成功'

        // 如果填写了邀请好友，则调用后端 invite 接口（后端负责校验并赠送）
        if (inviteFriend.value && inviteFriend.value.trim()) {
          try {
            const resInvite = await axios.post('http://localhost:5000/api/invite', { referrer: inviteFriend.value.trim() }, {
              headers: { Authorization: `Bearer ${token}` },
              timeout: 8000
            })
            if (resInvite && resInvite.data && resInvite.data.success) {
              info.value = `${info.value}；已为 ${inviteFriend.value.trim()} 赠送 1 个月会员。`
            } else {
              const msg = resInvite?.data?.message || '邀请已提交（若用户存在将处理）。'
              info.value = `${info.value}；${msg}`
            }
          } catch (invErr) {
            const s = invErr?.response?.status
            if (s === 404) {
              info.value = `${info.value}；未找到用户 ${inviteFriend.value.trim()}，未赠送会员。`
            } else {
              info.value = `${info.value}；赠送会员请求失败（非阻塞）：${invErr?.response?.data?.error || invErr.message}`
            }
          }
        }

        ui.closeLogin()
        resetForm()
        return
      } else {
        throw new Error('注册返回异常')
      }
    } catch (regErr) {
      const msg = regErr?.response?.data?.error || regErr?.message || '注册失败'
      error.value = `注册失败：${msg}`
      return
    }
  } catch (err) {
    error.value = err?.message || '网络或服务器错误'
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.modal-backdrop { background: rgba(8,10,20,0.45); z-index: 9999; }
.modal { border-radius: 12px; max-width: 480px; }
.close-btn { background: transparent; border: none; font-size: 18px; cursor: pointer; }
.input { width: 100%; padding: 10px 12px; border-radius: 10px; border: 1px solid rgba(15,23,42,0.06); outline: none; transition: box-shadow .12s, border-color .12s, transform .06s; font-size: 14px; }
.input:focus { box-shadow: 0 10px 26px rgba(37,99,235,0.06); border-color: rgba(37,99,235,0.5); transform: translateY(-1px); }
.primary-btn { background: linear-gradient(90deg,#2563eb,#7c3aed); color: white; border: none; padding: 12px 14px; border-radius: 10px; font-weight: 800; cursor: pointer; }
.primary-btn:disabled { opacity: 0.7; cursor: not-allowed; }
</style>
