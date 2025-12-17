<template>
  <div class="favorites-root">
    <div class="card">
      <div class="card-header">
        <div class="title-block">
          <h3 class="title">收藏资料</h3>
          <p class="subtitle">快速访问你收藏的资料与跳转阅读</p>
        </div>

        <div class="controls">
          <!-- 语言选择 -->
          <CustomDropdown
            v-model="favSelectedLang"
            :options="langOptions"
            labelKey="label"
            valueKey="value"
            placeholder="选择语言"
            class="control-dropdown"
            @change="onLangChanged"
          />
        </div>
      </div>

      <div class="card-body">
        <p v-if="loadingFavs" class="loading">加载收藏中…</p>

        <div v-else>
          <p v-if="favorites.length === 0" class="empty">
            你还没有收藏资料。
          </p>

          <ul v-else class="fav-list">
            <li v-for="(f, idx) in favorites" :key="f.id ?? idx" class="fav-item">
              <div class="fav-main">
                <div class="fav-meta">
                  <div class="meta-top">
                    <span class="meta-id">资料 ID：<strong>{{ f.id }}</strong></span>
                    <span class="meta-sep">|</span>
                    <span class="meta-lang">语言 {{ f.lang ?? '-' }}</span>
                    <span class="meta-time">· 收藏于 {{ formatTime(f.favorited_at) }}</span>
                  </div>

                  <div class="meta-title" v-if="f.title" v-html="f.title"></div>
                  <div class="meta-summary" v-if="f.summary">{{ f.summary }}</div>
                  <div class="meta-missing" v-else>（标题/简介不可用）</div>
                </div>

                <div class="fav-actions">
                  <button class="btn btn-outline" @click="removeFavorite(f.id)" :disabled="removing">
                    取消收藏
                  </button>
                  <button class="btn btn-primary" @click="goToLibraryDetail(f)" :disabled="!f.lb_id">
                    前往资料
                  </button>
                </div>
              </div>
            </li>
          </ul>

          <!-- pager（用后端返回的 totalPages/currentPage） -->
          <div class="pager" v-if="favTotalPages > 1">
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
import CustomDropdown from '../../components/CustomDropdown.vue' // 确认路径

const router = useRouter()
const BASE_API = 'http://localhost:5000' // 如需修改请替换

// state (服务器分页)
const favorites = ref([])
const loadingFavs = ref(false)
const removing = ref(false)
const favCurrentPage = ref(1)
const favTotalPages = ref(1)
const pageSize = ref(5) // 每页条数：默认 5，可按需调整

// language filter
const favSelectedLang = ref('all')
// language options: 初始给“全部”，会在接口返回时用 availableLangs 覆盖（只展示用户实际有的语言）
const langOptions = ref([{ value: 'all', label: '全部语言' }])

// page dropdown options computed from favTotalPages
const pageOptions = computed(() => {
  const n = Math.max(1, Number(favTotalPages.value || 1))
  const arr = []
  for (let i = 1; i <= n; i++) arr.push({ value: i, label: String(i) })
  return arr
})

// helpers
function formatTime(t) {
  if (!t) return ''
  try { return new Date(t).toLocaleString() } catch (e) { return String(t) }
}

// lifecycle
onMounted(() => {
  loadFavorites(1)
})

// watch language change: reset to page 1 and reload (bound to dropdown change)
function onLangChanged() {
  favCurrentPage.value = 1
  loadFavorites(1)
}

// load favorites from server with page, pageSize, lang
async function loadFavorites(page = 1) {
  const token = localStorage.getItem('yp_token')
  if (!token) {
    favorites.value = []; favTotalPages.value = 1; favCurrentPage.value = 1; return
  }

  loadingFavs.value = true
  try {
    const url = new URL(`${BASE_API}/api/library/favorites/page`)
    url.searchParams.set('page', String(page))
    url.searchParams.set('pageSize', String(pageSize.value))
    // 只有在用户选择了具体语言（非 'all'）时才传 lang
    if (favSelectedLang.value && favSelectedLang.value !== 'all') {
      url.searchParams.set('lang', String(favSelectedLang.value))
    }

    const res = await fetch(url.toString(), {
      headers: { 'Authorization': `Bearer ${token}`, 'Accept': 'application/json' }
    })

    if (!res.ok) {
      // 请求失败：清空并保持页数
      favorites.value = []
      favTotalPages.value = 1
      favCurrentPage.value = 1
      return
    }

    const data = await res.json().catch(() => null)
    if (data && Array.isArray(data.favorites)) {
      // 填充当前页数据
      favorites.value = data.favorites.map(item => ({
        id: item.id ?? null,
        lang: item.lang ?? '',
        lb_id: item.lb_id ?? null,
        title: item.title ?? '',
        summary: item.summary ?? '',
        difficulty: item.difficulty ?? null,
        favorited_at: item.favorited_at ?? item.created_at ?? null
      }))

      // 填充分页元信息（后端会返回 totalPages/currentPage）
      favTotalPages.value = (typeof data.totalPages === 'number') ? Number(data.totalPages) : Math.max(1, Math.ceil((data.total || favorites.value.length) / pageSize.value))
      favCurrentPage.value = (typeof data.currentPage === 'number') ? Number(data.currentPage) : page

      // 使用后端返回的 availableLangs 来渲染下拉（只显示用户实际收藏的语言）
      if (Array.isArray(data.availableLangs)) {
        const opts = [{ value: 'all', label: '全部语言' }]
        data.availableLangs.forEach(l => {
          if (l && l !== 'all') opts.push({ value: String(l), label: String(l).toUpperCase() })
        })
        // 如果 availableLangs 只有一个语言并且你希望默认选择该语言，可在此设置 favSelectedLang
        // 目前保留默认 'all'，但如果你想让它默认选单一语言，可以取消下面注释：
        // if (opts.length === 2) favSelectedLang.value = opts[1].value

        langOptions.value = opts
      } else {
        // 如果后端没有返回 availableLangs，尽量从当前页数据提取语言
        const langs = new Set()
        favorites.value.forEach(f => { if (f.lang) langs.add(f.lang) })
        const opts = [{ value: 'all', label: '全部语言' }, ...Array.from(langs).sort().map(l => ({ value: l, label: String(l).toUpperCase() })) ]
        langOptions.value = opts
      }
    } else {
      favorites.value = []
      favTotalPages.value = 1
      favCurrentPage.value = 1
      // 保持或清空下拉不动
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

// pagination handlers
function changePage(p) {
  if (!p || p < 1) return
  if (p === favCurrentPage.value) return
  favCurrentPage.value = p
  loadFavorites(p)
}
function onPageFromDropdown() {
  const num = Number(favCurrentPage.value) || 1
  changePage(num)
}

// remove favorite: 调用 DELETE /api/library/favorite/:id
async function removeFavorite(libraryId) {
  if (!libraryId) return
  if (!confirm('确认取消收藏该资料？')) return
  const token = localStorage.getItem('yp_token')
  if (!token) { alert('请先登录'); return }

  removing.value = true
  try {
    const res = await fetch(`${BASE_API}/api/library/favorite/${encodeURIComponent(String(libraryId))}`, {
      method: 'DELETE',
      headers: { 'Authorization': `Bearer ${token}` }
    })
    if (res.ok) {
      // 删除成功后刷新当前页：
      await loadFavorites(favCurrentPage.value)
      // 若当前页无数据并且不是第一页，则回退一页后加载
      if (favorites.value.length === 0 && favCurrentPage.value > 1) {
        favCurrentPage.value = Math.max(1, favCurrentPage.value - 1)
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

// 跳转到资料详情页
async function goToLibraryDetail(fav) {
  if (!fav || !fav.lang || !fav.lb_id) { alert('无法跳转：缺少 lang 或 lb_id'); return }
  try {
    await router.push({ path: `/library/${encodeURIComponent(String(fav.lang))}/${encodeURIComponent(String(fav.lb_id))}` })
  } catch (e) {
    window.location.href = `/library/${encodeURIComponent(String(fav.lang))}/${encodeURIComponent(String(fav.lb_id))}`
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
.meta-summary { color: #cbd5e1; font-size:13px; margin-top:6px; }
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