import { createRouter, createWebHistory } from '@ionic/vue-router'
// import { RouteRecordRaw } from 'vue-router';
import Home from '@/views/Home.vue';


const routes = [
  {
    path: '/',
    redirect: '/atencion',
  },
  // {
  //   path: '/home',
  //   name: 'Home',
  //   component: Home,
  // },
  {
    path: '/atencion',
    name: 'Atencion',
    component: () => import('@/views/Atencion.vue'),
  },
  {
    path: '/reportes',
    name: 'Reportes',
    component: () => import('@/views/Reportes.vue'),
  },
  {
    path: '/asignacion',
    name: 'Asignacion',
    component: () => import('@/views/Asignacion.vue'),
  },
  {
    path: '/ajustes',
    name: 'Ajustes',
    component: () => import('@/views/Ajustes.vue'),
  },
  {
    path: '/atencion/fab',
    name: 'Fab',
    component: () => import('@/views/Fab.vue'),
  },
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes,
})

export default router
