import { createRouter, createWebHistory, type RouteRecordRaw } from 'vue-router'
import RegisterComponent from '../components/User/RegisterComponent.vue'
import AdminView from '../views/AdminView.vue'
import HomeView from '../views/HomeView.vue'
import LoginView from '../views/LoginView.vue'
import ManagerView from '../views/ManagerView.vue'
import GeneralManagerView from '../views/GeneralManagerView.vue'

const routes: RouteRecordRaw[] = [
  { path: '/', component: HomeView, name: 'home' },
  { path: '/admin', component: AdminView },
  { path: '/generalManager', component: GeneralManagerView },
  { path: '/manager', component: ManagerView },
  { path: '/login', component: LoginView, name: 'login' },
  { path: '/register', component: RegisterComponent, name: 'register' },
  { path: '/:id', component: HomeView, name: 'dashboard' },
]


export const router = createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior() {
    return { top: 0, behavior: 'smooth' }
  },
})
