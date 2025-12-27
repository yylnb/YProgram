<template>
  <section class="audience-cards" aria-label="受众群体">
    <div class="container">
      <h2 class="heading">适配不同场景与年龄</h2>
      <p class="sub">为学生、职场人与孩子提供定制化的编程学习路径</p>

      <div class="grid">
        <FlipCard
          v-for="(a, idx) in audiences"
          :key="idx"
          class="group flip-card-wrapper"
          :aria-labelledby="`title-${idx}`"
          :flipOnHover="true"x
          :clickable="true"
        >
          <!-- front: 照片 + 底部居中 emoji + title -->
          <template #default>
            <div class="front-face">
              <div class="front-media" aria-hidden="true">
                <picture>
                  <source :srcset="a.srcset" sizes="800px" />
                  <img
                    :src="a.src"
                    :alt="a.title + ' 背景图'"
                    loading="lazy"
                    class="front-image"
                  />
                </picture>
              </div>

              <!-- bottom overlay: emoji + title（高度更小） -->
              <div class="front-meta" :id="`title-${idx}`">
                <div class="meta-inner">
                  <div class="emoji" aria-hidden="true">{{ a.emoji }}</div>
                  <div class="title">{{ a.title }}</div>
                </div>
              </div>
            </div>
          </template>

          <!-- back: tagline + desc + button -->
          <template #back>
            <div class="back-face">
              <div class="back-content">
                <h3 class="back-tagline">{{ a.tagline }}</h3>
                <p class="back-desc">{{ a.desc }}</p>
                <a :href="a.link" class="btn" :aria-label="`体验 ${a.title}`">去体验</a>
              </div>
            </div>
          </template>
        </FlipCard>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref } from 'vue'
import FlipCard from '../../components/ui/flip-card/FlipCard.vue'

const audiences = ref([
  {
    title: '学生',
    emoji: '🎓',
    tagline: '怎么学都学不会？',
    desc: '海量题库、别出心裁的刷题方式，帮你稳拿高分。',
    src: '/student.jpg',
    srcset: '/student-800.jpg 800w',
    link: '/map'
  },
  {
    title: '求职者',
    emoji: '🔎',
    tagline: '找工作怕技能不够？',
    desc: '帮助你从投简历到拿 Offer 更自信。',
    src: '/jobhunter.jpg',
    srcset: '/jobhunter-800.jpg 800w',
    link: '/map'
  },
  {
    title: '就业者',
    emoji: '💼',
    tagline: '工作中困难无法解决？',
    desc: '尝试使用编程工具，帮助你创新性提高效率。',
    src: '/worker.jpg',
    srcset: '/worker-800.jpg 800w',
    link: '/map'
  },
  // {
  //   title: '长者',
  //   emoji: '🧓',
  //   tagline: '有点跟不上时代？',
  //   desc: '从入门到趣味项目、循序渐进，让你也能与时俱进。',
  //   src: '/elderly.jpg',
  //   srcset: '/elderly-480.jpg 480w, /elderly-800.jpg 800w, /elderly-1200.jpg 1200w',
  //   link: '/map'
  // },
  {
    title: '幼儿',
    emoji: '🧸',
    tagline: '从小培养学习兴趣？',
    desc: '有趣的可视化编程与交互，让孩子在游戏中学会逻辑与创造。',
    src: '/children.jpg',
    srcset: '/children-800.jpg 800w',
    link: '/map'
  },
  // {
  //   title: '教师',
  //   emoji: '👩‍🏫',
  //   tagline: '想要更好的教学工具？',
  //   desc: '丰富的教学资源与课程，助力老师高效备课与授课。',
  //   src: '/teacher.jpg',
  //   srcset: '/children-480.jpg 480w, /children-800.jpg 800w, /children-1200.jpg 1200w',
  //   link: '/map'
  // }
])
</script>

<style scoped>
/* 页面背景：黑色 */
.audience-cards {
  padding: 48px 20px;
  box-sizing: border-box;
  background: #000; /* 页面背景黑色 */
  color: #ffffff; /* 全局字体默认白色 */
}

/* container 居中内容（内容区仍为白色文本） */
.container {
  max-width: 1100px;
  margin: 0 auto;
  text-align: center;
}

/* 标题样式：白色 */
.heading {
  font-size: 1.75rem;
  font-weight: 700;
  margin-bottom: 6px;
  color: #fff;
}
.sub {
  color: rgba(255,255,255,0.75);
  margin-bottom: 20px;
}

/* 网格布局 */
.grid { display: grid; grid-template-columns: 1fr; gap: 18px; }
@media (min-width: 640px) { .grid { grid-template-columns: repeat(2, 1fr); gap: 20px; } }
@media (min-width: 1024px) { 
  .grid { grid-template-columns: repeat(2, 1fr); gap: 24px; } 
  .flip-card-wrapper {
    max-width: 500px;
  }
}

/* 卡片包装器：渐变背景 + 白色字体 */
.flip-card-wrapper {
  width: 100%;
  height: 100%;
  min-height: 280px;
  border-radius: 12px;
  /* 渐变背景（从 #0e78e9 到 #ed3aed） */
  /* background: linear-gradient(180deg, #0e78e9 0%, #ed3aed 100%); */
  background: black;
  box-shadow: 0 12px 36px rgba(0,0,0,0.5);
  display: block;
  color: #ffffff; /* 卡片内文字白色 */
  overflow: hidden;
}

/* 鼠标 hover 时加深阴影（翻转由组件控制） */
.flip-card-wrapper:hover { box-shadow: 0 28px 56px rgba(0,0,0,0.6); }

/* front 面布局 */
.front-face {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  position: relative;
}

/* 图片占上部分（固定高度），图片之上仍可看到卡片渐变作为底色的边缘 */
.front-media { width: 100%; height: 230px; overflow: hidden; background: transparent; }
.front-image { width: 100%; height: 100%; object-fit: cover; display: block; }

/* 底部元数据覆盖：高度更小（更精简） */
.front-meta {
  position: absolute;
  left: 0;
  right: 0;
  bottom: 0;
  padding: 8px 10px; /* 缩小内边距 */
  display: flex;
  justify-content: center;
  align-items: center;
  /* 更轻的半透明叠层，保留卡片渐变色调但更暗以确保白字可读 */
  background: linear-gradient(180deg, rgba(14,120,233,0.0) 0%, rgba(0,0,0,0.35) 100%);
}

/* meta 内部：emoji + title 垂直布局，间距更小 */
.meta-inner {
  display: flex;
  flex-direction: row;
  align-items: center;
  gap: 15px; /* 缩小间距 */
}
.emoji { font-size: 1.5rem; line-height: 1; } 
.title { font-weight: 1000; color: #ffffff; font-size: 1.5rem; }

/* back 面布局：使用同样渐变（更深）并为文本留白 */
.back-face {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: stretch;
  justify-content: center;
  padding: 20px;
  box-sizing: border-box;
  /* 背面也使用渐变，但偏深以区分正面（保持与卡片主色一致） */
  /* background: linear-gradient(180deg, rgba(14,120,233,0.95) 0%, rgba(237,58,237,0.95) 100%); */
  color: #ffffff;
  background:
  radial-gradient(
    circle at top right,
    #4c4c4c,
    transparent 40%
  ),
  radial-gradient(
    circle at bottom left,
    #4c4c4c,
    transparent 40%
  ),
  #232323;
}

.back-content {
  width: 100%;
  max-width: 420px;
  display: flex;
  flex-direction: column;
  gap: 20px;
}
.back-tagline {
  margin: 0;
  font-size: 1.05rem;
  font-weight: 700;
  color: #ffffff;
}
.back-desc {
  margin: 0;
  color: rgba(255,255,255,0.9);
  font-size: 0.95rem;
}

/* 按钮：反白（白色文本在渐变上），并加深阴影以增强可点击感 */
.back-actions { margin-top: 12px; display: flex; justify-content: flex-end; }
.btn {
  display: inline-block;
  padding: 8px 14px;
  border-radius: 999px;
  background: rgba(255,255,255,0.12); /* 轻微半透明白作为按钮背景 */
  color: #ffffff;
  text-decoration: none;
  font-weight: 700;
  border: 1px solid rgba(255,255,255,0.12);
  transition: transform .12s, background .12s, box-shadow .12s;
}
/* === 修改点：当 hover / active / focus-visible 时，使用从 #0e78e9 到 #ed3aed 的渐变填充 === */
.btn:hover,
.btn:active,
.btn:focus-visible {
  transform: translateY(-2px);
  /* 渐变填充（水平渐变） */
  /* background-image: linear-gradient(45deg, #196ac1 0%, #bb38bb 100%);
  background-color: transparent; */
  color: #ffffff;
  border: 1px solid rgba(255,255,255,0.08); /* 轻保留边框，避免突然消失 */
  box-shadow: 0 6px 18px rgba(14,120,233,0.18);
  outline: none;
  background: #6b21a8;
  box-shadow: 0 36px 80px rgba(132, 63, 141, 0.479);
}

/* 响应式：小屏时图片高度减小与卡片高度调整 */
@media (max-width: 639px) {
  .front-media { height: 140px; }
  .flip-card-wrapper { min-height: 240px; }
}

/* 暗色主题兼容（页面已是黑色，保留白字） */
@media (prefers-color-scheme: dark) {
  .audience-cards { background: #000; }
  .heading { color: #fff; }
  .sub { color: rgba(255,255,255,0.75); }
  .title { color: #fff; }
  .back-desc { color: rgba(255,255,255,0.92); }
}
</style>