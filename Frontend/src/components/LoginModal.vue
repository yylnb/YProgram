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
              placeholder="希望怎么称呼你？"
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

  padding: 1.5rem;
  background: rgba(0, 0, 0, 0.65);
}

.modal {
  width: 100%;
  max-width: 480px;

  background: linear-gradient(180deg, rgba(255,255,255,0.02), rgba(255,255,255,0.01));
  backdrop-filter: blur(6px) saturate(110%);
  border-radius: 12px;
  overflow: hidden;
  border: 1px solid rgba(255, 255, 255, 0.511);

  box-shadow:
    12px 12px 36px rgba(194, 194, 194, 0.786),
    inset 0 0 0 1px rgba(255, 255, 255, 0.05);
}

.modal-body {
  padding: 1.5rem;
}

.modal-header {
  display: flex;
  align-items: center;
  justify-content: space-between;

  margin-bottom: 1rem;
}

.modal-title {
  font-size: 1.125rem;
  line-height: 1.75rem;
  font-weight: 700;
  color: #f8fafc; /* 白字 */
}

/* === form === */
.form {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.form-item {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}

.label {
  font-size: 0.875rem;
  line-height: 1.25rem;
  color: #cbd5f5; /* 浅灰蓝 */
}

/* === password === */
.password-wrap {
  position: relative;
}

/* === inputs === */
.input {
  width: 100%;
  font-size: 0.875rem;
  line-height: 1.25rem;

  padding: 10px 12px;
  border-radius: 0.75rem;

  background-color: #111827; /* 输入框深色 */
  color: #f9fafb;

  border: 1px solid rgba(255, 255, 255, 0.08);
  outline: none;

  transition:
    border-color 0.15s ease,
    box-shadow 0.15s ease,
    transform 0.06s ease;
}

.input::placeholder {
  color: #6b7280;
}

.input:focus {
  border-color: #6366f1;
  box-shadow: 0 0 0 2px rgba(99, 102, 241, 0.25);
  transform: translateY(-1px);
}

.input-password {
  padding-right: 3rem;
}

.password-toggle {
  position: absolute;
  right: 0.5rem;
  top: 0.625rem;

  font-size: 0.875rem;
  color: #9ca3af;

  background: transparent;
  border: none;
  cursor: pointer;
}

.password-toggle:hover {
  color: #e5e7eb;
}

/* === buttons === */
.primary-btn {
  width: 100%;
  padding: 12px 14px;

  border-radius: 0.75rem;
  border: none;

  font-weight: 800;
  color: #ffffff;

  background: linear-gradient(90deg, #6366f1, #8b5cf6);
  cursor: pointer;

  transition: transform 0.08s ease, opacity 0.15s ease;
}

.primary-btn:hover:not(:disabled) {
  transform: translateY(-3px);
  box-shadow: 0 36px 100px #8a5cf6a8;
}

.primary-btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

/* === close button === */
.close-btn {
  background: transparent;
  border: none;

  font-size: 18px;
  cursor: pointer;

  color: #9ca3af;
}

.close-btn:hover {
  color: #f9fafb;
}

/* === hints & alerts === */
.hint {
  margin-top: 0.25rem;
  font-size: 0.75rem;
  line-height: 1rem;
  color: #94a3b8;
}

.alert {
  margin-top: 0.5rem;
  padding: 0.5rem 0.75rem;

  font-size: 0.875rem;
  line-height: 1.25rem;

  border-radius: 0.375rem;
  border: 1px solid;
}

/* 错误提示：暗红 */
.alert-error {
  color: #fecaca;
  background-color: rgba(127, 29, 29, 0.25);
  border-color: rgba(239, 68, 68, 0.35);
}

/* 成功提示：暗绿 */
.alert-success {
  color: #bbf7d0;
  background-color: rgba(22, 101, 52, 0.25);
  border-color: rgba(34, 197, 94, 0.35);
}
</style>