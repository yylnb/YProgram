<template>
  <div
    class="modal-backdrop"
    @keydown.esc="close"
    tabindex="0"
  >
    <div
      class="modal"
      role="dialog"
      aria-modal="true"
      aria-labelledby="login-title"
    >
      <div class="modal-body">
        <div class="modal-header">
          <h3 id="login-title" class="modal-title">
            登录 / 注册
          </h3>
          <button
            class="close-btn"
            @click="close"
            aria-label="关闭弹窗"
          >
            ✕
          </button>
        </div>

        <form @submit.prevent="handleSubmit" class="form">
          <div class="form-item">
            <label class="label">用户名</label>
            <input
              v-model="username"
              type="text"
              class="input"
              placeholder="例如：xiaoming"
              autocomplete="username"
            />
          </div>

          <div class="form-item">
            <label class="label">密码</label>
            <div class="password-wrap">
              <input
                :type="showPassword ? 'text' : 'password'"
                v-model="password"
                class="input input-password"
                placeholder="你的密码"
                autocomplete="current-password"
              />
              <button
                type="button"
                class="password-toggle"
                @click="showPassword = !showPassword"
                :aria-pressed="showPassword"
              >
                {{ showPassword ? '隐藏' : '显示' }}
              </button>
            </div>
          </div>

          <div class="form-item">
            <label class="label">邀请你的朋友（选填）</label>
            <input
              v-model="inviteFriend"
              type="text"
              class="input"
              placeholder="填写被邀请人的用户名（若存在将赠送 1 个月会员）"
            />
            <div v-if="inviteHint" class="hint">
              {{ inviteHint }}
            </div>
          </div>

          <div>
            <button
              type="submit"
              class="primary-btn"
              :disabled="loading"
            >
              <span v-if="!loading">登录 / 注册</span>
              <span v-else>处理中…</span>
            </button>
          </div>

          <div v-if="error" class="alert alert-error">
            {{ error }}
          </div>

          <div v-if="info" class="alert alert-success">
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
import { useUIStore } from '../stores/ui'

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
  try { ui.closeLogin() } catch {}
}

function applyTokenToAxios(token) {
  if (token) {
    axios.defaults.headers.common['Authorization'] = `Bearer ${token}`
  } else {
    delete axios.defaults.headers.common['Authorization']
  }
}

async function handleSubmit() {
  error.value = ''
  info.value = ''

  if (!username.value || !password.value) {
    error.value = '用户名和密码不能为空'
    return
  }

  loading.value = true

  try {
    try {
      const res = await axios.post('/api/user/login', {
        username: username.value,
        password: password.value
      })
      if (res?.data?.token) {
        const token = res.data.token
        localStorage.setItem('yp_token', token)
        localStorage.setItem('yp_user', JSON.stringify(res.data.user || {}))
        applyTokenToAxios(token)
        window.dispatchEvent(new Event('auth-changed'))
        info.value = '登录成功'
        ui.closeLogin()
        resetForm()
        return
      }
      throw new Error()
    } catch {}

    if (password.value.length < 6) {
      error.value = '密码长度至少需要 6 个字符'
      return
    }
    if (!/^[A-Za-z0-9]+$/.test(password.value)) {
      error.value = '密码只能包含英文字母和数字'
      return
    }
    if (!/[A-Za-z]/.test(password.value) || !/[0-9]/.test(password.value)) {
      error.value = '密码必须同时包含字母和数字'
      return
    }

    const r = await axios.post('/api/user/register', {
      username: username.value,
      password: password.value
    })

    if (!r?.data?.token) throw new Error('注册返回异常')

    const token = r.data.token
    localStorage.setItem('yp_token', token)
    localStorage.setItem('yp_user', JSON.stringify(r.data.user || {}))
    applyTokenToAxios(token)
    window.dispatchEvent(new Event('auth-changed'))
    info.value = '注册并登录成功'

    if (inviteFriend.value?.trim()) {
      try {
        const resInvite = await axios.post(
          '/api/user/invite',
          { referrer: inviteFriend.value.trim() },
          { headers: { Authorization: `Bearer ${token}` } }
        )
        info.value += resInvite?.data?.success
          ? `；已为 ${inviteFriend.value.trim()} 赠送 1 个月会员。`
          : '；邀请已提交。'
      } catch {}
    }

    ui.closeLogin()
    resetForm()
  } catch (err) {
    error.value = err?.message || '网络或服务器错误'
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
/* === backdrop & modal === */
.modal-backdrop {
  position: fixed;
  inset: 0;
  z-index: 50;

  display: flex;
  align-items: center;
  justify-content: center;

  padding: 1.5rem; /* p-6 */
  background: rgba(8, 10, 20, 0.45);
}

.modal {
  width: 100%;
  max-width: 480px;

  background-color: #ffffff;
  border-radius: 12px;
  overflow: hidden;

  box-shadow:
    0 10px 15px -3px rgba(0, 0, 0, 0.1),
    0 4px 6px -4px rgba(0, 0, 0, 0.1); /* shadow-lg */
}

.modal-body {
  padding: 1.5rem; /* p-6 */
}

.modal-header {
  display: flex;
  align-items: center;
  justify-content: space-between;

  margin-bottom: 1rem; /* mb-4 */
}

.modal-title {
  font-size: 1.125rem; /* text-lg */
  line-height: 1.75rem;
  font-weight: 700; /* font-bold */
  color: #0f172a; /* text-slate-900 */
}

/* === form === */
.form {
  display: flex;
  flex-direction: column;
  gap: 1rem; /* space-y-4 */
}

.form-item {
  display: flex;
  flex-direction: column;
  gap: 0.25rem; /* space-y-1 */
}

.label {
  display: block;
  font-size: 0.875rem; /* text-sm */
  line-height: 1.25rem;
  color: #374151; /* text-gray-700 */
}

.password-wrap {
  position: relative;
}

/* === inputs === */
.input {
  width: 100%;
  font-size: 0.875rem; /* text-sm */
  line-height: 1.25rem;

  padding: 10px 12px;
  border-radius: 0.75rem; /* rounded-xl */
  border: 1px solid rgba(15, 23, 42, 0.06);

  outline: none;

  transition:
    box-shadow 0.12s ease,
    border-color 0.12s ease,
    transform 0.06s ease;
}

.input:focus {
  border-color: rgba(37, 99, 235, 0.5);
  box-shadow: 0 10px 26px rgba(37, 99, 235, 0.06);
  transform: translateY(-1px);
}

.input-password {
  padding-right: 3rem; /* pr-12 */
}

.password-toggle {
  position: absolute;
  right: 0.5rem; /* right-2 */
  top: 0.625rem; /* top-2.5 */

  font-size: 0.875rem; /* text-sm */
  color: #6b7280; /* text-gray-500 */

  background: transparent;
  border: none;
  cursor: pointer;
}

.password-toggle:hover {
  color: #374151; /* hover:text-gray-700 */
}

/* === buttons === */
.primary-btn {
  width: 100%;

  padding: 12px 14px;
  border-radius: 0.75rem; /* rounded-xl */
  border: none;

  font-weight: 800; /* font-extrabold */
  color: #ffffff;

  background: linear-gradient(90deg, #2563eb, #7c3aed);
  cursor: pointer;
}

.primary-btn:disabled {
  opacity: 0.7;
  cursor: not-allowed;
}

.close-btn {
  background: transparent;
  border: none;

  font-size: 18px;
  cursor: pointer;

  color: #9ca3af; /* text-gray-400 */
}

.close-btn:hover {
  color: #374151; /* hover:text-gray-700 */
}

/* === hints & alerts === */
.hint {
  margin-top: 0.25rem; /* mt-1 */
  font-size: 0.75rem; /* text-xs */
  line-height: 1rem;
  color: #9ca3af; /* text-gray-400 */
}

.alert {
  margin-top: 0.5rem; /* mt-2 */
  padding: 0.5rem 0.75rem; /* px-3 py-2 */

  font-size: 0.875rem; /* text-sm */
  line-height: 1.25rem;

  border-radius: 0.375rem; /* rounded */
  border: 1px solid;
}

.alert-error {
  color: #dc2626; /* text-red-600 */
  background-color: #fef2f2; /* bg-red-50 */
  border-color: #fee2e2; /* border-red-100 */
}

.alert-success {
  color: #15803d; /* text-green-700 */
  background-color: #f0fdf4; /* bg-green-50 */
  border-color: #dcfce7; /* border-green-100 */
}
</style>
