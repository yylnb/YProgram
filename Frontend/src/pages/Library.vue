<template>
  <div class="library-root">
    <!-- 顶部介绍 -->
    <header class="lib-hero p-6 mb-6">
      <div class="hero-title hero-left">资料库</div>
      <div class="hero-title hero-right">知识点</div>
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
                    <button class="btn-ghost" @click="copyToClipboard(`${window.location.origin.replace(/\/$/,'')}/library/${detail.lang}/${detail.lb_id}`)">复制链接</button>
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
  if (!id) return alert('非法的 topic id')
  const idx = findIndexById(id)
  if (idx >= 0) currentIndex = idx

  showDetail.value = true
  detailLoading.value = true

  try {
    const topicItem = topics.value.find(t => Number(t.id) === Number(id))
    const lang = topicItem?.lang || selectedLang.value
    const lb_id = topicItem?.lb_id
    if (!lang || lb_id === undefined || lb_id === null) throw new Error('缺少 lang 或 lb_id 信息')

    const res = await axios.get(`/api/library/${encodeURIComponent(lang)}/${encodeURIComponent(lb_id)}`)
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
      detail.value = { id, title: '加载失败', content: `<p>未能获取详情</p>` }
    }
  } catch (e) {
    console.error('openTopic error', e)
    detail.value = { id, title: '加载失败', content: `<p>${e?.message || '网络错误'}</p>` }
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
  // 优先使用 detail.lb_id + detail.lang；如传入参数则支持对象/数字/字符串
  const nid = id !== undefined && id !== null ? Number(id) : null

  // 如果传入了数字（旧用法），尝试判断是否为 db id —— 但我们强制使用 detail.lb_id 和 detail.lang
  const lb = detail.value && (detail.value.lb_id ?? detail.value.lbId ?? detail.value.lb) 
  const lang = detail.value && detail.value.lang

  if (!lang || !lb) {
    alert('无法打开：缺少语言或 lb_id 信息')
    return
  }

  const origin = window.location.origin.replace(/\/$/, '')
  const url = `${origin}/library/${encodeURIComponent(lang)}/${encodeURIComponent(lb)}`

  const newWin = window.open(url, '_blank', 'noopener,noreferrer')
  try { if (newWin) newWin.opener = null } catch (e) {}
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
  @import './Library/LibraryStyle.css';
</style>