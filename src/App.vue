<template>
  <div id="app">
    <header class="header">
      <h1 class="title">🌟 ViveApp Portal</h1>
      <p class="subtitle">당신의 모든 웹앱에 쉽게 접근하세요</p>
    </header>
    
    <main class="main">
      <!-- 로딩 상태 -->
      <div v-if="loading" class="loading">
        <div class="loading-spinner"></div>
        <p>앱 목록을 불러오는 중...</p>
      </div>
      
      <!-- 에러 상태 -->
      <div v-else-if="error" class="error">
        <div class="error-icon">⚠️</div>
        <p>{{ error }}</p>
        <button @click="loadApps" class="retry-btn">다시 시도</button>
      </div>
      
      <!-- 앱 목록 -->
      <div v-else class="apps-grid">
        <AppCard 
          v-for="app in apps" 
          :key="app.id"
          :app="app"
          @click="openApp(app)"
          @edit="editApp(app)"
        />
        
        <div class="add-app-card" @click="showAddForm = true">
          <div class="add-icon">+</div>
          <h3>새 앱 추가</h3>
        </div>
      </div>
    </main>

    <AddAppModal 
      v-if="showAddForm"
      @close="showAddForm = false"
      @add-app="addNewApp"
    />
    
    <EditAppModal
      v-if="showEditForm && editingApp"
      :app="editingApp"
      @close="showEditForm = false"
      @update-app="updateApp"
      @delete-app="deleteApp"
    />
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import AppCard from './components/AppCard.vue'
import AddAppModal from './components/AddAppModal.vue'
import EditAppModal from './components/EditAppModal.vue'
import { getApps, addApp, updateApp as updateAppService, deleteApp as deleteAppService, migrateFromLocalStorage } from './lib/appService'
// import { defaultApps } from './lib/appData'
import type { App } from './lib/supabase'

// 기본 앱 목록을 직접 정의
const defaultApps = [
  {
    name: '볼링 점수 트래커',
    description: '볼링 게임 점수를 기록하고 통계를 확인하세요',
    url: 'https://bowling-score.vercel.app/',
    icon: '🎳',
    category: '스포츠',
    color: '#e91e63'
  }
]

interface AppForm {
  name: string
  description?: string
  url: string
  icon: string
  category: string
  color: string
}

const apps = ref<App[]>([])
const showAddForm = ref(false)
const showEditForm = ref(false)
const editingApp = ref<App | null>(null)
const loading = ref(true)
const error = ref<string | null>(null)

const openApp = (app: App) => {
  window.open(app.url, '_blank')
}

const editApp = (app: App) => {
  editingApp.value = app
  showEditForm.value = true
}

const addNewApp = async (newApp: AppForm) => {
  try {
    const app = await addApp(newApp)
    if (app) {
      apps.value.push(app)
      showAddForm.value = false
    } else {
      error.value = '앱 추가에 실패했습니다.'
    }
  } catch (err) {
    console.error('Error adding app:', err)
    error.value = '앱 추가 중 오류가 발생했습니다.'
  }
}

const updateApp = async (updates: Partial<App>) => {
  if (!editingApp.value) return
  
  try {
    const updatedApp = await updateAppService(editingApp.value.id, updates)
    if (updatedApp) {
      const index = apps.value.findIndex(app => app.id === editingApp.value!.id)
      if (index !== -1) {
        apps.value[index] = updatedApp
      }
      showEditForm.value = false
      editingApp.value = null
    } else {
      error.value = '앱 수정에 실패했습니다.'
    }
  } catch (err) {
    console.error('Error updating app:', err)
    error.value = '앱 수정 중 오류가 발생했습니다.'
  }
}

const deleteApp = async (id: string) => {
  try {
    const success = await deleteAppService(id)
    if (success) {
      apps.value = apps.value.filter(app => app.id !== id)
      showEditForm.value = false
      editingApp.value = null
    } else {
      error.value = '앱 삭제에 실패했습니다.'
    }
  } catch (err) {
    console.error('Error deleting app:', err)
    error.value = '앱 삭제 중 오류가 발생했습니다.'
  }
}

const loadApps = async () => {
  try {
    console.log('Loading apps started...')
    loading.value = true
    error.value = null
    
    // 로컬스토리지에서 마이그레이션 시도
    console.log('Attempting migration...')
    await migrateFromLocalStorage()
    
    // Supabase에서 앱 목록 로드
    console.log('Fetching apps from Supabase...')
    const loadedApps = await getApps()
    console.log('Loaded apps:', loadedApps)
    
    // 데이터가 없으면 기본 앱 추가
    if (loadedApps.length === 0) {
      console.log('No apps found, adding default apps...')
      for (const defaultApp of defaultApps) {
        const app = await addApp(defaultApp)
        if (app) {
          loadedApps.push(app)
        }
      }
    }
    
    apps.value = loadedApps
    console.log('Apps loaded successfully:', apps.value)
  } catch (err) {
    console.error('Error loading apps:', err)
    error.value = '앱 목록을 불러오는데 실패했습니다.'
    
    // 오류 시 로컬스토리지 폴백
    const localData = localStorage.getItem('viveapp-portal-apps')
    if (localData) {
      apps.value = JSON.parse(localData)
    }
  } finally {
    loading.value = false
    console.log('Loading finished, loading state:', loading.value)
  }
}

onMounted(() => {
  console.log('Component mounted, starting loadApps...')
  loadApps()
  
  // 임시 디버깅: 3초 후 강제로 로딩 false
  setTimeout(() => {
    if (loading.value) {
      console.log('Force stopping loading...')
      loading.value = false
      if (apps.value.length === 0) {
        // 기본 앱 하드코딩
        apps.value = [{
          id: '1',
          name: '테스트 앱',
          description: '테스트용 앱입니다',
          url: 'https://google.com',
          icon: '💻',
          category: '테스트',
          color: '#2196f3'
        }]
      }
    }
  }, 3000)
})
</script>

<style scoped>
#app {
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 2rem;
}

.header {
  text-align: center;
  margin-bottom: 3rem;
  color: white;
}

.title {
  font-size: 3rem;
  font-weight: 700;
  margin: 0;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
}

.subtitle {
  font-size: 1.2rem;
  margin: 0.5rem 0 0 0;
  opacity: 0.9;
}

.main {
  max-width: 1200px;
  margin: 0 auto;
}

.apps-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 2rem;
}

.add-app-card {
  background: rgba(255, 255, 255, 0.1);
  border: 2px dashed rgba(255, 255, 255, 0.3);
  border-radius: 16px;
  padding: 2rem;
  text-align: center;
  cursor: pointer;
  transition: all 0.3s ease;
  color: white;
  min-height: 200px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.add-app-card:hover {
  background: rgba(255, 255, 255, 0.2);
  border-color: rgba(255, 255, 255, 0.5);
  transform: translateY(-4px);
}

.add-icon {
  font-size: 3rem;
  margin-bottom: 1rem;
  opacity: 0.7;
}

.add-app-card h3 {
  margin: 0;
  font-size: 1.2rem;
  opacity: 0.8;
}

/* 로딩 상태 스타일 */
.loading {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 300px;
  color: #6b7280;
}

.loading-spinner {
  width: 40px;
  height: 40px;
  border: 4px solid #e5e7eb;
  border-top: 4px solid #3b82f6;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin-bottom: 16px;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

/* 에러 상태 스타일 */
.error {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 300px;
  color: #ef4444;
  text-align: center;
}

.error-icon {
  font-size: 48px;
  margin-bottom: 16px;
}

.error p {
  margin-bottom: 20px;
  font-size: 16px;
}

.retry-btn {
  background: #3b82f6;
  color: white;
  border: none;
  padding: 12px 24px;
  border-radius: 8px;
  font-size: 14px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.retry-btn:hover {
  background: #2563eb;
}

@media (max-width: 768px) {
  #app {
    padding: 1rem;
  }
  
  .title {
    font-size: 2rem;
  }
  
  .apps-grid {
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }
}
</style>
