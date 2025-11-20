<template>
  <div class="card p-6">
    <div class="flex items-center justify-between mb-3">
      <h3 class="text-lg font-semibold">收藏题目</h3>

      <!-- 语言切换 -->
      <div class="lang-switch inline-flex gap-2">
        <button
          v-for="l in langs"
          :key="l"
          :class="['lang-btn', { active: favSelectedLang === l }]"
          @click="changeFavLang(l)"
        >
          {{ langLabel(l) }}
        </button>
      </div>
    </div>

    <p v-if="loadingFavs">加载收藏中…</p>

    <div v-else>
      <p v-if="favorites.length === 0" class="text-gray-600">
        你还没有收藏题目（当前语言：{{ langLabel(favSelectedLang) }}）。
      </p>

      <ul v-else class="list-disc list-inside space-y-4">
        <li
          v-for="(q, idx) in favorites"
          :key="q.fav_id || q.q_id || q.q_db_id || idx"
        >
          <div class="flex justify-between items-start gap-4">
            <div style="flex:1">
              <div class="text-sm text-gray-600 mb-1">
                <strong>题目 ID：</strong>{{ displayQid(q) }}
                <span class="mx-2">|</span>
                <span>单元 {{ q.unit_id ?? q.unitId ?? '-' }}</span>
                <span v-if="q.page_id || q.pageId" class="mx-2">
                  | 页 {{ q.page_id ?? q.pageId }}
                </span>
              </div>

              <div
                class="mt-1 text-sm text-gray-700"
                v-if="displayText(q)"
                v-html="displayText(q)"
              ></div>
              <div v-else class="text-sm text-gray-500">
                （题目内容不可用）
              </div>
            </div>

            <div class="fav-actions mt-2" style="display:flex; gap:8px; align-items:center;">
              <button class="btn-try" @click="removeFavorite(displayQid(q))">
                取消收藏
              </button>

              <button
                class="btn-primary"
                :disabled="!(q.unit_id || q.unitId || q.q_unit_id || q.q_db_id)"
                @click="goToPractice(q)"
                title="前往该收藏题所在单元练习（会切换到该题目的语言）"
              >
                去练习
              </button>
            </div>
          </div>
        </li>
      </ul>

      <!-- 分页控件 -->
      <div class="pagination mt-4 flex items-center gap-3">
        <button
          class="btn-try"
          :disabled="favCurrentPage <= 1"
          @click="changePage(favCurrentPage - 1)"
        >
          上一页
        </button>
        <div>
          第
          <select v-model.number="favCurrentPage" @change="onPageSelect">
            <option v-for="p in favTotalPages" :key="p" :value="p">{{ p }}</option>
          </select>
          / {{ favTotalPages }} 页
        </div>
        <button
          class="btn-try"
          :disabled="favCurrentPage >= favTotalPages"
          @click="changePage(favCurrentPage + 1)"
        >
          下一页
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'

const router = useRouter()

// state
const favorites = ref([])
const loadingFavs = ref(false)
const favTotalPages = ref(1)
const favCurrentPage = ref(1)
const favSelectedLang = ref('python')
const langs = ['python','cpp','java']

function langLabel(l) {
  const map = { python: 'Python', cpp: 'C++', java: 'Java' }
  return map[l] || l
}

async function loadFavorites(page = 1, lang = 'python') {
  const token = localStorage.getItem('yp_token')
  if (!token) { favorites.value = []; favTotalPages.value = 1; favCurrentPage.value = 1; return; }
  loadingFavs.value = true
  try {
    const url = new URL('http://localhost:5000/api/favorites')
    url.searchParams.set('lang', lang)
    url.searchParams.set('page', String(page))
    const res = await fetch(url.toString(), { headers: { 'Authorization': `Bearer ${token}` } })
    if (res.ok) {
      const data = await res.json()
      if (data && typeof data === 'object' && Array.isArray(data.favorites)) {
        favorites.value = data.favorites
        favTotalPages.value = data.totalPages && Number(data.totalPages) > 0 ? Number(data.totalPages) : Math.max(1, Math.ceil((data.totalCount || data.total || favorites.value.length) / 5))
        favCurrentPage.value = data.currentPage ? Number(data.currentPage) : page
      } else if (Array.isArray(data)) {
        favorites.value = data
        favTotalPages.value = 1
        favCurrentPage.value = 1
      } else {
        favorites.value = []
        favTotalPages.value = 1
        favCurrentPage.value = 1
      }
    } else {
      favorites.value = []
    }
  } catch (e) {
    console.error('loadFavorites error:', e)
    favorites.value = []
  } finally {
    loadingFavs.value = false
  }
}

function changeFavLang(lang) {
  if (!lang) return
  favSelectedLang.value = lang
  favCurrentPage.value = 1
  loadFavorites(favCurrentPage.value, favSelectedLang.value)
}

function changePage(p) {
  if (!p || p < 1) return
  if (p === favCurrentPage.value) return
  favCurrentPage.value = p
  loadFavorites(favCurrentPage.value, favSelectedLang.value)
}

function onPageSelect() {
  loadFavorites(favCurrentPage.value, favSelectedLang.value)
}

function displayQid(q) {
  if (!q) return ''
  return String(q.q_id ?? q.qid ?? q.id ?? q.question_id ?? q.q_db_id ?? '')
}
function displayText(q) {
  if (!q) return ''
  return q.question_text ?? q.q_text ?? q.q_text_html ?? q.q_title ?? q.question_text_html ?? q.q_title_html ?? q.text ?? ''
}

async function removeFavorite(qid) {
  if (!qid) return
  if (!confirm('确认取消收藏该题？')) return
  const token = localStorage.getItem('yp_token')
  if (!token) { alert('请先登录'); return }
  try {
    const url = new URL(`http://localhost:5000/api/favorites/${encodeURIComponent(String(qid))}`)
    if (favSelectedLang.value) url.searchParams.set('lang', favSelectedLang.value)
    const res = await fetch(url.toString(), {
      method: 'DELETE',
      headers: { 'Authorization': `Bearer ${token}` }
    })
    if (res.ok) {
      await loadFavorites(favCurrentPage.value, favSelectedLang.value)
    } else {
      const err = await res.json().catch(()=>({ error: 'unknown' }))
      alert('取消收藏失败：' + (err.error || JSON.stringify(err)))
    }
  } catch (e) {
    console.error('removeFavorite error:', e)
    alert('网络错误，取消收藏失败')
  }
}

async function goToPractice(fav) {
  if (!fav) return;

  const unit = fav.unit_id ?? fav.unitId ?? fav.q_unit_id ?? fav.unit ?? null;
  let lang = (fav.lang ?? localStorage.getItem('yp_lang') ?? 'python').toString().toLowerCase();

  if (!unit) {
    alert('无法跳转：该收藏条目没有绑定单元信息。');
    return;
  }

  try {
    localStorage.setItem('yp_lang', lang);
    window.dispatchEvent(new CustomEvent('language-changed', { detail: { lang } }));
  } catch (e) {
    console.warn('goToPractice: language switch failed', e);
  }

  let qIndex = 1;
  const qid = (fav.q_id ?? fav.qid ?? fav.q_qid ?? fav.question_id ?? fav.db_id ?? null);
  try {
    if (qid) {
      const res = await axios.get('http://localhost:5000/api/questions', {
        params: { unit: unit, lang: lang },
        timeout: 6000
      });
      const data = res && res.data ? res.data : null;
      if (Array.isArray(data) && data.length > 0) {
        const arrQids = data.map(item => (item.q_id ?? item.id ?? item.qId ?? item.qid ?? null)).map(x => x != null ? String(x) : null);
        const foundIndex = arrQids.findIndex(x => x === String(qid));
        if (foundIndex >= 0) {
          qIndex = foundIndex + 1;
        }
      }
    }
  } catch (e) {
    console.warn('goToPractice: find index failed, fallback to q=1', e);
  }

  await new Promise(r => setTimeout(r, 40));

  try {
    router.push({ path: `/study/${unit}`, query: { q: String(Math.max(1, Math.floor(qIndex))) } });
  } catch (e) {
    window.location.href = `/study/${unit}?q=${String(Math.max(1, Math.floor(qIndex)))}`;
  }
}

onMounted(async () => {
  await loadFavorites(favCurrentPage.value, favSelectedLang.value)
})
</script>

<style scoped>
.lang-switch .lang-btn {
  padding: 6px 10px;
  border-radius: 9999px;
  border: 1px solid rgba(15,23,42,0.06);
  background: white;
  font-weight:700;
  cursor:pointer;
}
.lang-switch .lang-btn.active {
  background: linear-gradient(90deg,#2563eb,#7c3aed);
  color: white;
  border-color: transparent;
}
.btn-try {
  background:#fff;
  border:1px solid rgba(15,23,42,0.06);
  padding:8px 12px;
  border-radius:10px;
  font-weight:800;
  cursor:pointer;
}
.btn-primary {
  background: linear-gradient(90deg,#2563eb,#7c3aed);
  color:white;
  border:none;
  padding:8px 12px;
  border-radius:8px;
  font-weight:700;
  cursor:pointer;
}
.text-gray-600 { color:#6b7280; }
.text-gray-500 { color:#6b7280; opacity:0.8;}
.list-disc { list-style-type: disc; }
</style>