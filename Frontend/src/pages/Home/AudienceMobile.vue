<template>
  <section class="audience-cards" aria-label="受众群体">
    <div class="container">
      <h2 class="heading">适配不同场景与年龄</h2>
      <p class="sub">为学生、职场人与孩子提供定制化的编程学习</p>

      <div class="grid">
        <div
        v-for="(a, idx) in audiences"
        :key="idx"
        class="card"
        >
        <!-- 背景图片 -->
        <img
            :src="a.src"
            :alt="a.title + ' 背景图'"
            class="card-image"
            loading="lazy"
        />

        <!-- 渐变遮罩（上清晰，下变暗） -->
        <div class="card-overlay"></div> 

        <!-- 文本内容 -->
        <div class="card-content">
            <h3 class="card-title">{{ a.title }}</h3>
            <p class="card-sub">{{ a.sub }}</p>
            <a class="card-btn" :href="a.link">去体验</a>
        </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref } from 'vue'

const audiences = ref([
  {
    title: '🎓学生',
    sub: '别出心裁的刷题方式，帮你稳拿高分。',
    src: '/student-800.jpg',
    link: '/map'
  },
  { 
    title: '🔎求职者',
    sub: '帮助你从投简历到拿 Offer 更自信。',
    src: '/jobhunter-800.jpg',
    link: '/map'
  },
  {
    title: '💼就业者',
    sub: '尝试使用编程工具，帮助你创新性提高效率。',
    src: '/worker-800.jpg',
    link: '/map'
  },
  {
    title: '🧸幼儿',
    sub: '有趣的可视化编程与交互，让孩子在游戏中学会逻辑与创造。',
    src: '/children-800.jpg',
    link: '/map'
  }
])
</script>

<style scoped>
/* ===== 页面背景 ===== */
.audience-cards {
  padding: 48px 0px;
  background: #000;
  color: #fff;
}

.container {
  max-width: 1100px;
  margin: 0 auto;
  text-align: center;
}

.heading {
  font-size: 1.75rem;
  font-weight: 700;
  margin-bottom: 6px;
}

.sub {
  color: rgba(255,255,255,0.75);
  margin-bottom: 24px;
}

/* ===== 列表布局 ===== */
.grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 20px;
}

/* ===== 单张卡片 ===== */
.card {
  position: relative;
  height: 360px;    
  width: 100%;
  /* border-radius: 16px; */
  overflow: hidden;
  background: #000;
  box-shadow: 0 20px 60px rgba(0,0,0,0.55);
}

/* 背景图 */
.card-image {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
}

/*
  渐变遮罩说明：
  - 0% ~ 30%：完全透明（图片清晰）
  - 30% ~ 65%：开始变暗
  - 100%：几乎全黑
*/
.card-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(
    to bottom,
    rgba(0,0,0,0) 0%,
    rgba(0,0,0,0) 20%,
    rgba(25, 25, 25, 0.734) 65%,
    rgb(0, 0, 0) 100%
  );
}

/* 文本区域 */
.card-content {
  position: absolute;
  left: 0;
  right: 0;
  bottom: 0;
  padding: 22px 18px;
  display: flex;
  flex-direction: column;
  gap: 10px;
  text-align: center;
}

/* 主标题 */
.card-title {
  margin: 0;
  font-size: 1.6rem;
  font-weight: 900;
  color: #fff;
}

/* 副标题 */
.card-sub {
  margin: 0;
  font-size: 0.95rem;
  color: rgba(200, 200, 200, 0.707);
}

/* 大按钮（参考图风格） */
.card-btn {
  margin: 10px 20px 0 20px; 
  width: 300px;
  align-self: center;
  padding: 10px 22px;
  border-radius: 999px;
  background: #a3ff12;
  color: #000;
  font-weight: 800;
  text-decoration: none;
  font-size: 0.95rem;
  transition: transform .15s, box-shadow .15s;
}

.card-btn:active {
  transform: scale(0.97);
}

.card-btn:hover {
  box-shadow: 0 10px 30px rgba(163,255,18,0.35);
}
</style>