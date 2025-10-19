// src/composables/useEnergy.js
import { ref, computed, onMounted, onBeforeUnmount } from 'vue'
import axios from 'axios'

export default function useEnergy() {
  const energy = ref(0)
  const maxEnergy = ref(30)
  const secondsToNext = ref(null)
  const isVip = ref(false)
  let _lastEnergyUpdateAt = null

  let _energyPollTimer = null
  let _tickTimer = null

  const energyPercent = computed(() => {
    if (isVip.value) return 100
    if (!maxEnergy.value || maxEnergy.value === 0) return 0
    return Math.round((energy.value / maxEnergy.value) * 100)
  })

  async function fetchEnergy() {
    const token = localStorage.getItem('yp_token')
    if (!token) {
      energy.value = 0
      maxEnergy.value = 30
      secondsToNext.value = null
      _lastEnergyUpdateAt = null
      return
    }

    try {
      const res = await axios.get('http://localhost:5000/api/user/energy', {
        headers: { Authorization: `Bearer ${token}` },
        timeout: 6000
      })
      if (res && res.status === 200 && res.data) {
        const d = res.data
        energy.value = Number.isFinite(Number(d.energy)) ? Number(d.energy) : (d.energy ? Number(d.energy) : 0)
        maxEnergy.value = Number.isFinite(Number(d.maxEnergy)) ? Number(d.maxEnergy) : (d.maxEnergy ? Number(d.maxEnergy) : 5)
        if (d.last_energy_update) {
          const last = new Date(d.last_energy_update)
          if (!isNaN(last)) {
            _lastEnergyUpdateAt = last
            computeSecondsToNextFromLastUpdate()
          } else {
            _lastEnergyUpdateAt = null
            secondsToNext.value = null
          }
        } else {
          _lastEnergyUpdateAt = null
          secondsToNext.value = null
        }
      }
    } catch (e) {
      // ignore
    }
  }

  async function fetchMembership() {
    const token = localStorage.getItem('yp_token')
    if (!token) { isVip.value = false; return }
    try {
      const res = await axios.get('http://localhost:5000/api/membership', {
        headers: { Authorization: `Bearer ${token}` },
        timeout: 6000
      })
      if (res && res.data && res.data.end_at) {
        const end = new Date(res.data.end_at)
        isVip.value = end > new Date()
      } else {
        isVip.value = false
      }
    } catch (e) { isVip.value = false }
  }

  function computeSecondsToNextFromLastUpdate() {
    const recoverInterval = 10 * 60
    if (energy.value >= maxEnergy.value) {
      secondsToNext.value = 0
      return
    }
    if (!_lastEnergyUpdateAt) {
      secondsToNext.value = null
      return
    }
    const now = new Date()
    const diffSeconds = Math.floor((now - _lastEnergyUpdateAt) / 1000)
    const sinceLastTick = diffSeconds % recoverInterval
    const remain = recoverInterval - sinceLastTick
    secondsToNext.value = remain > 0 ? remain : 0
  }

  function formatSec(s) {
    if (s === null || s === undefined) return '--:--'
    const sec = Math.max(0, Math.floor(Number(s)))
    const m = Math.floor(sec / 60)
    const ss = sec % 60
    return `${String(m).padStart(2, '0')}:${String(ss).padStart(2,'0')}`
  }

  function onEnergyClick() {
    if (!localStorage.getItem('yp_token')) return false
    return true
  }

  function startEnergyTimers() {
    if (_energyPollTimer) clearInterval(_energyPollTimer)
    _energyPollTimer = setInterval(() => { fetchEnergy().catch(()=>{}) }, 15000)
    if (_tickTimer) clearInterval(_tickTimer)
    _tickTimer = setInterval(() => {
      if (_lastEnergyUpdateAt) {
        computeSecondsToNextFromLastUpdate()
        if (energy.value >= maxEnergy.value || secondsToNext.value === 0) {
          fetchEnergy().catch(()=>{})
        }
      }
    }, 1000)
  }

  function stopEnergyTimers() {
    if (_energyPollTimer) { clearInterval(_energyPollTimer); _energyPollTimer = null }
    if (_tickTimer) { clearInterval(_tickTimer); _tickTimer = null }
  }

  onMounted(() => {})
  onBeforeUnmount(() => { stopEnergyTimers() })

  return {
    energy,
    maxEnergy,
    secondsToNext,
    isVip,
    energyPercent,
    fetchEnergy,
    fetchMembership,
    computeSecondsToNextFromLastUpdate,
    formatSec,
    onEnergyClick,
    startEnergyTimers,
    stopEnergyTimers
  }
}