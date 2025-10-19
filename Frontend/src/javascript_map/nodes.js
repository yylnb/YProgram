// src/composables/useNodes.js
import { computed } from 'vue'
import { useRouter } from 'vue-router'

export default function useNodes({ selectedStage, selectedLang, progressMap, openLoginModal, router }) {
  const internalRouter = router || useRouter()

  const verticalSpacing = 100
  const svgVW = 1000
  let svgVH = 600

  const nodesPositions = computed(() => {
    const baseUnitStart = selectedStage.value * 10 + 1
    const arr = []
    const count = 10
    const gap = verticalSpacing
    const topOffset = 40
    for (let i = 0; i < count; i++) {
      const localNumber = baseUnitStart + i
      const unitKey = `${selectedLang.value}-${localNumber}`
      const y = topOffset + i * gap
      const x = (i % 3 === 0) ? 28 : ((i % 3 === 1) ? 72 : 50)
      arr.push({
        unitKey,
        localNumber,
        localIndex: i + 1,
        x, y
      })
    }
    svgVH = Math.max(topOffset + (count - 1) * gap + 120, 600)
    return arr
  })

  const canvasHeight = computed(() => {
    const nodes = nodesPositions.value
    if (!nodes || nodes.length === 0) return 950
    const lastY = nodes[nodes.length - 1].y
    return Math.max(lastY + 120, 950)
  })

  const svgPath = computed(() => {
    const nodes = nodesPositions.value
    if (!nodes || nodes.length === 0) return ''
    const vw = svgVW
    const vh = Math.max(600, canvasHeight.value)
    const points = nodes.map(n => ({ x: (n.x / 100) * vw, y: (n.y / canvasHeight.value) * vh }))
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
  })

  function isUnitCompleted(localNumber) {
    const p = progressMap[String(localNumber)]
    return !!(p && (p.completed === 1 || p.completed === true || p.completed === '1'))
  }

  function isUnitUnlocked(localNumber) {
    const id = Number(localNumber)
    if (id === 1) return true
    if (!localStorage.getItem('yp_token')) return false
    const prev = progressMap[String(id - 1)]
    return !!(prev && (prev.completed === 1 || prev.completed === true || prev.completed === '1'))
  }

  function nodeStateClass(localNumber) {
    if (isUnitCompleted(localNumber)) return 'state-completed'
    if (isUnitUnlocked(localNumber)) return 'state-unlocked'
    return 'state-locked'
  }

  async function onNodeClick(node) {
    if (!isUnitUnlocked(node.localNumber)) {
      if (!localStorage.getItem('yp_token')) { openLoginModal(); return }
      // caller (Map.vue) may show inline message
      return
    }
    try {
      internalRouter.push({ name: "Study", params: { unitId: String(node.localNumber), lang: selectedLang.value } })
    } catch (e) {}
  }

  return {
    nodesPositions,
    svgPath,
    svgVW,
    svgVH,
    canvasHeight,
    nodeStateClass,
    onNodeClick,
    isUnitCompleted,
    isUnitUnlocked
  }
}