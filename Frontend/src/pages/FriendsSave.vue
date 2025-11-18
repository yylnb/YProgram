<template>
  <div class="friends-root p-6 min-h-screen bg-black text-white">
    <div class="max-w-6xl mx-auto">
      <!-- Header -->
      <div class="mb-6">
        <div class="flex items-center justify-between">
          <div>
            <h1 class="text-2xl font-extrabold">好友系统</h1>
            <div class="text-sm text-slate-400">管理好友与请求</div>
          </div>
          <div class="text-sm text-slate-400">
            当前用户 ID: <span class="font-medium text-white">{{ meId ?? '未登录' }}</span>
          </div>
        </div>
      </div>

      <!-- LAYOUT:
           - small: 单列堆叠
           - md+: 第一排 两列 并排 (添加 | 请求)
                  第二排 我的好友 横跨两列
      -->
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <!-- ADD 列 (col 1 of top row) -->
        <section class="bg-slate-900 border border-slate-800 rounded-2xl p-5 shadow-sm">
          <div class="flex items-center justify-between mb-4">
            <h2 class="text-lg font-semibold">添加好友</h2>
            <div class="text-sm text-slate-400">搜索并邀请新朋友</div>
          </div>

          <!-- 搜索输入 -->
          <div class="flex flex-col gap-3 mb-4">
            <div class="relative flex-1">
              <input
                v-model="searchQuery"
                @keydown.enter.prevent="onEnterSearch"
                type="text"
                placeholder="输入用户名或 ID 搜索（回车立即搜索）"
                class="w-full rounded-lg border px-4 py-2 bg-slate-800 border-slate-700 placeholder:text-slate-500 text-white focus:outline-none focus:ring-2 focus:ring-slate-600"
              />
              <button v-if="searching" class="absolute right-2 top-2 text-xs bg-slate-700 px-2 py-1 rounded text-slate-300" disabled>搜索中...</button>
            </div>

            <div class="flex items-center gap-3">
              <button
                @click="searchUsers"
                :disabled="searching || !searchQuery.trim()"
                class="px-4 py-2 rounded-md bg-indigo-600 text-white font-semibold hover:bg-indigo-500 disabled:opacity-60"
              >
                搜索
              </button>

              <button
                v-if="searchedOnce"
                @click="searchQuery=''; searchResults=[]; searchedOnce=false"
                class="px-3 py-2 rounded-md bg-slate-800 border border-slate-700 text-slate-300 hover:bg-slate-800/80"
              >
                清除
              </button>
            </div>
          </div>

          <!-- 搜索结果 -->
          <div class="space-y-3">
            <div v-if="searchResults.length === 0 && searchedOnce" class="text-slate-400">未找到匹配的用户。</div>

            <ul v-if="searchResults.length" class="space-y-2">
              <li
                v-for="user in searchResults"
                :key="user.id"
                class="flex items-center justify-between p-3 bg-slate-800 border border-slate-700 rounded-lg"
              >
                <div class="flex items-center gap-3 min-w-0">
                  <div class="w-10 h-10 rounded-full bg-gradient-to-br from-indigo-500 to-purple-500 flex items-center justify-center text-white font-bold">
                    {{ user.username ? user.username.charAt(0).toUpperCase() : '#' }}
                  </div>
                  <div class="min-w-0">
                    <div class="font-semibold truncate text-white">{{ user.username || '（无名）' }}</div>
                    <div class="text-xs text-slate-400">ID: {{ user.id }}</div>
                  </div>
                </div>

                <div class="flex items-center gap-2">
                  <!-- 状态分叉： accepted / pending_sent / pending_received / none -->
                  <template v-if="user.status === 'accepted'">
                    <button class="px-3 py-1.5 rounded-md bg-slate-700 text-slate-300 font-medium cursor-not-allowed" disabled>好友</button>
                  </template>

                  <template v-else-if="user.status === 'pending_sent'">
                    <button class="px-3 py-1.5 rounded-md bg-amber-600 text-white font-medium cursor-not-allowed" disabled>已邀请</button>
                  </template>

                  <template v-else-if="user.status === 'pending_received'">
                    <button
                      class="px-3 py-1.5 rounded-md bg-green-500 text-white font-medium hover:bg-green-400"
                      :disabled="processingRequest[user.pendingRequestId]"
                      @click="respondRequest(user.pendingRequestId, true)"
                    >
                      同意
                    </button>
                    <button
                      class="px-3 py-1.5 rounded-md bg-rose-600 text-white font-medium hover:bg-rose-500"
                      :disabled="processingRequest[user.pendingRequestId]"
                      @click="respondRequest(user.pendingRequestId, false)"
                    >
                      拒绝
                    </button>
                  </template>

                  <template v-else>
                    <button
                      class="px-3 py-1.5 rounded-md bg-green-600 text-white font-medium hover:bg-green-500"
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

        <!-- REQUESTS 列 (col 2 of top row) -->
        <section class="bg-slate-900 border border-slate-800 rounded-2xl p-5 shadow-sm">
          <div class="flex items-center justify-between mb-4">
            <h2 class="text-lg font-semibold">好友请求</h2>
            <div class="text-sm text-slate-400">待处理：<span class="font-medium text-white">{{ pendingCount }}</span></div>
          </div>

          <div v-if="loadingRequests" class="text-slate-400 py-6">加载中…</div>

          <ul v-else-if="friendRequests.length" class="space-y-3">
            <li v-for="r in friendRequests" :key="r.id" class="flex items-center justify-between p-3 bg-slate-800 border border-slate-700 rounded-lg">
              <div class="flex items-center gap-3 min-w-0">
                <div class="w-10 h-10 rounded-full bg-amber-500 flex items-center justify-center text-white font-bold">{{ r.username ? r.username.charAt(0).toUpperCase() : '#' }}</div>
                <div class="min-w-0">
                  <div class="font-semibold truncate text-white">{{ r.username || '（无名）' }}</div>
                  <div class="text-xs text-slate-400">ID: {{ r.from_id }}</div>
                </div>
              </div>

              <div class="flex items-center gap-2">
                <button
                  class="px-3 py-1.5 rounded-md bg-green-500 text-white hover:bg-green-400"
                  :disabled="processingRequest[r.id]"
                  @click="respondRequest(r.id, true)"
                >
                  <span v-if="!processingRequest[r.id]">同意</span><span v-else>处理中…</span>
                </button>
                <button
                  class="px-3 py-1.5 rounded-md bg-rose-600 text-white hover:bg-rose-500"
                  :disabled="processingRequest[r.id]"
                  @click="respondRequest(r.id, false)"
                >
                  拒绝
                </button>
              </div>
            </li>
          </ul>

          <div v-else class="text-slate-400 py-6">暂无好友请求</div>
        </section>

        <!-- FRIENDS 列：占满第二排（跨两列） -->
        <section class="md:col-span-2 bg-slate-900 border border-slate-800 rounded-2xl p-5 shadow-sm">
          <div class="flex items-center justify-between mb-4">
            <h2 class="text-lg font-semibold">我的好友</h2>
            <div class="text-sm text-slate-400">好友总数：<span class="font-medium text-white">{{ friends.length }}</span></div>
          </div>

          <div v-if="loadingFriends" class="text-slate-400 py-6">加载中…</div>

          <ul v-else-if="friends.length" class="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <li v-for="f in friends" :key="f.id" class="flex items-start gap-4 p-4 bg-slate-800 border border-slate-700 rounded-lg">
              <!-- 大头像 -->
              <div class="flex-shrink-0">
                <div class="w-16 h-16 rounded-full bg-indigo-500 flex items-center justify-center text-white font-bold text-xl">
                  {{ f.username ? f.username.charAt(0).toUpperCase() : '#' }}
                </div>
              </div>

              <!-- 信息主体 -->
              <div class="flex-1 min-w-0">
                <div class="flex items-center gap-3">
                  <!-- 昵称：若是会员，昵称为金色 -->
                  <div class="min-w-0">
                    <div class="flex items-center gap-3">
                      <div :class="['text-lg truncate', isMember(f) ? 'text-yellow-400 font-semibold' : 'text-white font-semibold']">
                        {{ f.username || '（无名）' }}
                      </div>
                      <div v-if="isMember(f)" class="text-xs bg-yellow-600/20 border border-yellow-700 text-yellow-200 px-2 py-0.5 rounded-full">
                        YPro会员
                      </div>
                    </div>

                    <!-- 会员到期或来源 -->
                    <div v-if="isMember(f)" class="text-xs text-yellow-200 mt-1">
                      到期：{{ formatDate(f.membership.end_at) }} <span class="text-slate-400">（来源：{{ f.membership.source || '—' }}）</span>
                    </div>
                  </div>
                </div>

                <!-- 更多 meta 信息 -->
                <div class="mt-2 text-sm text-slate-300">
                  <div class="truncate">ID: {{ f.id }}</div>
                  <!-- 占位简介：如果后端返回 bio 或 note 字段将展示 -->
                  <div v-if="f.bio" class="truncate mt-1">{{ f.bio }}</div>
                  <div v-else class="truncate mt-1 text-slate-500">这个人很懒，什么都没留下～</div>
                </div>
              </div>

              <!-- 操作按钮 -->
              <div class="flex flex-col items-end gap-2">
                <button class="px-3 py-1.5 rounded-md bg-rose-700 text-white border border-rose-600 font-medium hover:bg-rose-600" @click="removeFriend(f.id)">删除</button>
                <!-- 可扩展：发送消息等 -->
              </div>
            </li>
          </ul>

          <div v-else class="text-slate-400 py-6">你还没有好友，快去添加吧 😊</div>
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
    // fetch current user id (from /api/user/me if available)
    async loadMe() {
      try {
        const res = await axios.get("/api/user/me");
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

        // 批量获取所有好友的会员信息（一次请求）
        await this.fetchMembershipsForFriends();
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
    // 批量获取好友会员信息（/api/user/memberships?ids=1,2,3）
    // ------------------------
    async fetchMembershipsForFriends() {
      try {
        if (!Array.isArray(this.friends) || this.friends.length === 0) {
          return;
        }

        // 取所有好友 id 列表（排除无效 id）
        const ids = this.friends
          .map(f => (f && (f.id !== undefined && f.id !== null) ? String(f.id).trim() : null))
          .filter(x => x && x !== '');

        if (ids.length === 0) {
          // 确保每个 friend 都有 membership 字段（null）
          this.friends.forEach(f => { f.membership = null; });
          return;
        }

        // 限制数量以防滥用（与后端 MAX_IDS 保持一致）
        const MAX_IDS = 200;
        const safeIds = ids.slice(0, MAX_IDS);

        const idsParam = safeIds.join(',');

        const res = await axios.get('/api/user/memberships', { params: { ids: idsParam } });
        const data = res && res.data ? res.data : {};

        // data 期望是 { "123": { start_at, end_at, source }, "456": {...} }
        const map = data;

        // 合并到 this.friends 中
        this.friends = this.friends.map(f => {
          const key = String(f.id);
          const membership = map && map[key] ? map[key] : null;
          return {
            ...f,
            membership
          };
        });
      } catch (err) {
        console.warn("批量获取好友会员信息失败", err.response?.data || err.message);
        // 兜底：将 membership 设为 null，不影响主流程
        this.friends = this.friends.map(f => ({ ...f, membership: null }));
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
        const res = await axios.get("/api/friends/search", { params: { q, keyword: q } });
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
    },

    // helper: 判断是否会员（membership 存在且 end_at > now）
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
    }
  },

  watch: {
    // 任何时候搜索框内容变化都触发防抖搜索（只在添加区域需要，但同时显示所以直接启用）
    searchQuery() {
      if (this.searchQuery) {
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
.friends-root {
  font-family: Inter, ui-sans-serif, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial;
}

/* 全局按钮短粗圆角的统一风格（局部覆盖） */
button.rounded-md { border-radius: 0.5rem; }

/* 在窄屏时让三列垂直排列且间距合理（已有 tailwind grid 规则可处理） */
@media (max-width: 767px) {
  .friends-root { padding-left: 1rem; padding-right: 1rem; }
}
</style>