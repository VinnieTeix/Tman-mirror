import { createApp } from 'vue'
import { createRouter, createWebHistory } from 'vue-router'
import { createPinia } from 'pinia'
import App from './App.vue'
import NotFound from './pages/NotFound.vue'
import TheHome from './pages/home/TheHome.vue'
import UserAuth from './pages/auth/UserAuth.vue'
import BaseCard from './components/ui/BaseCard.vue'
import TheClocks from './pages/clocks/TheClocks.vue'
import ChartManager from './pages/chartmanager/ChartManager.vue'
import TheWorkingtime from './pages/workingtimes/TheWorkingtime.vue'
import UserRegistration from './pages/auth/register/UserRegistration.vue'
import { registerSW } from 'virtual:pwa-register'

registerSW({ immediate: true }) // load and register the service worker immediately

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/', name: 'home', component: TheHome },
    { path: '/login', name: 'login', component: UserAuth },
    { path: '/clocks', name: 'clocks', component: TheClocks },
    { path: '/chartmanager', name: 'chartmanager', component: ChartManager },
    { path: '/register', name: 'register', component: UserRegistration },
    { path: '/workingtimes', name: 'workingtime', component: TheWorkingtime },
    { path: '/:notFound(.*)', name: 'notfound', component: NotFound },
  ],
})

const app = createApp(App)
const pinia = createPinia()

app.use(router)
app.use(pinia)
app.component('base-card', BaseCard)

app.mount('#app')
