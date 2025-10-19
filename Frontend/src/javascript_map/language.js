// src/composables/useLanguage.js
import { ref, computed, onMounted, onBeforeUnmount } from 'vue'

export default function useLanguage() {
  const languages = [
    { value: 'python', label: 'Python' },
    { value: 'cpp', label: 'C++' },
    { value: 'c', label: 'C' },
    { value: 'java', label: 'Java' },
    { value: 'html', label: 'HTML' },
    { value: 'css', label: 'CSS' },
    { value: 'js', label: 'JavaScript' }
  ]
  const selectedLang = ref('python')

  const langStageLabels = {
    python: ['A','B','C','D','E'],
    cpp: ['F','G','H','I','J'],
    java: ['K','L','M','N','O']
  }

  const langStages = {
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
  }

  const defaultStages = [
    { subtitle: "入门基础：语法与输出" },
    { subtitle: "流程控制与数据结构" },
    { subtitle: "函数、模块与文件" },
    { subtitle: "面向对象与异步" },
    { subtitle: "实战项目练习" }
  ]

  const currentStages = computed(() => langStages[selectedLang.value] || defaultStages)

  function getStageLabel(idx) {
    const labels = langStageLabels[selectedLang.value]
    if (labels && labels[idx] !== undefined) return labels[idx]
    return String(idx + 1)
  }

  function simpleTitle(localNumber) {
    const idx = ((localNumber - 1) % 10) + 1
    return `第 ${idx} 关`
  }

  function selectLanguage(lang) {
    if (typeof lang !== 'string') return
    const allow = languages.map(l => l.value)
    if (!allow.includes(lang)) return
    if (lang === selectedLang.value) return

    selectedLang.value = lang
    try { localStorage.setItem('yp_lang', lang) } catch (e) {}
    try {
      window.dispatchEvent(new CustomEvent('language-changed', { detail: { lang, source: 'map' } }))
    } catch (e) {}
  }

  let _onStorage = null
  let _onLanguageChanged = null

  function initListeners() {
    _onStorage = (ev) => {
      if (ev && ev.key === 'yp_lang') {
        const newLang = ev.newValue || 'python'
        if (newLang && newLang !== selectedLang.value) {
          selectedLang.value = newLang
        }
      }
    }
    _onLanguageChanged = (ev) => {
      const newLang = ev && ev.detail && ev.detail.lang ? ev.detail.lang : null
      if (!newLang) return
      if (ev.detail && ev.detail.source === 'map') return
      if (newLang === selectedLang.value) return
      selectedLang.value = newLang
    }
    window.addEventListener('storage', _onStorage)
    window.addEventListener('language-changed', _onLanguageChanged)
  }

  function cleanupListeners() {
    if (_onStorage) window.removeEventListener('storage', _onStorage)
    if (_onLanguageChanged) window.removeEventListener('language-changed', _onLanguageChanged)
  }

  onMounted(() => {
    try {
      const saved = localStorage.getItem('yp_lang')
      const allow = languages.map(l => l.value)
      if (saved && allow.includes(saved)) selectedLang.value = saved
      else selectedLang.value = 'python'
    } catch (e) { selectedLang.value = 'python' }
    initListeners()
  })

  onBeforeUnmount(cleanupListeners)

  return {
    languages,
    selectedLang,
    selectLanguage,
    currentStages,
    getStageLabel,
    simpleTitle,
    initLanguageCleanup: cleanupListeners
  }
}