<template>
  <div class="library-view p-6 max-w-4xl mx-auto">
    <button
      class="mb-4 px-4 py-2 rounded bg-white border hover:shadow-sm flex items-center gap-2"
      @click="goBack()"
      aria-label="返回"
    >
      ← 返回
    </button>

    <div v-if="loading" class="text-gray-500">加载中...</div>
    <div v-else-if="error" class="text-red-500">{{ error }}</div>

    <div v-else-if="topic" class="bg-white shadow rounded-lg p-6">
      <!-- 标题区 -->
      <div class="flex items-start justify-between gap-4 mb-4">
        <div>
          <h1 class="text-2xl font-bold mb-2">{{ topic.title }}</h1>
          <div class="flex items-center gap-3 text-sm text-gray-600">
            <span class="inline-flex items-center px-2 py-1 rounded text-xs font-semibold bg-indigo-50 text-indigo-700">
              {{ displayLangLabel(topic.lang) }}
            </span>
            <span :class="difficultyClass(topic.difficulty)" class="px-2 py-1 rounded text-xs font-semibold">
              {{ difficultyLabel(topic.difficulty) }}
            </span>
            <span class="text-xs text-gray-400">最后更新：{{ formatDate(topic.updated_at) }}</span>
          </div>
        </div>

        <div class="flex items-center gap-2">
          <button class="btn-action" @click="toggleEditor">
            {{ showEditor ? '隐藏编辑器' : '在线运行' }}
          </button>
          <button class="btn-action" @click="downloadContent" title="下载当前代码">下载</button>
        </div>
      </div>

      <!-- 概要与正文 -->
      <p class="mb-4 text-gray-700">{{ topic.summary }}</p>
      <div class="prose max-w-none mb-6" v-html="topic.content"></div>

      <!-- 代码示例展示（只读）-->
      <div v-if="topic.code_example && !showEditor" class="bg-gray-900 text-green-100 p-4 rounded-lg font-mono text-sm overflow-x-auto mb-6">
        <pre class="whitespace-pre-wrap"><code>{{ topic.code_example }}</code></pre>
      </div>

      <!-- 在线编辑器（可切换显示） -->
      <div v-if="showEditor" class="mb-6">
        <div class="flex items-center gap-3 mb-3">
          <label class="text-sm text-gray-600">语言：</label>
          <select v-model="editorLang" class="input-sm">
            <option value="python">Python</option>
            <option value="cpp">C++</option>
          </select>

          <label class="text-sm text-gray-600 ml-4">输入（stdin，可选）：</label>
          <input v-model="stdin" class="input-sm w-48" placeholder="标准输入（回车分行）" />
          <div class="ml-auto flex gap-2">
            <button class="btn-primary" @click="runCode" :disabled="execLoading">
              {{ execLoading ? '运行中…' : '运行' }}
            </button>
            <button class="btn-try" @click="resetEditor" :disabled="execLoading">重置</button>
            <button class="btn-try" @click="clearOutput" :disabled="execLoading">清空输出</button>
          </div>
        </div>

        <textarea v-model="editorCode" class="editor-area" rows="12" spellcheck="false"></textarea>

        <div class="mt-3 text-sm text-gray-500">注：示例运行在后端短时沙箱，耗时或安全性取决于服务器配置。</div>

        <!-- 输出区 -->
        <div class="mt-4">
          <div class="flex items-center justify-between mb-2">
            <div class="text-sm font-medium">运行输出</div>
            <div class="flex items-center gap-2">
              <button class="btn-try" @click="copyOutput" :disabled="!execOutput && !execError">复制</button>
              <button class="btn-try" @click="downloadOutput" :disabled="!execOutput && !execError">下载</button>
            </div>
          </div>

          <div class="output-area border rounded p-3 bg-black text-green-100 font-mono text-sm whitespace-pre-wrap min-h-[80px]">
            <div v-if="execLoading" class="text-yellow-300">正在运行，请稍候…</div>
            <div v-else-if="execError" class="text-red-400">{{ execError }}</div>
            <div v-else-if="execOutput">{{ execOutput }}</div>
            <div v-else class="text-gray-500">尚无输出 — 点击运行以查看结果。</div>
          </div>
        </div>
      </div>

    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import axios from 'axios'

const route = useRoute()
const router = useRouter()

// existing refs (kept names)
const topic = ref(null)
const loading = ref(true)
const error = ref('')

// editor & exec state (new)
const showEditor = ref(false)
const editorCode = ref('')
const editorLang = ref('python') // 'python' | 'cpp'
const stdin = ref('')
const execLoading = ref(false)
const execOutput = ref('')
const execError = ref('')

// load topic (same endpoint you already have)
async function loadTopic() {
  loading.value = true
  error.value = ''
  try {
    const res = await axios.get(`/api/library/${route.params.id}`)
    topic.value = res.data

    // 初始化编辑器代码与语言
    if (topic.value) {
      // pick code example if exists
      editorCode.value = topic.value.code_example || ''
      // normalize language: backend stores 'c++' or 'cpp' or 'python' -> map to our editorLang
      const l = (topic.value.lang || '').toLowerCase()
      if (l.includes('c++') || l === 'cpp' || l === 'cxx') editorLang.value = 'cpp'
      else editorLang.value = 'python'
    }
  } catch (err) {
    console.error('loadTopic error', err)
    error.value = '加载失败，请稍后再试'
  } finally {
    loading.value = false
  }
}

function formatDate(dateStr) {
  if (!dateStr) return ''
  return new Date(dateStr).toLocaleString()
}

const goBack = () => {
  if (window.history.length > 1) {
    router.back()
  } else {
    router.push('/library')
  }
}

// UI helpers
function difficultyLabel(v) {
  if (!v) return '入门'
  if (v === 'beginner') return '入门'
  if (v === 'intermediate') return '中级'
  if (v === 'advanced') return '高级'
  return v
}
function difficultyClass(v) {
  if (v === 'advanced') return 'bg-red-100 text-red-700'
  if (v === 'intermediate') return 'bg-yellow-100 text-yellow-800'
  return 'bg-green-50 text-green-800'
}
function displayLangLabel(l) {
  if (!l) return ''
  const s = (l + '').toLowerCase()
  if (s.includes('c++') || s === 'cpp') return 'C++'
  if (s.includes('python')) return 'Python'
  return l
}

// editor helpers
function toggleEditor() {
  showEditor.value = !showEditor.value
  // lazy-init editor code if empty and topic has example
  if (showEditor.value && (!editorCode.value || !editorCode.value.trim()) && topic.value && topic.value.code_example) {
    editorCode.value = topic.value.code_example
  }
}
function resetEditor() {
  editorCode.value = topic.value?.code_example || ''
  stdin.value = ''
  execOutput.value = ''
  execError.value = ''
}
function clearOutput() {
  execOutput.value = ''
  execError.value = ''
}

// run code via backend exec API (注意：后端需提供 /api/exec 路由）
async function runCode() {
  if (!editorCode.value || !editorCode.value.trim()) {
    execError.value = '代码为空，无法运行'
    execOutput.value = ''
    return
  }

  execLoading.value = true
  execOutput.value = ''
  execError.value = ''

  const payloadLang = (editorLang.value === 'cpp') ? 'cpp' : 'python'
  try {
    // 注意：后端接口在本建议里为 /api/exec，若你的后端不同，请修改此处。
    const res = await axios.post('/api/exec', {
      lang: payloadLang,
      code: editorCode.value,
      stdin: stdin.value || ''
    }, { timeout: 20000 })

    if (res && res.data) {
      // 兼容后端返回 { stdout, stderr, code }
      const stdout = res.data.output ?? res.data.stdout ?? ''
      const stderr = res.data.stderr ?? ''
      const code = typeof res.data.code === 'number' ? res.data.code : (res.data.exitCode ?? 0)

      let out = ''
      if (stdout) out += stdout
      if (stderr) out += (out ? '\n--- stderr ---\n' : '') + stderr
      if (!out && (code === 0)) out = `(exit ${code})`

      execOutput.value = out
      execError.value = code !== 0 ? `程序退出码 ${code}` : ''
    } else {
      execError.value = '无效的执行返回'
    }
  } catch (err) {
    console.error('runCode error', err)
    // 优先显示后端返回的错误信息
    const serverMsg = err?.response?.data?.error || err?.response?.data?.message
    execError.value = serverMsg || err.message || '运行异常'
  } finally {
    execLoading.value = false
  }
}

// copy & download utilities
async function copyOutput() {
  const text = execOutput.value || execError.value || ''
  if (!text) return
  try {
    await navigator.clipboard.writeText(text)
    alert('已复制到剪贴板')
  } catch (e) {
    alert('复制失败：' + (e.message || e))
  }
}
function downloadOutput() {
  const text = execOutput.value || execError.value || ''
  if (!text) return
  const blob = new Blob([text], { type: 'text/plain;charset=utf-8' })
  const url = URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url
  a.download = `output_${route.params.id || 'topic'}.txt`
  document.body.appendChild(a)
  a.click()
  a.remove()
  URL.revokeObjectURL(url)
}
function downloadContent() {
  const code = editorCode.value || topic.value?.code_example || ''
  const ext = (editorLang.value === 'cpp') ? '.cpp' : '.py'
  const blob = new Blob([code], { type: 'text/plain;charset=utf-8' })
  const url = URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url
  a.download = `${(topic.value?.title || 'code').replace(/\s+/g, '_')}${ext}`
  document.body.appendChild(a)
  a.click()
  a.remove()
  URL.revokeObjectURL(url)
}

// initial load
onMounted(() => {
  loadTopic()
})
</script>

<style scoped>
.library-view {
  min-height: 100vh;
  background-color: #f3f6fb;
}

/* small utility buttons to fit your theme */
.btn-action {
  background: linear-gradient(90deg,#2563eb,#7c3aed);
  color: white;
  border: none;
  padding: 8px 12px;
  border-radius: 10px;
  font-weight: 700;
  cursor: pointer;
}
.btn-action:hover { transform: translateY(-1px); box-shadow: 0 8px 20px rgba(124,58,237,0.12); }

/* small buttons used inside editor region */
.btn-primary {
  background: linear-gradient(90deg,#06b6d4,#2563eb);
  color: white;
  border: none;
  padding: 8px 12px;
  border-radius: 8px;
  font-weight: 700;
  cursor: pointer;
}
.btn-primary:disabled { opacity: 0.6; cursor: not-allowed; }
.btn-try {
  background: white;
  border: 1px solid rgba(15,23,42,0.06);
  padding: 8px 10px;
  border-radius: 8px;
  font-weight: 700;
  cursor: pointer;
}

/* small input style */
.input-sm {
  padding: 6px 10px;
  border-radius: 8px;
  border: 1px solid rgba(15,23,42,0.06);
  outline: none;
}

/* editor area */
.editor-area {
  width: 100%;
  box-sizing: border-box;
  font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, "Roboto Mono", "Courier New", monospace;
  background: #0b1220;
  color: #dbeafe;
  padding: 12px;
  border-radius: 8px;
  border: 1px solid rgba(15,23,42,0.06);
  resize: vertical;
  min-height: 180px;
  white-space: pre;
}

/* output area style */
.output-area {
  min-height: 80px;
  max-height: 360px;
  overflow: auto;
  white-space: pre-wrap;
}

/* small responsive tweaks */
@media (max-width: 900px) {
  .editor-area { font-size: 13px; }
  .btn-action, .btn-primary { padding: 6px 10px; }
}
</style>
