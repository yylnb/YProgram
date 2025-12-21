<template>
  <div class="modal-backdrop" @click.self="handleClose">
    <div class="modal-card" role="dialog" aria-modal="true">
      <header class="modal-header">
        <h3 class="modal-title">编辑个人资料</h3>
        <button class="close-btn" @click="handleClose" aria-label="关闭">✕</button>
      </header>

      <div class="modal-body">
        <div class="left-col" ref="leftCol">
          <!-- avatar preview -->
          <div class="avatar-preview" :style="avatarPreviewStyle">
            <span v-if="emoji" class="preview-emoji">{{ emoji }}</span>
            <span v-else class="preview-text">{{ previewInitial }}</span>
          </div>

          <div class="field small">
            <label>头像 Emoji</label>
            <div class="control-row">
              <button class="emoji-btn" ref="emojiBtn" @click="toggleEmojiPicker">{{ emoji || '选择 Emoji' }}</button>
              <button class="btn-mini" @click="clearEmoji">清除</button>
            </div>

            <!-- teleport 到 body 的 overlay（不在 modal flow 中） -->
            <teleport to="body">
              <!-- <div v-if="showEmojiPicker" class="palette emoji-palette overlay" :style="emojiStyle" @click.stop>
                <div class="emoji-grid">
                  <button
                    v-for="(e, idx) in emojiOptions"
                    :key="'e'+idx"
                    class="emoji-item"
                    @click="selectEmoji(e)"
                  >{{ e }}</button>

                  <div class="emoji-custom">
                    <input v-model="customEmoji" placeholder="自定义 emoji" @keyup.enter="applyCustomEmoji" />
                    <button class="btn-mini" @click="applyCustomEmoji">应用自定义</button>
                  </div>
                </div>
              </div> -->

              <div
                v-if="showEmojiPicker"
                class="overlay-mask"
                @click="showEmojiPicker = false"
              >
                <div
                  class="palette emoji-palette overlay"
                  :style="emojiStyle"
                  @click.stop
                >
                  <div class="emoji-grid">
                    <button
                      v-for="(e, idx) in emojiOptions"
                      :key="'e'+idx"
                      class="emoji-item"
                      @click="selectEmoji(e)"
                    >{{ e }}</button>

                    <!-- custom option -->
                    <div class="emoji-custom">
                      <input v-model="customEmoji" placeholder="自定义 emoji" @keyup.enter="applyCustomEmoji" />
                      <button class="btn-mini" @click="applyCustomEmoji">应用自定义</button>
                    </div>
                  </div>
                </div>
              </div>
            </teleport>
          </div>

          <div class="field small">
            <label>头像背景色</label>
            <div class="control-row">
              <button class="color-btn" ref="colorBtn" @click="toggleColorPicker" :style="{ background: color }">{{ colorLabel }}</button>
              <button class="btn-mini" @click="clearColor">清除</button>
            </div>

            <!-- teleport 到 body 的颜色面板 overlay -->
            <teleport to="body">
              <!-- <div v-if="showColorPicker" class="palette color-palette overlay color-overlay" :style="colorStyle" @click.stop>
                <div class="color-grid">
                  <button
                    v-for="(c, idx) in colorOptions"
                    :key="'c'+idx"
                    class="color-item"
                    :style="{ background: c }"
                    @click="selectColor(c)"
                  ></button>
                </div>
              </div> -->

              <div
                v-if="showColorPicker"
                class="overlay-mask"
                @click="showColorPicker = false"
              >
                <div
                  class="palette color-palette overlay color-overlay"
                  :style="colorStyle"
                  @click.stop
                >
                  <div class="color-grid">
                    <button
                      v-for="(c, idx) in colorOptions"
                      :key="'c'+idx"
                      class="color-item"
                      :style="{ background: c }"
                      @click="selectColor(c)"
                    ></button>
                  </div>
                </div>
              </div>
            </teleport>
          </div>

          <!-- 专门的头像保存按钮 -->
          <div class="field">
            <!-- <div class="hint">头像设置单独保存（emoji 与 背景色）</div> -->
            <div style="margin-top:8px;">
              <button class="btn btn-primary" :disabled="savingAvatar" @click="saveAvatar">
                <span v-if="savingAvatar">保存中…</span>
                <span v-else>保存头像</span>
              </button>
              <span v-if="avatarMsg" class="msg" :class="{'msg-error': avatarError, 'msg-success': !avatarError}">{{ avatarMsg }}</span>
            </div>
          </div>
        </div>

        <div class="right-col">
          <!-- 用户名 -->
          <div class="field">
            <label>用户名</label>
            <div class="username-row">
              <input :readonly="!editingName" v-model="usernameInput" />
              <div class="name-actions">
                <button v-if="!editingName" class="btn-small" @click="startEditName">修改</button>

                <div v-else style="display:flex; flex-direction:column; gap:6px;">
                  <button class="btn-small primary" :disabled="savingUsername" @click="confirmUsername">
                    <span v-if="savingUsername">确认中…</span>
                    <span v-else>确认</span>
                  </button>
                  <button class="btn-small" @click="cancelEditName">取消</button>
                </div>
              </div>
            </div>

            <!-- <p class="hint">修改用户名需要后端校验。若用户名重复会提示并允许重新输入。</p> -->
            <div v-if="usernameMsg" class="msg" :class="{'msg-error': usernameError, 'msg-success': !usernameError}">{{ usernameMsg }}</div>
          </div>

          <!-- 密码 -->
          <div class="field">
            <label>密码</label>
            <div class="password-row">
              <div v-if="!editingPassword" class="pw-placeholder">••••••••</div>
              <div v-else class="pw-inputs">
                <input type="password" placeholder="原密码" v-model="oldPassword" />
                <input type="password" placeholder="新密码" v-model="newPassword" />
                <input type="password" placeholder="确认新密码" v-model="newPasswordConfirm" />
              </div>
              <div class="pw-actions">
                <button v-if="!editingPassword" class="btn-small" @click="editingPassword = true">修改</button>
                <div v-else style="display:flex; flex-direction:column; gap:6px;">
                  <button class="btn-small primary" :disabled="savingPassword" @click="confirmPassword">
                    <span v-if="savingPassword">确认中…</span>
                    <span v-else>确认</span>
                  </button>
                  <button class="btn-small" @click="cancelEditPassword">取消</button>
                </div>
              </div>
            </div>
            <!-- <p class="hint">更改密码会直接在此处调用后端接口并在成功后刷新页面。</p> -->
            <div v-if="passwordMsg" class="msg" :class="{'msg-error': passwordError, 'msg-success': !passwordError}">{{ passwordMsg }}</div>
          </div>

          <!-- 联系方式（单独修改） -->
          <div class="field">
            <label>联系方式</label>
            <div class="username-row">
              <input :readonly="!editingContact" v-model="contact" placeholder="电话或邮箱" />
              <div class="name-actions">
                <button v-if="!editingContact" class="btn-small" @click="startEditContact">修改</button>

                <div v-else style="display:flex; flex-direction:column; gap:6px;">
                  <button class="btn-small primary" :disabled="savingContact" @click="confirmContact">
                    <span v-if="savingContact">确认中…</span>
                    <span v-else>确认</span>
                  </button>
                  <button class="btn-small" @click="cancelEditContact">取消</button>
                </div>
              </div>
            </div>

            <!-- <p class="hint">联系方式修改将同步到后端并在成功后刷新页面。</p> -->
            <div v-if="contactMsg" class="msg" :class="{'msg-error': contactError, 'msg-success': !contactError}">{{ contactMsg }}</div>
          </div>

          <!-- 不再有全局保存按钮 -->
          <div class="field actions-row">
            <button class="btn btn-outline" @click="handleClose">关闭</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed, nextTick, watch, onBeforeUnmount } from 'vue'
import axios from 'axios'

const emit = defineEmits(['close','saved'])

// emoji & color sets
const emojiOptions = [
  '🙂','😄','😎','🤓','🤖','😺','👾','🦊','🐼','🐵',
  '🐸','🐯','🦁','🐙','🌟','🔥','🍀','🚀','🎯','🎧'
]
const colorOptions = [
  '#FF7A59','#FFB86B','#FFD166','#FFEF9F','#C7F9CC',
  '#7AE7C7','#5EEAD4','#6ED4FF','#74C0FC','#8B8BFF',
  '#B28CFF','#F6A6FF','#FF9AD1','#FF7AB6','#FF6B9A',
  '#F87272','#F97316','#F59E0B','#FACC15','#34D399'
]

// reactive state
const emoji = ref(null)
const color = ref('#2563eb')
const showEmojiPicker = ref(false)
const showColorPicker = ref(false)
const customEmoji = ref('')

const editingName = ref(false)
const usernameInput = ref('')
const savingUsername = ref(false)
const usernameMsg = ref('')
const usernameError = ref(false)

const editingPassword = ref(false)
const oldPassword = ref('')
const newPassword = ref('')
const newPasswordConfirm = ref('')
const savingPassword = ref(false)
const passwordMsg = ref('')
const passwordError = ref(false)

const editingContact = ref(false)
const contact = ref('')
const savingContact = ref(false)
const contactMsg = ref('')
const contactError = ref(false)

const savingAvatar = ref(false)
const avatarMsg = ref('')
const avatarError = ref(false)

// refs for buttons & positioning
const emojiBtn = ref(null)
const colorBtn = ref(null)
const leftCol = ref(null)
const emojiStyle = ref({})
const colorStyle = ref({})

// load existing from localStorage
onMounted(() => {
  try {
    const raw = localStorage.getItem('yp_user')
    if (raw) {
      const parsed = JSON.parse(raw)
      emoji.value = parsed.user_emoji ?? parsed.avatar_emoji ?? parsed.user_emoji ?? null
      color.value = parsed.user_color ?? parsed.avatar_color ?? color.value
      usernameInput.value = (parsed.username ?? parsed.name ?? '')
      contact.value = parsed.contact ?? parsed.phone ?? parsed.email ?? ''
    }
  } catch (e) {
    // ignore parse errors
  }

  // update positions if open initially
  addWindowListeners()
})

onBeforeUnmount(() => {
  removeWindowListeners()
})

// helpers
function toggleEmojiPicker(){ 
  showEmojiPicker.value = !showEmojiPicker.value; 
  showColorPicker.value = false;
  if (showEmojiPicker.value) {
    nextTick(updateEmojiPos)
  }
}
function toggleColorPicker(){ 
  showColorPicker.value = !showColorPicker.value; 
  showEmojiPicker.value = false;
  if (showColorPicker.value) {
    nextTick(updateColorPos)
  }
}
function selectEmoji(e){ emoji.value = e; showEmojiPicker.value = false; clearMsgAfterDelay() }
function applyCustomEmoji(){
  const s = (customEmoji.value || '').trim()
  if (!s) return
  emoji.value = s
  customEmoji.value = ''
  showEmojiPicker.value = false
  clearMsgAfterDelay()
}
function clearEmoji(){ emoji.value = null }

function selectColor(c){ color.value = c; showColorPicker.value = false; clearMsgAfterDelay() }
function clearColor(){ color.value = '#2563eb' }

const previewInitial = computed(()=>{
  try {
    const raw = localStorage.getItem('yp_user')
    if (raw) {
      const p = JSON.parse(raw)
      const n = (p.username ?? p.name ?? '') || usernameInput.value || ''
      return n ? String(n).trim()[0].toUpperCase() : 'U'
    }
  } catch(e){}
  return usernameInput.value ? usernameInput.value[0].toUpperCase() : 'U'
})

const avatarPreviewStyle = computed(()=>{
  return {
    background: emoji.value ? color.value : 'linear-gradient(90deg,#2563eb,#7c3aed)',
    color: '#fff'
  }
})

// position update helpers
function updateEmojiPos() {
  if (!emojiBtn.value) return
  const rect = emojiBtn.value.getBoundingClientRect()
  // place below button, but if not enough space place above
  const pad = 8
  const elWidth = 320
  const elHeightEstimate = 220
  let left = rect.left
  // ensure not overflow right
  if (left + elWidth > window.innerWidth - 12) left = window.innerWidth - elWidth - 12
  if (left < 12) left = 12

  let top = rect.bottom + pad
  if (top + elHeightEstimate > window.innerHeight - 12) {
    // place above
    top = rect.top - elHeightEstimate - pad
    if (top < 12) top = 12
  }

  emojiStyle.value = {
    position: 'absolute',
    top: `${top}px`,
    left: `${left}px`,
    width: `${elWidth}px`,
    zIndex: 4000
  }
}

function updateColorPos() {
  if (!colorBtn.value) return
  const rect = colorBtn.value.getBoundingClientRect()
  const pad = 8
  const elWidth = 260
  const elHeightEstimate = 180
  let left = rect.left
  if (left + elWidth > window.innerWidth - 12) left = window.innerWidth - elWidth - 12
  if (left < 12) left = 12

  let top = rect.bottom + pad
  if (top + elHeightEstimate > window.innerHeight - 12) {
    top = rect.top - elHeightEstimate - pad
    if (top < 12) top = 12
  }

  colorStyle.value = {
    position: 'absolute',
    top: `${top}px`,
    left: `${left}px`,
    width: `${elWidth}px`,
    zIndex: 4000
  }
}

function addWindowListeners() {
  window.addEventListener('resize', onWindowChange)
  window.addEventListener('scroll', onWindowChange, true)
}

function removeWindowListeners() {
  window.removeEventListener('resize', onWindowChange)
  window.removeEventListener('scroll', onWindowChange, true)
}

function onWindowChange() {
  if (showEmojiPicker.value) nextTick(updateEmojiPos)
  if (showColorPicker.value) nextTick(updateColorPos)
}

// small helpers
function handleClose(){ emit('close') }

function clearMsgAfterDelay() {
  setTimeout(()=> {
    avatarMsg.value = ''
    avatarError.value = false
    usernameMsg.value = ''
    usernameError.value = false
    contactMsg.value = ''
    contactError.value = false
    passwordMsg.value = ''
    passwordError.value = false
  }, 4000)
}

// ---------- Avatar save (PATCH /api/user/profile) ----------
async function saveAvatar(){
  savingAvatar.value = true
  avatarMsg.value = ''
  avatarError.value = false

  const token = localStorage.getItem('yp_token')
  try {
    const body = { }
    body.user_emoji = (emoji.value == null ? '' : emoji.value)
    body.user_color = (color.value == null ? '' : color.value)

    const res = await axios.patch('/api/user/profile', body, {
      headers: token ? { Authorization: `Bearer ${token}` } : {}
    })

    if (res && res.data && res.data.success && res.data.user) {
      try { localStorage.setItem('yp_user', JSON.stringify(res.data.user)) } catch (e) {}
      avatarMsg.value = '保存成功，页面将刷新……'
      avatarError.value = false
      setTimeout(()=> window.location.reload(), 700)
    } else {
      avatarMsg.value = '保存失败（服务端返回异常）'
      avatarError.value = true
    }
  } catch (err) {
    avatarError.value = true
    if (err.response && err.response.data && err.response.data.error) {
      avatarMsg.value = `保存失败：${err.response.data.error}`
    } else {
      avatarMsg.value = '网络或服务器错误，保存失败'
    }
  } finally {
    savingAvatar.value = false
    clearMsgAfterDelay()
  }
}

// ---------- Username change (PATCH /api/user/username) ----------
function startEditName(){ editingName.value = true; usernameMsg.value=''; usernameError.value=false }

async function confirmUsername(){
  const newUsername = (usernameInput.value || '').trim()
  if (!newUsername) {
    usernameMsg.value = '用户名不能为空'
    usernameError.value = true
    return
  }

  savingUsername.value = true
  usernameMsg.value = ''
  usernameError.value = false

  const token = localStorage.getItem('yp_token')
  try {
    const res = await axios.patch('/api/user/username', { newUsername }, {
      headers: token ? { Authorization: `Bearer ${token}` } : {}
    })

    if (res && res.data && res.data.success && res.data.user) {
      try { localStorage.setItem('yp_user', JSON.stringify(res.data.user)) } catch (e) {}
      usernameMsg.value = '用户名修改成功，页面将刷新……'
      usernameError.value = false
      setTimeout(()=> window.location.reload(), 700)
    } else {
      usernameMsg.value = '用户名修改失败（服务端返回异常）'
      usernameError.value = true
      editingName.value = true
    }
  } catch (err) {
    if (err.response && err.response.status === 409) {
      usernameMsg.value = '用户名已被占用，请换一个再试'
      usernameError.value = true
      editingName.value = true
    } else if (err.response && err.response.data && err.response.data.error) {
      usernameMsg.value = `修改失败：${err.response.data.error}`
      usernameError.value = true
      editingName.value = true
    } else {
      usernameMsg.value = '网络或服务器错误，修改失败'
      usernameError.value = true
      editingName.value = true
    }
  } finally {
    savingUsername.value = false
    clearMsgAfterDelay()
  }
}

function cancelEditName(){
  editingName.value = false
  const raw = localStorage.getItem('yp_user')
  if (raw) {
    try {
      const p = JSON.parse(raw)
      usernameInput.value = p.username ?? p.name ?? ''
    } catch(e){}
  }
}

// ---------- Contact change (PATCH /api/user/contact) ----------
function startEditContact(){ editingContact.value = true; contactMsg.value=''; contactError.value=false }

async function confirmContact(){
  const c = (contact.value || '').trim()
  savingContact.value = true
  contactMsg.value = ''
  contactError.value = false

  const token = localStorage.getItem('yp_token')
  try {
    const res = await axios.patch('/api/user/contact', { contact: c }, {
      headers: token ? { Authorization: `Bearer ${token}` } : {}
    })

    if (res && res.data && res.data.success && res.data.user) {
      try { localStorage.setItem('yp_user', JSON.stringify(res.data.user)) } catch (e) {}
      contactMsg.value = '联系方式修改成功，页面将刷新……'
      contactError.value = false
      setTimeout(()=> window.location.reload(), 700)
    } else {
      contactMsg.value = '修改失败（服务端返回异常）'
      contactError.value = true
    }
  } catch (err) {
    contactError.value = true
    if (err.response && err.response.data && err.response.data.error) {
      contactMsg.value = `修改失败：${err.response.data.error}`
    } else {
      contactMsg.value = '网络或服务器错误，修改失败'
    }
  } finally {
    savingContact.value = false
    clearMsgAfterDelay()
  }
}

function cancelEditContact(){
  editingContact.value = false
  const raw = localStorage.getItem('yp_user')
  if (raw) {
    try {
      const p = JSON.parse(raw)
      contact.value = p.contact ?? p.phone ?? p.email ?? ''
    } catch(e){}
  }
}

// ---------- Password change (POST /api/user/change-password) ----------
async function confirmPassword(){
  if (!oldPassword.value || !newPassword.value || !newPasswordConfirm.value) {
    passwordMsg.value = '请填写所有密码字段'
    passwordError.value = true
    return
  }
  if (newPassword.value !== newPasswordConfirm.value) {
    passwordMsg.value = '新密码与确认不一致'
    passwordError.value = true
    return
  }
  // basic check: length >= 6
  if (typeof newPassword.value !== 'string' || newPassword.value.length < 6) {
    passwordMsg.value = '新密码长度至少 6 位'
    passwordError.value = true
    return
  }
  // must contain both letters and numbers
  if (!/[A-Za-z]/.test(newPassword.value) || !/[0-9]/.test(newPassword.value)) {
    passwordMsg.value = '密码必须同时包含字母和数字';
    passwordError.value = true;
    return;
  }
  // only letters and numbers allowed
  if (!/^[A-Za-z0-9]+$/.test(newPassword.value)) {
    passwordMsg.value = '密码只能包含英文字母和数字，不能包含其它字符';
    passwordError.value = true;
    return;
  }
    

  savingPassword.value = true
  passwordMsg.value = ''
  passwordError.value = false

  const token = localStorage.getItem('yp_token')
  try {
    const res = await axios.post('/api/user/change-password', {
      oldPassword: oldPassword.value,
      newPassword: newPassword.value
    }, {
      headers: token ? { Authorization: `Bearer ${token}` } : {}
    })

    if (res && res.data && res.data.success) {
      passwordMsg.value = '密码修改成功，页面将刷新（请使用新密码登录）…'
      passwordError.value = false
      // clear local sensitive fields
      oldPassword.value = ''
      newPassword.value = ''
      newPasswordConfirm.value = ''
      setTimeout(()=> window.location.reload(), 700)
    } else {
      passwordMsg.value = '密码修改失败（服务端返回异常）'
      passwordError.value = true
    }
  } catch (err) {
    passwordError.value = true
    if (err.response && err.response.status === 401) {
      passwordMsg.value = '当前密码错误，请重试'
    } else if (err.response && err.response.data && err.response.data.error) {
      passwordMsg.value = `修改失败：${err.response.data.error}`
    } else {
      passwordMsg.value = '网络或服务器错误，修改失败'
    }
  } finally {
    savingPassword.value = false
    clearMsgAfterDelay()
  }
}

function cancelEditPassword(){
  editingPassword.value = false
  oldPassword.value = ''
  newPassword.value = ''
  newPasswordConfirm.value = ''
}
</script>

<style scoped>
/* ===============================
   Modal Backdrop & Card (Dark)
================================ */
.modal-backdrop {
  position: fixed;
  inset: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(0, 0, 0, 0.65);
  z-index: 2000;
  padding: 20px;
}

.modal-card {
  width: 920px;
  max-width: 98%;
  min-height: 70vh;
  max-height: 80vh;
  background: linear-gradient(180deg, rgba(255,255,255,0.02), rgba(255,255,255,0.01));
  -webkit-backdrop-filter: blur(8px);
  backdrop-filter: blur(30px);
  border-radius: 14px;
  padding: 18px;
  box-shadow: 12px 12px 36px rgba(194, 194, 194, 0.7);
  display: flex;
  flex-direction: column;
  border: 1px solid rgba(255, 255, 255, 0.737);
  overflow: auto;
}

/* ===============================
   Header
================================ */
.modal-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 8px;
}

.modal-title {
  font-size: 20px;
  font-weight: 900;
  color: #ffffff;
}

.close-btn {
  background: transparent;
  border: none;
  font-size: 25px;
  cursor: pointer;
  color: #cbd5f5;
}
.close-btn:hover {
  color: #ffffff;
  transform: translateY(-3px);
  transition: all 0.2s ease-in-out;
}

/* ===============================
   Layout
================================ */
.modal-body {
  display: flex;
  gap: 18px;
}

.left-col {
  width: 320px;
  display: flex;
  flex-direction: column;
  gap: 12px;
  position: relative; /* keep for potential internal absolute positioning */
}

.right-col {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

/* ===============================
   Avatar Preview
================================ */
.avatar-preview {
  width: 120px;
  height: 120px;
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 36px;
  font-weight: 900;
  color: #ffffff;
  box-shadow: 0 16px 40px rgba(0,0,0,0.6);
}

.preview-emoji {
  font-size: 44px;
}

/* ===============================
   Fields & Labels
================================ */
.field {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.field.small {
  gap: 6px;
}

.field label {
  font-size: 13px;
  font-weight: 800;
  color: #e5e7eb;
}

.control-row {
  display: flex;
  gap: 30px;
  align-items: center;
}

/* ===============================
   Inputs
================================ */
.field input,
.username-row input,
.password-row input,
.emoji-custom input {
  padding: 8px 10px;
  border-radius: 8px;
  background: #0f1629;
  border: 1px solid rgba(255,255,255,0.08);
  color: #ffffff;
  outline: none;
}

.field input::placeholder {
  color: #6b7280;
}

.field input:focus {
  border-color: #7c3aed;
  box-shadow: 0 0 0 1px rgba(124,58,237,0.4);
}

/* ===============================
   Buttons
================================ */
.emoji-btn,
.color-btn {
  padding: 8px 12px;
  border-radius: 8px;
  background: #111827;
  color: #ffffff;
  border: 1px solid rgba(255,255,255,0.08);
  cursor: pointer;
}
.color-btn {
  margin-left: 12px;
  margin-right: 10px;
}

.btn-mini {
  padding: 6px 8px;
  border-radius: 8px;
  background: #fffffff8;
  color: #000;
  border: 1px solid rgba(255,255,255,0.08);
  cursor: pointer;
}
.btn-mini:hover {
  background: #ffffffae;
  transform: translateY(-2px);
  transition: all 0.2s ease-in-out;
}

.emoji-btn:hover {
  background: #020617;
}

/* ===============================
   Palette (Emoji / Color) - overlay styles
   These are rendered in body via teleport
================================ */
.overlay {
  border-radius: 10px;
  padding: 10px;
  background: linear-gradient(180deg, rgba(10,12,18,0.96), rgba(18,20,28,0.98));
  border: 1px solid rgba(255,255,255,0.06);
  box-shadow: 0 20px 60px rgba(2,6,23,0.6);
  max-height: 65vh;
  overflow: auto;
}

/* keep previous palette class compatibility */
.palette {
  margin-top: 8px;
  border-radius: 10px;
  padding: 10px;
  border: none;
}

.emoji-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
}

.emoji-item {
  width: 44px;
  height: 36px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  border-radius: 8px;
  background: #0f172a;
  border: 1px solid rgba(255,255,255,0.06);
  cursor: pointer;
}

.emoji-item:hover {
  background: #1e293b;
}

.emoji-custom {
  display: flex;
  gap: 8px;
  align-items: center;
  margin-left: 6px;
  margin-top: 6px;
}

.color-grid {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  gap: 8px;
}

.color-item {
  width: 100%;
  aspect-ratio: 1 / 1;
  border-radius: 8px;
  border: 1px solid rgba(255,255,255,0.1);
  cursor: pointer;
}

/* ===============================
   Overlay click-outside mask
================================ */
.overlay-mask {
  position: fixed;
  inset: 0;
  z-index: 3999; /* 比 modal 高，比 overlay 低 */
  background: transparent;
}

/* ===============================
   Username / Password Rows
================================ */
.username-row,
.password-row {
  display: flex;
  gap: 30px;
  align-items: flex-start;
}

.name-actions,
.pw-actions {
  display: flex;
  gap: 8px;
  flex-direction: column;
}

.btn-small {
  padding: 6px 8px;
  border-radius: 8px;
  background: #fffffff8;
  color: #000;
  border: 1px solid rgba(255,255,255,0.08);
  cursor: pointer;
}
.btn-small:hover {
  background: #ffffffae;
  transform: translateY(-2px);
  transition: all 0.2s ease-in-out;
}

.btn-small.primary {
  background: linear-gradient(90deg, #2563eb, #7c3aed);
  color: #ffffff;
  border: none;
}

.pw-inputs {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.pw-placeholder {
  padding: 8px 12px;
  color: #9ca3af;
}

/* ===============================
   Footer Actions
================================ */
.actions-row {
  display: flex;
  gap: 10px;
  justify-content: flex-end;
  margin-top: 6px;
}

.btn {
  padding: 8px 12px;
  border-radius: 8px;
  cursor: pointer;
  font-weight: 800;
}

.btn-primary {
  background: linear-gradient(90deg, #2563eb, #7c3aed);
  color: #ffffff;
  border: none;
}

.btn-outline {
  background: transparent;
  border: 1px solid rgba(255,255,255,0.15);
  color: #ffffff;
}
.btn-outline:hover {
  background: rgba(255,255,255,0.05);
}

/* ===============================
   Hint & Messages
================================ */
.hint {
  font-size: 12px;
  color: #9ca3af;
  margin-top: 4px;
}

.msg {
  margin-left: 12px;
  font-size: 13px;
}

.msg-error {
  color: #f87171;
}

.msg-success {
  color: #34d399;
}

/* small responsive tweak */
@media (max-width: 760px) {
  .modal-card { width: 96%; padding: 12px; }
  .avatar-preview { width: 96px; height: 96px; }
  /* modal 内部改为纵向布局 */
  .modal-body {
    flex-direction: column;
  }

  /* 左右栏都占满宽度 */
  .left-col,
  .right-col {
    width: 100%;
  }

  /* modal 本身允许纵向滚动 */
  .modal-card {
    max-height: 90vh;
    overflow-y: auto;
  }

  /* 给底部一点安全空间，避免被系统手势遮挡 */
  .modal-body {
    padding-bottom: 12px;
  }
}
  

</style>