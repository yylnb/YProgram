<template>
  <div>
    <template v-if="loading">
      加载题目…
    </template>

    <template v-else-if="error">
      <div style="color:var(--danger,#c0392b)">{{ error }}</div>
    </template>

    <template v-else-if="!question">
      <div>题目未找到。</div>
    </template>

    <component
      v-else
      :is="currentComponent"
      :question="question"
      :language="language"
      @answered="forwardAnswered"
    />
  </div>
</template>

<script setup>
import { ref, computed, watch, onMounted } from 'vue';
import axios from 'axios';

// 子组件（Questions 只负责判断并引入）
import Choice from './Choice.vue';
import Fill from './Fill.vue';

// props: questionIndex 为 1-based 序号（你从 Map.vue 进入时可传）
const props = defineProps({
  questionIndex: { type: Number, default: 1 }, // 1..16
  language: { type: String, default: 'py' },   // 'py'|'cpp'|'c'|'java'
  unitId: { type: [String, Number], default: '' },
  token: { type: String, default: '' } // 可选：用于 Authorization header
});

const emit = defineEmits(['select-question', 'answered']);

const loading = ref(false);
const error = ref('');
const question = ref(null);

// API mapping
const CHOICE_API = {
  py: 'http://localhost:5000/api/que_choice_py_1',
  cpp: 'http://localhost:5000/api/que_choice_cpp_1',
  c: 'http://localhost:5000/api/que_choice_c_1',
  java: 'http://localhost:5000/api/que_choice_java_1'
};
const FILL_API = {
  py: 'http://localhost:5000/api/que_fill_py_1',
  cpp: 'http://localhost:5000/api/que_fill_cpp_1',
  c: 'http://localhost:5000/api/que_fill_c_1',
  java: 'http://localhost:5000/api/que_fill_java_1'
};

// 根据题号决定题型：1-3 choice, 4-5 fill, 6-8 choice, 9-10 fill, 11-13 choice, 14-16 fill
function isFillByIndex(idx) {
  if (!idx || typeof idx !== 'number') return false;
  if (idx >= 4 && idx <= 5) return true;
  if (idx >= 9 && idx <= 10) return true;
  if (idx >= 14 && idx <= 16) return true;
  return false;
}

const isFill = computed(() => isFillByIndex(props.questionIndex));
const currentComponent = computed(() => (isFill.value ? Fill : Choice));

// build request config (support token header and cookies)
function buildAxiosConfig() {
  const cfg = { withCredentials: true, timeout: 8000 };
  if (props.token) {
    cfg.headers = { Authorization: `Bearer ${props.token}` };
  }
  return cfg;
}

// fetch only current question from appropriate table
async function fetchCurrentQuestion() {
  loading.value = true;
  error.value = '';
  question.value = null;
  try {
    const lang = (props.language || 'py');
    const api = isFill.value ? (FILL_API[lang] || FILL_API.py) : (CHOICE_API[lang] || CHOICE_API.py);
    const params = {};
    // prefer q_id param (many of your tables use q_id). Also include unitId and index as fallback.
    params.q_id = String(props.questionIndex);
    if (props.unitId) params.unit_id = props.unitId;
    // also include id fallback
    params.id = props.questionIndex;

    const res = await axios.get(api, { params, ...buildAxiosConfig() });
    // assume backend returns object (single record) or array (take first)
    let data = res?.data ?? null;
    if (Array.isArray(data)) data = data[0] ?? null;
    // some backends return { rows: [...] }
    if (!data && res?.data?.rows) data = (res.data.rows[0] ?? null);

    if (!data) {
      error.value = '未找到题目（后端返回空）';
      question.value = null;
      emit('select-question', null);
    } else {
      // normalize minimal fields
      question.value = {
        ...data,
        // ensure we expose type for child components if needed
        type: isFill.value ? 'fill' : 'choice'
      };
      emit('select-question', question.value);
    }
  } catch (err) {
    console.error('Questions.fetchCurrentQuestion error', err);
    // friendly error
    if (err?.response?.status === 401) {
      error.value = '未登录或权限不足（401）';
    } else {
      error.value = '加载题目失败，请检查后端或网络';
    }
    question.value = null;
    emit('select-question', null);
  } finally {
    loading.value = false;
  }
}

// 当 props.questionIndex / language / unitId 改变时重新拉取
watch(() => [props.questionIndex, props.language, props.unitId], () => {
  fetchCurrentQuestion();
}, { immediate: true });

// forward answered event from child up
function forwardAnswered(payload) {
  emit('answered', payload);
}
</script>

<style scoped>
/* 极简样式，交给子组件做具体样式 */
div { font-family: Inter, system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial; }
</style>