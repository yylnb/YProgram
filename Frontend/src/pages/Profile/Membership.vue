<template>
  <div class="membership-root">
    <div class="membership-card">
      <!-- Header -->
      <header class="card-header">
        <div class="title-group">
          <div class="brand">
            <svg class="brand-logo" viewBox="0 0 64 64" aria-hidden>
              <defs>
                <linearGradient id="g1" x1="0" x2="1">
                  <stop offset="0" stop-color="#7C4DFF"/>
                  <stop offset="1" stop-color="#4DD0E1"/>
                </linearGradient>
              </defs>
              <rect x="0" y="0" width="64" height="64" rx="12" fill="url(#g1)"/>
              <text x="50%" y="55%" text-anchor="middle" font-size="28" font-weight="800" fill="#041025" font-family="system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', Arial">Y</text>
            </svg>
            <div class="title-text">
              <div class="ypro-title">YPro <span class="pro-accent">会员</span></div>
              <div class="subtitle">获取无限能量特权</div>
            </div>
          </div>
        </div>

        <div class="status-area">
          <div class="status-pill" v-if="loading">加载中…</div>
          <div class="status-pill" v-else>
            <template v-if="membership && membership.active">
              <svg class="check" viewBox="0 0 24 24" aria-hidden><path d="M20 6L9 17l-5-5" /></svg>
              <span>已激活</span>
            </template>
            <template v-else>
              <svg class="cross" viewBox="0 0 24 24" aria-hidden><path d="M18 6L6 18M6 6l12 12" /></svg>
              <span>未订阅</span>
            </template>
          </div>
        </div>
      </header>

      <!-- Body -->
      <main class="card-body">
        <!-- 左侧：大卡 info -->
        <div class="panel-left">
          <div class="big-badge" :class="{ active: membership && membership.active }">
            <div class="badge-top">🎖️</div>
            <div class="badge-main">YPro</div>
            <div class="badge-sub" v-if="membership && membership.active">已开通</div>
            <div class="badge-sub" v-else>立即开通</div>
          </div>

          <!-- <div class="account-line">
            <div class="acc-label">账号</div>
            <div class="acc-value">{{ profile?.username ?? '未登录' }}</div>
          </div> -->
        </div>

        <!-- 右侧：动作与提示 -->
        <div class="panel-right">
          <div v-if="!loading && membership && membership.active" class="member-block">
            <div class="exp-label">到期时间</div>

            <!-- 翻页式日期显示 -->
            <div class="flip-date" aria-live="polite" role="status">
              <template v-for="(ch, idx) in dateChars" :key="idx">
                <span class="flip-card">
                  <span class="flip-inner" :class="{ 'flip-active': flipStates[idx] }">
                    <span class="front">{{ prevChars[idx] ?? ch }}</span>
                    <span class="back">{{ ch }}</span>
                  </span>
                </span>
              </template>
            </div>

            <p class="hint">感谢支持！你可以通过下方方式续费或邀请好友获得优惠。</p>

            <div class="btn-row">
              <!-- 邀请作为主按钮（颜色引导） -->
              <button class="btn btn-primary" @click="handleInvite">
                <svg class="icon" viewBox="0 0 24 24" aria-hidden><path d="M4 12v7a1 1 0 0 0 1 1h14"/></svg>
                邀请好友
              </button>

              <!-- 在线支付改为弹窗提示 -->
              <button class="btn btn-outline" @click="openPayModal">
                <svg class="icon" viewBox="0 0 24 24" aria-hidden><path d="M12 1v22"/></svg>
                续费 / 在线支付
              </button>
            </div>
          </div>

          <div v-else-if="!loading" class="no-member-block">
            <div class="no-title">🔒 你还不是 YPro 会员</div>
            <p class="hint">开通后可获得无限能量特权。</p>

            <ul class="benefits">
              <li>• 邀请好友：邀请成功可获得一个月时长</li>
              <li>• 充值开通：根据需求个性化定制</li>
            </ul>

            <div class="btn-row">
              <!-- 邀请为主操作 -->
              <button class="btn btn-primary" @click="handleInvite">
                <svg class="icon" viewBox="0 0 24 24" aria-hidden><path d="M4 12v7a1 1 0 0 0 1 1h14"/></svg>
                邀请好友获取YPro
              </button>

              <!-- 充值 -> 打开弹窗说明（没有在线支付） -->
              <button class="btn btn-outline" @click="openPayModal">
                <svg class="icon" viewBox="0 0 24 24" aria-hidden><path d="M12 1v22"/></svg>
                立即充值
              </button>
            </div>
          </div>

          <div v-else class="skeleton">
            <div class="s-line s-title"></div>
            <div class="s-line s-sub"></div>
          </div>
        </div>
      </main>

      <!-- Footer -->
      <footer class="card-footer">
        <div class="foot-left">
          <!-- <small class="muted">帮助：<a href="#" @click.prevent="$emit('open-help')">联系客服</a></small> -->
        </div>
        <div class="foot-right">
          <!-- <small class="muted">版本：YPro · 2025</small> -->
        </div>
      </footer>
    </div>

    <!-- 提示泡 -->
    <div v-if="notice" class="notice" :class="noticeType">{{ notice }}</div>

    <!-- 自定义弹窗（在线支付提示） -->
    <div v-if="payModalVisible" class="modal-overlay" @click.self="closePayModal">
      <div class="modal">
        <header class="modal-header">
          <h4>关于在线支付</h4>
          <button class="modal-close" @click="closePayModal">✕</button>
        </header>
        <div class="modal-body">
          <p>当前我们尚未接入在线支付通道（微信/支付宝）。</p>
          <p>如果你想开通会员，可先通过以下方式：</p>
          <ul>
            <li>1) 邀请好友开通：邀请成功后你将获得优惠或延长时长。</li>
            <li>2) 联系开发者：我们可手动为你开通并提供线下支付方案。</li>
          </ul>
          <p class="muted" style="margin-top:10px;color:#6d6d6d">开发者正在学业之余开发中，敬请期待！</p>
        </div>
        <footer class="modal-footer">
          <button class="btn btn-primary" @click="handleInvite">邀请好友</button>
          <button class="btn btn-outline" @click="closePayModal">知道了</button>
        </footer>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, watch, nextTick } from 'vue'

const props = defineProps({
  profile: { type: Object, default: () => ({}) }
})

const emit = defineEmits(['open-help'])

const membership = ref(null)
const loading = ref(false)

const notice = ref('')
const noticeType = ref('') // 'success'|'error'
let noticeTimer = null

// pay modal
const payModalVisible = ref(false)

function showNotice(text, type = 'success', ms = 3000) {
  clearTimeout(noticeTimer)
  notice.value = text
  noticeType.value = type
  noticeTimer = setTimeout(() => {
    notice.value = ''
    noticeType.value = ''
  }, ms)
}

// ----- membership load -----
async function loadMembership() {
  const token = localStorage.getItem('yp_token')
  if (!token) {
    membership.value = { active: false }
    return
  }
  loading.value = true
  try {
    const res = await fetch('/api/user/membership', { headers: { 'Authorization': `Bearer ${token}` } })
    if (!res.ok) {
      membership.value = { active: false }
      return
    }
    const data = await res.json()
    if (data && data.end_at) {
      membership.value = {
        active: new Date(data.end_at) > new Date(),
        end_at_raw: data.end_at,
        end_at: new Date(data.end_at).toLocaleString()
      }
    } else {
      membership.value = { active: false }
    }
  } catch (e) {
    console.error('membership load error', e)
    membership.value = { active: false }
  } finally {
    loading.value = false
  }
}

// ----- invite -----
function handleInvite() {
  const base = location.origin
  const inviteCode = props.profile && props.profile.invite_code ? props.profile.invite_code : (Math.random().toString(36).slice(2,8))
  const username = (props.profile && props.profile.username) ? props.profile.username : '你的朋友'
  // const link = `${base}/invite/${inviteCode}`
  const weblink = `http://ypro.online`
  const link = `朋友，我在 YProgram 找到了一套很棒的编程题库，点击链接查看并注册：\n${weblink}\n（记得报我名字哦，由 ${username} 推荐）`

  if (navigator.clipboard && navigator.clipboard.writeText) {
    navigator.clipboard.writeText(link).then(() => {
      showNotice('邀请链接已复制到剪贴板', 'success')
    }).catch(() => {
      showNotice(`复制失败，请手动复制：${link}`, 'error', 5000)
    })
  } else {
    showNotice(`请手动复制链接：${link}`, 'error', 5000)
  }
}

// ----- pay modal -----
function openPayModal() { payModalVisible.value = true }
function closePayModal() { payModalVisible.value = false }

// ----- flip date animation -----
const dateChars = ref([])        // 当前目标字符数组
const prevChars = ref([])        // 前一帧字符（用于从旧到新翻页视觉）
const flipStates = ref([])       // 每个字符是否翻转（触发CSS）
let flipTimers = []

function prepareDateAnimation() {
  clearFlipTimers()
  dateChars.value = []
  prevChars.value = []
  flipStates.value = []

  if (!membership.value || !membership.value.active || !membership.value.end_at_raw) return

  const d = new Date(membership.value.end_at_raw)
  const pad = (n) => String(n).padStart(2, '0')
  const formatted = `${d.getFullYear()}-${pad(d.getMonth()+1)}-${pad(d.getDate())} ${pad(d.getHours())}:${pad(d.getMinutes())}`
  dateChars.value = formatted.split('')
  prevChars.value = Array(dateChars.value.length).fill(' ')
  flipStates.value = Array(dateChars.value.length).fill(false)

  dateChars.value.forEach((_, i) => {
    const t = setTimeout(() => {
      flipStates.value[i] = true
      setTimeout(() => {
        prevChars.value[i] = dateChars.value[i]
        flipStates.value[i] = false
      }, 420)
    }, 120 * i + 150)
    flipTimers.push(t)
  })
}

function clearFlipTimers() {
  flipTimers.forEach(t => clearTimeout(t))
  flipTimers = []
}

onMounted(async () => {
  await loadMembership()
  if (membership.value && membership.value.active) {
    await nextTick()
    prepareDateAnimation()
  }
})

watch(membership, async (nv) => {
  if (nv && nv.active) {
    await nextTick()
    prepareDateAnimation()
  } else {
    clearFlipTimers()
    dateChars.value = []
    prevChars.value = []
    flipStates.value = []
  }
})

onUnmounted(() => {
  clearFlipTimers()
  clearTimeout(noticeTimer)
})
</script>

<style scoped>
/* 全局背景与字体（固定深色） */
.membership-root {
  min-height: 0;
  width: 100%;
  background: #1c1c1c;
  color: #ffffff;      /* 字体白色 */
  display:flex;
  justify-content:center;
  align-items:flex-start;
  border-radius: 30px;
  box-shadow: 12px 12px 36px rgba(194, 194, 194, 0.7);
}

/* 卡片容器 */
.membership-card {
  width: 100%;
  background: rgba(255,255,255,0.03);
  border-radius: 30px;
  overflow: hidden;
}

/* header */
.card-header {
  display:flex;
  justify-content:space-between;
  align-items:center;
  padding: 20px 24px;
  gap: 12px;
}
.brand { display:flex; align-items:center; gap:14px; }
.brand-logo { width:56px; height:56px; border-radius:10px; flex-shrink:0; }
.title-text { display:flex; flex-direction:column; }
.ypro-title {
  font-size:20px;
  font-weight:800;
  letter-spacing:0.6px;
  color:#ffffff;
}
.pro-accent { color: #7C4DFF; margin-left:6px; font-weight:900; }
.subtitle { font-size:13px; color: rgba(255,255,255,0.72); margin-top:2px; }

/* 状态 */
.status-area { display:flex; gap:10px; align-items:center; }
.status-pill {
  display:flex;
  align-items:center;
  gap:8px;
  padding:8px 12px;
  border-radius:999px;
  font-size:13px;
  background: rgba(255,255,255,0.03);
  color: #fff;
  border: 1px solid rgba(255,255,255,0.02);
}
.status-pill .check, .status-pill .cross { width:16px;height:16px; stroke:currentColor; fill:none; stroke-width:2; }

/* body layout */
.card-body {
  display:flex;
  gap: 18px;
  padding: 18px 24px;
  align-items:flex-start;
  justify-content:space-between;
}

/* left panel */
.panel-left { flex:0 0 36%; display:flex; flex-direction:column; gap:18px; }
.big-badge {
  background: linear-gradient(180deg, rgba(0, 0, 0, 0.668), rgba(88, 88, 88, 0.581));
  border-radius: 12px;
  padding:18px;
  display:flex;
  flex-direction:column;
  gap:8px;
  align-items:center;
  justify-content:center;
  border: 1px solid rgba(255,255,255,0.02);
  width: 100%;
}
.big-badge.active { 
  background: linear-gradient(144deg, rgb(255, 235, 82), rgba(229, 220, 129, 0.568));
  box-shadow: 0 10px 30px rgba(255, 244, 93, 0.367); 
  border: 1px solid rgba(124,77,255,0.12); 
}
.badge-top { font-size:22px; }
.badge-main { font-size:28px; font-weight:900; color:#fff; letter-spacing:0.6px; }
.badge-sub { font-size:13px; color: rgba(255,255,255,0.72); }

.account-line { display:flex; justify-content:space-between; padding:8px 6px; color: rgba(255,255,255,0.72); font-size:13px; }

/* right panel */
.panel-right { flex:1; display:flex; flex-direction:column; gap:12px; }

.exp-label { font-size:13px; color: rgba(255,255,255,0.72); margin-bottom:6px; font-weight:600; }

/* 翻页式日期样式 */
.flip-date {
  display:inline-flex;
  gap:6px;
  align-items:center;
  margin-bottom:8px;
  flex-wrap:wrap;
}
.flip-card {
  width:22px;
  height:34px;
  perspective:900px;
  display:inline-flex;
}
.flip-inner {
  display:inline-block;
  width:100%;
  height:100%;
  transform-style:preserve-3d;
  transition: transform 0.42s ease-in;
  position:relative;
}
.flip-inner.flip-active {
  transform: rotateX(-180deg);
}
.flip-inner .front,
.flip-inner .back {
  display:flex;
  align-items:center;
  justify-content:center;
  backface-visibility:hidden;
  position:absolute;
  inset:0;
  font-weight:800;
  font-size:16px;
  border-radius:6px;
  background: rgba(255,255,255,0.02);
  color: #fff;
  border: 1px solid rgba(255,255,255,0.03);
}
.flip-inner .back {
  transform: rotateX(180deg);
}

/* hint & benefits */
.hint { color: rgba(255,255,255,0.76); font-size:13px; margin-top:6px; }
.benefits { margin:10px 0; padding-left:16px; color: rgba(255,255,255,0.72); }

/* buttons */
.btn-row { display:flex; gap:12px; margin-top:10px; flex-wrap:wrap; }
.btn {
  display:inline-flex;
  align-items:center;
  gap:8px;
  padding:10px 14px;
  border-radius:10px;
  cursor:pointer;
  font-weight:700;
  border:none;
  user-select:none;
  font-size:14px;
}
.btn .icon { width:16px;height:16px; stroke:currentColor; fill:none; stroke-width:2; }

/* 邀请为主色按钮（引导） */
.btn-primary {
  background: linear-gradient(90deg, #7C4DFF, #4DD0E1);
  color: #041025;
  box-shadow: 0 8px 20px rgba(92,88,255,0.12);
}

/* 边框按钮 */
.btn-outline {
  background: transparent;
  color: #ffffff;
  border: 1px solid rgba(255,255,255,0.06);
  backdrop-filter: blur(6px);
}

/* skeleton */
.skeleton { padding: 12px 0; }
.s-line { height: 14px; border-radius: 8px; opacity: 0.06; margin: 8px 0; background: linear-gradient(90deg, rgba(255,255,255,0.03), rgba(255,255,255,0.02)); }
.s-title { width: 60%; height: 18px; }
.s-sub { width: 40%; height: 14px; }

/* footer */
.card-footer {
  display:flex;
  justify-content:space-between;
  align-items:center;
  padding: 12px 20px;
  border-top: 1px solid rgba(255,255,255,0.03);
  font-size:13px;
  color: rgba(255,255,255,0.72);
}

/* notice */
.notice {
  position: fixed;
  left: auto;
  bottom: 28px;
  padding: 12px 16px;
  border-radius: 10px;
  font-weight:700;
  box-shadow: 0 12px 34px rgba(2,6,23,0.8);
  z-index: 2200;
}
.notice.success { background: rgba(34,197,94,0.98); color:#041025; }
.notice.error { background: rgba(239,68,68,0.98); color:#fff; }

/* modal */
.modal-overlay {
  position: fixed;
  inset: 0;
  background: rgba(255, 255, 255, 0.118);
  display:flex;
  align-items:center;
  justify-content:center;
  z-index: 2100;
  padding: 24px;
}
.modal {
  width: 100%;
  max-width: 680px;
  background: #121212;
  border-radius:12px;
  padding: 18px;
  border: 1px solid rgba(255,255,255,0.04);
  color: #fff;
  box-shadow: 0 18px 60px rgba(255, 255, 255, 0.373);
}
.modal-header { display:flex; justify-content:space-between; align-items:center; margin-bottom:8px; }
.modal-header h4 { margin:0; font-size:16px; font-weight:800; }
.modal-close { background:transparent; color:#fff; border:none; font-size:18px; cursor:pointer; }
.modal-body { color: rgba(255,255,255,0.82); font-size:14px; margin:8px 0; line-height:1.6; }
.modal-footer { display:flex; gap:12px; justify-content:flex-end; margin-top:12px; }

/* small-screen */
@media (max-width: 720px) {
  .card-body { flex-direction: column; padding: 16px; }
  .panel-left { width: 100%; flex-direction:row; justify-content:space-between; align-items:center; }
  .badge-main { font-size:20px; }
  .flip-card { width:18px; height:28px; }
  .ypro-title { font-size:18px; }
}
</style>