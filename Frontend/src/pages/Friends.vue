<template>
  <div class="friends-root">
    <div class="container">
      <header class="header">
        <div>
          <h1 class="title">好友系统</h1>
          <div class="subtitle">管理好友与请求</div>
        </div>
        <div class="user-info">当前用户 ID: <span class="user-id">{{ meId || '未登录' }}</span></div>
      </header>

      <!-- 布局：第一行两列（apply + requests），第二行跨两列（myfriends） -->
      <div class="grid">
        <div class="col">
          <ApplyFriend />
        </div>

        <div class="col">
          <CheckFriend />
        </div>

        <div class="full">
          <MyFriends />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import ApplyFriend from './Friends/ApplyFriends.vue';
import CheckFriend from './Friends/CheckFriends.vue';
import MyFriends from './Friends/MyFriends.vue';
import axios from 'axios';

export default {
  name: 'Friends',
  components: { ApplyFriend, CheckFriend, MyFriends },
  data() {
    return {
      meId: null
    };
  },
  async mounted() {
    // 入口只负责加载当前用户 id 显示
    try {
      const res = await axios.get('/api/user/me');
      if (res && res.data) this.meId = res.data.id;
    } catch (e) {
      // 忽略错误（子组件各自处理自己的请求）
      this.meId = null;
    }
  }
};
</script>

<style scoped>
.friends-root {
  background: #000; /* 黑色底 */
  color: #fff;
  min-height: 100vh;
  padding: 24px;
  box-sizing: border-box;
  font-family: Inter, ui-sans-serif, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial;
}

.container {
  max-width: 1200px;
  margin-left: auto;
  margin-right: auto;
}
/* 
@media (max-width: 1000px) {
  .container {
    margin-left: 5%;
    margin-right: 5%;
  }
} */

/* header */
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}
.title {
  font-size: 20px;
  font-weight: 800;
  margin: 0;
}
.subtitle {
  font-size: 13px;
  color: #9ca3af; /* slate-400 like */
}
.user-info {
  font-size: 13px;
  color: #9ca3af;
}
.user-id {
  color: #fff;
  font-weight: 600;
}

/* grid layout */
.grid {
  display: grid;
  grid-template-columns: 1fr;
  grid-row-gap: 30px;
  grid-column-gap: 30px;
}

/* at medium and above: two columns top row, second row spans both */
@media (min-width: 768px) {
  .grid {
    grid-template-columns: 1fr 1fr;
    grid-auto-rows: auto;
  }
  .full {
    grid-column: 1 / -1;
  }
}

</style>