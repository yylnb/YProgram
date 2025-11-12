<template>
  <teleport to="body">
    <div v-if="visibleLocal" class="modal-backdrop" @click.self="handleBackdropClick">
      <div class="modal" role="dialog" aria-modal="true" :aria-label="detail.title || '知识点详情'">
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
            <button
              class="fav-btn"
              :disabled="syncingFav"
              @click="onToggleFavorite"
              ref="favButton"
            >
              <span v-if="syncingFav">…</span>
              <span v-else-if="isFavLocal">★ 已收藏</span>
              <span v-else>☆ 收藏</span>
            </button>

            <button class="close-btn" @click="doClose" aria-label="关闭详情">✕</button>
          </div>
        </div>

        <!-- body -->
        <div class="modal-body">
          <div class="modal-grid">
            <!-- left: content -->
            <div class="modal-content">
              <div v-if="loading" class="loading-note">加载内容中…</div>

              <div v-else-if="error" class="content-card">
                <p class="text-red-600 font-bold">加载失败：{{ error }}</p>
                <p class="text-gray-600 mt-2">请稍后再试。</p>
                <div style="margin-top:12px;">
                  <button class="btn-primary" @click="fetchDetail">重试</button>
                </div>
              </div>

              <div v-else>
                <div class="content-card">
                  <div class="prose" v-html="detail.content || '<p>无可显示内容</p>'"></div>
                </div>

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

                <div v-if="detail.code_example" class="mt-4">
                  <h4>示例代码</h4>
                  <div class="code-and-tools">
                    <pre class="code" ref="codePre">{{ detail.code_example }}</pre>
                    <div class="code-tools" style="display:flex; flex-direction:column; gap:8px;">
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
                  <div class="res-card-foot" style="display:flex;gap:8px;">
                    <button class="btn-primary" @click="navigatePrev" :disabled="!hasPrev">上一条</button>
                    <button class="btn-primary" @click="navigateNext" :disabled="!hasNext">下一条</button>
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
                    <button class="btn-ghost" @click="copyLink">复制链接</button>
                    <button class="btn-primary" @click="openInNewTab">在新窗口打开</button>
                    <button class="btn-white" @click="emitPractice" v-if="detail.id">去练习</button>
                  </div>
                </div>
              </div>
            </aside>
          </div>
        </div>
      </div>
    </div>
  </teleport>
</template>

<script setup>
import { ref, watch, computed, onMounted, onBeforeUnmount, nextTick } from 'vue'
import axios from 'axios'

// ---------- Props / Emits ----------
const props = defineProps({
  topicId: { type: [String, Number], default: null },
  language: { type: String, default: '' },
  visible: { type: Boolean, default: false },
  fetchOnOpen: { type: Boolean, default: true },
  // optional: provide initial favorite ids or state? For simplicity we track local state here.
})

const emits = defineEmits(['update:visible', 'close', 'action', 'favorite', 'navigate'])

// ---------- Local state ----------
const visibleLocal = ref(Boolean(props.visible))
const topicIdLocal = ref(props.topicId)

const detail = ref({})
const loading = ref(false)
const error = ref('')
const syncingFav = ref(false)
const isFavLocal = ref(false) // local favorite state; will be tried to load from backend if possible

// For simple prev/next availability, we do not have full topics list here.
// So we let parent indicate availability via optional props in future.
// For now, we enable prev/next buttons and emit navigate - parent should respond by opening prev/next and possibly update props.
const hasPrev = ref(true)  // default true to enable buttons — parent may ignore
const hasNext = ref(true)

// refs for focus management
const favButton = ref(null)
const codePre = ref(null)

// ---------- Helpers ----------
function difficultyLabelOf(v) {
  return v === 'beginner' ? '入门' : v === 'intermediate' ? '中级' : v === 'advanced' ? '高级' : v
}
function formatExample(it) {
  if (it == null) return ''
  if (typeof it === 'string') return it
  try { return JSON.stringify(it, null, 2) } catch { return String(it) }
}
function safeParseJSON(val) {
  if (val == null) return null
  if (typeof val === 'object') return val
  try { return JSON.parse(val) } catch { return null }
}

// ---------- Fetch detail ----------
async function fetchDetail() {
  error.value = ''
  if (!topicIdLocal.value) {
    detail.value = {}
    return
  }
  loading.value = true
  try {
    const res = await axios.get(`/api/library/${topicIdLocal.value}`)
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
      // try to load favorite state for this id (best-effort)
      await loadFavState(detail.value.id)
    } else {
      error.value = '未能获取详情'
      detail.value = {}
    }
  } catch (e) {
    console.error('LibraryDetail fetch error', e)
    error.value = (e && e.message) ? e.message : '网络错误'
    detail.value = {}
  } finally {
    loading.value = false
    // after render, try focus the first actionable element
    await nextTick()
    tryFocusFirst()
  }
}

// load favorite state for a single id (best-effort)
async function loadFavState(id) {
  if (!id) return
  try {
    const res = await axios.get('/api/library/favorites') // server returns list of fav ids
    if (res.status === 200 && Array.isArray(res.data)) {
      const favs = res.data.map(r => Number(r.id)).filter(n => !Number.isNaN(n))
      isFavLocal.value = favs.includes(Number(id))
    } else {
      isFavLocal.value = false
    }
  } catch (e) {
    // ignore; keep existing state
    console.warn('loadFavState failed', e)
  }
}

// ---------- Favorite toggle ----------
async function onToggleFavorite() {
  if (!detail.value || !detail.value.id) return
  const id = Number(detail.value.id)
  syncingFav.value = true
  try {
    if (!isFavLocal.value) {
      await axios.post('/api/library/favorite', { id })
      isFavLocal.value = true
      emits('favorite', { id, favorited: true })
    } else {
      await axios.delete(`/api/library/favorite/${id}`)
      isFavLocal.value = false
      emits('favorite', { id, favorited: false })
    }
  } catch (e) {
    console.error('toggle favorite error', e)
    alert('收藏操作失败：' + ((e && e.response && e.response.data && e.response.data.error) ? e.response.data.error : (e && e.message ? e.message : '网络错误')))
  } finally {
    syncingFav.value = false
  }
}

// ---------- copy / open utilities ----------
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
function copyLink() {
  const id = detail.value && detail.value.id
  if (!id) { alert('无链接可复制'); return }
  const url = (window.location.origin || '') + '/library/' + id
  copyToClipboard(url)
}
function openInNewTab() {
  const id = detail.value && detail.value.id
  if (!id) { alert('无效的 id，无法在新窗口打开'); return }
  const origin = window.location.origin.replace(/\/$/, '')
  const url = origin + '/library/' + id
  window.open(url, '_blank')
}
function runExample(code) {
  alert('运行示例（暂未实现）：\n\n' + (code || ''))
}

// ---------- navigation emits ----------
function navigatePrev() { emits('navigate', 'prev') }
function navigateNext() { emits('navigate', 'next') }

// ---------- action emits ----------
function emitPractice() {
  if (!detail.value || !detail.value.id) return
  emits('action', { type: 'practice', topicId: detail.value.id })
}

// ---------- open/close handling ----------
function doClose() {
  visibleLocal.value = false
  emits('update:visible', false)
  emits('close')
}

function handleBackdropClick() {
  doClose()
}

// ---------- keyboard handling ----------
function handleKeydown(e) {
  if (!visibleLocal.value) return
  if (e.key === 'Escape') {
    doClose()
  } else if (e.key === 'ArrowLeft') {
    emits('navigate', 'prev')
  } else if (e.key === 'ArrowRight') {
    emits('navigate', 'next')
  }
}

// ---------- focus management ----------
function tryFocusFirst() {
  // prefer fav button, then close button, then code block
  if (favButton.value && favButton.value.focus) {
    favButton.value.focus()
    return
  }
  // fallback focus to modal container handled by browser (no explicit container ref here)
}

// ---------- watchers / lifecycle ----------
watch(() => props.visible, (nv) => {
  visibleLocal.value = Boolean(nv)
  if (visibleLocal.value) {
    // when opened, sync topicId and fetch if allowed
    if (props.topicId) {
      topicIdLocal.value = props.topicId
    }
    if (props.fetchOnOpen && props.topicId) {
      fetchDetail()
    } else {
      // if no fetchOnOpen or no topic, clear detail
      if (!props.topicId) detail.value = {}
    }
    window.addEventListener('keydown', handleKeydown)
  } else {
    window.removeEventListener('keydown', handleKeydown)
  }
})

watch(() => props.topicId, (nv) => {
  topicIdLocal.value = nv
  if (visibleLocal.value && props.fetchOnOpen && nv) {
    fetchDetail()
  }
})

onMounted(() => {
  // initialize local visible/topicId
  visibleLocal.value = Boolean(props.visible)
  topicIdLocal.value = props.topicId
  if (visibleLocal.value && props.fetchOnOpen && topicIdLocal.value) {
    fetchDetail()
  }
  if (visibleLocal.value) window.addEventListener('keydown', handleKeydown)
})

onBeforeUnmount(() => {
  window.removeEventListener('keydown', handleKeydown)
})

// Expose small utilities in template
const formatExampleLocal = formatExample
</script>

<style scoped>
/* 我复用主文件中 modal 和相关类，因此这里不重复写大量样式。
   如果需要对 Detail 做局部覆盖，可以在此处添加。 */

/* 确保 teleport 的 modal 在最上层（如果必要，可微调 z-index） */
.modal-backdrop { z-index: 9999; }
/* 确保 code pre 可水平滚动 */
pre.code { white-space: pre-wrap; word-break: break-word; max-height: 40vh; overflow: auto; }
</style>