<template>
  <section class="card">
    <div class="card-header">
      <div class="h-title">好友请求</div>
      <div class="h-sub">处理收到的请求</div>
    </div>

    <div v-if="loading" class="muted">加载中…</div>

    <ul v-else-if="requests.length" class="requests-list">
      <li v-for="r in requests" :key="r.id" class="req-item">
        <div class="left">
          <div class="avatar">{{ r.username ? r.username.charAt(0).toUpperCase() : '#' }}</div>
          <div class="meta">
            <div class="name">{{ r.username || '（无名）' }}</div>
            <div class="id">ID: {{ r.from_id }}</div>
          </div>
        </div>

        <div class="right">
          <button class="btn accept" :disabled="processing[r.id]" @click="respond(r.id, true)">
            <span v-if="!processing[r.id]">同意</span><span v-else>处理中…</span>
          </button>
          <button class="btn decline" :disabled="processing[r.id]" @click="respond(r.id, false)">拒绝</button>
        </div>
      </li>
    </ul>

    <div v-else class="muted">暂无好友请求</div>
  </section>
</template>

<script>
import axios from 'axios';
export default {
  name: 'CheckFriend',
  data() {
    return {
      requests: [],
      loading: false,
      processing: {}
    };
  },
  methods: {
    async fetchRequests() {
      this.loading = true;
      try {
        const res = await axios.get('/api/friends/requests');
        this.requests = Array.isArray(res.data) ? res.data : [];
      } catch (err) {
        console.error('获取好友请求失败', err.response?.data || err.message);
        this.requests = [];
      } finally {
        this.loading = false;
      }
    },
    async respond(requestId, accept) {
      if (!requestId) return;
      this.$set ? this.$set(this.processing, requestId, true) : (this.processing[requestId] = true);
      try {
        await axios.post('/api/friends/respond', { requestId, accept });
        // 刷新本区与好友区
        await Promise.all([this.fetchRequests(), this.$root.$emit && this.$root.$emit('refresh-friends')]);
      } catch (err) {
        console.error('处理好友请求失败', err.response?.data || err.message);
        alert(err.response?.data?.error || '处理失败');
      } finally {
        this.$set ? this.$set(this.processing, requestId, false) : (this.processing[requestId] = false);
      }
    }
  },
  async mounted() {
    await this.fetchRequests();
    // 支持其他组件触发刷新
    this.$root.$on && this.$root.$on('refresh-requests', this.fetchRequests);
  },
  beforeUnmount() {
    this.$root.$off && this.$root.$off('refresh-requests', this.fetchRequests);
  }
};
</script>

<style scoped>
.card {
  background: #1c1c1c;
  border-radius: 30px;
  box-shadow: 12px 12px 36px rgba(194, 194, 194, 0.7);
  padding: 16px;
  color: #fff;
  min-height: 270px;
}
.card-header { display:flex; justify-content:space-between; align-items:baseline; margin-bottom:12px; }
.h-title { font-size:16px; font-weight:700; }
.h-sub { font-size:12px; color:#9ca3af; }

.requests-list { margin-top: 4px; }
.req-item {
  display:flex;
  justify-content:space-between;
  align-items:center;
  background:#0b1220;
  border:1px solid #111827;
  padding:10px;
  border-radius:8px;
  margin-bottom:8px;
}
.left { display:flex; gap:12px; align-items:center; }
.avatar { width:40px; height:40px; border-radius:50%; background:#f59e0b; display:flex; align-items:center; justify-content:center; color:#fff; font-weight:700; }
.meta .name { font-weight:700; }
.meta .id { font-size:12px; color:#9ca3af; margin-top:2px; }
.right { display:flex; gap:8px; align-items:center; }

.btn { border:none; padding:8px 12px; border-radius:8px; cursor:pointer; font-weight:600; }
.btn.accept { background:#16a34a; color:#fff; }
.btn.decline { background:#dc2626; color:#fff; }
.muted { color:#9ca3af; font-size:13px; }
</style>