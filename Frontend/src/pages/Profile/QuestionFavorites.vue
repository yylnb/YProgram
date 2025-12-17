<template>
  <div class="favorites-root">
    <div class="card">
      <div class="card-header">
        <div class="title-block">
          <h3 class="title">收藏题目</h3>
          <p class="subtitle">快速访问你收藏的练习题与跳转练习</p>
        </div>

        <div class="controls">
          <!-- 使用自定义下拉：语言 -->
          <CustomDropdown
            v-model="favSelectedLang"
            :options="langOptions"
            labelKey="label"
            valueKey="value"
            placeholder="选择语言"
            class="control-dropdown"
            @change="onLangChanged"
          />

          <!-- 使用自定义下拉：难度（阶段 index） -->
          <CustomDropdown
            v-model="favSelectedDifficulty"
            :options="difficultyOptions"
            labelKey="label"
            valueKey="value"
            placeholder="选择阶段"
            class="control-dropdown"
            @change="onDiffChanged"
          />
        </div>
      </div>

      <div class="card-body">
        <p v-if="loadingFavs" class="loading">加载收藏中…</p>

        <div v-else>
          <p v-if="favorites.length === 0" class="empty">
            你还没有收藏题目（当前课程：<strong class="mono">{{ apiCourse }}</strong>）。
          </p>

          <ul v-else class="fav-list">
            <li v-for="(q, idx) in favorites" :key="q.id ?? q.q_id ?? idx" class="fav-item">
              <div class="fav-main">
                <div class="fav-meta">
                  <div class="meta-top">
                    <span class="meta-id">题目 ID：<strong>{{ displayQid(q) }}</strong></span>
                    <span class="meta-sep">|</span>
                    <span class="meta-unit">单元 {{ q.unit_id ?? '-' }}</span>
                    <span class="meta-time">· {{ formatTime(q.created_at) }}</span>
                  </div>
                  <div class="meta-title" v-if="displayText(q)" v-html="displayText(q)"></div>
                  <div class="meta-missing" v-else>（题目标题不可用）</div>
                </div>

                <div class="fav-actions">
                  <button class="btn btn-outline" @click="removeFavorite(displayQid(q))" :disabled="removing">取消收藏</button>
                  <button class="btn btn-primary" :disabled="!(q.unit_id)" @click="goToPractice(q)">去练习</button>
                </div>
              </div>
            </li>
          </ul>

          <!-- pagination: 使用自定义下拉作为页码选择 -->
          <div class="pager">
            <button class="btn btn-outline" :disabled="favCurrentPage <= 1 || loadingFavs" @click="changePage(favCurrentPage - 1)">
              上一页
            </button>

            <div class="pager-center">
              第
              <CustomDropdown
                v-model="favCurrentPage"
                :options="pageOptions"
                labelKey="label"
                valueKey="value"
                placeholder="第几页"
                @change="onPageFromDropdown"
              />
              / {{ favTotalPages }} 页
            </div>

            <button class="btn btn-outline" :disabled="favCurrentPage >= favTotalPages || loadingFavs" @click="changePage(favCurrentPage + 1)">
              下一页
            </button>
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
import CustomDropdown from '../../components/CustomDropdown.vue' // <- 确保路径正确

const router = useRouter()
const BASE_API = 'http://localhost:5000'

// state
const favorites = ref([])
const loadingFavs = ref(false)
const favTotalPages = ref(1)
const favCurrentPage = ref(1)
const removing = ref(false)

// selection state: use simple value objects for dropdown compatibility
const langOptions = [
  { value: 'python', label: 'Python' },
  { value: 'cpp', label: 'C++' },
  { value: 'c', label: 'C' },
  { value: 'java', label: 'Java' },
]
const difficultyOptions = [
  { value: 1, label: '入门' },
  { value: 2, label: '进阶' },
]

// v-model bindings
const favSelectedLang = ref('python')
const favSelectedDifficulty = ref(1)

// computed course strings:
// - for API: e.g. "python_1"
// - for route: e.g. "python1" (no underscore)
const apiCourse = computed(() => `${favSelectedLang.value}_${favSelectedDifficulty.value}`)
const routeCourse = computed(() => `${favSelectedLang.value}${favSelectedDifficulty.value}`)

// pages dropdown options computed from favTotalPages
const pageOptions = computed(() => {
  const n = Math.max(1, Number(favTotalPages.value || 1))
  const arr = []
  for (let i = 1; i <= n; i++) {
    arr.push({ value: i, label: String(i) })
  }
  return arr
})

// helpers
function displayQid(q) {
  if (!q) return ''
  return String(q.q_id ?? q.qid ?? q.id ?? '')
}
function displayText(q) {
  if (!q) return ''
  return q.title ?? q.question_text ?? ''
}
function formatTime(t) {
  if (!t) return ''
  try { return new Date(t).toLocaleString() } catch (e) { return String(t) }
}

// lifecycle: initial load
onMounted(async () => {
  await loadFavorites(1)
})

// called when language dropdown changes
function onLangChanged() {
  favCurrentPage.value = 1
  loadFavorites(1)
}
function onDiffChanged() {
  favCurrentPage.value = 1
  loadFavorites(1)
}

// load favorites from backend using apiCourse
async function loadFavorites(page = 1) {
  const token = localStorage.getItem('yp_token')
  if (!token) {
    favorites.value = []; favTotalPages.value = 1; favCurrentPage.value = 1; return
  }

  const course = apiCourse.value
  loadingFavs.value = true
  try {
    const url = new URL(`${BASE_API}/api/favorites`)
    url.searchParams.set('course', course)
    url.searchParams.set('page', String(page))
    url.searchParams.set('pageSize', '5')

    const res = await fetch(url.toString(), {
      headers: { 'Authorization': `Bearer ${token}`, 'Accept': 'application/json' }
    })

    if (res.ok) {
      const data = await res.json().catch(()=>null)
      if (data && typeof data === 'object' && Array.isArray(data.favorites)) {
        favorites.value = data.favorites.map(item => ({
          id: item.id ?? null,
          q_id: item.q_id ?? item.qid ?? null,
          unit_id: item.unit_id ?? item.unitId ?? null,
          title: item.title ?? '',
          created_at: item.created_at ?? null
        }))
        favTotalPages.value = data.totalPages && Number(data.totalPages) > 0 ? Number(data.totalPages) : Math.max(1, Math.ceil((data.total || favorites.value.length) / 5))
        favCurrentPage.value = data.currentPage ? Number(data.currentPage) : page
      } else {
        favorites.value = []
        favTotalPages.value = 1
        favCurrentPage.value = 1
      }
    } else {
      favorites.value = []
      favTotalPages.value = 1
      favCurrentPage.value = 1
    }
  } catch (e) {
    console.error('loadFavorites error:', e)
    favorites.value = []
    favTotalPages.value = 1
    favCurrentPage.value = 1
  } finally {
    loadingFavs.value = false
  }
}

// pagination
function changePage(p) {
  if (!p || p < 1) return
  if (p === favCurrentPage.value) return
  favCurrentPage.value = p
  loadFavorites(p)
}
function onPageFromDropdown(val) {
  // val already updated via v-model; ensure numeric
  const num = Number(favCurrentPage.value) || 1
  changePage(num)
}

// remove favorite
async function removeFavorite(qid) {
  if (!qid) return
  if (!confirm('确认取消收藏该题？')) return
  const token = localStorage.getItem('yp_token')
  if (!token) { alert('请先登录'); return }

  removing.value = true
  try {
    const url = new URL(`${BASE_API}/api/favorites/${encodeURIComponent(String(qid))}`)
    url.searchParams.set('course', apiCourse.value)

    const res = await fetch(url.toString(), {
      method: 'DELETE',
      headers: { 'Authorization': `Bearer ${token}` }
    })
    if (res.ok) {
      await loadFavorites(favCurrentPage.value)
      if (favCurrentPage.value > favTotalPages.value) {
        favCurrentPage.value = favTotalPages.value
        await loadFavorites(favCurrentPage.value)
      }
    } else {
      const err = await res.json().catch(()=>({ error: 'unknown' }))
      alert('取消收藏失败：' + (err.error || JSON.stringify(err)))
    }
  } catch (e) {
    console.error('removeFavorite error:', e)
    alert('网络错误，取消收藏失败')
  } finally {
    removing.value = false
  }
}

// goToPractice: 跳转到 /study/course/unit （course 不含下划线，例如 python1）
async function goToPractice(fav) {
  if (!fav) return
  const unit = fav.unit_id ?? null
  if (!unit) { alert('无法跳转：该收藏条目没有绑定单元信息。'); return }

  // build course without underscore
  const courseForRoute = routeCourse.value // e.g. python1
  // compute qIndex best-effort (try to find index inside unit)
  let qIndex = 1
  const qid = fav.q_id ?? fav.id ?? null
  try {
    if (qid) {
      const res = await axios.get(`${BASE_API}/api/questions`, {
        params: { unit: unit, lang: favSelectedLang.value },
        timeout: 6000
      })
      const data = res && res.data ? res.data : null
      if (Array.isArray(data) && data.length > 0) {
        const arrQids = data.map(item => (item.q_id ?? item.id ?? null)).map(x => x != null ? String(x) : null)
        const foundIndex = arrQids.findIndex(x => x === String(qid))
        if (foundIndex >= 0) qIndex = foundIndex + 1
      }
    }
  } catch (e) {
    console.warn('goToPractice: find index failed, fallback to q=1', e)
  }

  // push route: /study/<courseNoUnderscore>/<unit>?q=<qIndex>
  try {
    router.push({ path: `/study/${courseForRoute}/${unit}`, query: { q: String(Math.max(1, Math.floor(qIndex))) } })
  } catch (e) {
    window.location.href = `/study/${courseForRoute}/${unit}?q=${String(Math.max(1, Math.floor(qIndex)))}`
  }
}
</script>

<style scoped>
/* Root dark background surrounding the card */
.favorites-root {
  min-height: 220px;
  background: #1c1c1c;
  color: #fff;
  border-radius: 30px;
  box-shadow: 12px 12px 36px rgba(194, 194, 194, 0.7);
}

/* Card */
.card {
  background: #1c1c1c;
  border: 1px solid rgba(255,255,255,0.06);
  border-radius: 30px;
  padding: 18px;
}

/* Header */
.card-header {
  display: flex;
  justify-content: space-between;
  gap: 12px;
  align-items: center;
  margin-bottom: 12px;
}
.title-block .title {
  font-size: 18px;
  font-weight: 700;
  margin: 0;
  color: #fff;
}
.title-block .subtitle {
  margin: 4px 0 0;
  color: #cbd5e1;
  font-size: 13px;
}

/* Controls (dropdowns) */
.controls {
  display: flex;
  gap: 12px;
  align-items: center;
}

/* Body */
.card-body { padding-top: 6px; }
.loading { color: #9ca3af; }
.empty { color: #9ca3af; }

/* Favorites list */
.fav-list { list-style: none; margin: 8px 0 0; padding: 0; display: grid; gap: 12px; }
.fav-item {
  padding: 12px;
  border-radius: 20px;
  background:
  radial-gradient(
    circle at top right,
    #4c4c4c,
    transparent 40%
  ),
  radial-gradient(
    circle at bottom left,
    #4c4c4c,
    transparent 40%
  ),
  #232323;
  backdrop-filter: blur(12px);
  color: #fff !important;
  border: 0.01px solid #aeaeae69;
}
.fav-item:hover {
  background: #6b21a8;
  border: 0.01px solid #AEAEAE;
  box-shadow: 0 36px 80px rgba(132, 63, 141, 0.479);
}
.fav-main { display:flex; justify-content:space-between; gap: 12px; align-items:flex-start; }
.fav-meta { flex:1; min-width: 0; }
.meta-top { color: #cbd5e1; font-size: 13px; margin-bottom: 8px; display:flex; gap:8px; align-items:center; flex-wrap:wrap; }
.meta-top .mono { font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, "Roboto Mono", monospace; }
.meta-title { color: #f8fafc; font-weight:700; font-size:15px; line-height:1.3; }
.meta-missing { color: #94a3b8; font-size:14px; }

/* Actions */
.fav-actions { display:flex; gap:8px; align-items:center; }
.btn {
  padding: 8px 12px;
  border-radius: 10px;
  font-weight: 800;
  cursor:pointer;
  border: 1px solid transparent;
}
.btn-outline {
  background: transparent;
  color: #fff;
  border: 1px solid rgba(255,255,255,0.06);
}
.btn-outline:disabled { opacity: 0.5; cursor: not-allowed; }
.btn-primary {
  background: linear-gradient(90deg,#2563eb,#7c3aed);
  color: #fff;
  border: none;
}
.btn-primary:disabled { opacity: 0.6; cursor: not-allowed; }

/* pager */
.pager { display:flex; gap:12px; align-items:center; justify-content:space-between; margin-top:14px; }
.pager-center { color: #cbd5e1; display:flex; gap:8px; align-items:center; }

/* responsive */
@media (max-width: 720px) {
  .card { padding: 12px; margin: 12px; }
  .controls { gap: 8px; }
  .fav-main { flex-direction: column; align-items: stretch; }
  .fav-actions { justify-content: flex-start; margin-top:8px; }
}
</style>