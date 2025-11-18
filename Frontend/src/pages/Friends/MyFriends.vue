<template>
  <section class="card">
    <div class="card-header">
      <div class="h-title">我的好友</div>
      <div class="h-sub">好友总数：<span class="count">{{ friends.length }}</span></div>
    </div>

    <div v-if="loading" class="muted">加载中…</div>

    <ul v-else-if="friends.length" class="friends-list">
      <li v-for="f in friends" :key="f.id" class="friend-item">
        <div class="avatar-large">{{ f.username ? f.username.charAt(0).toUpperCase() : '#' }}</div>

        <div class="info">
          <div class="top">
            <div :class="['display-name', isMember(f) ? 'member' : '']">{{ f.username || '（无名）' }}</div>
            <div v-if="isMember(f)" class="member-badge">YPro会员</div>
          </div>

          <div v-if="isMember(f)" class="member-info">到期：{{ formatDate(f.membership.end_at) }} <span class="muted">（来源：{{ f.membership.source || '—' }}）</span></div>

          <div class="meta">
            <div class="id">ID: {{ f.id }}</div>
            <div v-if="f.bio" class="bio">{{ f.bio }}</div>
            <div v-else class="bio muted">这个人很懒，什么都没留下～</div>
          </div>
        </div>

        <div class="actions">
          <button class="btn delete" @click="removeFriend(f.id)">删除</button>
        </div>
      </li>
    </ul>

    <div v-else class="muted">你还没有好友，快去添加吧 😊</div>
  </section>
</template>

<script>
import axios from 'axios';
export default {
  name: 'MyFriends',
  data() {
    return {
      friends: [],
      loading: false,
      MAX_IDS: 200
    };
  },
  methods: {
    async fetchFriends() {
      this.loading = true;
      try {
        const res = await axios.get('/api/friends');
        this.friends = Array.isArray(res.data) ? res.data : [];
        // then batch fetch memberships
        await this.fetchMembershipsForFriends();
      } catch (err) {
        console.error('获取好友失败', err.response?.data || err.message);
        this.friends = [];
      } finally {
        this.loading = false;
      }
    },

    async fetchMembershipsForFriends() {
      try {
        if (!Array.isArray(this.friends) || this.friends.length === 0) {
          this.friends.forEach(f => { f.membership = null; });
          return;
        }

        const ids = this.friends
          .map(f => (f && (f.id !== undefined && f.id !== null) ? String(f.id).trim() : null))
          .filter(x => x && x !== '');

        if (ids.length === 0) {
          this.friends.forEach(f => { f.membership = null; });
          return;
        }

        const safe = ids.slice(0, this.MAX_IDS);
        const idsParam = safe.join(',');

        const res = await axios.get('/api/user/memberships', { params: { ids: idsParam } });
        const data = res && res.data ? res.data : {};

        this.friends = this.friends.map(f => {
          const key = String(f.id);
          const membership = data && data[key] ? data[key] : null;
          return { ...f, membership };
        });
      } catch (err) {
        console.warn('批量获取好友会员信息失败', err.response?.data || err.message);
        this.friends = this.friends.map(f => ({ ...f, membership: null }));
      }
    },

    isMember(user) {
      try {
        if (!user || !user.membership || !user.membership.end_at) return false;
        const end = new Date(user.membership.end_at).getTime();
        return !isNaN(end) && end > Date.now();
      } catch (e) {
        return false;
      }
    },

    formatDate(iso) {
      if (!iso) return '—';
      try {
        const d = new Date(iso);
        if (isNaN(d.getTime())) return iso;
        return d.toLocaleDateString();
      } catch (e) {
        return iso;
      }
    },

    async removeFriend(friendId) {
      if (!confirm('确定删除该好友吗？')) return;
      try {
        await axios.delete(`/api/friends/${friendId}`);
        await this.fetchFriends();
      } catch (err) {
        console.error('删除好友失败', err.response?.data || err.message);
        alert(err.response?.data?.error || '删除失败');
      }
    }
  },
  async mounted() {
    await this.fetchFriends();
    // 支持事件触发刷新（来自别的组件）
    this.$root.$on && this.$root.$on('refresh-friends', this.fetchFriends);
  },
  beforeUnmount() {
    this.$root.$off && this.$root.$off('refresh-friends', this.fetchFriends);
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
}
.card-header { display:flex; justify-content:space-between; align-items:baseline; margin-bottom:12px; }
.h-title { font-size:16px; font-weight:700; }
.h-sub { font-size:13px; color:#9ca3af; }
.count { color:#fff; font-weight:700; }

.friends-list { display:flex; flex-direction:column; gap:12px; margin-top:6px; }
.friend-item {
  display:flex;
  gap:12px;
  align-items:flex-start;
  background:#0b1220;
  border:1px solid #111827;
  padding:12px;
  border-radius:10px;
}
.avatar-large {
  width:64px;
  height:64px;
  border-radius:50%;
  background:linear-gradient(135deg,#6366f1,#7c3aed);
  display:flex;
  align-items:center;
  justify-content:center;
  color:#fff;
  font-weight:700;
  font-size:22px;
}
.info { flex:1; min-width:0; }
.top { display:flex; gap:10px; align-items:center; }
.display-name { font-size:16px; font-weight:700; color:#fff; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; }
.display-name.member { color:#fbbf24; } /* gold-ish */
.member-badge {
  padding:4px 8px;
  border-radius:999px;
  background: rgba(251,191,36,0.12);
  border:1px solid rgba(245,158,11,0.2);
  color:#fde68a;
  font-size:12px;
}
.member-info { margin-top:6px; color:#f6e05e; font-size:13px; }
.meta { margin-top:8px; color:#cbd5e1; font-size:13px; }
.id { color:#9ca3af; margin-bottom:6px; }
.bio { color:#cbd5e1; }

.actions { display:flex; flex-direction:column; gap:8px; align-items:flex-end; }
.btn { border:none; padding:8px 12px; border-radius:8px; cursor:pointer; font-weight:600; }
.btn.delete { background:#b91c1c; color:#fff; }
.muted { color:#9ca3af; font-size:13px; }
</style>