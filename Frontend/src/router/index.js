import { createRouter, createWebHistory } from 'vue-router'
import Home from '../pages/Home.vue'
import Study from '../pages/Study.vue'
import Library from '../pages/Library.vue'
import Friends from '../pages/Friends.vue'
import Profile from '../pages/Profile.vue'
import Map from "../pages/Map.vue";
import LibraryView from "../pages/LibraryView.vue"
import Test from "../pages/test1.vue"

const routes = [
  { path: '/', name: 'Home', component: Home },
  { path: '/library', name: 'Library', component: Library },
  { path: '/friends', name: 'Friends', component: Friends },
  { path: '/profile', name: 'Profile', component: Profile },
  { path: "/map", name: "map", component: Map },
  { path: '/study/:unitId', name: 'Study', component: Study },
  { path: '/library/:id', name: 'LibraryView', component: LibraryView },
  { path: '/test', name: 'Test', component: Test },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router
