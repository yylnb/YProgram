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
        <div class="card p-6">
          <h3 class="text-lg font-semibold mb-2">基本信息</h3>
          <p><strong>用户名：</strong> {{ profile.username }}</p>
          <p><strong>用户 ID：</strong> {{ profile.id }}</p>
          <p v-if="tokenExp"><strong>Token 到期：</strong> {{ tokenExp }}</p>
          <p v-if="joinDays !== null"><strong>加入时间：</strong> {{ joinDays }} 天</p>
        </div>

        <!-- 日历 -->
        <Calendar />

        <!-- 会员 -->
        <div class="card p-6">
          <h3 class="text-lg font-semibold mb-2">YPro 会员</h3>
          <div v-if="loadingMembership">加载中…</div>
          <div v-else>
            <p v-if="membership && membership.active">
              ✅ 你当前是 <strong>YPro</strong> 会员<br>
              <span class="text-gray-600">到期时间：{{ membership.end_at }}</span>
            </p>
            <p v-else class="text-gray-600">暂无 YPro 会员</p>
          </div>
        </div>

        <!-- 收藏题目 -->
        <div class="card p-6">
          <div class="flex items-center justify-between mb-3">
            <h3 class="text-lg font-semibold">收藏题目</h3>

            <!-- 语言切换 -->
            <div class="lang-switch inline-flex gap-2">
              <button
                v-for="l in ['python','cpp','java']"
                :key="l"
                :class="['lang-btn', { active: favSelectedLang === l }]"
                @click="changeFavLang(l)"
              >
                {{ langLabel(l) }}
              </button>
            </div>
          </div>

          <p v-if="loadingFavs">加载收藏中…</p>

          <div v-else>
            <p v-if="favorites.length === 0" class="text-gray-600">
              你还没有收藏题目（当前语言：{{ langLabel(favSelectedLang) }}）。
            </p>

            <ul v-else class="list-disc list-inside space-y-4">
              <li
                v-for="(q, idx) in favorites"
                :key="q.fav_id || q.q_id || q.q_db_id || idx"
              >
                <div class="flex justify-between items-start gap-4">
                  <div style="flex:1">
                    <div class="text-sm text-gray-600 mb-1">
                      <strong>题目 ID：</strong>{{ displayQid(q) }}
                      <span class="mx-2">|</span>
                      <span>单元 {{ q.unit_id ?? q.unitId ?? '-' }}</span>
                      <span v-if="q.page_id || q.pageId" class="mx-2">
                        | 页 {{ q.page_id ?? q.pageId }}
                      </span>
                    </div>

                    <div
                      class="mt-1 text-sm text-gray-700"
                      v-if="displayText(q)"
                      v-html="displayText(q)"
                    ></div>
                    <div v-else class="text-sm text-gray-500">
                      （题目内容不可用）
                    </div>
                  </div>

                  <div
                    class="mt-2"
                    style="display:flex; gap:8px; align-items:center;"
                  >
                    <button class="btn-try" @click="removeFavorite(displayQid(q))">
                      取消收藏
                    </button>

                    <button
                      class="btn-primary"
                      :disabled="!(q.unit_id || q.unitId || q.q_unit_id || q.q_db_id)"
                      @click="goToPractice(q)"
                      title="前往该收藏题所在单元练习（会切换到该题目的语言）"
                    >
                      去练习
                    </button>
                  </div>
                </div>
              </li>
            </ul>

            <!-- 分页控件 -->
            <div class="pagination mt-4 flex items-center gap-3">
              <button
                class="btn-try"
                :disabled="favCurrentPage <= 1"
                @click="changePage(favCurrentPage - 1)"
              >
                上一页
              </button>
              <div>
                第
                <select v-model.number="favCurrentPage" @change="onPageSelect">
                  <option v-for="p in favTotalPages" :key="p" :value="p">{{ p }}</option>
                </select>
                / {{ favTotalPages }} 页
              </div>
              <button
                class="btn-try"
                :disabled="favCurrentPage >= favTotalPages"
                @click="changePage(favCurrentPage + 1)"
              >
                下一页
              </button>
            </div>
          </div>
        </div>

      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'
import Calendar from './Calendar.vue'

const router = useRouter()
const storedToken = ref(localStorage.getItem('yp_token') || null)
const storedUserRaw = localStorage.getItem('yp_user')
let parsedUser = null
try { parsedUser = storedUserRaw ? JSON.parse(storedUserRaw) : null } catch(e){ parsedUser = null }
const profile = ref(parsedUser || { id: null, username: '', created_at: null })
const tokenExp = ref(null)
const isLogged = computed(() => !!storedToken.value)

const calendarAttrs = ref([
  {
    key: 'today',
    highlight: { color: 'blue', fillMode: 'solid' },
    dates: new Date()
  }
])

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

// 收藏相关 state（注意用 fav 前缀，避免与页面中其它名称冲突）
const favorites = ref([])
const loadingFavs = ref(false)
const favTotalPages = ref(1)
const favCurrentPage = ref(1)
const favSelectedLang = ref('python')

// 会员和加入时间
const membership = ref(null)
const loadingMembership = ref(false)
const joinDays = ref(null)

// helper: human readable language label
function langLabel(l) {
  const map = { python: 'Python', cpp: 'C++', java: 'Java' }
  return map[l] || l
}

// 获取收藏（支持后端返回 { favorites, totalPages, currentPage } 或老式直接数组）
async function loadFavorites(page = 1, lang = 'python') {
  const token = localStorage.getItem('yp_token')
  if (!token) { favorites.value = []; favTotalPages.value = 1; favCurrentPage.value = 1; return; }
  loadingFavs.value = true
  try {
    const url = new URL('http://localhost:5000/api/favorites')
    url.searchParams.set('lang', lang)
    url.searchParams.set('page', String(page))
    const res = await fetch(url.toString(), { headers: { 'Authorization': `Bearer ${token}` } })
    if (res.ok) {
      const data = await res.json()
      // If server returns object { favorites, totalPages, currentPage }
      if (data && typeof data === 'object' && Array.isArray(data.favorites)) {
        favorites.value = data.favorites
        favTotalPages.value = data.totalPages && Number(data.totalPages) > 0 ? Number(data.totalPages) : Math.max(1, Math.ceil((data.totalCount || data.total || favorites.value.length) / 5))
        favCurrentPage.value = data.currentPage ? Number(data.currentPage) : page
      } else if (Array.isArray(data)) {
        // backward compatibility: server returned plain array
        favorites.value = data
        favTotalPages.value = 1
        favCurrentPage.value = 1
      } else {
        // unknown shape -> safe fallback
        favorites.value = []
        favTotalPages.value = 1
        favCurrentPage.value = 1
      }
    } else {
      favorites.value = []
    }
  } catch (e) {
    console.error('loadFavorites error:', e)
    favorites.value = []
  } finally {
    loadingFavs.value = false
  }
}

// change language for favorites
function changeFavLang(lang) {
  if (!lang) return
  favSelectedLang.value = lang
  favCurrentPage.value = 1
  loadFavorites(favCurrentPage.value, favSelectedLang.value)
}

// change page (prev/next)
function changePage(p) {
  if (!p || p < 1) return
  if (p === favCurrentPage.value) return
  favCurrentPage.value = p
  loadFavorites(favCurrentPage.value, favSelectedLang.value)
}

function onPageSelect() {
  // favCurrentPage is v-model bound number, call load
  loadFavorites(favCurrentPage.value, favSelectedLang.value)
}

// 格式化显示 q id
function displayQid(q) {
  if (!q) return ''
  return String(q.q_id ?? q.qid ?? q.id ?? q.question_id ?? q.q_db_id ?? '')
}
// 取题目文本的字段（兼容多种后端名称）
function displayText(q) {
  if (!q) return ''
  return q.question_text ?? q.q_text ?? q.q_text_html ?? q.q_title ?? q.question_text_html ?? q.q_title_html ?? q.text ?? ''
}

// 取消收藏（按当前语言删除，服务器会重新 flow page_id）
async function removeFavorite(qid) {
  if (!qid) return
  if (!confirm('确认取消收藏该题？')) return
  const token = localStorage.getItem('yp_token')
  if (!token) { alert('请先登录'); return }
  try {
    const url = new URL(`http://localhost:5000/api/favorites/${encodeURIComponent(String(qid))}`)
    // prefer to scope to current language to speed up delete
    if (favSelectedLang.value) url.searchParams.set('lang', favSelectedLang.value)
    const res = await fetch(url.toString(), {
      method: 'DELETE',
      headers: { 'Authorization': `Bearer ${token}` }
    })
    if (res.ok) {
      // reload current page (server has reflowed page ids)
      // but if current page might be out of range after deletion, request page 1 as fallback
      await loadFavorites(favCurrentPage.value, favSelectedLang.value)
    } else {
      const err = await res.json().catch(()=>({ error: 'unknown' }))
      alert('取消收藏失败：' + (err.error || JSON.stringify(err)))
    }
  } catch (e) {
    console.error('removeFavorite error:', e)
    alert('网络错误，取消收藏失败')
  }
}

async function goToPractice(fav) {
  if (!fav) return;

  // 1) 解析 unit 和 lang（兼容多种命名）
  const unit = fav.unit_id ?? fav.unitId ?? fav.q_unit_id ?? fav.unit ?? null;
  let lang = (fav.lang ?? localStorage.getItem('yp_lang') ?? 'python').toString().toLowerCase();

  if (!unit) {
    alert('无法跳转：该收藏条目没有绑定单元信息。');
    return;
  }

  // 2) 切换语言（写入 localStorage 并触发自定义事件）
  try {
    localStorage.setItem('yp_lang', lang);
    // 触发事件，Study.vue / Map.vue 都应监听 language-changed 并重新拉题或进度
    window.dispatchEvent(new CustomEvent('language-changed', { detail: { lang } }));
  } catch (e) {
    // ignore
    console.warn('goToPractice: language switch failed', e);
  }

  // 3) 尝试定位题号（优先使用 q_id）
  let qIndex = 1; // 默认跳第1题
  const qid = (fav.q_id ?? fav.qid ?? fav.q_qid ?? fav.question_id ?? fav.db_id ?? null);
  try {
    if (qid) {
      // 拉取该单元该语言的题目列表，查找 q_id 在数组中的位置
      const res = await axios.get('http://localhost:5000/api/questions', {
        params: { unit: unit, lang: lang },
        timeout: 6000
      });
      const data = res && res.data ? res.data : null;
      if (Array.isArray(data) && data.length > 0) {
        // 标准化每个题目的 q_id 值（后端有时用 q_id 或 id）
        const arrQids = data.map(item => (item.q_id ?? item.id ?? item.qId ?? item.qid ?? null)).map(x => x != null ? String(x) : null);
        const foundIndex = arrQids.findIndex(x => x === String(qid));
        if (foundIndex >= 0) {
          qIndex = foundIndex + 1; // 1-based
        }
      }
    }
  } catch (e) {
    // 网络或解析出错，退回到第1题（但仍切换语言）
    console.warn('goToPractice: find index failed, fallback to q=1', e);
  }

  // optional small delay  -> 使 language-changed 事件有机会被目标页面捕获（通常不必要）
  await new Promise(r => setTimeout(r, 40));

  // 4) 跳转到 Study 页面（携带 q 查询，表示 1-based 题号）
  try {
    router.push({ path: `/study/${unit}`, query: { q: String(Math.max(1, Math.floor(qIndex))) } });
  } catch (e) {
    // 如果 push 出错，作为兜底直接替换 location
    window.location.href = `/study/${unit}?q=${String(Math.max(1, Math.floor(qIndex)))}`;
  }
}

// ==== 会员和加入时间 ====
async function loadMembership() {
  const token = localStorage.getItem('yp_token')
  if (!token) return
  loadingMembership.value = true
  try {
    const res = await fetch('http://localhost:5000/api/user/membership', { headers: { 'Authorization': `Bearer ${token}` } })
    if (res.ok) {
      const data = await res.json()
      if (data && data.end_at) {
        membership.value = {
          active: new Date(data.end_at) > new Date(),
          end_at: new Date(data.end_at).toLocaleString()
        }
      } else {
        membership.value = { active: false }
      }
    } else {
      membership.value = { active: false }
    }
  } catch(e) {
    membership.value = { active: false }
  } finally {
    loadingMembership.value = false
  }
}

function calcJoinDays() {
  if (profile.value.created_at) {
    const created = new Date(profile.value.created_at)
    const now = new Date()
    const diff = Math.floor((now - created) / (1000*60*60*24))
    joinDays.value = diff
  }
}

onMounted(async () => {
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

  calcJoinDays()
  // initial favorites load using default language & page
  await loadFavorites(favCurrentPage.value, favSelectedLang.value)
  await loadMembership()
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
.lang-switch .lang-btn {
  padding: 6px 10px;
  border-radius: 9999px;
  border: 1px solid rgba(15,23,42,0.06);
  background: white;
  font-weight:700;
  cursor:pointer;
}
.lang-switch .lang-btn.active {
  background: linear-gradient(90deg,#2563eb,#7c3aed);
  color: white;
  border-color: transparent;
}
.btn-try {
  background:#fff;
  border:1px solid rgba(15,23,42,0.06);
  padding:8px 12px;
  border-radius:10px;
  font-weight:800;
  cursor:pointer;
}
.card {
  background:white;
  border-radius:12px;
  box-shadow:0 10px 30px rgba(2,6,23,0.06);
  padding:12px;
}
</style>