<template>
  <div class="cd-root" ref="root">
    <button class="cd-toggle" @click.stop="toggle" :aria-expanded="open" type="button">
      <span class="cd-label">{{ currentLabel }}</span>
      <svg class="cd-chevron" viewBox="0 0 20 20" width="14" height="14" aria-hidden>
        <path d="M5 7l5 5 5-5" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/>
      </svg>
    </button>

    <ul v-show="open" class="cd-menu" role="listbox">
      <li
        v-for="opt in options"
        :key="String(opt[valueKey])"
        class="cd-item"
        role="option"
        :aria-selected="isSelected(opt)"
        @click.stop="select(opt)"
      >
        <span class="cd-item-label">{{ opt[labelKey] }}</span>
      </li>
    </ul>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted, watch } from 'vue'

/**
 * Props:
 * - modelValue: current selected value (valueKey)
 * - options: [{ value, label }, ...] or any objects
 * - labelKey: property name to use as label (default 'label')
 * - valueKey: property name to use as value (default 'value')
 * - placeholder: fallback string when no selection
 */
const props = defineProps({
  modelValue: { required: false },
  options: { type: Array, default: () => [] },
  labelKey: { type: String, default: 'label' },
  valueKey: { type: String, default: 'value' },
  placeholder: { type: String, default: '请选择' },
})
const emit = defineEmits(['update:modelValue', 'change'])

// internal state
const open = ref(false)
const root = ref(null)

function toggle() {
  open.value = !open.value
}
function close() {
  open.value = false
}

function select(opt) {
  const val = opt[props.valueKey]
  emit('update:modelValue', val)
  emit('change', val)
  close()
}

function isSelected(opt) {
  return props.modelValue === opt[props.valueKey]
}

const currentLabel = computed(() => {
  const found = props.options.find(o => o[props.valueKey] === props.modelValue)
  if (found) return found[props.labelKey]
  return props.placeholder
})

// click outside to close
function onDocClick(e) {
  if (!root.value) return
  if (!root.value.contains(e.target)) {
    close()
  }
}

onMounted(() => {
  document.addEventListener('click', onDocClick)
})
onUnmounted(() => {
  document.removeEventListener('click', onDocClick)
})

// close when options change but current invalid
watch(() => props.options, (newOpts) => {
  const valid = newOpts.some(o => o[props.valueKey] === props.modelValue)
  if (!valid) {
    // keep modelValue, but label will show placeholder
  }
}, { deep: true })
</script>

<style scoped>
.cd-root { position: relative; display: inline-block;}
.cd-toggle {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  padding: 8px 12px;
  border-radius: 9999px;
  border: 1px solid rgba(255,255,255,0.06);
  background: rgba(255,255,255,0.02);
  color: #fff;
  cursor: pointer;
  font-weight: 700;
  min-width: 110px;
  justify-content: space-between;
}
.cd-label { font-size: 14px; white-space: nowrap; text-overflow: ellipsis; overflow: hidden; }
.cd-chevron { opacity: 0.9; transform: translateY(1px); }

.cd-menu {
  position: absolute;
  right: 0;
  top: calc(100% + 8px);
  min-width: 160px;
  background: rgba(10,10,10,0.98);
  border: 1px solid rgba(255,255,255,0.06);
  border-radius: 10px;
  padding: 8px;
  z-index: 60;
  box-shadow: 0 8px 30px rgba(0,0,0,0.6);
}
.cd-item {
  padding: 8px 10px;
  font-weight: 700;
  color: #e6eef8;
  cursor: pointer;
  border-radius: 8px;
  display: block;
}
.cd-item + .cd-item { margin-top: 6px; }
.cd-item:hover { background: rgba(255,255,255,0.03); }
</style>