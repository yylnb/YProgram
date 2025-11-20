<template>
  <div class="card p-6">
    <h3 class="text-lg font-semibold mb-2">YPro 会员</h3>
    <div v-if="loading">加载中…</div>
    <div v-else>
      <p v-if="membership && membership.active">
        ✅ 你当前是 <strong>YPro</strong> 会员<br>
        <span class="text-gray-600">到期时间：{{ membership.end_at }}</span>
      </p>
      <p v-else class="text-gray-600">暂无 YPro 会员</p>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const props = defineProps({
  profile: { type: Object, default: () => ({}) } // 目前没直接用 profile，但保留可扩展性
})

const membership = ref(null)
const loading = ref(false)

async function loadMembership() {
  const token = localStorage.getItem('yp_token')
  if (!token) return
  loading.value = true
  try {
    const res = await fetch('http://localhost:5000/api/user/membership', { headers: { 'Authorization': `Bearer ${token}` } })
    if (res.ok) {
      const data = await res.json()
      if (data && data.end_at) {
        membership.value = {
          active: new Date(data.end_at) > new Date(),
          end_at: new Date(data.end_at).toLocaleString()
        }
      } else {
        membership.value = { active: false }
      }
    } else {
      membership.value = { active: false }
    }
  } catch(e) {
    membership.value = { active: false }
  } finally {
    loading.value = false
  }
}

onMounted(loadMembership)
</script>

<style scoped>
.card { padding:12px; }
.text-gray-600 { color: #6b7280; }
</style>