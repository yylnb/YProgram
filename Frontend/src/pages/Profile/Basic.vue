<template>
  <div class="card p-6 basic-root">
    <div class="basic-grid">
      <!-- 左侧：头像 + 名称 -->
      <div class="left">
        <div class="avatar-wrap" title="用户头像或首字母">
          <div class="avatar">{{ avatarText }}</div>
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
          <div class="stat-card">
            <div class="stat-label">加入时长</div>
            <div class="stat-value" v-if="joinDays !== null">{{ joinDays }} 天</div>
            <div class="stat-value muted" v-else>未知</div>
            <div class="stat-sub muted">基于注册时间计算</div>
          </div>

          <div class="stat-card">
            <div class="stat-label">打卡天数</div>
            <div class="stat-value" v-if="streakDisplay !== null">{{ streakDisplay }}</div>
            <div class="stat-value muted" v-else>—</div>
            <div class="stat-sub muted">连续 / 累计（若可用）</div>
          </div>

          <div class="stat-card">
            <div class="stat-label">学习的语言</div>
            <div class="stat-value" v-if="languagesDisplay && languagesDisplay.length">
              <div class="lang-list">
                <span class="lang-pill" v-for="(l, i) in languagesDisplay" :key="i">{{ langLabel(l) }}</span>
              </div>
            </div>
            <div class="stat-value muted" v-else>未设置</div>
            <div class="stat-sub muted">可在学习页面切换语言</div>
          </div>
        </div>

        <div class="actions">
          <button class="btn btn-primary" @click="$emit('edit')">编辑个人资料</button>
          <button class="btn btn-outlined" @click="$emit('open-settings')">账户设置</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { toRef, ref, watch, computed, onMounted } from 'vue'
import axios from 'axios'

const props = defineProps({
  profile: { type: Object, default: () => ({ id: null, username: '', created_at: null }) }
})

const prof = toRef(props, 'profile')
const joinDays = ref(null)
const copied = ref(false)

// 快速统计数据（优先从后端 /api/user/stats 获取）
const stats = ref(null)

// 打卡显示（例如 "5 / 120" 或 单一数字）
const streakDisplay = computed(() => {
  if (!stats.value) {
    // try profile fallback fields
    const p = prof.value || {}
    if (p.streak_days != null && p.total_checkin_days != null) {
      return `${p.streak_days} / ${p.total_checkin_days}`
    }
    if (p.streak_days != null) return String(p.streak_days)
    if (p.checkin_days != null) return String(p.checkin_days)
    return null
  }
  // stats 优先级： 连续 streak_days 与 累计 total_checkin_days
  const s = stats.value
  if (s.streak_days != null && s.total_checkin_days != null) return `${s.streak_days} / ${s.total_checkin_days}`
  if (s.streak_days != null) return String(s.streak_days)
  if (s.total_checkin_days != null) return String(s.total_checkin_days)
  return null
})

// 学习语言显示（数组）
// 优先从 stats.languages 或 profile.languages，兜底用 localStorage 的 yp_lang（单项）
const languagesDisplay = computed(() => {
  if (stats.value && Array.isArray(stats.value.languages) && stats.value.languages.length) return stats.value.languages
  const p = prof.value || {}
  if (Array.isArray(p.languages) && p.languages.length) return p.languages
  // profile 可能使用 csv 字符串
  if (typeof p.languages === 'string' && p.languages.trim()) return p.languages.split(',').map(s => s.trim()).filter(Boolean)
  // fallback to localStorage yp_lang
  const cur = localStorage.getItem('yp_lang')
  if (cur) return [cur]
  return []
})

// 兼容 created_at / createdAt / created
const createdRaw = computed(() => prof.value && (prof.value.created_at ?? prof.value.createdAt ?? prof.value.created ?? null))

const createdAtFormatted = computed(() => {
  const v = createdRaw.value
  if (!v) return null
  const d = new Date(v)
  if (isNaN(d.getTime())) return null
  return d.toLocaleString()
})

function calcJoinDays() {
  if (!createdRaw.value) { joinDays.value = null; return }
  const created = new Date(createdRaw.value)
  if (isNaN(created.getTime())) { joinDays.value = null; return }
  const now = new Date()
  const diff = Math.floor((now - created) / (1000*60*60*24))
  joinDays.value = diff
}

const displayId = computed(() => {
  const p = prof.value || {}
  return String(p.id ?? p.user_id ?? p.uid ?? '—')
})

const avatarText = computed(() => {
  const name = (prof.value && (prof.value.username ?? prof.value.name)) || ''
  const s = String(name).trim()
  if (!s) return 'U'
  return s[0].toUpperCase()
})

const roleLabel = computed(() => {
  const p = prof.value || {}
  return p.role ?? p.membership_role ?? null
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
  const map = { python: 'Python', cpp: 'C++', java: 'Java', javascript: 'JavaScript', ts: 'TypeScript' }
  return map[l] || (typeof l === 'string' ? l : String(l))
}

/*
  自动加载 /api/user/stats（如果用户已登录）
  期望后端返回结构示例：
  {
    streak_days: 5,
    total_checkin_days: 120,
    languages: ['python','cpp'],
    completed_courses: 3,
    completed_units: 24
  }
*/
async function loadQuickStats() {
  const token = localStorage.getItem('yp_token')
  if (!token) { stats.value = null; return }
  try {
    const res = await axios.get('http://localhost:5000/api/user/stats', { headers: { Authorization: `Bearer ${token}` }, timeout: 6000 })
    if (res && res.data) stats.value = res.data
    else stats.value = null
  } catch (e) {
    // 静默失败即可
    stats.value = null
  }
}

onMounted(() => {
  calcJoinDays()
  loadQuickStats()
})
watch(createdRaw, calcJoinDays)
</script>

<style scoped>
.basic-root {
  padding: 18px;
  min-height: 220px; /* 增大最小高度，使布局更舒展 */
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
  .avatar-wrap { margin: 0 auto; }
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
  box-shadow: 0 10px 30px rgba(2,6,23,0.06);
  background: linear-gradient(135deg, rgba(37,99,235,0.12), rgba(124,58,237,0.08));
}
.avatar {
  width:64px;
  height:64px;
  border-radius:14px;
  background: linear-gradient(90deg,#2563eb,#7c3aed);
  color: #fff;
  display:flex;
  align-items:center;
  justify-content:center;
  font-weight:900;
  font-size:22px;
  box-shadow: 0 8px 20px rgba(37,99,235,0.12);
}

/* 名字部分 */
.name-block { display:flex; flex-direction:column; gap:8px; }
.username { display:flex; align-items:center; gap:10px; flex-wrap:wrap; }
.name-txt { font-size:20px; font-weight:900; color: #0f172a; }
.name-txt.muted { color:#6b7280; font-weight:700; }

.role-badge {
  padding:5px 10px;
  border-radius:999px;
  font-weight:800;
  font-size:12px;
  color:#fff;
  background: linear-gradient(90deg,#10b981,#06b6d4);
}

/* meta 小字 */
.meta-small { display:flex; align-items:center; gap:10px; color:#6b7280; font-size:13px; }
.id-txt { font-weight:800; color:#0f172a; }
.icon-btn {
  border:1px solid rgba(15,23,42,0.06);
  background:white;
  padding:6px 10px;
  border-radius:10px;
  cursor:pointer;
  font-weight:800;
  font-size:13px;
}

/* 右侧信息：统计卡片 */
.right { display:flex; flex-direction:column; gap:16px; }
.stats-row { display:flex; gap:14px; flex-wrap:wrap; }
.stat-card {
  background: rgba(15,23,42,0.02);
  padding:14px;
  border-radius:12px;
  min-width:160px;
  flex:1;
  display:flex;
  flex-direction:column;
  gap:8px;
}
.stat-label { font-size:13px; color:#6b7280; }
.stat-value { font-weight:900; font-size:18px; color:#0f172a; }
.stat-value.muted { color:#6b7280; font-weight:700; }
.stat-sub { font-size:12px; color:#6b7280; }

/* 语言 pill 列表 */
.lang-list { display:flex; gap:8px; flex-wrap:wrap; }
.lang-pill {
  padding:6px 10px;
  border-radius:999px;
  background: white;
  border:1px solid rgba(15,23,42,0.06);
  font-weight:800;
  font-size:13px;
}

/* 按钮 */
.actions { display:flex; gap:12px; margin-top:6px; }
.btn { padding:10px 14px; border-radius:12px; cursor:pointer; font-weight:800; font-size:14px; }
.btn-primary { background: linear-gradient(90deg,#2563eb,#7c3aed); color:white; border:none; }
.btn-outlined { background: white; border:1px solid rgba(15,23,42,0.08); color:#0f172a; }

/* muted 文本 */
.muted { color:#6b7280; }
</style>