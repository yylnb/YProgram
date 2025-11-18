<template>
  <section class="card">
    <div class="card-header">
      <div class="h-title">添加好友</div>
      <div class="h-sub">搜索并邀请新朋友</div>
    </div>

    <div class="search-area">
      <input
        v-model="searchQuery"
        @keydown.enter.prevent="onEnterSearch"
        placeholder="输入用户名或 ID 搜索（回车立即搜索）"
        class="search-input"
      />
      <div class="search-actions">
        <button class="btn primary" @click="searchUsers" :disabled="searching || !searchQuery.trim()">搜索</button>
        <button v-if="searchedOnce" class="btn neutral" @click="clearSearch">清除</button>
      </div>
      <div v-if="searching" class="small muted">搜索中…</div>
    </div>

    <div class="results">
      <div v-if="allResults.length === 0 && searchedOnce" class="muted">未找到匹配的用户。</div>

      <!-- 使用 transition 包裹分页内容；mode="out-in" 保证离开先完成 -->
      <transition :name="transitionName" mode="out-in">
        <div :key="page" class="page-wrapper">
          <ul v-if="displayedResults.length" class="page-list">
            <li v-for="user in displayedResults" :key="user.id" class="result-item">
              <div class="left">
                <div class="avatar">{{ user.username ? user.username.charAt(0).toUpperCase() : '#' }}</div>
                <div class="meta">
                  <div class="name">{{ user.username || '（无名）' }}</div>
                  <div class="id">ID: {{ user.id }}</div>
                  <div v-if="user.membership && user.membership.end_at" class="membership-note">会员：到期 {{ formatDate(user.membership.end_at) }}</div>
                </div>
              </div>

              <div class="right">
                <!-- 如果是自己 -->
                <template v-if="user.id === meId">
                  <button class="btn disabled" disabled>自己</button>
                </template>

                <!-- 已为好友 -->
                <template v-else-if="user.status === 'accepted'">
                  <button class="btn disabled" disabled>好友</button>
                </template>

                <!-- 已发送邀请 -->
                <template v-else-if="user.status === 'pending_sent'">
                  <button class="btn disabled amber" disabled>已邀请</button>
                </template>

                <!-- 收到对方请求 -->
                <template v-else-if="user.status === 'pending_received'">
                  <button class="btn accept" :disabled="processingRequest[user.pendingRequestId]" @click="respondRequest(user.pendingRequestId, true)">同意</button>
                  <button class="btn decline" :disabled="processingRequest[user.pendingRequestId]" @click="respondRequest(user.pendingRequestId, false)">拒绝</button>
                </template>

                <!-- 普通可邀请用户 -->
                <template v-else>
                  <button class="btn primary" :disabled="sendingTo[user.id]" @click="sendFriendRequest(user.id)">
                    <span v-if="!sendingTo[user.id]">邀请</span>
                    <span v-else>发送中…</span>
                  </button>
                </template>
              </div>
            </li>
          </ul>
        </div>
      </transition>

      <!-- 分页控件 -->
      <div v-if="totalPages > 1" class="pager">
        <button class="pg-btn" :disabled="page === 1" @click="handlePrev">上一页</button>

        <button
          v-for="p in pageButtons"
          :key="p"
          :class="['pg-number', { active: p === page }]"
          @click="goPageWithAnim(p)"
        >
          {{ p }}
        </button>

        <button class="pg-btn" :disabled="page === totalPages" @click="handleNext">下一页</button>
      </div>
    </div>
  </section>
</template>

<script>
import axios from 'axios';
export default {
  name: 'ApplyFriend',
  data() {
    return {
      // search state
      searchQuery: '',
      allResults: [],     // 所有搜索结果（未分页）
      searchedOnce: false,
      searching: false,

      // pagination
      page: 1,
      pageSize: 3, // <- 每页 3 个

      // per-item states
      sendingTo: {},
      processingRequest: {},

      // debounce
      searchTimer: null,
      searchDebounceMs: 400,

      // current user id
      meId: null,

      // animation control: 'left' | 'right' | ''  (用于 transition 名称)
      transitionDirection: ''
    };
  },
  computed: {
    totalPages() {
      return Math.max(1, Math.ceil(this.allResults.length / this.pageSize));
    },
    displayedResults() {
      const start = (this.page - 1) * this.pageSize;
      const slice = this.allResults.slice(start, start + this.pageSize);
      return slice;
    },
    // page buttons - simple full list (for small totals)
    pageButtons() {
      const pages = [];
      for (let i = 1; i <= this.totalPages; i++) pages.push(i);
      return pages;
    },
    transitionName() {
      // 由 transitionDirection 决定使用哪组 CSS 动画类
      if (this.transitionDirection === 'left') return 'slide-left';
      if (this.transitionDirection === 'right') return 'slide-right';
      return 'slide-left'; // 默认
    }
  },
  methods: {
    clearSearch() {
      this.searchQuery = '';
      this.allResults = [];
      this.searchedOnce = false;
      this.page = 1;
    },

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
      const q = (this.searchQuery || '').trim();
      this.searchedOnce = true;
      this.page = 1; // reset to first page on new search
      if (!q) {
        this.allResults = [];
        return;
      }
      this.searching = true;

      try {
        // 1) 搜索用户（返回所有匹配，前端分页）
        const res = await axios.get('/api/friends/search', { params: { q, keyword: q } });
        const rows = Array.isArray(res.data) ? res.data : [];
        const normalized = rows.map(r => ({
          id: r.id ?? r.user_id ?? null,
          username: r.username ?? r.name ?? r.user ?? ''
        })).filter(u => u.id !== null && u.id !== undefined);

        // set allResults
        this.allResults = normalized.map(u => ({ ...u, status: 'none', pendingRequestId: null, membership: null }));

        // 2) fetch statuses in batch for all results (so statuses are available across pages)
        const allIds = this.allResults.map(u => u.id).join(',');
        if (allIds.length) {
          try {
            const stRes = await axios.get('/api/friends/statuses', { params: { ids: allIds } });
            const arr = Array.isArray(stRes.data) ? stRes.data : [];
            const map = new Map(arr.map(x => [Number(x.id), x]));
            this.allResults = this.allResults.map(u => {
              const s = map.get(Number(u.id)) || { status: 'none' };
              return { ...u, status: s.status || 'none', pendingRequestId: s.requestId || null };
            });
          } catch (e) {
            console.warn('fetch statuses failed', e?.response?.data || e?.message || e);
          }
        }

        // 3) fetch membership for the first page (batch)
        await this.fetchMembershipsForCurrentPage();
      } catch (err) {
        console.error('搜索用户失败', err.response?.data || err.message);
        this.allResults = [];
      } finally {
        this.searching = false;
      }
    },

    async fetchMembershipsForCurrentPage() {
      try {
        const pageItems = this.displayedResults;
        if (!pageItems || pageItems.length === 0) return;

        const ids = pageItems.map(u => String(u.id)).filter(x => x !== '');
        if (ids.length === 0) return;

        // limit safety - front-end side (should align with backend)
        const MAX_IDS = 200;
        const safe = ids.slice(0, MAX_IDS);
        const idsParam = safe.join(',');

        const res = await axios.get('/api/user/memberships', { params: { ids: idsParam } });
        const data = res && res.data ? res.data : {};

        // merge membership to current page items (in allResults)
        const map = data;
        const start = (this.page - 1) * this.pageSize;
        for (let i = 0; i < pageItems.length; i++) {
          const idx = start + i;
          const key = String(this.allResults[idx].id);
          const membership = map && map[key] ? map[key] : null;
          if (this.$set) {
            this.$set(this.allResults[idx], 'membership', membership);
          } else {
            this.allResults[idx].membership = membership;
          }
        }
      } catch (err) {
        console.warn('批量获取会员信息失败', err.response?.data || err.message);
        const start = (this.page - 1) * this.pageSize;
        for (let i = 0; i < this.pageSize; i++) {
          const idx = start + i;
          if (idx >= 0 && idx < this.allResults.length) {
            if (this.$set) this.$set(this.allResults[idx], 'membership', null);
            else this.allResults[idx].membership = null;
          }
        }
      }
    },

    // goPageWithAnim: set direction and change page -> transition runs (mode out-in)
    async goPageWithAnim(p) {
      if (p < 1 || p > this.totalPages || p === this.page) return;
      const old = this.page;
      this.transitionDirection = p > old ? 'left' : 'right';
      // change page to trigger transition (out-in)
      this.page = p;
      // fetch memberships for new page
      await this.fetchMembershipsForCurrentPage();
      // after a short delay, reset transitionDirection to default (optional)
      setTimeout(() => { this.transitionDirection = ''; }, 600);
    },

    // helper handlers for prev/next (use animations)
    handleNext() {
      if (this.page >= this.totalPages) return;
      this.goPageWithAnim(this.page + 1);
    },
    handlePrev() {
      if (this.page <= 1) return;
      this.goPageWithAnim(this.page - 1);
    },

    // keep backwards-compatible goPage (no animation) if used elsewhere
    async goPage(p) {
      if (p < 1 || p > this.totalPages) return;
      this.page = p;
      await this.fetchMembershipsForCurrentPage();
    },

    async sendFriendRequest(userId) {
      if (!userId) return;
      if (this.sendingTo[userId]) return;
      this.$set ? this.$set(this.sendingTo, userId, true) : (this.sendingTo[userId] = true);
      try {
        const s = this.allResults.find(x => Number(x.id) === Number(userId));
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
        // refresh requests and search statuses
        this.$root.$emit && this.$root.$emit('refresh-requests');
        // refresh statuses and page membership
        await this.searchUsers(); // re-run search to refresh statuses and memberships
      } catch (err) {
        console.error('发送好友请求失败', err.response?.data || err.message);
        alert(err.response?.data?.error || '发送失败');
      } finally {
        this.$set ? this.$set(this.sendingTo, userId, false) : (this.sendingTo[userId] = false);
      }
    },

    async respondRequest(requestId, accept) {
      if (!requestId) return;
      this.$set ? this.$set(this.processingRequest, requestId, true) : (this.processingRequest[requestId] = true);
      try {
        await axios.post('/api/friends/respond', { requestId, accept });
        // refresh requests/friends globally by emitting event
        this.$root.$emit && this.$root.$emit('refresh-requests');
        this.$root.$emit && this.$root.$emit('refresh-friends');
        // refresh current search results & memberships
        await this.searchUsers();
      } catch (err) {
        console.error('处理好友请求失败', err.response?.data || err.message);
        alert(err.response?.data?.error || '处理失败');
      } finally {
        this.$set ? this.$set(this.processingRequest, requestId, false) : (this.processingRequest[requestId] = false);
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
    searchQuery() {
      if (this.searchQuery) this.scheduleSearch();
    }
  },

  async mounted() {
    // load current user id for local checks
    try {
      const res = await axios.get('/api/user/me');
      if (res && res.data) this.meId = res.data.id;
    } catch (e) {
      this.meId = null;
    }

    if (this.allResults.length) {
      await this.fetchMembershipsForCurrentPage();
    }
  }
};
</script>

<style scoped>
.card {
  background: #1c1c1c; /* dark slate */
  border-radius: 30px;
  box-shadow: 12px 12px 36px rgba(194, 194, 194, 0.7);
  padding: 16px;
  color: #fff;
  min-height: 270px; /* 初始高度更大一些 */
}

/* header */
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: baseline;
  margin-bottom: 12px;
}
.h-title { font-size: 16px; font-weight: 700; }
.h-sub { font-size: 12px; color: #9ca3af; }

/* search */
.search-area { margin-bottom: 8px; }
.search-input {
  width: 100%;
  padding: 8px 10px;
  border-radius: 8px;
  border: 1px solid #1f2937;
  background: #0b1220;
  color: #fff;
  box-sizing: border-box;
}
.search-actions {
  margin-top: 8px;
  display: flex;
  gap: 8px;
}
.btn {
  border: none;
  padding: 8px 12px;
  border-radius: 8px;
  cursor: pointer;
  font-weight: 600;
}
.btn.primary { background: #4f46e5; color: #fff; }
.btn.neutral { background: #111827; color: #cbd5e1; border: 1px solid #111827; }
.btn.disabled { background: #1f2937; color: #94a3b8; cursor: default; }
.btn.accept { background: #16a34a; color: #fff; }
.btn.decline { background: #dc2626; color: #fff; }
.btn.amber { background: #b45309; color: #fff; }

/* results */
/* 取消滚动条、让高度随内容自适应，显示当前页所有好友与分页按钮 */
.results { margin-top: 12px; max-height: none; overflow: visible; }

/* 包裹当前页的 wrapper（transition key = page） */
.page-wrapper { width: 100%; }

/* 页面列表（每页三条） */
.page-list { list-style:none; margin:0; padding:0; display:flex; flex-direction:column; gap:8px; }

.result-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background: #0b1220;
  border: 1px solid #111827;
  padding: 10px;
  border-radius: 8px;
}
.left { display: flex; gap: 12px; align-items: center; min-width: 0; }
.avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: linear-gradient(135deg,#6366f1,#7c3aed);
  display:flex;
  align-items:center;
  justify-content:center;
  font-weight:700;
  color:#fff;
  flex-shrink: 0;
}
.meta .name { font-weight:700; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 180px; }
.meta .id { font-size:12px; color:#9ca3af; margin-top:2px; }
.meta .membership-note { font-size:12px; color:#fde68a; margin-top:4px; }

.right { display:flex; gap:8px; align-items:center; }
.muted { color:#9ca3af; font-size:13px; margin-top:6px; }
.small { font-size:12px; color:#9ca3af; }

/* pagination styles */
.pager {
  display:flex;
  gap:8px;
  align-items:center;
  justify-content:center;
  margin-top: 8px;
}
.pg-btn {
  padding:6px 10px;
  border-radius:6px;
  border: 1px solid #1f2937;
  background:#111827;
  color:#cbd5e1;
  cursor: pointer;
}
.pg-btn:disabled {
  opacity:0.5;
  cursor:not-allowed;
}
.pg-number {
  padding:6px 8px;
  border-radius:6px;
  border: 1px solid transparent;
  background: transparent;
  color:#cbd5e1;
  cursor:pointer;
}
.pg-number.active {
  background: #374151;
  border-color: #4f46e5;
  color: #fff;
}

/* ---------------------
   TRANSITION 动画：左右滑动
   使用 .slide-left-xxxx 表示“向左翻页（next）”：
   - leave (旧页) 向左移动并淡出
   - enter (新页) 从右侧移动进来并淡入
   使用 .slide-right-xxxx 表示“向右翻页（prev）”：
   - leave (旧页) 向右移动并淡出
   - enter (新页) 从左侧移动进来并淡入
   mode="out-in" 保证离场先完成
   --------------------- */

/* next: slide-left */
.slide-left-enter-active,
.slide-left-leave-active {
  transition: transform 420ms cubic-bezier(.2,.9,.2,1), opacity 320ms ease;
}
.slide-left-leave-to {
  transform: translateX(-30%);
  opacity: 0;
}
.slide-left-enter {
  transform: translateX(30%);
  opacity: 0;
}
.slide-left-enter-to {
  transform: translateX(0%);
  opacity: 1;
}

/* prev: slide-right */
.slide-right-enter-active,
.slide-right-leave-active {
  transition: transform 420ms cubic-bezier(.2,.9,.2,1), opacity 320ms ease;
}
.slide-right-leave-to {
  transform: translateX(30%);
  opacity: 0;
}
.slide-right-enter {
  transform: translateX(-30%);
  opacity: 0;
}
.slide-right-enter-to {
  transform: translateX(0%);
  opacity: 1;
}

/* small screens adjust distance */
@media (max-width: 640px) {
  .slide-left-enter,
  .slide-left-leave-to,
  .slide-right-enter,
  .slide-right-leave-to {
    transform: translateX(20%);
  }
}
</style>