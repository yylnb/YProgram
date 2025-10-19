// study.computed.js
export default {
  token() { return localStorage.getItem('yp_token') || null },

  batteryPercent() {
    const e = Number(this.energyData.energy ?? 0);
    const m = Number(this.energyData.maxEnergy ?? 1);
    if (!m || m <= 0) return 0;
    return Math.max(0, Math.min(100, Math.round((e / m) * 100)));
  },

  timeToFullSeconds() {
    const energy = Number(this.energyData.energy ?? 0);
    const maxE = Number(this.energyData.maxEnergy ?? 0);
    if (!maxE || energy >= maxE) return 0;
    let secNext = Number(this.energyData.secondsToNext ?? 0);
    if (!secNext || secNext < 0) secNext = Math.max(0, Math.ceil((this.recoverIntervalMinutes * 60) - 0));
    const pointsNeeded = maxE - energy;
    const intervalSec = this.recoverIntervalMinutes * 60;
    const totalSec = secNext + Math.max(0, pointsNeeded - 1) * intervalSec;
    return Math.max(0, Math.floor(totalSec));
  },

  unitData() {
    const uid = Number(this.unitId) || 1;
    const stage = Math.ceil(uid / 10);
    const idxInStage = ((uid - 1) % 10) + 1;
    const localIdx = uid - 1;
    if (this.units[localIdx]) return this.units[localIdx];
    const placeholderQuestions = Array.from({ length: 5 }).map((_, i) => ({
      id: null, q_id: null, db_id: null, _local: true,
      text: `示例题 ${i+1}：该单元的云端题库尚未导入（unit ${uid}）。`,
      options: ['示例选项 A', '示例选项 B', '示例选项 C', '示例选项 D'],
      answer: 0, hints: ['云端题库未导入，请联系管理员或导入后在服务器查看'], explanation: '这是占位讲解。', example: '', energy: 1
    }));
    return { title: `阶段 ${stage} · 单元 ${idxInStage}`, scenario: `本单元为阶段 ${stage} 的第 ${idxInStage} 关，包含 30 道练习题。`, questions: placeholderQuestions };
  },

  currentQuestion() {
    if (this.unitQuestions && this.unitQuestions[this.currentQuestionIndex]) return this.unitQuestions[this.currentQuestionIndex];
    const local = this.unitData.questions[this.currentQuestionIndex] || null;
    if (local && !local.id) return Object.assign({}, local, { id: null, _local: true });
    return local;
  },

  totalQuestions() {
    return (this.unitQuestions.length > 0 ? this.unitQuestions.length : this.unitData.questions.length);
  },

  progressPercent() {
    if (!this.totalQuestions) return 0;
    const pct = Math.round((Math.min(this.currentQuestionIndex, this.totalQuestions) / this.totalQuestions) * 100);
    return Math.min(Math.max(pct, 0), 100);
  },

  showHint() { return this.attemptCount > 0 && this.currentQuestion && Array.isArray(this.currentQuestion.hints); },

  currentHint() {
    if (!this.currentQuestion || !Array.isArray(this.currentQuestion.hints)) return "";
    const idx = Math.min(this.attemptCount - 1, this.currentQuestion.hints.length - 1);
    return this.currentQuestion.hints[idx] || "";
  },

  hasNextUnit() { const nextIdx = Number(this.unitId) + 1; return nextIdx <= 50; },

  cardMaxHeightStyle() { return { maxHeight: `calc(100vh - ${this.navOffset + 120}px)`, overflow: 'auto' }; },

  isFavorite() {
    const q = this.currentQuestion;
    const qid = this.getQuestionQid(q);
    if (!qid) return false;
    return this.favoritesIds.includes(String(qid));
  },

  selectedLangLabel() {
    const map = { python: 'Python', cpp: 'C++', c: 'C', java: 'Java', html: 'HTML', css: 'CSS', js: 'JavaScript' }
    return map[this.selectedLang] || this.selectedLang;
  },

  nextQuestionExists() {
    return (this.currentQuestionIndex + 1) < this.totalQuestions;
  },

  nextQuestionEnergy() {
    const idx = this.currentQuestionIndex + 1;
    if (this.unitQuestions && this.unitQuestions[idx]) return this.unitQuestions[idx].energy ?? 1;
    if (this.unitData && this.unitData.questions && this.unitData.questions[idx]) return this.unitData.questions[idx].energy ?? 1;
    return 1;
  },

  showExecHint() {
    if (!this.currentQuestion || !this.currentQuestion.exec) return false;
    return (this.execAttemptFailed || (this.execFeedback === false)) && Array.isArray(this.currentQuestion.hints) && this.currentQuestion.hints.length > 0;
  },

  currentExecHint() {
    if (!this.currentQuestion || !this.currentQuestion.exec) return '';
    return Array.isArray(this.currentQuestion.hints) && this.currentQuestion.hints.length > 0 ? this.currentQuestion.hints[0] : '';
  },

  examples() {
    const q = this.currentQuestion;
    if (!q) return [];
    const list = [];
    for (let i = 1; i <= 3; i++) {
      const inp = (q['eg_in' + i] !== undefined && q['eg_in' + i] !== null) ? q['eg_in' + i] : null;
      const out = (q['eg_out' + i] !== undefined && q['eg_out' + i] !== null) ? q['eg_out' + i] : null;
      if (inp || out) {
        list.push({
          idx: i,
          in: inp,
          out: out
        });
      }
    }
    return list;
  },
};
