// study.energy_progress.js
import axios from 'axios';

export async function fetchEnergy() {
  if (!this.token) {
    this.energyData = { energy: null, maxEnergy: null, last_energy_update: null, secondsToNext: null };
    this.stopEnergyTimer();
    return;
  }
  try {
    const res = await axios.get('http://localhost:5000/api/user/energy', {
      headers: { Authorization: `Bearer ${this.token}` },
      timeout: 6000,
      validateStatus: s => (s >= 200 && s < 500)
    });
    if (res && res.status === 200 && res.data) {
      this.energyData.energy = Number(res.data.energy ?? 0);
      this.energyData.maxEnergy = Number(res.data.maxEnergy ?? 0);
      this.energyData.last_energy_update = res.data.last_energy_update ?? null;
      this.energyData.secondsToNext = (typeof res.data.secondsToNext === 'number') ? Math.max(0, Math.floor(res.data.secondsToNext)) : null;
      this.startEnergyTimer();
    } else {
      this.energyData = { energy: null, maxEnergy: null, last_energy_update: null, secondsToNext: null };
      this.stopEnergyTimer();
    }
  } catch (e) {
    console.error('fetchEnergy error', e);
    this.stopEnergyTimer();
  }
}

export function startEnergyTimer() {
  this.stopEnergyTimer();
  if (this.energyData.secondsToNext == null || this.energyData.energy == null || this.energyData.maxEnergy == null) return;
  this._energyTimerId = setInterval(() => {
    if (this.energyData.secondsToNext > 0) {
      this.energyData.secondsToNext = Math.max(0, this.energyData.secondsToNext - 1);
    } else {
      if (this.energyData.energy < this.energyData.maxEnergy) {
        this.energyData.energy = Math.min(this.energyData.maxEnergy, this.energyData.energy + 1);
        if (this.energyData.energy < this.energyData.maxEnergy) {
          this.energyData.secondsToNext = this.recoverIntervalMinutes * 60;
        } else {
          this.energyData.secondsToNext = 0;
          this.stopEnergyTimer();
        }
      } else {
        this.energyData.secondsToNext = 0;
        this.stopEnergyTimer();
      }
    }
  }, 1000);
}

export function stopEnergyTimer() {
  if (this._energyTimerId) {
    clearInterval(this._energyTimerId);
    this._energyTimerId = null;
  }
}

export function formatDuration(sec) {
  if (sec == null) return '--';
  sec = Number(sec);
  if (sec <= 0) return '已充满';
  const days = Math.floor(sec / 86400);
  sec %= 86400;
  const hours = Math.floor(sec / 3600);
  sec %= 3600;
  const mins = Math.floor(sec / 60);
  const secs = sec % 60;
  const part = [];
  if (days > 0) part.push(`${days}天`);
  if (hours > 0 || days > 0) part.push(`${String(hours).padStart(2,'0')}时`);
  part.push(`${String(mins).padStart(2,'0')}分`);
  part.push(`${String(secs).padStart(2,'0')}秒`);
  return part.join(' ');
}

export async function ensureEntryEnergyAndProgress() {
  if (!this.token) {
    this.entryLoading = false;
    this.entryError = null;
    return;
  }
  if (!this.unitQuestions || this.unitQuestions.length === 0) {
    this.entryLoading = false;
    return;
  }

  this.entryLoading = true;
  this.entryError = null;
  try {
    const res = await axios.get(`http://localhost:5000/api/progress/${this.unitId}`, {
      headers: { Authorization: `Bearer ${this.token}` },
      params: { lang: this.selectedLang },
      validateStatus: s => (s >= 200 && s < 500)
    });

    if (res.status === 200 && res.data) {
      const data = res.data;
      const completed = (data.completed === 1 || data.completed === true || data.completed === '1');
      const serverIndex = typeof data.current_index !== 'undefined' ? Number(data.current_index) : null;

      if (completed) {
        this.currentQuestionIndex = this.totalQuestions;
        this.entryError = null;
        this.entryLoading = false;
        await this.fetchEnergy();
        return;
      }

      if (serverIndex != null && !isNaN(serverIndex) && serverIndex >= 1) {
        this.currentQuestionIndex = Math.min(Math.max(0, serverIndex - 1), Math.max(0, this.totalQuestions - 1));
        this.entryError = null;
        this.entryLoading = false;
        await this.fetchEnergy();
        return;
      }
    }

    const firstEnergy = this.unitQuestions[0] && Number.isFinite(Number(this.unitQuestions[0].energy)) ? Number(this.unitQuestions[0].energy) : 1;

    if (this.isVip) {
      try {
        await axios.post('http://localhost:5000/api/user/use-energy', { amount: firstEnergy }, {
          headers: { Authorization: `Bearer ${this.token}` },
          timeout: 8000,
          validateStatus: s => (s >= 200 && s < 500)
        });
      } catch (vipErr) {
        console.warn('VIP use-energy sync failed during entry:', vipErr);
      }

      this.currentQuestionIndex = 0;
      await this.saveProgress(false);
      this.entryLoading = false;
      this.entryError = null;
      await this.fetchEnergy();
      return;
    }

    try {
      const useRes = await axios.post('http://localhost:5000/api/user/use-energy', { amount: firstEnergy }, {
        headers: { Authorization: `Bearer ${this.token}` },
        timeout: 8000,
        validateStatus: s => (s >= 200 && s < 500)
      });
      if (useRes.status === 200) {
        await this.fetchEnergy();
        this.currentQuestionIndex = 0;
        await this.saveProgress(false);
        this.entryLoading = false;
        this.entryError = null;
        return;
      } else {
        const errMsg = useRes.data && useRes.data.error ? useRes.data.error : '扣能量失败';
        if (useRes.status === 400 && String(errMsg).includes('能量不足')) {
          this.entryError = `能量不足，进入该单元需要 ⚡${firstEnergy}，请前往图书馆获取能量或等待恢复。`;
        } else {
          this.entryError = `无法扣除能量：${errMsg}`;
        }
        this.entryLoading = false;
        await this.fetchEnergy();
        return;
      }
    } catch (errInner) {
      console.error('use-energy error during entry', errInner);
      this.entryError = '扣能量时网络或服务器错误，请重试或稍后再试。';
      this.entryLoading = false;
      await this.fetchEnergy();
      return;
    }
  } catch (err) {
    console.error('progress fetch error during entry', err);
    this.entryError = '检查学习进度失败，已进入默认题目。';
    this.entryLoading = false;
    await this.fetchEnergy();
    return;
  }
}

export async function onNextClicked() {
  if (this.nextActionLoading || this.entryLoading) return;

  const nextIndex = this.currentQuestionIndex + 1;
  if (nextIndex >= this.totalQuestions) {
    await this.saveProgress(true);
    this.currentQuestionIndex = this.totalQuestions;
    this.feedback = null; this.selectedOption = null; this.disableOptions = false; this.attemptCount = 0;
    this.updateRouteQuery();
    return;
  }

  if (!this.token) {
    this.currentQuestionIndex = nextIndex;
    this.feedback = null; this.selectedOption = null; this.disableOptions = false; this.attemptCount = 0;
    this.resetExecState();
    await this.saveProgress(false);
    this.updateRouteQuery();
    return;
  }

  if (this.isVip) {
    this.nextActionLoading = true;
    const amount = this.nextQuestionEnergy ?? 1;
    try {
      try {
        await axios.post('http://localhost:5000/api/user/use-energy', { amount }, {
          headers: { Authorization: `Bearer ${this.token}` },
          timeout: 8000,
          validateStatus: s => (s >= 200 && s < 500)
        });
      } catch (vipErr) {
        console.warn('VIP use-energy sync failed on next:', vipErr);
      }

      this.currentQuestionIndex = nextIndex;
      this.feedback = null; this.selectedOption = null; this.disableOptions = false; this.attemptCount = 0;
      this.resetExecState();
      await this.saveProgress(nextIndex >= this.totalQuestions - 1 ? true : false);
      this.updateRouteQuery();
    } catch (e) {
      console.error('vip advance error', e);
    } finally {
      this.nextActionLoading = false;
    }
    return;
  }

  const amount = this.nextQuestionEnergy ?? 1;
  this.nextActionLoading = true;
  this.energyInsufficient = false;
  this.pendingNextEnergy = amount;

  try {
    const res = await axios.post('http://localhost:5000/api/user/use-energy', { amount }, {
      headers: { Authorization: `Bearer ${this.token}` },
      timeout: 8000,
      validateStatus: s => (s >= 200 && s < 500)
    });

    if (res.status === 200) {
      await this.fetchEnergy();
      this.currentQuestionIndex = nextIndex;
      this.feedback = null; this.selectedOption = null; this.disableOptions = false; this.attemptCount = 0;
      this.resetExecState();
      await this.saveProgress(nextIndex >= this.totalQuestions - 1 ? true : false);
      this.updateRouteQuery();
      this.energyInsufficient = false;
      this.pendingNextEnergy = 0;
    } else {
      const errMsg = res.data && res.data.error ? res.data.error : '扣能量失败';
      if (res.status === 400 && String(errMsg).includes('能量不足')) {
        this.energyInsufficient = true;
        await this.fetchEnergy();
        this.entryError = null;
      } else {
        alert(`扣能量失败：${errMsg}`);
      }
    }
  } catch (err) {
    console.error('use-energy error on next', err);
    alert('扣能量时发生网络或服务器错误，请稍后再试。');
  } finally {
    this.nextActionLoading = false;
  }
}

export async function saveProgress(completed = false) {
  try {
    const raw = localStorage.getItem('yp_local_progress');
    const obj = raw ? JSON.parse(raw) : {};
    obj[String(this.unitId)] = { current_index: this.currentQuestionIndex + 1, completed: !!completed, lang: this.selectedLang };
    localStorage.setItem('yp_local_progress', JSON.stringify(obj));
  } catch (e) {}

  const token = localStorage.getItem('yp_token');
  if (!token) return;
  try {
    const serverIndex = completed ? Number(this.totalQuestions) : Number(Math.max(1, this.currentQuestionIndex + 1));
    await axios.post('http://localhost:5000/api/progress', { unit_id: Number(this.unitId), current_index: serverIndex, completed: !!completed, lang: this.selectedLang }, { headers: { Authorization: `Bearer ${token}` } });
  } catch (e) {
    // ignore
  }
}

export async function loadProgressRemoteIfAny() {
  const token = localStorage.getItem('yp_token');
  if (!token) return;
  try {
    const res = await axios.get(`http://localhost:5000/api/progress/${this.unitId}`, { headers: { Authorization: `Bearer ${token}` }, params: { lang: this.selectedLang }, validateStatus: s => (s >= 200 && s < 500) });
    const data = res.data;
    if (res.status === 200 && data) {
      const completed = (data.completed === 1 || data.completed === true || data.completed === '1');
      const serverIndex = typeof data.current_index !== 'undefined' ? Number(data.current_index) : null;
      if (completed) {
        this.currentQuestionIndex = this.totalQuestions;
        this.updateRouteQuery();
        return;
      }
      if (serverIndex != null && !isNaN(serverIndex) && serverIndex >= 1) {
        this.currentQuestionIndex = Math.min(Math.max(0, serverIndex - 1), Math.max(0, this.totalQuestions - 1));
        this.updateRouteQuery();
      }
    }
  } catch (e) {}
}

export function goToNextUnit() {
  const nextUnitId = Number(this.unitId) + 1;
  if (nextUnitId <= 50) {
    this.$router.push({ path: `/study/${nextUnitId}` });
  } else {
    this.$router.push('/map');
  }
}

export function goToLibrary() {
  try { this.$router.push({ name: 'Library' }); } catch (e) { this.$router.push('/library'); }
}

export function dismissInsufficient() {
  this.energyInsufficient = false;
  this.pendingNextEnergy = 0;
}

export function updateRouteQuery() {
  try {
    const qVal = Math.max(1, Math.min(this.totalQuestions || 1, this.currentQuestionIndex + 1));
    this.$router.replace({ path: this.$route.path, query: { ...this.$route.query, q: String(qVal) } });
  } catch (e) {}
}

export function reloadQuestions() { return this.loadUnitQuestionsFromServer(true); }

export async function handleLanguageChanged(newLang) {
  if (!newLang || newLang === this.selectedLang) return;
  this.selectedLang = newLang;
  this.currentQuestionIndex = 0;
  await this.loadUnitQuestionsFromServer();
  await this.loadFavoritesFromServer();
  await this.loadProgressRemoteIfAny();
  if (this.token) await this.ensureEntryEnergyAndProgress();
}

export async function fetchMembership() {
  if (!this.token) {
    this.isVip = false
    return
  }
  try {
    const res = await axios.get("http://localhost:5000/api/membership", {
      headers: { Authorization: `Bearer ${this.token}` },
      timeout: 6000,
      validateStatus: s => (s >= 200 && s < 500)
    })
    if (res.status === 200 && res.data && res.data.end_at) {
      const end = new Date(res.data.end_at)
      this.isVip = end > new Date()
    } else {
      this.isVip = false
    }
  } catch (e) {
    console.error("fetchMembership error", e)
    this.isVip = false
  }
}

export function confirmRestart() {
  if (!confirm('如果重新学习将会丢失当前进度，确认要重新学习本单元吗？')) return;
  this.restartUnit();
}

export async function restartUnit() {
  try {
    const raw = localStorage.getItem('yp_local_progress');
    const obj = raw ? JSON.parse(raw) : {};
    delete obj[String(this.unitId)];
    localStorage.setItem('yp_local_progress', JSON.stringify(obj));
  } catch (e) {}
  this.currentQuestionIndex = 0; this.feedback = null; this.selectedOption = null; this.disableOptions = false; this.attemptCount = 0;
  this.resetExecState();
  const token = localStorage.getItem('yp_token');
  if (token) {
    try {
      await axios.post('http://localhost:5000/api/progress', { unit_id: Number(this.unitId), current_index: 1, completed: false, lang: this.selectedLang }, { headers: { Authorization: `Bearer ${token}` } });
    } catch (e) {}
  }
  alert('单元进度已重置。');
}