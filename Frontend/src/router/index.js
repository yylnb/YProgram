import { createRouter, createWebHistory } from 'vue-router'
import Home from '../pages/Home.vue'
import Study from '../pages/Study.vue'
import Library from '../pages/Library.vue'
import Friends from '../pages/Friends.vue'
import Profile from '../pages/Profile.vue'
import Map from "../pages/Map.vue";
import LibraryView from "../pages/LibraryView.vue"

const routes = [
  { path: '/', name: 'Home', component: Home },
  { path: '/library', name: 'Library', component: Library },
  { path: '/friends', name: 'Friends', component: Friends },
  { path: '/profile', name: 'Profile', component: Profile },
  { path: "/map", name: "map", component: Map },
  // { path: '/study/:unitId', name: 'Study', component: Study },
  { path: '/study/:course/:unitId', name: 'Study', component: Study, props: true },
  { path: '/library/:lang/:id', name: 'LibraryView', component: LibraryView },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router
