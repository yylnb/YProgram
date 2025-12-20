<template>
  <div
    :class="wrapperClass"
    role="button"
    :aria-pressed="isFlipped"
    @click="onRootClick"
  >
    <div :class="innerClass">
      <!-- Front -->
      <div
        class="absolute inset-0 overflow-hidden rounded-2xl border-self [backface-visibility:hidden]"
      >
        <slot />
      </div>

      <!-- Back -->
      <div
        :class="backFaceClass"
        aria-hidden="true"
      >
        <slot name="back" />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, ref, withDefaults } from 'vue';

type Rotate = 'x' | 'y';

interface FlipCardProps {
  rotate?: Rotate;
  flipOnHover?: boolean;
  clickable?: boolean;
  modelValue?: boolean;
  class?: string;
}

/**
 * 关键修复：
 * - 使用 defineProps<FlipCardProps>() 来给 props 类型（TS friendly）
 * - 用 withDefaults(...) 提供默认值
 */
const props = withDefaults(defineProps<FlipCardProps>(), {
  rotate: 'y',
  flipOnHover: true,
  clickable: false,
  class: '',
});

// 明确 emit 类型（v-model）
const emit = defineEmits<{
  (e: 'update:modelValue', value: boolean): void;
}>();

// --- 简单的 cn (可替换为你项目已有的工具) ---
function cn(...parts: Array<string | false | null | undefined>) {
  return parts.filter(Boolean).join(' ');
}

// 控制逻辑（受控 vs 非受控）
const internal = ref<boolean>(false);
const isControlled = computed(() => props.modelValue !== undefined);
const isFlipped = computed<boolean>({
  get() {
    return isControlled.value ? !!props.modelValue : internal.value;
  },
  set(v: boolean) {
    if (isControlled.value) emit('update:modelValue', v);
    else internal.value = v;
  },
});

// Tailwind arbitrary transform classes
const hoverRotateClass = computed(() =>
  props.rotate === 'x' ? 'group-hover:[transform:rotateX(180deg)]' : 'group-hover:[transform:rotateY(180deg)]'
);
const activeRotateClass = computed(() =>
  props.rotate === 'x' ? '[transform:rotateX(180deg)]' : '[transform:rotateY(180deg)]'
);
const backInitTransform = computed(() =>
  props.rotate === 'x' ? '[transform:rotateX(180deg)]' : '[transform:rotateY(180deg)]'
);

// wrapper class（允许通过 props.class 覆盖）
// 默认样式与你给的示例保持一致
const wrapperClass = computed(() => {
  const base = props.class && props.class.trim().length > 0
    ? props.class
    : 'group h-72 w-56 [perspective:1000px]';
  return cn('relative', base);
});

// inner (旋转层)
const innerClass = computed(() => {
  const base = 'relative h-full rounded-2xl transition-all duration-500 [transform-style:preserve-3d]';
  const hover = props.flipOnHover ? hoverRotateClass.value : '';
  const active = isFlipped.value ? activeRotateClass.value : '';
  return cn(base, hover, active);
});

// back face 类
const backFaceClass = computed(() =>
  cn(
    'absolute inset-0 overflow-hidden rounded-2xl border-self bg-black/80 text-slate-200 [backface-visibility:hidden]',
    backInitTransform.value
  )
);

// 点击切换（当 clickable=true 时启用）
function onRootClick() {
  if (!props.clickable) return;
  isFlipped.value = !isFlipped.value;
}
</script>

<style scoped>
:where(.group) { -webkit-tap-highlight-color: transparent; }
.absolute img { display: block; width: 100%; height: 100%; object-fit: cover; }
.border-self { 
  border-style: var(--tw-border-style); 
  border-width: 2px; 
  /* border-bottom-color: #d450d0a4; 
  border-top-color: rgba(27, 124, 228, 0.815);
  border-left-color: rgba(27, 124, 228, 0.815);
  border-right-color: rgba(27, 124, 228, 0.815); */
  border-color: white;
}
@media (min-width: 1200px) {
  .border-self { border: 2px solid #ffffffbf; }
}
</style>