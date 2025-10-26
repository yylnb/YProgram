<template>
  <header class="hero">
    <!-- 左上：返回地图（fixed）-->
    <button
      class="back-map action-btn"
      @click="handleBackMapClick"
      :disabled="navigatingToMap"
      aria-label="返回地图"
    >
      ← 返回地图
    </button>

    <!-- header + progress -->
    <section class="header">
      <div class="title-wrap">
        <!-- 标题居中 -->
        <div class="title-center">
          <h1 class="unit-title">{{ unitData.title }}</h1>
          <p class="unit-sub lang-label">
            语言：<span style="text-transform: capitalize">{{ selectedLangLabel }}</span>
          </p>
        </div>

        <!-- Energy 放右上角 -->
        <div class="energy-block" aria-hidden="false">
          <!-- 未登录 -->
          <div v-if="!token" class="energy-guest">
            <div class="battery battery-disabled" aria-hidden="true">
              <div class="battery-level" :style="{ width: '100%' }"></div>
              <div class="battery-cap"></div>
            </div>
            <div class="energy-text">请登录以启用能量机制</div>
          </div>

          <!-- 已登录 -->
          <div v-else class="energy-user" title="能量状态" role="group" aria-label="能量信息">
            <div
              class="battery"
              :class="{
                vip: isVip,
                low: !isVip && energyData.energy !== null && energyData.maxEnergy !== null && energyData.maxEnergy > 0 && batteryPercent <= 15
              }"
              role="img"
              aria-label="能量电池"
            >
              <div
                class="battery-level"
                :style="{ width: isVip ? '100%' : (batteryPercent + '%') }"
              ></div>
              <div class="battery-cap"></div>
            </div>

            <div class="energy-meta">
              <div class="energy-numbers">
                <template v-if="isVip">
                  <span class="energy-current">∞</span>
                </template>
                <template v-else>
                  <span class="energy-current">⚡{{ energyData.energy ?? '-' }}</span>
                  <span class="energy-slash">/</span>
                  <span class="energy-max">{{ energyData.maxEnergy ?? '-' }}</span>
                </template>
              </div>

              <div v-if="!isVip" class="energy-subsmall">
                <div v-if="timeToFullSeconds !== null">剩余时间：<strong>{{ formatDuration(timeToFullSeconds) }}</strong></div>
                <div v-else-if="entryLoading">同步中…</div>
                <div v-else>—</div>
              </div>
            </div>
          </div>
        </div>
        <!-- end energy-block -->
      </div>

      <div class="progress-wrap">
        <div
          class="progress-bar-outer"
          role="progressbar"
          :aria-valuenow="progressPercent"
          aria-valuemin="0"
          aria-valuemax="100"
        >
          <div
            class="progress-bar-inner"
            :style="{ width: progressPercent + '%' }"
          ></div>
        </div>
      </div>

      <!-- entry error / info -->
      <div v-if="entryError" class="hint-box" style="margin-top: 10px;">
        {{ entryError }}
      </div>

      <!-- blocking overlay while checking/deducting entry energy -->
      <div v-if="entryLoading" class="loading-box">
        <div>正在检查学习进度与能量…</div>
      </div>

      <!-- 如果后端没有题目或加载失败显示提示 -->
      <div v-if="noServerData && !entryLoading" class="hint-box" style="margin-top: 10px;">
        注意：当前题目来自本地示例，若要收藏或同步进度，请先将题库导入后端数据库或确认后端服务可用。
      </div>
    </section>
  </header>
</template>

<script setup>
import { ref, reactive, computed, watch, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import axios from 'axios';

/**
 * Props (由父组件传入)
 * - unitData: 单元信息（包含 title）
 * - selectedLangLabel: 当前语言标签显示
 * - token: 如果无 token 则视为未登录（你项目可能使用 cookie 认证；若是 token header，请传入）
 * - progressPercent: 进度条百分比（0-100）
 */
const props = defineProps({
  unitData: { type: Object, default: () => ({ title: '学习单元' }) },
  selectedLangLabel: { type: String, default: 'Python' },
  token: { type: String, default: '' },
  progressPercent: { type: Number, default: 0 }
});

const router = useRouter();

// 状态
const navigatingToMap = ref(false);
const entryLoading = ref(false);
const entryError = ref('');
const noServerData = ref(false);

// membership / energy state
const isVip = ref(false);
const energyData = reactive({
  energy: null,
  maxEnergy: null
});
const timeToFullSeconds = ref(null);

// 当 token 改变时触发数据刷新（父组件可传 token）
watch(() => props.token, (v) => {
  if (v) fetchMembershipAndEnergy();
});

// 组件挂载时尝试获取（若父组件已传 token）
onMounted(() => {
  if (props.token) {
    fetchMembershipAndEnergy();
  } else {
    // 如果不传 token，我们仍尝试调用接口（如果后端用 cookie 认证则可能成功）
    fetchMembershipAndEnergy();
  }
});

// 跳转到 /map
async function handleBackMapClick() {
  try {
    navigatingToMap.value = true;
    await router.push('/map');
  } catch (e) {
    console.error('navigate to /map failed', e);
  } finally {
    navigatingToMap.value = false;
  }
}

// 主要：并行获取 membership 与 energy（membership 用来判断是否 VIP）
async function fetchMembershipAndEnergy() {
  entryLoading.value = true;
  entryError.value = '';
  noServerData.value = false;

  try {
    // 并行请求 membership 和 energy
    const [mRes, eRes] = await Promise.allSettled([
      axios.get('/api/user/membership'),
      axios.get('/api/user/energy')
    ]);

    // 处理 membership
    if (mRes.status === 'fulfilled') {
      // response data may be {} (not VIP) or {start_at, end_at, source}
      const mData = mRes.value?.data ?? {};
      if (mData && Object.keys(mData).length > 0 && mData.end_at) {
        // 判断结束时间是否在未来
        try {
          const now = new Date();
          const endAt = new Date(mData.end_at);
          isVip.value = endAt > now;
        } catch (err) {
          // 无法解析时间则把它视为非会员（保守）
          console.warn('membership parse error', err);
          isVip.value = false;
        }
      } else {
        isVip.value = false;
      }
    } else {
      // membership 请求失败：非致命，记录日志
      console.warn('membership request failed', mRes.reason);
      isVip.value = false;
    }

    // 处理 energy
    if (eRes.status === 'fulfilled') {
      const payload = eRes.value?.data ?? null;
      if (!payload || Object.keys(payload).length === 0) {
        // no data
        noServerData.value = true;
      } else {
        // 兼容不同字段命名
        const energy = payload.energy ?? payload.current ?? payload.value ?? null;
        const maxEnergy = payload.maxEnergy ?? payload.max ?? payload.capacity ?? null;
        const nextFull = payload.timeToFullSeconds ?? payload.nextFullSeconds ?? payload.next_full_seconds ?? null;
        // 更新 reactive
        energyData.energy = (energy === undefined) ? null : energy;
        energyData.maxEnergy = (maxEnergy === undefined) ? null : maxEnergy;
        timeToFullSeconds.value = nextFull === undefined ? null : nextFull;
      }
    } else {
      console.warn('energy request failed', eRes.reason);
      // 标记为无后端题库数据（以便提醒用户）
      noServerData.value = true;
      entryError.value = '无法从服务器获取能量数据，请检查后端服务。';
    }

    // 如果是 VIP，把能量视作无限
    if (isVip.value) {
      energyData.energy = Infinity;
      // keep maxEnergy maybe null or Infinity
      energyData.maxEnergy = Infinity;
      timeToFullSeconds.value = null;
    }
  } catch (err) {
    console.error('fetchMembershipAndEnergy error', err);
    entryError.value = '获取能量信息失败';
    noServerData.value = true;
  } finally {
    entryLoading.value = false;
  }
}

// 计算电池百分比（0 - 100）
const batteryPercent = computed(() => {
  if (isVip.value) return 100;
  const cur = Number(energyData.energy);
  const max = Number(energyData.maxEnergy);
  if (!isFinite(cur) || !isFinite(max) || max <= 0) return 0;
  return Math.max(0, Math.min(100, Math.round((cur / max) * 100)));
});

// 格式化时间（秒 -> mm分ss秒）
function formatDuration(seconds) {
  if (seconds == null || seconds === undefined) return '--';
  const s = Number(seconds);
  if (Number.isNaN(s)) return '--';
  const m = Math.floor(s / 60);
  const sec = Math.floor(s % 60);
  if (m > 60) {
    const h = Math.floor(m / 60);
    const mm = m % 60;
    return `${h}小时${mm}分`;
  }
  return `${m}分${String(sec).padStart(2, '0')}秒`;
}
</script>

<style scoped>
.hero {
  background: #000;
  color: #fff;
  padding: 20px 30px;
  position: relative;
  overflow: hidden;
  box-shadow: 0 2px 10px rgba(255, 255, 255, 0.03);
}

/* 返回地图按钮（固定在左上） */
.back-map {
  position: fixed;
  top: 16px;
  left: 20px;
  padding: 6px 14px;
  font-size: 15px;
  background: transparent;
  border: 1px solid rgba(255,255,255,0.12);
  border-radius: 8px;
  color: #fff;
  cursor: pointer;
  transition: all 0.15s ease;
  z-index: 60;
}
.back-map:hover:not(:disabled) {
  background: rgba(255,255,255,0.06);
}
.back-map:disabled {
  opacity: 0.45;
  cursor: not-allowed;
}

/* header 布局 */
.header {
  margin-top: 40px;
}
.title-wrap {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: 12px;
  flex-wrap: wrap;
}
.title-center {
  text-align: center;
  flex: 1;
}
.unit-title {
  font-size: 26px;
  margin: 0;
  font-weight: 700;
  letter-spacing: -0.02em;
}
.lang-label {
  font-size: 14px;
  opacity: 0.85;
}

/* 能量区块 */
.energy-block {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 6px;
}

/* 电池样式 */
.battery {
  width: 46px;
  height: 18px;
  border: 2px solid rgba(255,255,255,0.16);
  border-radius: 4px;
  position: relative;
  margin-bottom: 4px;
  overflow: hidden;
  background: rgba(255,255,255,0.02);
}
.battery-cap {
  position: absolute;
  right: -5px;
  top: 4px;
  width: 4px;
  height: 8px;
  background: rgba(255,255,255,0.16);
  border-radius: 1px;
  transform: translateZ(0);
}
.battery-level {
  height: 100%;
  transition: width 0.3s ease;
  /* 默认绿色渐变 */
  background: linear-gradient(90deg, #00c853, #64dd17);
}

/* 低电量样式 */
.battery.low .battery-level {
  background: linear-gradient(90deg, #ff5252, #ff1744);
}

/* VIP（金色）样式 */
.battery.vip {
  border-color: rgba(255, 215, 64, 0.9);
  background: rgba(255, 215, 64, 0.05);
}
.battery.vip .battery-level {
  background: linear-gradient(90deg, #ffcf33, #ffd166);
}

/* Battery disabled for guest */
.battery-disabled {
  border-color: rgba(255,255,255,0.06);
}
.battery-disabled .battery-level {
  background: rgba(255,255,255,0.03);
}

/* energy 文本 */
.energy-text {
  font-size: 13px;
  opacity: 0.85;
}
.energy-numbers {
  font-size: 15px;
  font-weight: 600;
}
.energy-subsmall {
  font-size: 12px;
  opacity: 0.75;
}

/* 进度条 */
.progress-wrap {
  margin-top: 16px;
}
.progress-bar-outer {
  width: 100%;
  height: 10px;
  background: rgba(255,255,255,0.06);
  border-radius: 6px;
  overflow: hidden;
}
.progress-bar-inner {
  height: 100%;
  background: linear-gradient(90deg, #0e78e9, #ed3aed);
  transition: width 0.35s;
}

/* 提示/加载框 */
.hint-box {
  background: rgba(255, 255, 255, 0.06);
  padding: 10px;
  border-radius: 8px;
  font-size: 14px;
  color: #ffe58f;
  margin-top: 8px;
}
.loading-box {
  margin-top: 10px;
  padding: 10px;
  border-radius: 10px;
  background: rgba(255,255,255,0.95);
  display: flex;
  align-items: center;
  gap: 10px;
  color: #000;
}

/* 响应式 */
@media (max-width: 640px) {
  .title-wrap {
    flex-direction: column;
    align-items: center;
    gap: 12px;
  }
  .energy-block {
    align-items: center;
  }
  .back-map { left: 10px; top: 10px; padding: 6px 10px; }
}
</style>