<template>
  <div class="library-view p-6 mx-auto">
    <button
      class="mb-4 px-4 py-2 rounded btn-back flex items-center gap-2"
      @click="goBack()"
      aria-label="返回"
    >
      ← 返回
    </button>

    <div v-if="loading" class="text-muted">加载中...</div>
    <div v-else-if="error" class="text-error">{{ error }}</div>

    <div v-else-if="topic" class="card p-6">
      <!-- 标题区 -->
      <div class="flex items-start justify-between gap-4 mb-4">
        <div>
          <h1 class="title mb-2">{{ topic.title }}</h1>
          <div class="flex items-center gap-3 text-sm meta">
            <span class="lang-badge">
              {{ displayLangLabel(topic.lang || routeLang) }}
            </span>
            <span :class="difficultyClass(topic.difficulty)" class="difficulty-badge">
              {{ difficultyLabel(topic.difficulty) }}
            </span>
            <span class="text-xs text-muted">最后更新：{{ formatDate(topic.updated_at) }}</span>
          </div>
        </div>

        <div class="flex items-center gap-2">
          <button class="btn-action" @click="downloadContent" title="下载当前代码">下载</button>
        </div>
      </div>

      <!-- 概要与正文 -->
      <p class="mb-4 summary">{{ topic.summary }}</p>
      <div class="prose max-w-none mb-6 content-html" v-html="topic.content"></div>

      <!-- 代码示例展示（只读）-->
      <div v-if="topic.code_example" class="code-readonly p-4 rounded-lg font-mono text-sm overflow-x-auto mb-6">
        <pre class="whitespace-pre-wrap"><code>{{ topic.code_example }}</code></pre>
      </div>

      <!-- 在线运行控制（不展示代码编辑与输出框） -->
      <div class="mb-6 run-controls">
        <div class="flex items-center gap-3 mb-3">
          <label class="text-sm text-muted">语言：</label>
          <select v-model="editorLang" class="input-sm">
            <option value="python">Python</option>
            <option value="cpp">C++</option>
          </select>

          <div class="ml-auto flex gap-2">
            <!-- 在线运行按钮，当前仅弹窗提示 -->
            <button class="btn-primary" @click="onOnlineRunClick">
              在线运行
            </button>
          </div>
        </div>

        <!-- 示例输入 / 输出：以友好文本格式显示（非 JSON） -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <div class="text-sm font-medium mb-2">示例输入</div>
            <textarea v-model="egInDisplay" class="editor-area" rows="6" spellcheck="false" placeholder="示例输入（多行）"></textarea>
          </div>

          <div>
            <div class="text-sm font-medium mb-2">示例输出</div>
            <textarea v-model="egOutDisplay" class="editor-area" rows="6" spellcheck="false" placeholder="示例输出（多行）"></textarea>
          </div>
        </div>
      </div>

    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import axios from 'axios'

const route = useRoute()
const router = useRouter()

const routeLang = route.params.lang || route.query.lang || null
const routeId = () => route.params.id || route.params.lb_id || route.query.id || null

// state
const topic = ref(null)
const loading = ref(true)
const error = ref('')

// simplified run-related state (no editor/output UI)
const editorCode = ref('')     // keep for download fallback
const editorLang = ref('python')

// Display-friendly fields (plain text shown to user)
const egInDisplay = ref('')    // plain text for eg_in
const egOutDisplay = ref('')   // plain text for eg_out

// remember original types so we can convert back when needed
let _egInType = null   // 'array' | 'object' | 'string' | null
let _egOutType = null

// ---------- loadTopic: use new API GET /api/library/:lang/:id ----------
async function loadTopic() {
  loading.value = true
  error.value = ''
  topic.value = null

  const idParam = routeId()
  const langParam = routeLang

  try {
    if (langParam && idParam) {
      try {
        const path = `/api/library/${encodeURIComponent(String(langParam))}/${encodeURIComponent(String(idParam))}`
        const res = await axios.get(path, { timeout: 10000 })
        if (res && res.status === 200 && res.data) {
          topic.value = res.data
        }
      } catch (err) {
        console.warn('GET /api/library/:lang/:id failed, will attempt fallback:', err && err.message ? err.message : err)
      }
    }

    if (!topic.value && idParam) {
      try {
        const numeric = Number(idParam)
        const path = (!Number.isNaN(numeric) && String(idParam).trim() === String(numeric)) ? `/api/library/${numeric}` : `/api/library/${encodeURIComponent(String(idParam))}`
        const res2 = await axios.get(path, { timeout: 10000 })
        if (res2 && res2.status === 200 && res2.data) {
          topic.value = res2.data
        }
      } catch (err) {
        console.warn('Fallback GET /api/library/:id failed:', err && err.message ? err.message : err)
      }
    }

    if (!topic.value) {
      throw new Error('未能获取到条目（请确认路由或后端接口）')
    }

    // init editorCode
    editorCode.value = topic.value.code_example || ''
    const detectedLang = (topic.value.lang || routeLang || '').toLowerCase()
    if (detectedLang.includes('c++') || detectedLang === 'cpp' || detectedLang === 'cxx') editorLang.value = 'cpp'
    else editorLang.value = 'python'

    // initialize egInDisplay / egOutDisplay from topic.eg_in / topic.eg_out
    initEgFields(topic.value.eg_in, egInDisplay, '_egInType')
    initEgFields(topic.value.eg_out, egOutDisplay, '_egOutType')

  } catch (err) {
    console.error('loadTopic error', err)
    error.value = (err && err.message) ? err.message : '加载失败，请稍后再试'
  } finally {
    loading.value = false
  }
}

/**
 * Initialize a display ref from an original eg value.
 * - value: original value (could be JSON object/array/string)
 * - displayRef: ref to write plain-text output
 * - typeVarName: name of the module-level variable to set ('_egInType' or '_egOutType')
 */
function initEgFields(value, displayRef, typeVarName) {
  let t = null
  try {
    if (value === null || value === undefined) {
      displayRef.value = ''
      t = null
    } else if (typeof value === 'string') {
      // try to see if string actually contains JSON
      try {
        const parsed = JSON.parse(value)
        t = detectType(parsed)
        displayRef.value = prettyFromParsed(parsed)
      } catch {
        // plain string
        displayRef.value = value
        t = 'string'
      }
    } else {
      // already an object/array
      t = detectType(value)
      displayRef.value = prettyFromParsed(value)
    }
  } catch (e) {
    // fallback: convert to string
    displayRef.value = String(value)
    t = 'string'
  }

  // assign to module-level var by name
  if (typeVarName === '_egInType') _egInType = t
  if (typeVarName === '_egOutType') _egOutType = t
}

function detectType(val) {
  if (Array.isArray(val)) return 'array'
  if (val !== null && typeof val === 'object') return 'object'
  return 'string'
}

/**
 * Convert parsed JSON (array/object/primitive) into user-friendly plain text.
 * - array -> each element on its own line
 * - object -> each "key: value" on its own line (value stringified if needed)
 * - primitive -> toString
 */
function prettyFromParsed(parsed) {
  if (Array.isArray(parsed)) {
    return parsed.map(item => {
      if (item === null || item === undefined) return ''
      if (typeof item === 'object') return JSON.stringify(item)
      return String(item)
    }).join('\n')
  }
  if (parsed !== null && typeof parsed === 'object') {
    return Object.entries(parsed).map(([k, v]) => {
      if (v !== null && typeof v === 'object') return `${k}: ${JSON.stringify(v)}`
      return `${k}: ${String(v)}`
    }).join('\n')
  }
  return String(parsed)
}

/**
 * Convert user-edited display text back into JSON-like value according to original type.
 * - if original type is 'array' -> split lines into array (trim each non-empty)
 * - if original type is 'object' -> try parse lines "k: v" into object; if parse fails, return the raw string
 * - if original type is 'string' or unknown -> return the raw string
 */
function displayToOriginal(displayText, originalType) {
  const txt = (displayText || '').replace(/\r\n/g, '\n')
  if (!originalType) {
    // if unknown, try to infer: multiple lines -> array, else string
    if (txt.includes('\n')) {
      return txt.split('\n').map(s => s)
    }
    return txt
  }

  if (originalType === 'array') {
    return txt === '' ? [] : txt.split('\n').map(line => line)
  }

  if (originalType === 'object') {
    // try to parse as JSON first
    try {
      return JSON.parse(txt)
    } catch {
      // fallback: parse lines like "key: value"
      const obj = {}
      const lines = txt.split('\n').map(l => l.trim()).filter(l => l !== '')
      for (const line of lines) {
        const idx = line.indexOf(':')
        if (idx === -1) {
          // if there's a line without colon, store under special key or skip
          // we'll append it to a special "_extra" array
          if (!obj._extra) obj._extra = []
          obj._extra.push(line)
        } else {
          const k = line.slice(0, idx).trim()
          const vStr = line.slice(idx + 1).trim()
          // try to parse vStr as JSON primitive
          try {
            obj[k] = JSON.parse(vStr)
          } catch {
            obj[k] = vStr
          }
        }
      }
      return obj
    }
  }

  // default: string
  return txt
}

// UI helpers kept
function formatDate(dateStr) {
  if (!dateStr) return ''
  return new Date(dateStr).toLocaleString()
}

const goBack = () => {
  if (window.history.length > 1) {
    router.back()
  } else {
    if (routeLang) router.push({ path: '/library', query: { lang: routeLang } })
    else router.push({ path: '/library' })
  }
}

function difficultyLabel(v) {
  if (!v) return '入门'
  if (v === 'beginner') return '入门'
  if (v === 'intermediate') return '中级'
  if (v === 'advanced') return '高级'
  return v
}
function difficultyClass(v) {
  if (v === 'advanced') return 'badge-adv'
  if (v === 'intermediate') return 'badge-mid'
  return 'badge-beg'
}
function displayLangLabel(l) {
  if (!l && routeLang) l = routeLang
  if (!l) return ''
  const s = (l + '').toLowerCase()
  if (s.includes('c++') || s === 'cpp') return 'C++'
  if (s.includes('python')) return 'Python'
  return l
}

// 在线运行按钮：当前以 alert 提示（后续可换成项目的 modal）
function onOnlineRunClick() {
  alert('Sorry，该功能尚未实现。开发者研发中，敬请期待！')
  // 如果将来需要构造 payload 发给后端，可以用如下方式将显示文本还原成 JSON/原始类型：
  /*
    const payload = {
      lang: editorLang.value === 'cpp' ? 'cpp' : 'python',
      code: editorCode.value || topic.value?.code_example || '',
      eg_in: displayToOriginal(egInDisplay.value, _egInType),
      eg_out: displayToOriginal(egOutDisplay.value, _egOutType)
    }
  */
}

// downloadContent 保持不变
function downloadContent() {
  const code = editorCode.value || topic.value?.code_example || ''
  if (!code) {
    alert('无可下载的代码')
    return
  }
  const ext = (editorLang.value === 'cpp') ? '.cpp' : '.py'
  const safeTitle = (topic.value?.title || 'code').replace(/\s+/g, '_').replace(/[^\w\-_.]/g, '')
  const idPart = routeId() || 'topic'
  const langPart = routeLang ? String(routeLang) + '_' : ''
  const blob = new Blob([code], { type: 'text/plain;charset=utf-8' })
  const url = URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url
  a.download = `${safeTitle}_${langPart}${idPart}${ext}`
  document.body.appendChild(a)
  a.click()
  a.remove()
  URL.revokeObjectURL(url)
}

// initial load + react to param change
onMounted(() => {
  loadTopic()
})

watch(() => [route.params.id, route.params.lang, route.query.id, route.query.lang], () => {
  loadTopic()
})
</script>

<style scoped>
  @import './LibraryView/LibraryViewStyle.css';
</style>