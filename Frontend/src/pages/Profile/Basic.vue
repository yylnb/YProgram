<template>
  <div class="p-6 basic-root">
    <div class="basic-grid">
      <!-- 左侧：头像 + 名称 -->
      <div class="left">
        <div class="avatar-wrap" title="用户头像或首字母">
          <!-- avatar: 支持 user_color + user_emoji，如果没有则显示首字母并使用渐变 -->
          <div
            class="avatar"
            :style="avatarStyle"
            role="img"
            :aria-label="avatarEmoji ? `avatar ${avatarEmoji}` : `avatar ${avatarText}`"
          >
            <span v-if="avatarEmoji" class="avatar-emoji">{{ avatarEmoji }}</span>
            <span v-else class="avatar-text">{{ avatarText }}</span>
          </div>
        </div>

        <div class="name-block">
          <div class="username">
            <span class="name-txt" v-if="prof.username">{{ prof.username }}</span>
            <span class="name-txt muted" v-else>匿名用户</span>

            <span v-if="roleLabel" class="role-badge">{{ roleLabel }}</span>
          </div>

          <div class="meta-small">
            <span class="muted">用户 ID：</span>
            <span class="id-txt">{{ displayId }}</span>
            <button class="icon-btn" @click="copyId" :title="copied ? '已复制' : '复制 ID'">
              {{ copied ? '✓' : '复制' }}
            </button>
          </div>
        </div>
      </div>

      <!-- 右侧：信息卡片（加入时长 / 打卡 / 学习语言） -->
      <div class="right">
        <div class="stats-row">
          <div class="stat-card" :style="cardStyle">
            <div class="stat-label">加入时长</div>
            <div class="stat-value" v-if="joinDays !== null">{{ joinDays }} 天</div>
            <div class="stat-value muted" v-else>未知</div>
          </div>

          <div class="stat-card" :style="cardStyle">
            <div class="stat-label">打卡天数</div>
            <div class="stat-value" v-if="streakDisplay !== null">{{ streakDisplay }} 天</div>
            <div class="stat-value muted" v-else>— 天</div>
            <div class="stat-sub muted" v-if="localMaxStreak !== null">最大连续打卡：{{ localMaxStreak }} 天</div>
            <div class="stat-sub muted" v-else>最大连续打卡：— 天</div>
          </div>

          <div class="stat-card" :style="cardStyle">
            <div class="stat-label">学习的语言</div>
            <div class="stat-value" v-if="languagesDisplay && languagesDisplay.length">
              <div class="lang-list">
                <button
                  class="lang-pill"
                  v-for="(l, i) in languagesDisplay"
                  :key="i"
                  @click="onLangClick(l)"
                >
                  {{ langLabel(l) }}
                </button>
              </div>
            </div>
            <div class="stat-value muted" v-else>未设置</div>
          </div>
        </div>

        <div class="actions">
          <button class="btn btn-primary" @click="openEdit">编辑个人资料</button>
          <!-- 账户设置 已移除 -->
        </div>
      </div>
    </div>

    <!-- BasicChange modal -->
    <BasicChange v-if="showChangeModal" @close="showChangeModal = false" @saved="onProfileSaved" />
  </div>
</template>

<script setup>
import { toRef, ref, watch, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import BasicChange from './BasicChange.vue'

const router = useRouter()

const props = defineProps({
  profile: { type: Object, default: () => ({ id: null, username: '', created_at: null }) }
})

const prof = toRef(props, 'profile')
const joinDays = ref(null)
const copied = ref(false)
const showChangeModal = ref(false)

// localStorage 缓存用户（优先从 localStorage 读取某些字段）
const localUser = ref(null)
const localCheckin = ref(null)       // 累计打卡
const localMaxStreak = ref(null)     // 最大连续打卡
const localCurrentStreak = ref(null) // 当前连续（如果你后端有此字段可填）
const localLang = ref([])

const createdRawFromProfile = computed(() => prof.value && (prof.value.created_at ?? prof.value.createdAt ?? prof.value.created ?? null))
const createdRawFromLocal = computed(() => {
  if (!localUser.value) return null
  return localUser.value.created_at ?? localUser.value.createdAt ?? localUser.value.created ?? null
})
const createdRaw = computed(() => createdRawFromProfile.value ?? createdRawFromLocal.value)

// 计算加入时长
function calcJoinDays() {
  const v = createdRaw.value
  if (!v) { joinDays.value = null; return }
  const created = new Date(v)
  if (isNaN(created.getTime())) { joinDays.value = null; return }
  const now = new Date()
  const diff = Math.floor((now - created) / (1000*60*60*24))
  joinDays.value = diff
}

// 打卡显示（优先使用 localStorage -> profile -> stats）
const streakDisplay = computed(() => {
  if (localCurrentStreak.value != null && localCheckin.value != null) {
    return `${localCurrentStreak.value} / ${localCheckin.value}`
  }
  if (localCheckin.value != null) return String(localCheckin.value)
  const p = prof.value || {}
  if (p.current_streak != null && p.checkin_days != null) return `${p.current_streak} / ${p.checkin_days}`
  if (p.checkin_days != null) return String(p.checkin_days)
  if (p.streak_days != null && p.total_checkin_days != null) return `${p.streak_days} / ${p.total_checkin_days}`
  if (p.streak_days != null) return String(p.streak_days)
  return null
})

// languages 显示（优先 localUser.lang -> profile.languages -> localStorage yp_lang）
const languagesDisplay = computed(() => {
  if (localLang.value && localLang.value.length) return localLang.value
  const p = prof.value || {}
  if (Array.isArray(p.languages) && p.languages.length) return p.languages
  if (typeof p.languages === 'string' && p.languages.trim()) return p.languages.split(',').map(s => s.trim()).filter(Boolean)
  const cur = localStorage.getItem('yp_lang')
  if (cur) return [cur]
  return []
})

// helper: safe parse lang value into array
function parseLangValue(raw) {
  if (raw == null) return []
  if (Array.isArray(raw)) return raw
  if (typeof raw === 'object') {
    try { return Array.isArray(raw) ? raw : [String(raw)] } catch (e) { return [] }
  }
  const s = String(raw).trim()
  if (!s) return []
  try {
    const parsed = JSON.parse(s)
    if (Array.isArray(parsed)) return parsed
    if (typeof parsed === 'string') return [parsed]
    return [String(parsed)]
  } catch (e) {
    return [s]
  }
}

const displayId = computed(() => {
  const p = prof.value || {}
  const fromProfile = p.id ?? p.user_id ?? p.uid
  if (fromProfile != null) return String(fromProfile)
  if (localUser.value) {
    const lu = localUser.value
    return String(lu.id ?? lu.user_id ?? lu.uid ?? '—')
  }
  return '—'
})

const avatarText = computed(() => {
  const name = (prof.value && (prof.value.username ?? prof.value.name)) || (localUser.value && (localUser.value.username ?? localUser.value.name)) || ''
  const s = String(name).trim()
  if (!s) return 'U'
  return s[0].toUpperCase()
})

const roleLabel = computed(() => {
  const p = prof.value || {}
  return p.role ?? p.membership_role ?? (localUser.value && (localUser.value.role ?? localUser.value.membership_role)) ?? null
})

// ---------- avatar color & emoji support ----------
const avatarBg = computed(() => {
  const p = prof.value || {}
  const fromProfile = p.user_color ?? p.avatar_color ?? null
  if (fromProfile) return fromProfile
  if (localUser.value) {
    return localUser.value.user_color ?? localUser.value.avatar_color ?? '#2563eb'
  }
  return '#2563eb'
})
const avatarEmoji = computed(() => {
  const p = prof.value || {}
  const fromProfile = p.user_emoji ?? p.avatar_emoji ?? null
  if (fromProfile) return fromProfile
  if (localUser.value) return localUser.value.user_emoji ?? localUser.value.avatar_emoji ?? null
  return null
})

const avatarStyle = computed(() => {
  if (avatarEmoji.value) {
    return {
      background: avatarBg.value,
      color: '#fff'
    }
  }
  return {
    background: 'linear-gradient(90deg,#2563eb,#7c3aed)',
    color: '#fff'
  }
})

const cardStyle = computed(() => {
  if (avatarBg.value) {
    return {
      background: "radial-gradient( circle at bottom right, "+ avatarBg.value +", transparent 40%), #232323"
    }
  }
  return {
    background: "radial-gradient( circle at bottom right, #4c4c4c, transparent 40%), #232323"
  }
})

async function copyId() {
  try {
    await navigator.clipboard.writeText(displayId.value)
    copied.value = true
    setTimeout(() => (copied.value = false), 1500)
  } catch (e) {
    const ta = document.createElement('textarea')
    ta.value = displayId.value
    ta.style.position = 'fixed'
    ta.style.left = '-9999px'
    document.body.appendChild(ta)
    ta.select()
    try { document.execCommand('copy'); copied.value = true; setTimeout(()=> (copied.value=false),1500) } catch(e){}
    document.body.removeChild(ta)
  }
}

function langLabel(l) {
  const map = { python1: 'Python入门', cpp1: 'C++入门', c1: 'C入门', java1: 'Java入门', javascript1: 'JavaScript入门' }
  return map[l] || (typeof l === 'string' ? l : String(l))
}

// === language click handling & yp_current/yp_select sync ===
function courseKeyFromLang(l) {
  if (!l) return 'python1'
  const s = String(l).trim()
  if (/\d$/.test(s)) return s
  const base = s.replace(/[^a-zA-Z]/g, '').toLowerCase()
  return `${base}1`
}

function onLangClick(l) {
  try {
    const course = courseKeyFromLang(l)
    // read yp_select
    const rawSelect = localStorage.getItem('yp_select')
    let selectObj = {}
    if (rawSelect) {
      try { selectObj = JSON.parse(rawSelect) } catch (e) { selectObj = {} }
    }
    const stage = Number(selectObj[course] ?? 0)
    const newCurrent = { course, stage }
    localStorage.setItem('yp_current', JSON.stringify(newCurrent))
  } catch (e) {
    // fallback: set python1
    localStorage.setItem('yp_current', JSON.stringify({ course: 'python1', stage: 0 }))
  } finally {
    router.push('/map')
  }
}

// open edit modal
function openEdit() {
  showChangeModal.value = true
}

// when BasicChange emits saved -> reload local user data
function onProfileSaved() {
  loadLocalUser()
  showChangeModal.value = false
}

// 加载 localStorage 中的 yp_user（并从中提取需要的字段）
function loadLocalUser() {
  try {
    const raw = localStorage.getItem('yp_user')
    if (!raw) {
      localUser.value = null
      localCheckin.value = null
      localMaxStreak.value = null
      localCurrentStreak.value = null
      localLang.value = []
      return
    }
    const parsed = JSON.parse(raw)
    localUser.value = parsed

    // checkin / streak fields
    localCheckin.value = parsed.checkin_days ?? parsed.total_checkin_days ?? parsed.checkin ?? null
    localMaxStreak.value = parsed.max_streak_days ?? parsed.max_streak ?? parsed.max_streak ?? null
    localCurrentStreak.value = parsed.current_streak ?? parsed.streak_days ?? parsed.streak ?? null

    // lang: may be JSON array, string like 'python' or single token
    localLang.value = parseLangValue(parsed.lang ?? parsed.languages ?? null)
  } catch (e) {
    localUser.value = null
    localCheckin.value = null
    localMaxStreak.value = null
    localCurrentStreak.value = null
    localLang.value = []
  }
}

onMounted(() => {
  loadLocalUser()
  calcJoinDays()
})

watch(createdRaw, calcJoinDays)
</script>


<style scoped>
.basic-root {
  background: #1c1c1c;
  color: #fff;
  padding: 18px;
  min-height: 220px;
  border-radius: 30px;
  box-shadow: 12px 12px 36px rgba(194, 194, 194, 0.7);
}

/* 网格布局：左侧固定宽度，右侧自适应 */
.basic-grid {
  display: grid;
  grid-template-columns: 180px 1fr;
  gap: 22px;
  align-items: start;
}

/* 小屏幕下改为单列 */
@media (max-width: 720px) {
  .basic-grid { grid-template-columns: 1fr; }
  .avatar-wrap { margin: 0 0; }
}

/* 左侧 */
.left {
  display:flex;
  gap:14px;
  align-items:center;
}
.avatar-wrap {
  width:84px;
  height:84px;
  display:flex;
  align-items:center;
  justify-content:center;
  border-radius:18px;
  box-shadow: 0 10px 30px rgba(0,0,0,0.6);
  background: linear-gradient(135deg, rgba(255,255,255,0.03), rgba(255,255,255,0.02));
  border: 1px solid rgba(255,255,255,0.04);
}
.avatar {
  width:64px;
  height:64px;
  border-radius:14px;
  display:flex;
  align-items:center;
  justify-content:center;
  font-weight:900;
  font-size:22px;
  box-shadow: 0 8px 20px rgba(0,0,0,0.6);
  transition: transform .12s ease;
  background: linear-gradient(90deg,#111827,#374151); /* 深色默认 */
  color: #fff;
}
.avatar:hover { transform: translateY(-2px); }

/* emoji 与文字样式 */
.avatar-emoji { font-size:32px; line-height:1; }
.avatar-text { font-size:22px; color: #fff; }

/* 名字部分 */
.name-block { display:flex; flex-direction:column; gap:8px; }
.username { display:flex; align-items:center; gap:10px; flex-wrap:wrap; }
.name-txt { font-size:20px; font-weight:900; color: #fff; }
.name-txt.muted { color:#9CA3AF; font-weight:700; }

.role-badge {
  padding:5px 10px;
  border-radius:999px;
  font-weight:800;
  font-size:12px;
  color:#0f172a;
  background: linear-gradient(90deg,#10b981,#06b6d4);
}

/* meta 小字 */
.meta-small { display:flex; align-items:center; gap:10px; color:#9CA3AF; font-size:13px; }
.id-txt { font-weight:800; color:#fff; }
.icon-btn {
  border:1px solid rgba(255,255,255,0.06);
  background: rgba(255,255,255,0.02);
  padding:6px 10px;
  border-radius:10px;
  cursor:pointer;
  font-weight:800;
  font-size:13px;
  color: #fff;
}

/* 右侧信息：统计卡片 */
.right { display:flex; flex-direction:column; gap:16px; }
.stats-row { display:flex; gap:14px; flex-wrap:wrap; }
.stat-card {
  padding:14px;
  border-radius:12px;
  min-width:160px;
  flex:1;
  display:flex;
  flex-direction:column;
  gap:8px;
  /* background:
  radial-gradient(
    circle at bottom right,
    #ff88007e,
    transparent 40%
  ),
  #232323; */
  backdrop-filter: blur(12px);
  border: 0.01px solid #aeaeae69;
}
.stat-label { font-size:13px; color:#9CA3AF; }
.stat-value { font-weight:900; font-size:18px; color:#fff; }
.stat-value.muted { color:#9CA3AF; font-weight:700; }
.stat-sub { font-size:12px; color:#9CA3AF; }

/* 语言 pill 列表 */
.lang-list { display:flex; gap:8px; flex-wrap:wrap; }
.lang-pill {
  padding:6px 10px;
  border-radius:999px;
  background: rgba(255,255,255,0.02);
  border:1px solid rgba(255,255,255,0.04);
  font-weight:800;
  font-size:13px;
  cursor: pointer;
  color: #fff;
}
.lang-pill:active { transform: translateY(1px); }

/* 按钮 */
.actions { display:flex; gap:12px; margin-top:6px; }
.btn { padding:10px 14px; border-radius:12px; cursor:pointer; font-weight:800; font-size:14px; }
.btn-primary {
  background: linear-gradient(90deg,#2563eb,#7c3aed);
  color:white;
  border:none;
  box-shadow: 0 6px 18px rgba(124,58,237,0.18);
}

/* 其他暗色调整 */
.muted { color:#9CA3AF; }
</style>