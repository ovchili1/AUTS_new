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
  {
    path: "/users",
    name: "Users",
    meta: {
      layout: 'main',
    },
    component: () => import("../views/User/List.vue")
  },
  {
    path: "/users/:id/edit",
    name: "User_edit",
    meta: {
      layout: 'main',
    },
    component: () => import("../views/User/Edit.vue")
  },
  {
    path: "/themas",
    name: "Themas",
    meta: {
      layout: 'main',
    },
    component: () => import("../views/Themas/List.vue")
  },
  {
    path: "/themas/add",
    name: "Themas_add",
    meta: {
      layout: 'main',
    },
    component: () => import("../views/Themas/Add_edit.vue")
  },
  {
    path: "/themas/:id/edit",
    name: "Themas_edit",
    meta: {
      layout: 'main',
    },
    component: () => import("../views/Themas/Add_edit.vue")
  },
  {
    path: "/questions",
    name: "Questions",
    meta: {
      layout: 'main',
    },
    component: () => import("../views/Questions/List.vue")
  },
  {
    path: "/questions/:id/edit",
    name: "Questions_edit",
    meta: {
      layout: 'main',
    },
    component: () => import("../views/Questions/Add_edit.vue")
  },
  {
    path: "/questions/add",
    name: "Question_add",
    meta: {
      layout: 'main',
    },
    component: () => import("../views/Questions/Add_edit.vue")
  },
  {
    path: "/tests",
    name: "Test",
    meta: {
      layout: 'main',
    },
    component: () => import("../views/Tests/List.vue")
  },
  {
    path: "/tests/:id/edit",
    name: "Test_edit",
    meta: {
      layout: 'main',
    },
    component: () => import("../views/Tests/Add_edit.vue")
  },
  {
    path: "/tests/add",
    name: "Test_add",
    meta: {
      layout: 'main',
    },
    component: () => import("../views/Tests/Add_edit.vue")
  },
  {
    path: "/testings",
    name: "Testing",
    meta: {
      layout: 'main',
    },
    component: () => import("../views/Testings/List.vue")
  },
  {
    path: "/tests/:id/add",
    name: "Testing_add",
    meta: {
      layout: 'main',
    },
    component: () => import("../views/Testings/Add.vue")
  },
  {
    path: "/testings/:id",
    name: "Testing_show",
    meta: {
      layout: 'main',
    },
    component: () => import("../views/Testings/Show.vue")
  }
  
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
