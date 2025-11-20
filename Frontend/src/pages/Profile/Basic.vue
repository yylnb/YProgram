<template>
  <div class="card p-6">
    <h3 class="text-lg font-semibold mb-2">基本信息</h3>
    <p><strong>用户名：</strong> {{ prof.username || '—' }}</p>
    <p><strong>用户 ID：</strong> {{ prof.id ?? '—' }}</p>
    <p v-if="tokenExp"><strong>Token 到期：</strong> {{ tokenExp }}</p>
    <p v-if="joinDays !== null"><strong>加入时间：</strong> {{ joinDays }} 天</p>
  </div>
</template>

<script setup>
import { toRef, ref, watch, onMounted } from 'vue'

const props = defineProps({
  profile: { type: Object, default: () => ({ id: null, username: '', created_at: null }) },
  tokenExp: { type: String, default: null }
})

const prof = toRef(props, 'profile')
const joinDays = ref(null)

function calcJoinDays() {
  const createdVal = prof.value && (prof.value.created_at ?? prof.value.createdAt ?? prof.value.created)
  if (createdVal) {
    const created = new Date(createdVal)
    if (!isNaN(created.getTime())) {
      const now = new Date()
      const diff = Math.floor((now - created) / (1000*60*60*24))
      joinDays.value = diff
      return
    }
  }
  joinDays.value = null
}

onMounted(calcJoinDays)
watch(prof, calcJoinDays, { deep: true })
</script>

<style scoped>
.card { padding:12px; }
</style>