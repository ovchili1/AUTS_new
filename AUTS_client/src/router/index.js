import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Signin',
    meta: {
      layout: 'empty'
    },
    component: () => import('../views/Login.vue') 
  },
  {
    path: '/signin',
    name: 'Signin',
    meta: {
      layout: 'empty'
    },
    component: () => import('../views/Login.vue') 
  },
  {
    path: '/signup',
    name: 'Signup',
    meta: {
      layout: 'empty'
    },
    component: () => import('../views/Signup.vue') 
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    meta: {
      layout: 'main'
    },
    component: () => import('../views/Dashboard.vue') 
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
