<template>
  <header class="hero">
    <button
      class="back-map action-btn"
      @click="handleBackMapClick"
      :disabled="navigatingToMap"
      aria-label="返回地图"
    >
      ← 返回地图
    </button>

    <section class="header">
      <div class="title-wrap">
        <div class="title-center">
          <h1 class="unit-title">{{ displayTitle }}</h1>
          <p class="unit-sub lang-label">
            语言：<span style="text-transform: capitalize">{{ selectedLangLabel }}</span>
          </p>
        </div>

        <div class="energy-block" aria-hidden="false">
          <div v-if="!loggedIn" class="energy-guest">
            <div class="battery battery-disabled" aria-hidden="true">
              <div class="battery-level" :style="{ width: '100%' }"></div>
              <div class="battery-cap"></div>
            </div>
            <div class="energy-text">请登录以启用能量机制</div>
          </div>

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
      </div>

      <div class="progress-wrap">
        <div
          class="progress-bar-outer"
          role="progressbar"
          :aria-valuenow="computedProgressPercent"
          aria-valuemin="0"
          aria-valuemax="100"
        >
          <div
            class="progress-bar-inner"
            :style="{ width: computedProgressPercent + '%' }"
          ></div>
        </div>

        <div class="progress-meta" style="margin-top:8px; text-align:center; font-size:13px; opacity:0.92;">
          <template v-if="progressData">
            <span v-if="progressData.completed">已完成：{{ totalQuestions }} / {{ totalQuestions }}</span>
            <span v-else>已学习：{{ safeCurrentIndex }} / {{ totalQuestions }} （{{ computedProgressPercent }}%）</span>
          </template>
          <template v-else>
            <span>进度：{{ computedProgressPercent }}%</span>
          </template>
        </div>
      </div>

      <div v-if="entryError" class="hint-box" style="margin-top: 10px;">
        {{ entryError }}
      </div>

      <div v-if="entryLoading" class="loading-box">
        <div>正在检查学习进度与能量…</div>
      </div>

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

const props = defineProps({
  // unitData.title 示例： "python1 · 单元 3"（但这次不会被用来编辑，只用于解析 key 作为后备）
  unitData: { type: Object, default: () => ({ title: '学习单元' }) },
  // 新增：如果父组件能直接传入 courseFull（例如 "python1"），Hero 优先使用它进行映射
  courseFull: { type: String, default: '' },
  selectedLangLabel: { type: String, default: 'Python' },
  token: { type: String, default: '' },          // 可由父组件传入（若使用 token 认证）
  progressPercent: { type: Number, default: 0 }, // 后备值
  progressData: { type: [Object, null], default: null } // 后端返回的进度对象（StudyNew 已传）
});

const router = useRouter();
const navigatingToMap = ref(false);
const entryLoading = ref(false);
const entryError = ref('');
const noServerData = ref(false);

// membership / energy state
const isVip = ref(false);
const energyData = reactive({ energy: null, maxEnergy: null });
const timeToFullSeconds = ref(null);

// loggedIn 判断：如果有 token 或服务器返回有效 energy，则认为登录
const loggedIn = ref(Boolean(props.token));

watch(() => props.token, (v) => {
  loggedIn.value = Boolean(v);
  fetchMembershipAndEnergy();
});

onMounted(() => {
  fetchMembershipAndEnergy();
});

// ------------------ 固定的课程显示名映射（在代码中手动维护） ------------------
// 在此对象中直接修改/添加课程映射，例如： python1 -> 'Python入门'
const COURSE_DISPLAY_MAP = {
  python1: 'Python入门',
  python2: 'Python进阶',
  cpp1: 'C++入门',
  cpp2: 'c++进阶',
  c1: 'C语言入门',
  c2: 'C语言进阶',
  // 若需更多课程，请在这里扩展，例如：
  // js1: 'JavaScript入门',
  // java1: 'Java基础'
};

// ------------------ 解析 courseKey（优先使用 props.courseFull，其次从 unitData.title 提取） ----------
function parseCourseKeyFromTitle(title) {
  if (!title || typeof title !== 'string') return null;
  // 尝试提取开头的连续字母数字下划线部分，例如 python1 python_advanced1
  const m = title.match(/^[\s]*([A-Za-z_]+\d*)/i);
  if (m) return m[1];
  const m2 = title.match(/([A-Za-z_]+\d*)/i);
  return m2 ? m2[1] : null;
}

const currentCourseKey = computed(() => {
  if (props.courseFull && typeof props.courseFull === 'string' && props.courseFull.trim()) {
    return props.courseFull.trim();
  }
  return parseCourseKeyFromTitle(props.unitData?.title || '') || '';
});

// computed displayTitle: 用映射替换 course key（若找不到映射则保留原始标题）
const displayTitle = computed(() => {
  const raw = props.unitData?.title ?? '学习单元';
  const key = currentCourseKey.value;
  if (!key) return raw;
  const mapped = COURSE_DISPLAY_MAP[key];
  if (!mapped) return raw;
  return raw.replace(new RegExp(key, 'i'), mapped);
});

// ------------------ 进度计算（固定总题数 15） ------------------
const totalQuestions = 15;

const safeCurrentIndex = computed(() => {
  const p = props.progressData || null;
  if (!p) return 0;
  const ci = p.current_index ?? p.currentIndex ?? 0;
  const n = Number(ci);
  if (Number.isNaN(n) || n < 0) return 0;
  return Math.min(totalQuestions, Math.max(0, Math.round(n)));
});

const computedProgressPercent = computed(() => {
  const p = props.progressData || null;
  if (!p) {
    return Math.max(0, Math.min(100, Math.round(props.progressPercent || 0)));
  }
  if (p.completed) return 100;
  const percent = Math.floor((safeCurrentIndex.value / totalQuestions) * 100);
  if (safeCurrentIndex.value >= totalQuestions && !p.completed) return 99;
  return Math.max(0, Math.min(99, percent));
});

// ------------------ 原有的能量 / membership 逻辑（保持不变） ------------------
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

/**
 * fetchMembershipAndEnergy
 * - 优先使用 props.token（若传入则放到 Authorization header）
 * - 同时使用 withCredentials: true（以支持 cookie/session 认证）
 * - 使用 Promise.allSettled 处理两个接口，记录错误细节到 console
 */
async function fetchMembershipAndEnergy() {
  entryLoading.value = true;
  entryError.value = '';
  noServerData.value = false;

  const headers = {};
  if (props.token) {
    headers['Authorization'] = `Bearer ${props.token}`;
  }
  const axiosConfig = { headers, withCredentials: true, timeout: 8000 };

  try {
    const [mRes, eRes] = await Promise.allSettled([
      axios.get('/api/user/membership', axiosConfig),
      axios.get('/api/user/energy', axiosConfig)
    ]);

    if (mRes.status === 'fulfilled') {
      const mData = mRes.value?.data ?? {};
      if (mData && Object.keys(mData).length > 0 && mData.end_at) {
        try {
          const now = new Date();
          const endAt = new Date(mData.end_at);
          isVip.value = endAt > now;
        } catch (err) {
          console.warn('membership parse error', err);
          isVip.value = false;
        }
      } else {
        isVip.value = false;
      }
      if (mRes.value && mRes.value.status === 200) loggedIn.value = true;
    } else {
      console.warn('/api/user/membership failed:', mRes.reason);
      if (mRes.reason?.response?.status === 401) {
        entryError.value = '未登录或凭证无效（membership）';
        loggedIn.value = false;
      }
      isVip.value = false;
    }

    if (eRes.status === 'fulfilled') {
      const payload = eRes.value?.data ?? null;
      if (!payload || Object.keys(payload).length === 0) {
        noServerData.value = true;
      } else {
        const energy = payload.energy ?? payload.current ?? payload.value ?? null;
        const maxEnergy = payload.maxEnergy ?? payload.max ?? payload.capacity ?? null;
        const nextFull = payload.timeToFullSeconds ?? payload.nextFullSeconds ?? payload.next_full_seconds ?? null;
        energyData.energy = (energy === undefined) ? null : energy;
        energyData.maxEnergy = (maxEnergy === undefined) ? null : maxEnergy;
        timeToFullSeconds.value = nextFull === undefined ? null : nextFull;
        loggedIn.value = true;
      }
    } else {
      console.warn('/api/user/energy failed:', eRes.reason);
      if (eRes.reason?.response?.status === 401) {
        entryError.value = '未登录或凭证无效（energy）';
        loggedIn.value = false;
      } else {
        entryError.value = '无法获取能量信息（network/server）';
      }
      noServerData.value = true;
    }

    if (isVip.value) {
      energyData.energy = Infinity;
      energyData.maxEnergy = Infinity;
      timeToFullSeconds.value = null;
    }

    if (!loggedIn.value) {
      entryError.value = entryError.value || '未检测到登录凭证；请检查 token 或 Cookie (withCredentials) 设置。';
    }
  } catch (err) {
    console.error('fetchMembershipAndEnergy unexpected error', err);
    entryError.value = '获取能量信息时发生异常';
    noServerData.value = true;
  } finally {
    entryLoading.value = false;
  }
}

// battery percent
const batteryPercent = computed(() => {
  if (isVip.value) return 100;
  const cur = Number(energyData.energy);
  const max = Number(energyData.maxEnergy);
  if (!isFinite(cur) || !isFinite(max) || max <= 0) return 0;
  return Math.max(0, Math.min(100, Math.round((cur / max) * 100)));
});

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
.hero { background: #000; color: #fff; padding: 20px 30px; position: relative; overflow: hidden; }
.back-map { position: fixed; top: 16px; left: 20px; padding: 6px 14px; font-size: 15px; background: transparent; border: 1px solid rgba(255,255,255,0.12); border-radius: 8px; color: #fff; cursor: pointer; transition: all 0.15s ease; z-index:60; }
.back-map:hover:not(:disabled){ background: rgba(255,255,255,0.06); } .back-map:disabled{ opacity:0.45; cursor:not-allowed; }
.header { margin-top: 40px; }
.title-wrap { display:flex; justify-content:space-between; align-items:flex-start; gap:12px; flex-wrap:wrap; }
.title-center { text-align:center; flex:1; }
.unit-title { font-size:26px; margin:0; font-weight:700; letter-spacing:-0.02em; }
.lang-label { font-size:14px; opacity:0.85; }
.energy-block { display:flex; flex-direction:column; align-items:flex-end; gap:6px; }
.battery { width:46px; height:18px; border:2px solid rgba(255,255,255,0.16); border-radius:4px; position:relative; margin-bottom:4px; overflow:hidden; background: rgba(255,255,255,0.02); }
.battery-cap { position:absolute; right:-5px; top:4px; width:4px; height:8px; background:rgba(255,255,255,0.16); border-radius:1px; transform:translateZ(0); }
.battery-level { height:100%; transition:width .3s ease; background: linear-gradient(90deg,#00c853,#64dd17); }
.battery.low .battery-level { background: linear-gradient(90deg,#ff5252,#ff1744); }
.battery.vip { border-color: rgba(255,215,64,0.9); background: rgba(255,215,64,0.05); }
.battery.vip .battery-level { background: linear-gradient(90deg,#ffcf33,#ffd166); }
.battery-disabled { border-color: rgba(255,255,255,0.06); }
.battery-disabled .battery-level { background: rgba(255,255,255,0.03); }
.energy-text { font-size:13px; opacity:0.85; }
.energy-numbers { font-size:15px; font-weight:600; }
.energy-subsmall { font-size:12px; opacity:0.75; }
.progress-wrap { margin-top:16px; }
.progress-bar-outer { width:100%; height:10px; background: rgba(255,255,255,0.06); border-radius:6px; overflow:hidden; }
.progress-bar-inner { height:100%; background: linear-gradient(90deg,#0e78e9,#ed3aed); transition: width .35s; }
.hint-box { background: rgba(255,255,255,0.06); padding:10px; border-radius:8px; font-size:14px; color:#ffe58f; margin-top:8px; }
.loading-box { margin-top:10px; padding:10px; border-radius:10px; background: rgba(255,255,255,0.95); display:flex; align-items:center; gap:10px; color:#000; }
.progress-meta { color: rgba(255,255,255,0.9); }
@media (max-width:640px){ .title-wrap{ flex-direction:column; align-items:center; gap:12px } .energy-block{ align-items:center } .back-map{ left:10px; top:10px; padding:6px 10px } }
</style>