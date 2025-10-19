<template>
  <div class="library-root">
    <!-- 顶部介绍 -->
    <header class="lib-hero p-6 mb-6">
      <h1 class="text-2xl font-extrabold mb-2">资料库 · 编程知识点</h1>
      <p class="text-gray-600">选择语言后，浏览知识点卡片，点击卡片查看详细讲解（来自云端数据库）。</p>
    </header>

    <!-- 控件栏 -->
    <div class="controls p-4 mb-4 flex flex-wrap gap-4 items-center">
      <div class="languages flex gap-2 items-center">
        <button
          v-for="lang in languages"
          :key="lang.value"
          :class="['pill', { active: lang.value === selectedLang }]"
          @click="selectLang(lang)"
        >
          {{ lang.label }}
        </button>
      </div>

      <div class="flex-1 min-w-[220px] search-wrapper">
        <input
          v-model="q"
          @input="onSearchDebounced"
          placeholder="搜索知识点，支持标题/概述/标签"
          class="input search"
          aria-label="搜索知识点"
        />
        <button v-if="q" class="clear-btn" @click="clearSearch" aria-label="清除搜索">✕</button>
      </div>

      <div class="flex gap-2 items-center">
        <label class="text-sm text-gray-600">难度：</label>
        <select v-model="filter" class="input">
          <option value="all">全部</option>
          <option value="beginner">入门</option>
          <option value="intermediate">中级</option>
          <option value="advanced">高级</option>
        </select>
      </div>
    </div>

    <!-- 列表 -->
    <section class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 px-4">
      <!-- 加载中 -->
      <template v-if="loading">
        <div v-for="n in 6" :key="n" class="card p-4 animate-pulse">
          <div class="h-5 bg-slate-200 rounded w-3/4 mb-3"></div>
          <div class="h-4 bg-slate-200 rounded w-full mb-2"></div>
        </div>
      </template>

      <!-- 错误 fallback -->
      <template v-else-if="error">
        <div class="col-span-full card p-6">
          <p class="text-red-600 font-bold">加载失败：{{ error }}</p>
          <p class="text-gray-600 mt-2">请稍后再试。</p>
        </div>
      </template>

      <!-- 正常列表 -->
      <template v-else>
        <template v-for="topic in visibleTopics" :key="topic.id">
          <article class="card p-4">
            <div class="flex justify-between items-start gap-3">
              <div class="flex-1 min-w-0">
                <h3 class="text-lg font-bold mb-1">{{ topic.title }}</h3>
                <p class="text-sm mb-2 preserve">{{ topic.summary }}</p>
                <div class="text-xs meta">
                  <span>{{ topic.difficultyLabel }}</span> · <span v-if="topic.lb_id">ID: {{ topic.lb_id }}</span>
                </div>
              </div>

              <div class="actions">
                <!-- 查看按钮：不弹起，仅变色 -->
                <button class="btn-view" @click="openTopic(topic.id)">查看</button>

                <button class="fav-btn" :disabled="isSyncingFav(topic.id)" @click="toggleFavorite(topic.id)">
                  <span v-if="isSyncingFav(topic.id)">…</span>
                  <span v-else-if="isFav(topic.id)">★ 已收藏</span>
                  <span v-else>☆ 收藏</span>
                </button>
              </div>
            </div>
          </article>
        </template>
      </template>
    </section>

    <!-- 加载更多 -->
    <div v-if="hasMore" class="load-more-wrap">
      <button class="btn-primary" @click="loadMore" :disabled="loadingMore">{{ loadingMore ? '加载中…' : '加载更多' }}</button>
    </div>

    <!-- 详情模态 -->
    <div v-if="showDetail" class="modal-backdrop" @click.self="closeDetail">
      <div class="modal" role="dialog" aria-modal="true" aria-label="知识点详情">
        <!-- header -->
        <div class="modal-header">
          <div class="title">
            <h2>{{ detail.title || '—' }}</h2>
            <div class="meta">
              <span v-if="detail.lang">{{ detail.lang }}</span>
              <span v-if="detail.lb_id"> · 编号: {{ detail.lb_id }}</span>
              <span v-if="detail.page"> · 页: {{ detail.page }}</span>
              <span v-if="detail.difficulty"> · 难度: {{ difficultyLabelOf(detail.difficulty) }}</span>
            </div>
          </div>

          <div class="actions">
            <!-- 保留收藏与关闭 -->
            <button class="fav-btn" :disabled="isSyncingFav(detail.id)" @click="toggleFavorite(detail.id)">
              {{ isFav(detail.id) ? '★ 已收藏' : '☆ 收藏' }}
            </button>
            <button class="close-btn" @click="closeDetail" aria-label="关闭详情">✕</button>
          </div>
        </div>

        <!-- body -->
        <div class="modal-body">
          <div class="modal-grid">
            <!-- left: content (白底阅读区) -->
            <div class="modal-content">
              <div v-if="detailLoading" class="loading-note">加载内容中…</div>
              <div v-else>
                <!-- 内容白底卡 -->
                <div class="content-card">
                  <div class="prose" v-html="detail.content"></div>
                </div>

                <!-- 输入/输出示例，白底（标题也白底） -->
                <div v-if="(detail.eg_in && detail.eg_in.length) || (detail.eg_out && detail.eg_out.length)" class="examples mt-4">
                  <div class="example-card">
                    <h4 class="example-title">示例输入 / 输出</h4>
                    <div v-if="detail.eg_in && detail.eg_in.length" style="margin-top:8px;">
                      <strong>输入：</strong>
                      <ul>
                        <li v-for="(it, idx) in detail.eg_in" :key="'in-'+idx" class="preserve">{{ formatExample(it) }}</li>
                      </ul>
                    </div>
                    <div v-if="detail.eg_out && detail.eg_out.length" style="margin-top:8px;">
                      <strong>输出：</strong>
                      <ul>
                        <li v-for="(it, idx) in detail.eg_out" :key="'out-'+idx" class="preserve">{{ formatExample(it) }}</li>
                      </ul>
                    </div>
                  </div>
                </div>

                <!-- 示例代码 -->
                <div v-if="detail.code_example" class="mt-4">
                  <h4>示例代码</h4>
                  <div class="code-and-tools">
                    <pre class="code">{{ detail.code_example }}</pre>
                    <div class="code-tools">
                      <button class="btn-primary" @click="copyToClipboard(detail.code_example)">复制代码</button>
                      <button class="btn-ghost" @click="runExample(detail.code_example)">运行（若支持）</button>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- right: meta / nav / actions -->
            <aside class="modal-side">
              <div class="side-card">
                <div class="res-card-header">
                  <div class="res-title">资料信息</div>
                  <div class="res-sub">
                    <div v-if="detail.lang">语言：{{ detail.lang }}</div>
                    <div v-if="detail.lb_id">编号：{{ detail.lb_id }}</div>
                    <div v-if="detail.page">页码：{{ detail.page }}</div>
                    <div v-if="detail.difficulty">难度：{{ difficultyLabelOf(detail.difficulty) }}</div>
                  </div>
                </div>

                <div style="margin-top:12px;">
                  <div class="res-card-foot">
                    <!-- 上一/下一 使用紫色底白字 -->
                    <button class="btn-primary" @click="prevTopic" :disabled="!hasPrev">上一条</button>
                    <button class="btn-primary" @click="nextTopic" :disabled="!hasNext">下一条</button>
                  </div>
                </div>

                <hr style="margin:12px 0;border:none;border-top:1px solid rgba(0,0,0,0.04)" />

                <div v-if="detail.tags && detail.tags.length">
                  <strong>标签</strong>
                  <div style="display:flex;flex-wrap:wrap;gap:6px;margin-top:8px;">
                    <span v-for="(t,i) in detail.tags" :key="i" class="pill-tag">{{ t }}</span>
                  </div>
                </div>

                <div style="margin-top:12px;">
                  <strong>操作</strong>
                  <div style="display:flex;flex-direction:column;gap:8px;margin-top:8px;">
                    <!-- 先复制链接（无色），再在新窗口中打开（紫色底白字） -->
                    <button class="btn-ghost" @click="copyToClipboard(window.location.origin + '/library/' + detail.id)">复制链接</button>
                    <button class="btn-primary" @click="openInNewTab(detail.id)">在新窗口打开</button>
                  </div>
                </div>
              </div>
            </aside>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted, watch } from 'vue'
import axios from 'axios'

// ----------------- Helpers -----------------
function safeParseJSON(val) {
  if (val == null) return null
  if (typeof val === 'object') return val
  try {
    return JSON.parse(val)
  } catch (e) {
    return null
  }
}

function toLocale(d) { return d ? new Date(d).toLocaleString() : '—' }
function difficultyLabelOf(v) {
  return v === 'beginner' ? '入门' : v === 'intermediate' ? '中级' : v === 'advanced' ? '高级' : v
}
function formatExample(it) {
  if (it == null) return ''
  if (typeof it === 'string') return it
  try { return JSON.stringify(it, null, 2) } catch { return String(it) }
}
function debounce(fn, delay = 400) { let t; return (...a) => { clearTimeout(t); t = setTimeout(() => fn(...a), delay) } }

// ----------------- State -----------------
const languages = [
  { label: 'python', value: 'python' },
  { label: 'c++',    value: 'cpp' },
  { label: 'c',      value: 'c' },
  { label: 'java',   value: 'java' },
  { label: 'html',   value: 'html' },
  { label: 'css',    value: 'css' },
  { label: 'javascript', value: 'javascript' }
]

const selectedLang = ref('python')
const q = ref('')
const filter = ref('all')

const topics = ref([])
const loading = ref(false)
const error = ref('')
const page = ref(1)
const pageSize = ref(12)
const hasMore = ref(false)
const loadingMore = ref(false)

// detail modal state
const showDetail = ref(false)
const detail = ref({})
const detailLoading = ref(false)

// favorites
const favoritesIds = ref([])        // number[]
const syncingFavs = ref(new Set())  // Set<number>

// computed
const visibleTopics = computed(() => topics.value || [])

// ----------------- Sorting -----------------
function sortByLbId(list) {
  return list.slice().sort((a, b) => {
    const na = Number(a.lb_id), nb = Number(b.lb_id)
    if (Number.isNaN(na) || Number.isNaN(nb)) return 0
    return na - nb
  })
}

// ----------------- Load topics -----------------
async function loadTopics({ append = false } = {}) {
  if (!append) { loading.value = true; error.value = '' } else { loadingMore.value = true }

  try {
    const params = {
      lang: selectedLang.value,
      page: page.value,
      pageSize: pageSize.value
    }
    if (q.value && q.value.trim()) params.q = q.value.trim()
    if (filter.value && filter.value !== 'all') params.filter = filter.value

    const res = await axios.get('/api/library', { params })
    if (res.status === 200 && res.data && Array.isArray(res.data.items)) {
      // Map items, parse JSON fields safely
      const items = res.data.items.map(r => ({
        id: r.id,
        lang: r.lang,
        lb_id: r.lb_id,
        difficulty: r.difficulty,
        page: r.page,
        title: r.title,
        tags: safeParseJSON(r.tags) || (Array.isArray(r.tags) ? r.tags : []),
        summary: r.summary,
        content: r.content || '',
        eg_in: safeParseJSON(r.eg_in) || (Array.isArray(r.eg_in) ? r.eg_in : []),
        eg_out: safeParseJSON(r.eg_out) || (Array.isArray(r.eg_out) ? r.eg_out : []),
        code_example: r.code_example || r.code || null,
        updated_at: r.updated_at || r.created_at || null,
        difficultyLabel: difficultyLabelOf(r.difficulty)
      }))

      if (append) {
        // merge dedupe by id then sort
        const merged = topics.value.concat(items)
        const map = new Map(); merged.forEach(it => map.set(it.id, it))
        topics.value = sortByLbId(Array.from(map.values()))
      } else {
        topics.value = sortByLbId(items)
      }

      hasMore.value = !!res.data.hasMore
    } else {
      if (!append) topics.value = []
      hasMore.value = false
    }
  } catch (e) {
    console.error('loadTopics error', e)
    if (!append) {
      error.value = (e && e.message) ? e.message : '加载失败'
      topics.value = []
    } else {
      alert('加载更多失败：' + ((e && e.message) ? e.message : '网络错误'))
    }
  } finally {
    loading.value = false
    loadingMore.value = false
  }
}

// ----------------- Favorites -----------------
async function loadFavorites() {
  try {
    const res = await axios.get('/api/library/favorites')
    if (res.status === 200 && Array.isArray(res.data)) {
      // backend returns rows with id = library.id
      favoritesIds.value = res.data.map(r => Number(r.id)).filter(n => !Number.isNaN(n))
    } else {
      favoritesIds.value = []
    }
  } catch (e) {
    console.warn('loadFavorites failed', e)
    favoritesIds.value = []
  }
}

function isFav(id) { return favoritesIds.value.includes(Number(id)) }
function isSyncingFav(id) { return syncingFavs.value.has(Number(id)) }

async function toggleFavorite(id) {
  const nid = Number(id)
  if (!nid) return
  const currentlyFav = isFav(nid)
  syncingFavs.value.add(nid)
  try {
    if (!currentlyFav) {
      await axios.post('/api/library/favorite', { id: nid })
      if (!favoritesIds.value.includes(nid)) favoritesIds.value.push(nid)
    } else {
      await axios.delete(`/api/library/favorite/${nid}`)
      favoritesIds.value = favoritesIds.value.filter(x => x !== nid)
    }
  } catch (e) {
    console.error('toggleFavorite error', e)
    alert('收藏操作失败：' + ((e && e.response && e.response.data && e.response.data.error) ? e.response.data.error : (e && e.message ? e.message : '网络错误')))
  } finally {
    syncingFavs.value.delete(nid)
  }
}

// ----------------- Pagination -----------------
function loadMore() {
  if (!hasMore.value || loadingMore.value) return
  page.value += 1
  loadTopics({ append: true })
}

// ----------------- Interactions -----------------
function selectLang(langObj) {
  const val = typeof langObj === 'string' ? (languages.find(x => x.label === langObj || x.value === langObj) || {}).value : langObj.value
  if (!val) return
  if (selectedLang.value === val) return
  selectedLang.value = val
  page.value = 1
  loadTopics()
  loadFavorites()
}

// ----------------- Detail modal + navigation -----------------
let currentIndex = -1
function findIndexById(id) {
  return topics.value.findIndex(t => Number(t.id) === Number(id))
}

async function openTopic(id) {
  const nid = Number(id)
  if (!nid) {
    alert('非法的 topic id')
    return
  }

  showDetail.value = true
  detailLoading.value = true
  // update currentIndex if possible
  currentIndex = findIndexById(nid)

  try {
    const res = await axios.get(`/api/library/${nid}`)
    if (res.status === 200 && res.data) {
      const r = res.data
      detail.value = {
        id: r.id,
        lang: r.lang,
        lb_id: r.lb_id,
        title: r.title,
        tags: safeParseJSON(r.tags) || (Array.isArray(r.tags) ? r.tags : []),
        summary: r.summary,
        content: r.content || '',
        eg_in: safeParseJSON(r.eg_in) || (Array.isArray(r.eg_in) ? r.eg_in : []),
        eg_out: safeParseJSON(r.eg_out) || (Array.isArray(r.eg_out) ? r.eg_out : []),
        code_example: r.code_example || r.code || null,
        difficulty: r.difficulty,
        page: r.page,
        updated_at: r.updated_at || r.created_at || null
      }
    } else {
      detail.value = { id: nid, title: '加载失败', content: `<p>未能获取详情</p>` }
    }
  } catch (e) {
    console.error('openTopic error', e)
    detail.value = { id: nid, title: '加载失败', content: `<p>${(e && e.message) ? e.message : '网络错误'}</p>` }
  } finally {
    detailLoading.value = false
  }
}

function closeDetail() {
  showDetail.value = false
  detail.value = {}
  currentIndex = -1
}

watch(filter, (newVal, oldVal) => {
  page.value = 1
  loadTopics() // 使用你已有的 loadTopics 函数
})

function getCurrentIndex() {
  if (!detail.value || detail.value.id == null) return -1
  // 返回 topics 中 id 相等的索引（Number 比较以防字符串/数字差异）
  return topics.value.findIndex(t => Number(t.id) === Number(detail.value.id))
}

const hasPrev = computed(() => {
  const idx = getCurrentIndex()
  return idx > 0
})

const hasNext = computed(() => {
  const idx = getCurrentIndex()
  return idx >= 0 && idx < topics.value.length - 1
})

function prevTopic() {
  const idx = getCurrentIndex()
  if (idx <= 0) return
  const prevId = topics.value[idx - 1].id
  // 直接打开上一条（openTopic 会重新加载详情并更新 detail）
  openTopic(prevId)
}

function nextTopic() {
  const idx = getCurrentIndex()
  if (idx < 0 || idx >= topics.value.length - 1) return
  const nextId = topics.value[idx + 1].id
  openTopic(nextId)
}

// keyboard nav
function handleKeydown(e) {
  if (!showDetail.value) return
  if (e.key === 'Escape') closeDetail()
  else if (e.key === 'ArrowLeft') prevTopic()
  else if (e.key === 'ArrowRight') nextTopic()
}
watch(showDetail, (nv) => {
  if (nv) window.addEventListener('keydown', handleKeydown)
  else window.removeEventListener('keydown', handleKeydown)
})
onUnmounted(() => { window.removeEventListener('keydown', handleKeydown) })

// ----------------- Utilities -----------------
async function copyToClipboard(text) {
  try {
    if (!text) return alert('无可复制内容')
    await navigator.clipboard.writeText(text)
    alert('已复制到剪贴板')
  } catch (e) {
    console.error('copy failed', e)
    alert('复制失败')
  }
}

function openInNewTab(id) {
  const nid = id !== undefined && id !== null ? Number(id) : (detail.value && Number(detail.value.id))
  if (!nid) {
    alert('无效的 id，无法在新窗口打开')
    return
  }
  const origin = window.location.origin.replace(/\/$/, '')
  const url = origin + '/library/' + nid
  window.open(url, '_blank')
}

// placeholder: run example
function runExample(code) {
  alert('运行示例（暂未实现）：\n\n' + (code || ''))
}

// ----------------- Search helpers -----------------
function clearSearch() { q.value = ''; page.value = 1; loadTopics() }
const onSearchDebounced = debounce(() => { page.value = 1; loadTopics() }, 400)

// ----------------- Lifecycle -----------------
onMounted(() => {
  page.value = 1
  loadTopics()
  loadFavorites()
})
</script>

<style scoped>
/* 主题变量 */
.library-root {
  --bg-image: url('../assets/StudyBackground.png');
  --bg-fallback: #f6eefb;
  --primary: #843f8d;        /* 你指定的紫色 */
  --primary-600: #5e195f;
  --card-border: rgba(132,63,141,0.12);
  --muted: #6b4b66;
  --text-strong: #33122E;
  --glass-shadow: 0 14px 40px rgba(61,22,61,0.06);
  --code-bg: #0b1220;
  --code-fg: #e6eef8;
  --fav-yellow: #d6b24b;

  min-height: calc(100vh - 0px);
  box-sizing: border-box;
  position: relative;
  z-index: 1;
  padding: 70px 12px 80px;
}

/* 背景（伪元素） */
.library-root::before {
  content: "";
  position: fixed;
  inset: 0;
  z-index: 0;
  pointer-events: none;
  background-image: var(--bg-image);
  background-position: top center;
  background-repeat: no-repeat;
  background-size: cover;
  background-color: var(--bg-fallback);
}

/* 顶部介绍 */
.lib-hero {
  position: relative;
  z-index: 2;
  border-radius: 12px;
  padding: 18px 22px;
  overflow: visible;
  background: linear-gradient(180deg, rgba(132,63,141,0.14), rgba(132,63,141,0.06));
  border: 1px solid var(--card-border);
  -webkit-backdrop-filter: blur(12px) saturate(120%);
  backdrop-filter: blur(12px) saturate(120%);
  box-shadow: var(--glass-shadow);
  color: var(--text-strong);
}
.lib-hero h1 { margin:0 0 6px 0; font-size:1.5rem; font-weight:900; color: var(--text-strong); }
.lib-hero p { margin:0; color: var(--text-strong); opacity: 0.95; }

/* controls */
.controls {
  position: relative;
  z-index: 2;
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  align-items: center;
  margin-top: 18px;
}

/* language pills */
.languages { display:flex; gap:8px; align-items:center; }
.pill {
  padding: 8px 12px;
  border-radius: 999px;
  cursor: pointer;
  font-weight: 700;
  background: linear-gradient(180deg, rgba(255,255,255,0.02), rgba(255,255,255,0.01));
  color: var(--text-strong);
  border: 1px solid rgba(255,255,255,0.04);
  -webkit-backdrop-filter: blur(6px) saturate(110%);
  backdrop-filter: blur(6px) saturate(110%);
  transition: transform .12s ease, box-shadow .12s ease, color .12s;
}
.pill:hover { transform: translateY(-2px); box-shadow: 0 8px 18px rgba(0,0,0,0.06); }
.pill.active {
  background: linear-gradient(180deg, var(--primary), var(--primary-600));
  color: #ffffff;
  border-color: rgba(255,255,255,0.12);
}

/* search input */
.search-wrapper { position: relative; display: block; z-index:2; }
.input.search {
  padding: 10px 40px 10px 38px;
  border-radius: 12px;
  border: 1px solid rgba(51,18,46,0.08);
  background: rgba(255,255,255,0.98);
  color: var(--text-strong);
  outline: none;
  box-shadow: 0 6px 18px rgba(51,18,46,0.04);
  transition: box-shadow .18s, border-color .12s, transform .12s;
  min-width: 260px;
  font-weight: 700;
}
.input.search:focus {
  box-shadow: 0 10px 30px rgba(132,63,141,0.12);
  border-color: var(--primary-600);
  transform: translateY(-1px);
}
/* magnifier icon inline SVG */
.input.search {
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24'%3E%3Cpath fill='%2333122E' d='M21.53 20.47l-4.91-4.91A7 7 0 1 0 18 18l4.53 4.53a.75.75 0 0 0 1.06-1.06zM5.5 11a5.5 5.5 0 1 1 11 0 5.5 5.5 0 0 1-11 0z'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: 12px center;
  background-size: 16px 16px;
}
.clear-btn {
  position: absolute;
  right: 10px;
  top: 50%;
  transform: translateY(-50%);
  background: rgba(0,0,0,0.04);
  border: none;
  padding: 6px 8px;
  border-radius: 8px;
  cursor: pointer;
  color: var(--text-strong);
  font-weight: 700;
  z-index: 3;
}

/* select styling */
select.input {
  -webkit-appearance: none;
  appearance: none;
  padding: 10px 36px 10px 12px;
  border-radius: 10px;
  border: 1px solid rgba(51,18,46,0.08);
  background: linear-gradient(180deg, rgba(255,255,255,0.98), rgba(255,255,255,0.96));
  color: var(--text-strong);
  font-weight: 700;
  min-width: 160px;
  box-shadow: 0 6px 18px rgba(51,18,46,0.04);
  z-index: 2;
}
select.input {
  background-image: linear-gradient(180deg, rgba(255,255,255,0), rgba(255,255,255,0)), url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='14' height='14' viewBox='0 0 24 24'%3E%3Cpath fill='%2333122E' d='M7 10l5 5 5-5z'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 12px center;
  background-size: 14px 14px;
}
select.input:focus { box-shadow: 0 10px 30px rgba(132,63,141,0.12); border-color: var(--primary-600); transform: translateY(-1px); }

/* grid & cards */
section.grid { position: relative; z-index: 2; display: grid; grid-template-columns: repeat(1, 1fr); gap: 18px; margin-top: 18px; padding: 0 4px; }
@media (min-width: 640px) { section.grid { grid-template-columns: repeat(2, 1fr); } }
@media (min-width: 1024px) { section.grid { grid-template-columns: repeat(3, 1fr); } }

/* card — 悬停时弹起（弹起效果保留） */
.card {
  cursor: default;
  transition: transform 260ms cubic-bezier(.2,.9,.2,1), box-shadow 260ms cubic-bezier(.2,.9,.2,1), border-color 180ms;
  border: 1px solid rgba(132,63,141,0.08);
  background: linear-gradient(180deg, rgba(132,63,141,0.06), rgba(255,255,255,0.02));
  padding: 14px;
  border-radius: 12px;
  -webkit-backdrop-filter: blur(12px) saturate(120%);
  backdrop-filter: blur(12px) saturate(120%);
  box-shadow: 0 10px 30px rgba(61,22,61,0.04);
  color: var(--text-strong);
}
.card:hover {
  transform: translateY(-8px) scale(1.01);
  box-shadow: 0 36px 80px rgba(132,63,141,0.12);
  border-color: rgba(132,63,141,0.22);
  background: linear-gradient(180deg, rgba(132,63,141,0.12), rgba(255,255,255,0.04));
}

.card h3 { margin:0 0 6px 0; font-size:1.05rem; font-weight:900; color: var(--text-strong); }
.card p { margin:0; color: var(--text-strong); opacity: 0.95; font-size:0.95rem; }
.card .meta { margin-top:10px; font-size:0.85rem; color: var(--text-strong); opacity: 0.85; display:flex; gap:8px; align-items:center; }

/* card actions */
.card .actions { display:flex; flex-direction:column; gap:8px; align-items:flex-end; }

/* 查看按钮（卡片里）：去掉弹起，仅微变色 */
.btn-view {
  background: linear-gradient(180deg, rgba(255,255,255,0.98), rgba(255,255,255,0.96));
  color: var(--text-strong);
  border: 1px solid rgba(132,63,141,0.06);
  padding: 8px 12px;
  border-radius: 10px;
  font-weight:800;
  cursor:pointer;
  -webkit-backdrop-filter: blur(6px) saturate(110%);
  backdrop-filter: blur(6px) saturate(110%);
  box-shadow: 0 6px 18px rgba(51,18,46,0.04);
  transition: background .12s ease, color .12s ease;
}
.btn-view:hover {
  background: rgba(132,63,141,0.06);
}

/* 收藏按钮 */
.fav-btn {
  background: rgba(214,178,75,0.06);
  color: var(--fav-yellow);
  border: 1px solid rgba(214,178,75,0.18);
  padding: 6px 10px;
  border-radius: 8px;
  cursor: pointer;
  font-weight: 800;
}
.fav-btn:hover { background: rgba(214,178,75,0.10); box-shadow: 0 8px 18px rgba(214,178,75,0.06); }
.fav-btn[disabled] { opacity: 0.6; cursor: not-allowed; }

/* load more */
.load-more-wrap { display:flex; justify-content:center; padding: 16px 0; z-index:2; }

/* ---------- modal ---------- */
/* backdrop: 透明 + 毛玻璃（不遮暗背景） */
.modal-backdrop {
  position: fixed;
  inset: 0;
  z-index: 60;
  display:flex;
  align-items:center;
  justify-content:center;
  pointer-events: auto;
  background: transparent;
  -webkit-backdrop-filter: blur(6px) saturate(110%);
  backdrop-filter: blur(6px) saturate(110%);
}

/* modal container — 增强阴影以提升立体感 */
.modal {
  max-width: 920px;
  width: calc(100% - 32px);
  border-radius: 12px;
  overflow: hidden;
  -webkit-backdrop-filter: blur(8px);
  backdrop-filter: blur(8px);
  border: 1px solid rgba(255,255,255,0.04);
  background: linear-gradient(180deg, rgba(255,255,255,0.02), rgba(132,63,141,0.02));
  color: var(--text-strong);
  display: flex;
  flex-direction: column;
  max-height: 85vh;
  z-index: 70;
  box-shadow: 0 40px 80px rgba(12,12,12,0.18), 0 10px 30px rgba(132,63,141,0.06);
}

/* modal header */
.modal .modal-header {
  padding: 16px 18px;
  border-bottom: 1px solid rgba(132,63,141,0.04);
  display:flex;
  align-items:center;
  justify-content:space-between;
  gap:12px;
  background: linear-gradient(180deg, rgba(132,63,141,0.06), rgba(255,255,255,0.01));
  -webkit-backdrop-filter: blur(10px) saturate(120%);
  backdrop-filter: blur(10px) saturate(120%);
}
.modal .modal-header .title { display:flex; flex-direction:column; gap:6px; }
.modal .modal-header h2 { margin:0; font-size:1.15rem; font-weight:900; color: var(--text-strong); }
.modal .modal-header .meta { font-size:0.9rem; color: var(--muted); }

/* header actions */
.modal .modal-header .actions { display:flex; gap:10px; align-items:center; }
.modal .modal-header .close-btn {
  background: transparent;
  border: 1px solid rgba(51,18,46,0.06);
  padding: 6px 9px;
  border-radius: 10px;
  cursor: pointer;
  color: var(--text-strong);
}
.modal .modal-header .close-btn:hover { transform: translateY(-2px); box-shadow: 0 8px 18px rgba(51,18,46,0.04); }

/* modal body */
.modal .modal-body { padding: 18px; overflow: auto; color: var(--text-strong); line-height: 1.7; background: linear-gradient(180deg, rgba(255,255,255,0.01), rgba(255,255,255,0.00)); }
.modal-grid { display:grid; grid-template-columns: 1fr 320px; gap: 18px; align-items:start; }
@media (max-width: 900px) { .modal-grid { grid-template-columns: 1fr; } }

/* 左侧：白底内容区域 */
.content-card {
  background: #ffffff;
  border-radius: 10px;
  padding: 16px;
  border: 1px solid rgba(12,12,12,0.04);
  box-shadow: 0 8px 24px rgba(12,12,12,0.04);
  color: var(--text-strong);
}
.example-card {
  background: #ffffff;
  border-radius: 10px;
  padding: 12px;
  border: 1px solid rgba(12,12,12,0.04);
  box-shadow: inset 0 1px 0 rgba(255,255,255,0.6);
  color: var(--text-strong);
}
.example-title {
  display:inline-block;
  background: #ffffff;
  margin: 0;
  padding: 6px 10px;
  border-radius: 8px;
  font-weight: 900;
  color: var(--text-strong);
  border: 1px solid rgba(12,12,12,0.04);
}

/* code and tools */
.code-and-tools { display:flex; gap:12px; align-items:flex-start; margin-top:8px; }
.code { background: var(--code-bg); color: var(--code-fg); padding: 12px; border-radius: 8px; overflow:auto; flex:1; border: 1px solid rgba(132,63,141,0.06); box-shadow: inset 0 2px 6px rgba(0,0,0,0.28); }

/* modal right side */
.modal-side .side-card { padding:12px; border-radius:12px; background: linear-gradient(180deg, rgba(132,63,141,0.06), rgba(255,255,255,0.02)); border:1px solid rgba(132,63,141,0.06); -webkit-backdrop-filter: blur(12px); backdrop-filter: blur(12px); }
.pill-tag { padding:6px 8px; border-radius:8px; background: rgba(255,255,255,0.88); border:1px solid rgba(132,63,141,0.04); color: var(--text-strong); font-weight:700; }

/* 按钮：紫色主题（用于强调） */
.btn-primary {
  background: linear-gradient(90deg, var(--primary), var(--primary-600));
  color: #ffffff;
  border: none;
  padding: 8px 12px;
  border-radius: 10px;
  font-weight:900;
  cursor:pointer;
  box-shadow: 0 12px 30px rgba(132,63,141,0.14);
}
.btn-primary:hover { filter: brightness(0.95); }

/* 白底按钮 */
.btn-white {
  background: #ffffff;
  color: var(--primary);
  border: 1px solid rgba(132,63,141,0.08);
  padding: 8px 12px;
  border-radius: 10px;
  font-weight:800;
  cursor: pointer;
  box-shadow: 0 8px 20px rgba(12,12,12,0.06);
}
.btn-white:hover { transform: translateY(-2px); }

/* 无色透明按钮（ghost） */
.btn-ghost {
  background: transparent;
  color: var(--primary);
  border: 1px solid rgba(132,63,141,0.08);
  padding: 8px 12px;
  border-radius: 10px;
  font-weight:800;
  cursor: pointer;
}
.btn-ghost:hover { background: rgba(132,63,141,0.06); }

/* 其它细节 */
.prose { color: var(--text-strong); }
.animate-pulse { animation: pulse 1.4s ease-in-out infinite; }
@keyframes pulse { 0% { opacity: 1 } 50% { opacity: 0.55 } 100% { opacity: 1 } }
.preserve { white-space: pre-wrap; word-break: break-word; }

@media (max-width: 900px) {
  .library-root { padding: 36px 10px 60px; }
  .lib-hero { padding: 14px; }
  .controls { gap:8px; }
  .pill { padding:6px 10px; font-size: 0.95rem; }
  .input.search { min-width: 160px; }
  .modal { width: calc(100% - 20px); max-height: 92vh; }
}

/* focus accessibility */
.pill:focus, .btn-primary:focus, .btn-try:focus, .fav-btn:focus, .close-btn:focus, .btn-white:focus, .btn-ghost:focus {
  outline: 3px solid rgba(132,63,141,0.12);
  outline-offset: 2px;
  border-radius: 10px;
}

/* 小工具颜色 */
.loading-note { color: var(--muted); font-weight:700; }
</style>