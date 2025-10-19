<template>
  <div class="map-root min-h-screen p-6 bg-gradient-to-b from-blue-50 to-white">
    <div class="header mb-6 flex items-center justify-between">
      <div>
        <h1 class="text-2xl font-bold">学习地图 · 闯关模式</h1>
        <p class="text-sm text-gray-600 mt-1">5 阶段 · 每阶段 10 关 · 每关 5 题（云端解锁）</p>

        <!-- 精简后的语言选择：仅保留 Python / C++ / Java -->
        <div class="lang-switcher mt-3 flex gap-2 flex-wrap" role="tablist" aria-label="选择学习语言">
          <button
            @click="selectLanguage('python')"
            class="lang-btn"
            :class="{ active: selectedLang === 'python' }"
            :aria-pressed="selectedLang === 'python'"
            title="切换到 Python"
          >
            Python
          </button>

          <button
            @click="selectLanguage('cpp')"
            class="lang-btn"
            :class="{ active: selectedLang === 'cpp' }"
            :aria-pressed="selectedLang === 'cpp'"
            title="切换到 C++"
          >
            C++
          </button>

          <button
            @click="selectLanguage('java')"
            class="lang-btn"
            :class="{ active: selectedLang === 'java' }"
            :aria-pressed="selectedLang === 'java'"
            title="切换到 Java"
          >
            Java
          </button>
        </div>
      </div>

      <!-- 右侧：操作 + 能量电池（新增） -->
      <div class="actions flex items-center gap-3">
        <div v-if="!token" class="text-sm text-gray-600">请先登录以同步进度并解锁关卡。</div>
        <button v-if="!token" class="btn-try" @click="openLoginModal">去登录</button>
        <button v-else class="btn-try" @click="refreshProgress" :disabled="loadingProgress">
          {{ loadingProgress ? '加载中…' : '刷新进度' }}
        </button>

        <!-- ==== 能量面板：新增部分 ==== -->
        <div
          class="energy-panel"
          :class="{ vip: isVip }"
          role="region"
          aria-label="能量面板"
          :title="energyTooltip"
          @click="onEnergyClick"
        >
          <div class="energy-display" :aria-hidden="false">
            <!-- 电池图标（用纯 CSS） + 数字 -->
            <div class="battery" aria-hidden="true">
              <div class="battery-cap"></div>
              <div class="battery-body" :style="{ '--fill': energyPercent + '%' }">
                <div class="battery-fill" :style="{ width: energyPercent + '%' }"></div>
              </div>
            </div>

            <!-- 文本部分：VIP 与 非VIP 不同展示 -->
            <div class="energy-text">
              <!-- VIP 显示：∞ / 无限能量 -->
              <template v-if="isVip">
                <div class="energy-numbers" aria-live="polite">
                  <span class="energy-infinite">∞</span>
                </div>
                <div class="energy-meta text-xs text-gray-500">
                  <span>无限能量（会员）</span>
                </div>
              </template>

              <!-- 非 VIP 显示：能量数值与倒计时 -->
              <template v-else>
                <div class="energy-numbers" aria-live="polite">
                  <span class="energy-value">{{ energy }}</span>
                  <span class="energy-slash">/</span>
                  <span class="energy-max">{{ maxEnergy }}</span>
                </div>
                <div class="energy-meta text-xs text-gray-500">
                  <span v-if="energy >= maxEnergy">已满</span>
                  <span v-else-if="secondsToNext !== null">下一点：{{ formatSec(secondsToNext) }}</span>
                  <span v-else>恢复中…</span>
                </div>
              </template>
            </div>
          </div>
        </div>
        <!-- ==== /能量面板 ==== -->
      </div>
    </div>

    <!-- 阶段选择：使用 currentStages（按语言特定） -->
    <div class="stages-list mb-6 flex gap-4 flex-wrap">
      <button
        v-for="(s, idx) in currentStages"
        :key="idx"
        @click="selectStage(idx)"
        :class="['stage-btn', { active: selectedStage === idx }]"
        :aria-pressed="selectedStage === idx"
      >
        <div class="stage-title">阶段 {{ getStageLabel(idx) }}</div>
        <div class="stage-sub text-sm">{{ s.subtitle }}</div>
      </button>
    </div>

    <!-- 地图区域 -->
    <div class="stage-map bg-white rounded-2xl p-6 shadow-md overflow-hidden">
      <h2 class="text-lg font-semibold mb-4">阶段 {{ getStageLabel(selectedStage) }} · 闯关线路</h2>

      <div class="map-canvas relative" :style="{ height: canvasHeight + 'px' }">
        <svg
          v-if="svgPath"
          class="absolute inset-0 w-full h-full pointer-events-none"
          :viewBox="`0 0 ${svgVW} ${svgVH}`"
          preserveAspectRatio="none"
        >
          <path :d="svgPath" fill="none" stroke="rgba(37,99,235,0.16)" stroke-width="6" stroke-linecap="round" stroke-linejoin="round" />
        </svg>

        <div class="nodes-container relative">
          <div
            v-for="(node, idx) in nodesPositions"
            :key="node.unitKey"
            class="node-wrapper"
            :style="{
              position: 'absolute',
              left: node.x + '%',
              top: node.y + 'px',
              transform: 'translate(-50%, -50%)'
            }"
          >
            <button
              :class="['unit-node', nodeStateClass(node.localNumber)]"
              @click="onNodeClick(node)"
              :disabled="!isUnitUnlocked(node.localNumber)"
              :aria-label="`单元 ${node.localIndex}（${selectedLang}）`"
            >
              <div class="node-inner">
                <div class="node-number">单元 {{ node.localIndex }}</div>
                <div class="node-sub text-xs">{{ simpleTitle(node.localNumber) }}</div>
              </div>

              <div class="node-badge" v-if="isUnitCompleted(node.localNumber)">✓</div>
              <div class="node-lock" v-else-if="!isUnitUnlocked(node.localNumber) && token">🔒</div>
            </button>
          </div>
        </div>
      </div>

      <p class="mt-4 text-sm text-gray-600">
        说明：节点按上下曲折排列，已完成显示 ✓，未解锁显示锁。解锁策略全由服务器端 progress 控制（按语言区分）。
      </p>
    </div>

    <!-- 本地回退 modal（很少会用到，因为我们全局已有 LoginModal） -->
    <LoginModal v-if="showLocalLoginModal" @close="closeLocalLoginModal" @success="onLoginSuccess" />
  </div>
</template>

<script>
import axios from 'axios'
import { useUIStore } from '../stores/ui'
import LoginModal from '@/components/LoginModal.vue'

// import useLanguage from '../javascript_map/language'
// import useProgress from '../javascript_map/progress'
// import useEnergy from '../javascript_map/energy'
// import useNodes from '../javascript_map/nodes'
// import { useUIStore } from '../stores/ui'

export default {
  name: 'Map',
  components: { LoginModal },

  data() {
    return {
      // 可支持的语言列表（保持已有配置）
      languages: [
        { value: 'python', label: 'Python' },
        { value: 'cpp', label: 'C++' },
        { value: 'c', label: 'C' },
        { value: 'java', label: 'Java' },
        { value: 'html', label: 'HTML' },
        { value: 'css', label: 'CSS' },
        { value: 'js', label: 'JavaScript' }
      ],
      selectedLang: 'python',
      progressCache: {},

      // NOTE: 不再使用通用 stages 数组 —— 每个语言有自己的阶段说明（subtitle）
      selectedStage: 0,
      progressMap: {},
      loadingProgress: false,
      showLocalLoginModal: false,
      canvasHeight: 950,
      verticalSpacing: 100,
      svgVW: 1000,
      svgVH: 600,
      ui: null,

      // listener refs for cleanup
      _onStorage: null,
      _onLanguageChanged: null,

      // ==== 能量相关 state ====
      energy: 0,
      maxEnergy: 30,
      secondsToNext: null,
      _energyPollTimer: null,
      _tickTimer: null,
      _lastEnergyUpdateAt: null,

      // ==== 会员状态 ====
      isVip: false,

      // 语言对应的阶段标签（字母/标识）
      langStageLabels: {
        python: ['A','B','C','D','E'],
        cpp: ['F','G','H','I','J'],
        java: ['K','L','M','N','O']
      },

      // 每个语言对应的 5 个阶段说明（subtitle）—— 请根据需要修改文本
      langStages: {
        python: [
          { subtitle: '入门基础：变量、类型与输出（Python 风格）' },
          { subtitle: '流程控制与列表/字典' },
          { subtitle: '函数、模块与文件操作（实践）' },
          { subtitle: '面向对象与异步入门（async/await）' },
          { subtitle: '实战项目：小爬虫与数据处理' }
        ],
        cpp: [
          { subtitle: '基础语法与编译流程（C++ 特性）' },
          { subtitle: '指针、引用与内存管理' },
          { subtitle: 'STL 容器与算法' },
          { subtitle: '类与模板编程' },
          { subtitle: '实战项目：算法题与性能优化' }
        ],
        java: [
          { subtitle: 'Java 基础：类、方法与编译运行' },
          { subtitle: '集合框架与异常处理' },
          { subtitle: '多线程与并发基础' },
          { subtitle: '面向对象进阶与设计模式' },
          { subtitle: '实战项目：Web 服务与小项目' }
        ]
        // 若需为其它语言增加阶段说明，可在此处补充，例如 html/css/js 等
      },

      // 默认回退的通用阶段说明（当某语言未定义时使用）
      defaultStages: [
        { subtitle: "入门基础：语法与输出" },
        { subtitle: "流程控制与数据结构" },
        { subtitle: "函数、模块与文件" },
        { subtitle: "面向对象与异步" },
        { subtitle: "实战项目练习" }
      ]
    }
  },

  computed: {
    token() { return localStorage.getItem('yp_token') || null },
    energyPercent() {
      if (this.isVip) return 100
      if (!this.maxEnergy || this.maxEnergy === 0) return 0
      return Math.round((this.energy / this.maxEnergy) * 100)
    },
    energyTooltip() {
      if (!this.token) return '请登录以同步能量'
      if (this.isVip) return `会员：无限能量`
      if (this.energy >= this.maxEnergy) return `能量 ${this.energy}/${this.maxEnergy}（已满）`
      if (this.secondsToNext !== null) return `当前能量 ${this.energy}/${this.maxEnergy}，下一点在 ${this.formatSec(this.secondsToNext)}`
      return `当前能量 ${this.energy}/${this.maxEnergy}，恢复中…`
    },

    // 返回当前语言对应的 5 个阶段对象（包含 subtitle）；若没有对应定义则回退到 defaultStages
    currentStages() {
      return this.langStages[this.selectedLang] || this.defaultStages
    },

    // 计算出节点布局：注意 node.localNumber 是“语言内部的全局单元编号”（1..50），
    // node.localIndex 是当前阶段内的序号（1..10），node.unitKey 是唯一的 v-for key（例如 "python-1"）
    nodesPositions() {
      const baseUnitStart = this.selectedStage * 10 + 1
      const arr = []
      const count = 10
      const gap = this.verticalSpacing
      const topOffset = 40
      for (let i = 0; i < count; i++) {
        const localNumber = baseUnitStart + i               // 语言内部编号：1..50
        const unitKey = `${this.selectedLang}-${localNumber}` // 唯一 key（语言感知）
        const y = topOffset + i * gap
        const x = (i % 3 === 0) ? 28 : ((i % 3 === 1) ? 72 : 50)
        arr.push({
          unitKey,
          localNumber,   // 用于进度查找
          localIndex: i + 1, // 当前阶段内的序号 (1..10)
          x, y
        })
      }
      this.canvasHeight = topOffset + (count - 1) * gap + 120
      this.svgVH = Math.max(this.canvasHeight, 600)
      return arr
    },
    svgPath() {
      const nodes = this.nodesPositions
      if (!nodes || nodes.length === 0) return ''
      const vw = this.svgVW
      const vh = this.svgVH
      const points = nodes.map(n => ({ x: (n.x / 100) * vw, y: (n.y / this.canvasHeight) * vh }))
      let d = `M ${points[0].x} ${points[0].y}`
      for (let i = 1; i < points.length; i++) {
        const prev = points[i - 1]
        const curr = points[i]
        const cx = (prev.x + curr.x) / 2
        const cy = (prev.y + curr.y) / 2
        d += ` Q ${prev.x} ${prev.y} ${cx} ${cy}`
        d += ` T ${curr.x} ${curr.y}`
      }
      return d
    }
  },

  methods: {
    // 获取当前语言对应的阶段标签（优先使用 langStageLabels，否则回退为数字 1..5）
    getStageLabel(idx) {
      const labels = this.langStageLabels[this.selectedLang]
      if (labels && labels[idx] !== undefined) return labels[idx]
      return String(idx + 1)
    },

    // click handler to change language (originator)
    async selectLanguage(lang) {
      if (typeof lang !== 'string') return
      const allow = this.languages.map(l => l.value)
      if (!allow.includes(lang)) return
      if (lang === this.selectedLang) {
        return
      }

      // set immediate local state
      this.selectedLang = lang
      localStorage.setItem('yp_lang', lang)

      // update cache-backed progressMap quickly (progressCache keyed by language)
      this.progressMap = this.progressCache[lang] ? { ...this.progressCache[lang] } : {}

      // refresh cloud progress for the selected language
      if (this.token) {
        try { await this.refreshProgress(lang) } catch (e) { /* ignore */ }
      }

      // dispatch a custom event to notify other components in same window
      try {
        window.dispatchEvent(new CustomEvent('language-changed', { detail: { lang, source: 'map' } }))
      } catch (e) { /* ignore */ }
    },

    selectStage(idx) {
      if (typeof idx !== 'number') return
      this.selectedStage = idx
      if (this.token) this.refreshProgress().catch(()=>{})
    },

    // simpleTitle: 接受语言内部编号 (1..50) 并返回本阶段内序号字符串
    simpleTitle(localNumber) {
      const idx = ((localNumber - 1) % 10) + 1
      return `第 ${idx} 关`
    },

    // node 状态样式（传入 localNumber）
    nodeStateClass(localNumber) {
      if (this.isUnitCompleted(localNumber)) return 'state-completed'
      if (this.isUnitUnlocked(localNumber)) return 'state-unlocked'
      return 'state-locked'
    },

    // completed 判断（传入 localNumber）
    isUnitCompleted(localNumber) {
      const p = this.progressMap[String(localNumber)]
      return !!(p && (p.completed === 1 || p.completed === true || p.completed === '1'))
    },

    // unlocked 判断（传入 localNumber）
    isUnitUnlocked(localNumber) {
      const id = Number(localNumber)
      // 每种语言的第一个单元默认开启（localNumber === 1）
      if (id === 1) return true
      if (!this.token) return false
      const prev = this.progressMap[String(id - 1)]
      return !!(prev && (prev.completed === 1 || prev.completed === true || prev.completed === '1'))
    },

    // 点击节点：node 为 nodesPositions 的项（带 localNumber），跳转时带上 lang 参数
    async onNodeClick(node) {
      if (!this.isUnitUnlocked(node.localNumber)) {
        if (!this.token) { this.openLoginModal(); return }
        this.showInlineMessage('该单元尚未解锁，请先完成前一关。')
        return
      }
      // 跳转到 Study 页面：把单元编号（语言内部编号）和语言一起传
      this.$router.push({ name: "Study", params: { unitId: String(node.localNumber), lang: this.selectedLang } })
    },

    showInlineMessage(text) {
      const id = 'map-inline-msg'
      let el = document.getElementById(id)
      if (!el) {
        el = document.createElement('div')
        el.id = id
        el.style.position = 'fixed'
        el.style.left = '50%'
        el.style.bottom = '28px'
        el.style.transform = 'translateX(-50%)'
        el.style.background = 'rgba(15,23,42,0.9)'
        el.style.color = 'white'
        el.style.padding = '10px 14px'
        el.style.borderRadius = '10px'
        el.style.zIndex = 9999
        el.style.transition = 'opacity .3s'
        document.body.appendChild(el)
      }
      el.textContent = text
      el.style.opacity = '1'
      setTimeout(() => { if (el) el.style.opacity = '0' }, 2200)
    },
    openLoginModal() {
      try { window.dispatchEvent(new Event('open-login-modal')) } catch (e) {}
      try {
        if (this.ui && typeof this.ui.openLogin === 'function') { this.ui.openLogin(); return }
      } catch (e) {}
      this.showLocalLoginModal = true
    },
    closeLocalLoginModal() { this.showLocalLoginModal = false },
    async onLoginSuccess() { try { await this.refreshProgress(); await this.fetchEnergy(); await this.fetchMembership(); } catch (e) {} },

    // refreshProgress: always passes lang param so backend can route to proper per-lang table
    async refreshProgress(langParam) {
      const lang = (typeof langParam === 'string') ? langParam : this.selectedLang
      if (!this.token) {
        this.progressMap = {}
        this.progressCache[lang] = {}
        return
      }

      this.loadingProgress = true
      try {
        // try aggregated endpoint first (expects ?lang=...)
        try {
          const res = await axios.get('http://localhost:5000/api/progress', {
            headers: { Authorization: `Bearer ${this.token}` },
            params: { lang },
            timeout: 8000
          })
          if (res && res.status === 200 && res.data) {
            const pm = {}
            const data = res.data
            if (Array.isArray(data)) data.forEach(r => { if (r && r.unit_id !== undefined) pm[String(r.unit_id)] = r })
            else if (typeof data === 'object') {
              if (data.unit_id !== undefined) pm[String(data.unit_id)] = data
              else Object.keys(data).forEach(k => pm[k] = data[k])
            }
            this.progressCache[lang] = pm
            this.progressMap = { ...pm }
            return
          }
        } catch (e) {
          // fallback to per-unit
        }

        // fallback: per-unit fetch (backwards compatible)
        const total = 50, concurrency = 6
        const pm2 = {}
        for (let i = 1; i <= total; i += concurrency) {
          const batch = []
          for (let j = i; j < i + concurrency && j <= total; j++) batch.push(j)
          await Promise.all(batch.map(async u => {
            try {
              const r = await axios.get(`http://localhost:5000/api/progress/${u}`, {
                headers: { Authorization: `Bearer ${this.token}` },
                params: { lang },
                timeout: 4000
              })
              if (r && r.status === 200) pm2[String(u)] = r.data || null
            } catch (e) { pm2[String(u)] = null }
          }))
        }
        this.progressCache[lang] = pm2
        this.progressMap = { ...pm2 }
      } finally {
        this.loadingProgress = false
      }
    },

    /* ================= 能量相关方法 ================= */

    // 从服务器获取能量（期望返回至少 { energy, maxEnergy }）
    async fetchEnergy() {
      if (!this.token) {
        this.energy = 0
        this.maxEnergy = 30
        this.secondsToNext = null
        return
      }

      try {
        const res = await axios.get('http://localhost:5000/api/user/energy', {
          headers: { Authorization: `Bearer ${this.token}` },
          timeout: 6000
        })
        if (res && res.status === 200 && res.data) {
          const d = res.data
          this.energy = Number.isFinite(Number(d.energy)) ? Number(d.energy) : (d.energy ? Number(d.energy) : 0)
          this.maxEnergy = Number.isFinite(Number(d.maxEnergy)) ? Number(d.maxEnergy) : (d.maxEnergy ? Number(d.maxEnergy) : 5)

          if (d.last_energy_update) {
            const last = new Date(d.last_energy_update)
            if (!isNaN(last)) {
              this._lastEnergyUpdateAt = last
              this.computeSecondsToNextFromLastUpdate()
            } else {
              this._lastEnergyUpdateAt = null
              this.secondsToNext = null
            }
          } else {
            this._lastEnergyUpdateAt = null
            this.secondsToNext = null
          }
        }
      } catch (e) {
        // ignore
      }
    },

    // 新增：从 /api/membership 查询会员状态
    async fetchMembership() {
      if (!this.token) {
        this.isVip = false
        return
      }
      try {
        const res = await axios.get('http://localhost:5000/api/membership', {
          headers: { Authorization: `Bearer ${this.token}` },
          timeout: 6000
        })
        if (res && res.data && res.data.end_at) {
          const end = new Date(res.data.end_at)
          this.isVip = end > new Date()
        } else {
          this.isVip = false
        }
      } catch (e) {
        this.isVip = false
      }
    },

    computeSecondsToNextFromLastUpdate() {
      const recoverInterval = 10 * 60 // 秒
      if (this.energy >= this.maxEnergy) {
        this.secondsToNext = 0
        return
      }
      if (!this._lastEnergyUpdateAt) {
        this.secondsToNext = null
        return
      }
      const now = new Date()
      const diffSeconds = Math.floor((now - this._lastEnergyUpdateAt) / 1000)
      const recovered = Math.floor(diffSeconds / recoverInterval)
      const sinceLastTick = diffSeconds % recoverInterval
      const remain = recoverInterval - sinceLastTick
      this.secondsToNext = remain > 0 ? remain : 0
    },

    onEnergyClick() {
      if (!this.token) {
        this.openLoginModal()
        return
      }
      try { this.$router.push({ name: 'Library' }) } catch (e) { /* ignore */ }
    },

    formatSec(s) {
      if (s === null || s === undefined) return '--:--'
      const sec = Math.max(0, Math.floor(Number(s)))
      const m = Math.floor(sec / 60)
      const ss = sec % 60
      return `${String(m).padStart(2, '0')}:${String(ss).padStart(2,'0')}`
    },
  },

  created() {
    // init language
    try {
      const saved = localStorage.getItem('yp_lang')
      const allow = ['python', 'cpp', 'c', 'java', 'html', 'css', 'js']
      if (saved && allow.includes(saved)) this.selectedLang = saved
      else this.selectedLang = 'python'
    } catch (e) { this.selectedLang = 'python' }

    // get ui store instance
    try { this.ui = useUIStore() } catch (e) { this.ui = null }

    // bind and store listeners so they can be removed later
    this._onStorage = (ev) => {
      if (ev && ev.key === 'yp_lang') {
        const newLang = ev.newValue || 'python'
        this.selectedLang = newLang
        this.progressMap = this.progressCache[newLang] ? { ...this.progressCache[newLang] } : {}
        if (this.token) this.refreshProgress(newLang).catch(()=>{})
      }
    };

    this._onLanguageChanged = (ev) => {
      const newLang = ev && ev.detail && ev.detail.lang ? ev.detail.lang : null;
      if (!newLang) return;
      if (ev.detail && ev.detail.source === 'map') {
        return;
      }
      if (newLang === this.selectedLang) return;
      this.selectedLang = newLang;
      this.progressMap = this.progressCache[newLang] ? { ...this.progressCache[newLang] } : {}
      if (this.token) this.refreshProgress(newLang).catch(()=>{})
    };

    window.addEventListener('auth-changed', this.refreshProgress);
    window.addEventListener('storage', this._onStorage);
    window.addEventListener('language-changed', this._onLanguageChanged);

    // initial load
    if (this.token) {
      this.refreshProgress().catch(()=>{})
      this.fetchEnergy().catch(()=>{})
      this.fetchMembership().catch(()=>{})
      this._energyPollTimer = setInterval(() => { this.fetchEnergy().catch(()=>{}) }, 15000)
    } else {
      this.progressMap = {}
      this.progressCache[this.selectedLang] = {}
    }
  },

  mounted() {
    this._tickTimer = setInterval(() => {
      if (this._lastEnergyUpdateAt) {
        this.computeSecondsToNextFromLastUpdate()
        if (this.energy >= this.maxEnergy || this.secondsToNext === 0) {
          this.fetchEnergy().catch(()=>{})
        }
      }
    }, 1000)
  },

  beforeUnmount() {
    window.removeEventListener('auth-changed', this.refreshProgress);
    if (this._onStorage) window.removeEventListener('storage', this._onStorage);
    if (this._onLanguageChanged) window.removeEventListener('language-changed', this._onLanguageChanged);

    if (this._energyPollTimer) { clearInterval(this._energyPollTimer); this._energyPollTimer = null }
    if (this._tickTimer) { clearInterval(this._tickTimer); this._tickTimer = null }
  }
}
</script>

<style scoped>
.map-root { font-family: Inter, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial; }

/* header 按钮样式，保持与站点一致 */
.btn-try {
  background: #fff;
  border: 1px solid rgba(15,23,42,0.06);
  padding: 8px 12px;
  border-radius: 10px;
  font-weight: 800;
  cursor: pointer;
}

/* 语言选择：新增 */
.lang-switcher { user-select: none; }
.lang-btn {
  background: #ffffff;
  border: 1px solid rgba(15,23,42,0.06);
  padding: 6px 12px;
  border-radius: 9999px;
  font-weight: 700;
  font-size: 12px;
  box-shadow: 0 6px 16px rgba(2,6,23,0.04);
  cursor: pointer;
  transition: transform .12s ease, box-shadow .12s ease, background .12s ease, border .12s ease;
}
.lang-btn:hover { transform: translateY(-2px); box-shadow: 0 12px 24px rgba(2,6,23,0.06); }
.lang-btn.active {
  background: linear-gradient(90deg, rgba(37,99,235,0.10), rgba(124,58,237,0.08));
  border-color: rgba(37,99,235,0.7);
}

/* 阶段按钮 */
.stage-btn {
  background: white;
  border-radius: 12px;
  padding: 10px 14px;
  box-shadow: 0 8px 20px rgba(2,6,23,0.06);
  cursor: pointer;
  font-weight: 800;
  display:flex;
  flex-direction:column;
  gap:4px;
  min-width: 160px;
  transition: transform .18s ease, box-shadow .18s ease;
}
.stage-btn.active { transform: translateY(-6px); box-shadow: 0 20px 40px rgba(2,6,23,0.08); }

/* 地图卡片 */
.map-canvas { height: auto; min-height: 520px; position: relative; }

/* 节点容器（relative） */
.nodes-container { position: relative; width: 100%; height: 100%; min-height: 600px; padding: 20px 12px; box-sizing: border-box; }

/* 节点样式 */
.node-wrapper { width: 160px; height: auto; pointer-events: auto; }
.unit-node {
  position: relative;
  z-index: 3;
  display:flex;
  flex-direction:column;
  align-items:center;
  justify-content:center;
  padding: 12px;
  width: 160px;
  border-radius: 14px;
  background: linear-gradient(180deg,#fbfdff,#ffffff);
  border: 1px solid rgba(15,23,42,0.06);
  box-shadow: 0 10px 26px rgba(2,6,23,0.04);
  cursor: pointer;
  transition: transform .12s ease, box-shadow .12s ease;
  text-align:center;
}
.unit-node:disabled { cursor:not-allowed; opacity:0.8; transform:none; box-shadow:none; }

.node-inner { display:flex; flex-direction:column; gap:6px; align-items:center; }
.node-number { font-weight:800; color:#07102a; }
.node-sub { color:#475569; }

/* badge / lock */
.node-badge { position: absolute; right: 8px; top: 8px; background: rgba(34,197,94,0.12); color: #166534; padding: 6px 8px; border-radius: 8px; font-weight:800; border: 1px solid rgba(16,185,129,0.12); z-index:5; }
.node-lock { position: absolute; right: 8px; top: 8px; font-size: 18px; z-index:5; }

/* 状态 */
.state-completed { border-color: #16a34a; background: linear-gradient(90deg, rgba(16,185,129,0.06), rgba(16,185,129,0.02)); transform: translateY(-6px); box-shadow: 0 22px 48px rgba(16,185,129,0.06); }
.state-unlocked { border-color: rgba(37,99,235,0.9); background: linear-gradient(180deg, rgba(37,99,235,0.04), rgba(124,58,237,0.02)); }
.state-locked { border-color: rgba(15,23,42,0.06); opacity: 0.82; }

.modal-backdrop { background: rgba(11,16,38,0.4); }
.modal { box-shadow: 0 28px 60px rgba(2,6,23,0.18); }
.input { border: 1px solid rgba(15,23,42,0.06); padding: 10px; border-radius: 8px; }
.btn-primary { background: linear-gradient(90deg,#2563eb,#7c3aed); color:white; border:none; padding:8px 12px; border-radius:10px; font-weight:700; }

/* ========== 能量面板样式 ========== */
.energy-panel {
  display:flex;
  align-items:center;
  gap:10px;
  padding:6px 8px;
  border-radius:10px;
  cursor:pointer;
  user-select:none;
  transition: transform .12s ease, box-shadow .12s ease;
}
.energy-panel:hover { transform: translateY(-2px); box-shadow: 0 10px 20px rgba(2,6,23,0.06); }

.energy-display { display:flex; align-items:center; gap:8px; }

.battery { 
  position: relative; 
  width: 46px; 
  height: 22px; 
  display:flex; 
  align-items:center;

  /* 新增：裁切外溢，防止电池帽撑出页面宽度 */
  overflow: hidden;
  box-sizing: border-box; /* 建议保留为 border-box */
}
.battery-cap { 
  position: absolute; 
  right: 0; 
  width: 4px; 
  height: 10px; 
  background: rgba(0,0,0,0.12); 
  border-radius:2px; top: 6px; 
   /* 使用 transform 做视觉位移（不会影响布局的外宽度） */
  transform: translateX(40%); /* 根据视觉微调：30%/40%/50% 等 */
}
.battery-body {
  width: 36px;
  height: 22px;
  border-radius: 4px;
  border: 2px solid rgba(15,23,42,0.08);
  box-sizing: border-box;
  overflow: hidden;
  position: relative;
  background: linear-gradient(180deg,#fff,#f3f4f6);
}
.battery-fill {
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 0%;
  transition: width 0.6s ease;
  background: linear-gradient(90deg,#34d399,#10b981);
}

.energy-panel.vip .battery-fill {
  background: linear-gradient(90deg, #facc15, #eab308);
}

.energy-text { display:flex; flex-direction:column; line-height:1; }
.energy-numbers { font-weight:800; font-size:13px; color:#0b1220; }
.energy-numbers .energy-infinite { font-size:18px; color:#d97706; font-weight:900; }
.energy-slash { margin: 0 6px; color:#6b7280; }
.energy-meta { margin-top:2px; color:#6b7280; font-weight:700; font-size:11px; }

@media (max-width: 900px) {
  .nodes-container { min-height: 760px; }
  .unit-node { width: 140px; }
  svg { display: none; }
  .battery { width: 36px; height: 18px; }
  .energy-numbers { font-size:12px; }
}
</style>