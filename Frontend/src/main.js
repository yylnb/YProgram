import { createApp } from 'vue'
import { createPinia } from 'pinia'
import App from './App.vue'
import router from './router'

import './assets/style.css'
import axios from 'axios';
import VCalendar from 'v-calendar'
import 'v-calendar/dist/style.css'

const app = createApp(App)
app.use(createPinia())
app.use(router)
app.mount('#app')
app.use(VCalendar, {})

const existing = localStorage.getItem('yp_token');
if (existing) {
  axios.defaults.headers.common['Authorization'] = `Bearer ${existing}`;
}

