import { createApp } from 'vue'
import { createRouter, createWebHistory } from 'vue-router'
import App from './App.vue'
import PromptsPage from './pages/PromptsPage.vue'
import ToolsPage from './pages/ToolsPage.vue'
import './styles.css'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/', redirect: '/prompts' },
    { path: '/prompts', component: PromptsPage },
    { path: '/tools', component: ToolsPage }
  ]
})

createApp(App).use(router).mount('#app')
