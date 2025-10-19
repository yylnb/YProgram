// src/composables/useProgress.js
import { reactive, ref, onMounted, onBeforeUnmount } from 'vue'
import axios from 'axios'

export default function useProgress({ selectedLang }) {
  const progressCache = reactive({})
  const progressMap = reactive({})
  const loadingProgress = ref(false)

  async function refreshProgress(langParam) {
    const lang = (typeof langParam === 'string') ? langParam : selectedLang.value
    const token = localStorage.getItem('yp_token')
    if (!token) {
      // clear
      Object.keys(progressMap).forEach(k => delete progressMap[k])
      progressCache[lang] = {}
      return
    }

    loadingProgress.value = true
    try {
      // try aggregated endpoint first
      try {
        const res = await axios.get('http://localhost:5000/api/progress', {
          headers: { Authorization: `Bearer ${token}` },
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
          progressCache[lang] = pm
          Object.keys(progressMap).forEach(k => delete progressMap[k])
          Object.keys(pm).forEach(k => { progressMap[k] = pm[k] })
          return
        }
      } catch (e) {
        // fallback to per-unit
      }

      // fallback per-unit
      const total = 50, concurrency = 6
      const pm2 = {}
      for (let i = 1; i <= total; i += concurrency) {
        const batch = []
        for (let j = i; j < i + concurrency && j <= total; j++) batch.push(j)
        await Promise.all(batch.map(async u => {
          try {
            const r = await axios.get(`http://localhost:5000/api/progress/${u}`, {
              headers: { Authorization: `Bearer ${token}` },
              params: { lang },
              timeout: 4000
            })
            if (r && r.status === 200) pm2[String(u)] = r.data || null
          } catch (e) { pm2[String(u)] = null }
        }))
      }
      progressCache[lang] = pm2
      Object.keys(progressMap).forEach(k => delete progressMap[k])
      Object.keys(pm2).forEach(k => { progressMap[k] = pm2[k] })
    } finally {
      loadingProgress.value = false
    }
  }

  // listen for auth-changed to refresh progress
  function onAuthChanged() { refreshProgress().catch(()=>{}) }

  onMounted(() => {
    window.addEventListener('auth-changed', onAuthChanged)
  })
  onBeforeUnmount(() => {
    window.removeEventListener('auth-changed', onAuthChanged)
  })

  function initProgressCleanup() {
    window.removeEventListener('auth-changed', onAuthChanged)
  }

  return {
    progressMap,
    progressCache,
    loadingProgress,
    refreshProgress,
    initProgressCleanup
  }
}