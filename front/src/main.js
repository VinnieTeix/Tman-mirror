import { createApp } from 'vue'
import { createRouter, createWebHistory } from 'vue-router'
import { registerLicense } from '@syncfusion/ej2-base'
import App from './App.vue'
import NotFound from './pages/NotFound.vue'
import TheHome from './pages/home/TheHome.vue'
import UserAuth from './pages/auth/UserAuth.vue'
import BaseCard from './components/ui/BaseCard.vue'
import TheUser from './pages/users/TheUser.vue'
import TheClocks from './pages/clocks/TheClocks.vue'
import ChartManager from './pages/chartmanager/ChartManager.vue'
import TheWorkingtime from './pages/workingtimes/TheWorkingtime.vue'
import UserRegistration from './pages/auth/register/UserRegistration.vue'

registerLicense("ORg4AjUWIQA/Gnt2UlhhQlVMfV5DQmFLYVF2R2dJe1Ryc19GaEwgOX1dQl9nSH5RdUVnWnleeHNcRWI=")

const router = createRouter({
    history: createWebHistory(),
    routes : [
        {path: '/', name:'home', component: TheHome},
        { path: '/users', name:'users', component: TheUser},
        { path: '/login', name:'auth', component: UserAuth},
        { path: '/clocks', name:'clocks', component: TheClocks },
        {path: '/chartmanager', name:'chartmanager', component: ChartManager},
        { path: '/register', name:'registration', component: UserRegistration},
        { path: '/workingtimes', name:'workingtime', component: TheWorkingtime },
        { path: '/:notFound(.*)', name:'notfound', component: NotFound }
    ]
})

const app = createApp(App)

app.use(createPinia())
app.use(router)
app.component('base-card', BaseCard);

app.mount('#app')
