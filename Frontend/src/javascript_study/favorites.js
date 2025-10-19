// study.favorites.js
import axios from 'axios';

export async function loadFavoritesFromServer() {
  const token = localStorage.getItem('yp_token');
  if (!token) {
    this.favoritesIds = [];
    return;
  }
  this.favLoading = true;
  try {
    const res = await axios.get('http://localhost:5000/api/favorites', {
      headers: { Authorization: `Bearer ${token}` },
      params: { lang: this.selectedLang, page: 1 },
      timeout: 8000,
      validateStatus: s => (s >= 200 && s < 500)
    });

    const data = res && res.data ? res.data : null;
    let favArr = [];

    if (Array.isArray(data)) {
      favArr = data;
    } else if (data && Array.isArray(data.favorites)) {
      favArr = data.favorites;
    } else if (data && Array.isArray(data.results)) {
      favArr = data.results;
    } else {
      favArr = [];
    }

    this.favoritesIds = favArr.map(x => {
      const qid = (x && (x.q_id !== undefined && x.q_id !== null)) ? x.q_id : (x && x.id ? x.id : null);
      return qid != null ? String(qid) : null;
    }).filter(Boolean);

  } catch (e) {
    console.error('loadFavoritesFromServer error:', e);
    this.favoritesIds = [];
  } finally {
    this.favLoading = false;
  }
}

export function getFavoritePayload(qidStr, q) {
  const payload = {
    q_id: String(qidStr),
    lang: this.selectedLang,
    unit_id: Number(this.unitId)
  };
  if (q && q.page_id != null) {
    const pid = Number(q.page_id);
    if (!isNaN(pid)) payload.page_id = pid;
  }
  return payload;
}

export async function toggleFavorite() {
  const token = localStorage.getItem('yp_token');
  if (!token) { alert('请先登录后再收藏题目。'); return; }
  const q = this.currentQuestion;
  const qid = this.getQuestionQid(q);
  if (!qid) { alert('该题尚不可收藏（缺少 q_id）。请确认题库已导入到后端。'); return; }
  const qidStr = String(qid);

  if (this.favoritesIds.includes(qidStr)) {
    this.favLoading = true;
    try {
      try {
        const res = await axios.delete(`http://localhost:5000/api/favorites/${encodeURIComponent(qidStr)}`, {
          headers: { Authorization: `Bearer ${token}` },
          params: { lang: this.selectedLang },
          timeout: 8000,
          validateStatus: s => (s >= 200 && s < 500)
        });
        if (res && (res.status === 200 || res.status === 204 || (res.data && res.data.success))) {
          await this.loadFavoritesFromServer();
          return;
        }
      } catch (errPath) {
        console.warn('path-delete failed, will try body-delete fallback', errPath && (errPath.message || errPath));
      }

      try {
        const res2 = await axios.delete('http://localhost:5000/api/favorites', {
          headers: { Authorization: `Bearer ${token}` },
          data: { q_id: qidStr, lang: this.selectedLang },
          timeout: 8000,
          validateStatus: s => (s >= 200 && s < 500)
        });
        if (res2 && (res2.status === 200 || (res2.data && res2.data.success))) {
          await this.loadFavoritesFromServer();
          return;
        }
        throw new Error('取消收藏失败（后端未返回成功）');
      } catch (errBody) {
        console.error('delete favorite fallback error', errBody);
        alert('取消收藏失败，请重试或联系管理员。');
      }
    } finally {
      this.favLoading = false;
    }
    return;
  }

  const payload = this.getFavoritePayload(qidStr, q);

  this.favLoading = true;
  try {
    const res = await axios.post('http://localhost:5000/api/favorites', payload, {
      headers: { Authorization: `Bearer ${token}` },
      timeout: 8000,
      validateStatus: s => (s >= 200 && s < 500)
    });

    if (res && (res.status === 200 || res.status === 201 || (res.data && res.data.success))) {
      await this.loadFavoritesFromServer();
      return;
    }

    let errMsg = '收藏失败，请重试。';
    if (res && res.data && res.data.error) errMsg = `收藏失败：${res.data.error}`;
    alert(errMsg);

  } catch (e) {
    console.error('add favorite error', e);
    const serverErr = e.response && e.response.data && e.response.data.error ? e.response.data.error : null;
    if (serverErr && typeof serverErr === 'string' && (serverErr.includes('foreign key') || serverErr.includes('REFERENCES'))) {
      alert('收藏失败：后端数据库约束错误（可能题目尚未在后端主表中存在）。请确认题库已导入或联系管理员。');
    } else {
      let msg = '网络错误，收藏失败';
      if (serverErr) msg += `：${serverErr}`;
      alert(msg);
    }
  } finally {
    this.favLoading = false;
  }
}