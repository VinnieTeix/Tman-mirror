import { createPinia } from 'pinia'
import { createApp } from 'vue'
import { globalCookiesConfig } from 'vue3-cookies'
import App from './App.vue'
import { router } from './router/index'
import './assets/main.css'
import 'primeicons/primeicons.css'

const app = createApp(App)

const pinia = createPinia()
app.use(pinia)

app.use(router)

globalCookiesConfig({
  expireTimes: '30d',
  path: '/',
  domain: '',
  secure: true,
  sameSite: 'None',
})

app.mount('#app')
