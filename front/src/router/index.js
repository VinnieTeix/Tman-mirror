import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import UsersView from '../views/UsersView.vue'
import ClocksView from '../views/ClocksView.vue'
import WorkingtimesView from '../views/WorkingtimesView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/users',
      name: 'users',
      component: UsersView,
      children: [

      ]
    },
    {
      path: '/clocks',
      name: 'clocks',
      component: ClocksView,
      children: [

      ]
    },
    {
      path: '/workingtimes',
      name: 'workingtimes',
      component: WorkingtimesView,
      children: [

      ]
    }

  ]
})

export default router
