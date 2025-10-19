<template>
  <!-- 将 $attrs 绑定到根元素，这样父组件传的 class / style 等会自动合并到这里 -->
  <div
    v-bind="$attrs"
    :class="cn('relative overflow-hidden', props.containerClass)"
    aria-hidden="true"
  >
    <canvas
      id="canvas"
      ref="canvasRef"
      class="absolute inset-0 w-full h-full z-0"
      :style="{ filter: isSafari ? `blur(${props.blur}px)` : undefined }"
    ></canvas>

    <!-- 内部内容容器：使用 contentClass（避免与 Vue class 冲突） -->
    <div :class="cn('relative z-10', props.contentClass)">
      <slot />
    </div>
  </div>
</template>

<script setup>
import { createNoise3D } from "simplex-noise";
import { cn } from "@/lib/utils";
import { ref, onMounted, onBeforeUnmount } from "vue";
import { templateRef } from "@vueuse/core";

const props = defineProps({
  // 不再使用名为 `class` 的 prop，避免与 Vue 的 class attrs 冲突
  contentClass: { type: String, required: false },
  containerClass: { type: String, required: false },
  colors: {
    type: Array,
    required: false,
    default: () => ["#38bdf8", "#818cf8", "#c084fc", "#e879f9", "#22d3ee"],
  },
  waveWidth: { type: Number, required: false, default: 50 },
  backgroundFill: { type: String, required: false, default: "black" },
  blur: { type: Number, required: false, default: 10 },
  speed: { type: String, required: false, default: "fast" },
  waveOpacity: { type: Number, required: false, default: 0.5 },
});

const noise = createNoise3D();

// canvas / render state
let w = 0,
  h = 0,
  nt = 0,
  ctx = null;
let animationId = null;
const canvasRef = templateRef("canvasRef");

function getSpeed() {
  return props.speed === "slow" ? 0.001 : 0.002;
}

function updateSize() {
  const canvas = canvasRef.value;
  if (!canvas || !canvas.parentElement || !ctx) return;
  const parent = canvas.parentElement;
  // set actual pixel size considering devicePixelRatio for sharper lines
  const dpr = window.devicePixelRatio || 1;
  const pw = Math.max(320, Math.round(parent.clientWidth));
  const ph = Math.max(240, Math.round(parent.clientHeight));
  w = pw;
  h = ph;
  ctx.canvas.width = Math.round(pw * dpr);
  ctx.canvas.height = Math.round(ph * dpr);
  // scale context so drawing coordinates use CSS pixels
  ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
  ctx.filter = `blur(${props.blur}px)`;
}

function init() {
  const canvas = canvasRef.value;
  if (!canvas) return;
  ctx = canvas.getContext("2d");
  if (!ctx) return;

  updateSize();

  // use event listener so we can remove it later
  window.addEventListener("resize", updateSize, { passive: true });

  render();
}

function drawWave(n) {
  nt += getSpeed();
  // clear with background (fillRect)
  ctx.fillStyle = props.backgroundFill;
  ctx.globalAlpha = 1; // fully overwrite background first
  ctx.fillRect(0, 0, w, h);

  ctx.globalAlpha = props.waveOpacity;
  for (let i = 0; i < n; i++) {
    ctx.beginPath();
    ctx.lineWidth = props.waveWidth;
    ctx.strokeStyle = props.colors[i % props.colors.length];
    // draw a polyline with noise-based y
    for (let x = 0; x < w; x += 5) {
      const y = noise(x / 800, 0.3 * i, nt) * 100;
      ctx.lineTo(x, y + h * 0.5);
    }
    ctx.stroke();
    ctx.closePath();
  }
}

function render() {
  if (!ctx) return;
  drawWave(5);
  animationId = requestAnimationFrame(render);
}

onMounted(() => {
  // safari detection
  isSafari.value =
    typeof window !== "undefined" &&
    navigator.userAgent.includes("Safari") &&
    !navigator.userAgent.includes("Chrome");

  init();
});

onBeforeUnmount(() => {
  if (animationId) cancelAnimationFrame(animationId);
  // remove resize listener
  window.removeEventListener("resize", updateSize);
});

const isSafari = ref(false);
</script>

<style scoped>
/* 根容器本身现在接收父传入的 class（因为 v-bind="$attrs"） */
/* 你可以在 Hero.vue 里继续写 .hero-wavy 来控制位置 / z-index 等 */

.wavy-root {
  position: relative;
  overflow: hidden;
}

/* 确保 canvas 覆盖父元素 */
canvas {
  display: block;
}

/* 如果希望在组件内部提供默认占满样式（备选），可以打开下面注释：
:root .wavy-root {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
}
*/
</style>