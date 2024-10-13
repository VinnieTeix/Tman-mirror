import { createApp } from 'vue'
import { createPinia } from 'pinia'
import { createRouter, createWebHistory } from 'vue-router'
import App from './App.vue'
import TheUser from './components/Users/TheUser.vue'
import TheClocks from './components/Clocks/TheClocks.vue'
import TheWorkingtime from './components/Workingtimes/TheWorkingtime.vue'

const router = createRouter({
    history: createWebHistory(),
    routes : [
        { path: '/users', component: TheUser },
        { path: '/clocks', component: TheClocks },
        { path: '/workingtimes', component: TheWorkingtime }
    ]
})

const app = createApp(App)

app.use(createPinia())
app.use(router)

app.mount('#app')
