<template>
  <div class="friends-root p-6 min-h-screen bg-gradient-to-b from-slate-50 to-white">
    <div class="max-w-4xl mx-auto">
      <div class="bg-white rounded-2xl shadow-md p-6">
        <div class="flex items-center justify-between mb-4">
          <h1 class="text-2xl font-extrabold text-slate-800">好友系统</h1>
          <div class="text-sm text-slate-500">管理好友与请求</div>
        </div>

        <!-- Tabs -->
        <div class="mb-6 grid grid-cols-3 gap-3">
          <button :class="tabBtnClass('add')" @click="tab = 'add'">添加好友</button>
          <button :class="tabBtnClass('requests')" @click="tab = 'requests'">
            好友请求
            <span v-if="pendingCount > 0" class="ml-2 inline-flex items-center justify-center px-2 py-0.5 text-xs font-semibold rounded-full bg-rose-100 text-rose-700">
              {{ pendingCount }}
            </span>
          </button>
          <button :class="tabBtnClass('list')" @click="tab = 'list'">我的好友</button>
        </div>

        <!-- ADD: 搜索 -->
        <section v-if="tab === 'add'">
          <div class="flex flex-col md:flex-row md:items-center gap-3 mb-4">
            <div class="relative flex-1">
              <input
                v-model="searchQuery"
                @keydown.enter.prevent="onEnterSearch"
                type="text"
                placeholder="输入用户名或 ID 搜索（回车立即搜索）"
                class="w-full rounded-lg border px-4 py-2 focus:ring-2 focus:ring-blue-300 focus:border-transparent"
              />
              <button v-if="searching" class="absolute right-2 top-2 text-xs bg-slate-100 px-2 py-1 rounded" disabled>搜索中...</button>
            </div>

            <div class="flex-shrink-0">
              <button @click="searchUsers" :disabled="searching || !searchQuery.trim()" class="px-4 py-2 rounded-md bg-blue-600 text-white font-semibold hover:bg-blue-700 disabled:opacity-60">
                搜索
              </button>
            </div>
          </div>

          <div class="space-y-3">
            <div v-if="searchResults.length === 0 && searchedOnce" class="text-slate-500">未找到匹配的用户。</div>

            <ul v-if="searchResults.length" class="space-y-2">
              <li
                v-for="user in searchResults"
                :key="user.id"
                class="flex items-center justify-between p-3 bg-slate-50 border rounded-lg"
              >
                <div class="flex items-center gap-3 min-w-0">
                  <div class="w-10 h-10 rounded-full bg-gradient-to-br from-indigo-500 to-purple-500 flex items-center justify-center text-white font-bold">
                    {{ user.username ? user.username.charAt(0).toUpperCase() : '#' }}
                  </div>
                  <div class="min-w-0">
                    <div class="font-semibold text-slate-800 truncate">{{ user.username || '（无名）' }}</div>
                    <div class="text-xs text-slate-400">ID: {{ user.id }}</div>
                  </div>
                </div>

                <div class="flex items-center gap-2">
                  <!-- 状态分叉： accepted / pending_sent / pending_received / none -->
                  <template v-if="user.status === 'accepted'">
                    <button class="px-3 py-1.5 rounded-md bg-slate-100 text-slate-600 font-medium cursor-not-allowed" disabled>好友</button>
                  </template>

                  <template v-else-if="user.status === 'pending_sent'">
                    <button class="px-3 py-1.5 rounded-md bg-amber-100 text-amber-700 font-medium cursor-not-allowed" disabled>已邀请</button>
                  </template>

                  <template v-else-if="user.status === 'pending_received'">
                    <!-- 显示接受/拒绝小按钮（需要 requestId） -->
                    <button
                      class="px-3 py-1.5 rounded-md bg-green-600 text-white font-medium hover:bg-green-700"
                      :disabled="processingRequest[user.pendingRequestId]"
                      @click="respondRequest(user.pendingRequestId, true)"
                    >
                      同意
                    </button>
                    <button
                      class="px-3 py-1.5 rounded-md bg-red-600 text-white font-medium hover:bg-red-700"
                      :disabled="processingRequest[user.pendingRequestId]"
                      @click="respondRequest(user.pendingRequestId, false)"
                    >
                      拒绝
                    </button>
                  </template>

                  <template v-else>
                    <!-- none -->
                    <button
                      class="px-3 py-1.5 rounded-md bg-green-600 text-white font-medium hover:bg-green-700"
                      :disabled="sendingTo[user.id] || user.id === meId"
                      @click="sendFriendRequest(user.id)"
                    >
                      <span v-if="!sendingTo[user.id]">邀请</span>
                      <span v-else>发送中…</span>
                    </button>
                  </template>
                </div>
              </li>
            </ul>
          </div>
        </section>

        <!-- REQUESTS -->
        <section v-else-if="tab === 'requests'">
          <div v-if="loadingRequests" class="text-slate-500 py-6">加载中…</div>

          <ul v-else-if="friendRequests.length" class="space-y-3">
            <li v-for="r in friendRequests" :key="r.id" class="flex items-center justify-between p-3 bg-slate-50 border rounded-lg">
              <div class="flex items-center gap-3 min-w-0">
                <div class="w-10 h-10 rounded-full bg-amber-400 flex items-center justify-center text-white font-bold">{{ r.username ? r.username.charAt(0).toUpperCase() : '#' }}</div>
                <div class="min-w-0">
                  <div class="font-semibold truncate">{{ r.username || '（无名）' }}</div>
                  <div class="text-xs text-slate-400">ID: {{ r.from_id }}</div>
                </div>
              </div>

              <div class="flex items-center gap-2">
                <button class="px-3 py-1.5 rounded-md bg-green-600 text-white hover:bg-green-700" :disabled="processingRequest[r.id]" @click="respondRequest(r.id, true)">
                  <span v-if="!processingRequest[r.id]">同意</span><span v-else>处理中…</span>
                </button>
                <button class="px-3 py-1.5 rounded-md bg-red-600 text-white hover:bg-red-700" :disabled="processingRequest[r.id]" @click="respondRequest(r.id, false)">
                  拒绝
                </button>
              </div>
            </li>
          </ul>

          <div v-else class="text-slate-500 py-6">暂无好友请求</div>
        </section>

        <!-- LIST -->
        <section v-else-if="tab === 'list'">
          <div v-if="loadingFriends" class="text-slate-500 py-6">加载中…</div>

          <ul v-else-if="friends.length" class="grid grid-cols-1 sm:grid-cols-2 gap-3">
            <li v-for="f in friends" :key="f.id" class="flex items-center justify-between p-3 bg-slate-50 border rounded-lg">
              <div class="flex items-center gap-3 min-w-0">
                <div class="w-10 h-10 rounded-full bg-indigo-400 flex items-center justify-center text-white font-bold">{{ f.username ? f.username.charAt(0).toUpperCase() : '#' }}</div>
                <div class="min-w-0">
                  <div class="font-semibold truncate">{{ f.username || '（无名）' }}</div>
                  <div class="text-xs text-slate-400">ID: {{ f.id }}</div>
                </div>
              </div>

              <div>
                <button class="px-3 py-1.5 rounded-md bg-rose-50 text-rose-600 border border-rose-100 font-medium hover:bg-rose-100" @click="removeFriend(f.id)">删除</button>
              </div>
            </li>
          </ul>

          <div v-else class="text-slate-500 py-6">你还没有好友，快去添加吧 😊</div>
        </section>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "Friends",
  data() {
    return {
      tab: "add",
      searchQuery: "",
      searchResults: [],
      searchedOnce: false,
      searching: false,
      friends: [],
      friendRequests: [],
      loadingFriends: false,
      loadingRequests: false,
      sendingTo: {},
      processingRequest: {},
      searchTimer: null,
      searchDebounceMs: 400,
      // 当前用户 id（用于避免向自己发请求）
      meId: null
    };
  },
  computed: {
    pendingCount() {
      return this.friendRequests.length;
    }
  },
  methods: {
    tabBtnClass(name) {
      const base = "py-2 px-3 rounded-lg text-sm font-semibold";
      if (this.tab === name) {
        return base + " bg-gradient-to-r from-blue-500 to-indigo-600 text-white shadow";
      }
      return base + " bg-slate-100 text-slate-600 hover:bg-slate-200";
    },

    // fetch current user id (from /api/me if available)
    async loadMe() {
      try {
        const res = await axios.get("/api/me");
        if (res && res.data) this.meId = res.data.id;
      } catch (e) { /* ignore */ }
    },

    // ------------------------
    // 保持原名：fetchFriends / fetchFriendRequests
    // ------------------------
    async fetchFriends() {
      this.loadingFriends = true;
      try {
        const res = await axios.get("/api/friends");
        this.friends = Array.isArray(res.data) ? res.data : [];
      } catch (err) {
        console.error("获取好友失败", err.response?.data || err.message);
        this.friends = [];
      } finally {
        this.loadingFriends = false;
      }
    },

    async fetchFriendRequests() {
      this.loadingRequests = true;
      try {
        const res = await axios.get("/api/friends/requests");
        this.friendRequests = Array.isArray(res.data) ? res.data : [];
      } catch (err) {
        console.error("获取好友请求失败", err.response?.data || err.message);
        this.friendRequests = [];
      } finally {
        this.loadingRequests = false;
      }
    },

    // ------------------------
    // 搜索 & 状态检测（防抖 + 回车）
    // ------------------------
    scheduleSearch() {
      clearTimeout(this.searchTimer);
      this.searchTimer = setTimeout(() => {
        this.searchUsers();
      }, this.searchDebounceMs);
    },

    onEnterSearch() {
      clearTimeout(this.searchTimer);
      this.searchUsers();
    },

    async searchUsers() {
      const q = (this.searchQuery || "").trim();
      this.searchedOnce = true;

      if (!q) {
        this.searchResults = [];
        return;
      }

      this.searching = true;
      try {
        // 1) 搜索用户
        const res = await axios.get("/api/users/search", { params: { q, keyword: q } });
        const rows = Array.isArray(res.data) ? res.data : [];
        // normalize -> ensure id and username
        const normalized = rows.map(r => ({
          id: r.id ?? r.user_id ?? null,
          username: r.username ?? r.name ?? r.user ?? ''
        })).filter(u => u.id !== null && u.id !== undefined);

        this.searchResults = normalized;

        // 2) 批量获取这些 id 的关系状态（避免 N+1）
        const ids = normalized.map(u => u.id).join(',');
        if (ids.length) {
          const stRes = await axios.get('/api/friends/statuses', { params: { ids } });
          const arr = Array.isArray(stRes.data) ? stRes.data : [];
          // 转成 map
          const map = new Map(arr.map(x => [Number(x.id), x]));
          // merge status into searchResults
          this.searchResults = normalized.map(u => {
            const s = map.get(Number(u.id)) || { status: 'none' };
            return {
              ...u,
              status: s.status || 'none',
              pendingRequestId: s.requestId || null
            };
          });
        } else {
          // no ids
          this.searchResults = normalized.map(u => ({ ...u, status: 'none', pendingRequestId: null }));
        }
      } catch (err) {
        console.error("搜索用户失败", err.response?.data || err.message);
        this.searchResults = [];
      } finally {
        this.searching = false;
      }
    },

    // ------------------------
    // 发送好友请求（保持原名和请求体）
    // ------------------------
    async sendFriendRequest(userId) {
      if (!userId) return;
      // 防重复发送
      if (this.sendingTo[userId]) return;
      this.$set ? this.$set(this.sendingTo, userId, true) : (this.sendingTo[userId] = true);

      try {
        // double-check status client-side (optional)
        const s = this.searchResults.find(x => Number(x.id) === Number(userId));
        if (s && s.status === 'pending_sent') {
          alert('你已发送邀请，等待对方处理');
          return;
        }
        if (s && s.status === 'accepted') {
          alert('你们已是好友');
          return;
        }

        await axios.post('/api/friends/request', { toUserId: userId });
        alert('好友请求已发送');
        // 刷新收到的请求（如果有人给你发了），以及 search 状态
        await Promise.all([this.fetchFriendRequests(), this.searchUsers()]);
      } catch (err) {
        console.error('发送好友请求失败', err.response?.data || err.message);
        alert(err.response?.data?.error || '发送失败');
      } finally {
        this.$set ? this.$set(this.sendingTo, userId, false) : (this.sendingTo[userId] = false);
      }
    },

    // ------------------------
    // 处理请求（接受/拒绝），保持原名
    // ------------------------
    async respondRequest(requestId, accept) {
      if (!requestId) return;
      this.$set ? this.$set(this.processingRequest, requestId, true) : (this.processingRequest[requestId] = true);

      try {
        await axios.post('/api/friends/respond', { requestId, accept });
        // 刷新请求列表和好友列表、以及可能的 search 状态
        await Promise.all([this.fetchFriendRequests(), this.fetchFriends(), this.searchUsers()]);
      } catch (err) {
        console.error('处理好友请求失败', err.response?.data || err.message);
        alert(err.response?.data?.error || '处理失败');
      } finally {
        this.$set ? this.$set(this.processingRequest, requestId, false) : (this.processingRequest[requestId] = false);
      }
    },

    // ------------------------
    // 删除好友（保持原名）
    // ------------------------
    async removeFriend(friendId) {
      if (!confirm('确定删除该好友吗？')) return;
      try {
        await axios.delete(`/api/friends/${friendId}`);
        await this.fetchFriends();
        // 搜索页可能需刷新状态
        this.searchUsers();
      } catch (err) {
        console.error('删除好友失败', err.response?.data || err.message);
        alert(err.response?.data?.error || '删除失败');
      }
    }
  },

  watch: {
    searchQuery() {
      if (this.searchQuery && this.tab === 'add') {
        this.scheduleSearch();
      }
    }
  },

  async mounted() {
    // load current user id & lists
    await this.loadMe();
    await Promise.all([this.fetchFriends(), this.fetchFriendRequests()]);
  }
};
</script>

<style scoped>
.friends-root { font-family: Inter, ui-sans-serif, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial; }

/* 进一步微调：短粗按钮的统一样式（局部） */
button.rounded-md { border-radius: 0.5rem; }
</style>
