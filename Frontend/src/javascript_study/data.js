// study.data.js
export default function() {
  return {
    unitId: this.$route.params.unitId,
    units: [],
    currentQuestionIndex: 0,
    feedback: null,
    selectedOption: null,
    disableOptions: false,
    attemptCount: 0,
    advancedFlag: false,
    unitQuestions: [],
    favoritesIds: [],
    favLoading: false,
    navOffset: 64,
    serverLoaded: false,
    noServerData: false,
    selectedLang: 'python',
    questionCache: {},
    _onStorage: null,
    _onLanguageChanged: null,

    // energy / entry state
    entryLoading: false,
    entryError: null,
    energyInsufficient: false,
    pendingNextEnergy: 0,
    nextActionLoading: false,

    // energy data fetched from server
    energyData: {
      energy: null,
      maxEnergy: null,
      last_energy_update: null,
      secondsToNext: null
    },
    isVip: false,

    _energyTimerId: null,
    recoverIntervalMinutes: 10,

    // exec
    codeEditorContent: '',
    stdinContent: '',
    execRunning: false,
    execOutputStdout: '',
    execOutputStderr: '',
    execError: null,
    execFeedback: null,
    execAttemptFailed: false
  };
}
