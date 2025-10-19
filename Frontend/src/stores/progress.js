import { defineStore } from 'pinia'
import { ref, computed } from 'vue'

export const useProgressStore = defineStore('progress', () => {
  const current = ref(0)
  const questions = ref([])  // 可在 Study.vue 初始化时传入

  const progressPercent = computed(() => {
    return Math.max((current.value / questions.value.length) * 100, 5)
  })

  function nextQuestion() {
    if (current.value < questions.value.length - 1) {
      current.value++
    }
  }

  return { current, questions, progressPercent, nextQuestion }
})
