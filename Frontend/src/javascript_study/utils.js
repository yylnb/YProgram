// study.utils.js
export function safeParse(s) {
  if (!s) return [];
  if (Array.isArray(s)) return s;
  try { return JSON.parse(s) } catch (e) { if (typeof s === 'string') return [s]; return []; }
}
