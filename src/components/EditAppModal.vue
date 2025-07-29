<template>
  <div class="modal-overlay" @click="closeModal">
    <div class="modal-content" @click.stop>
      <div class="modal-header">
        <h2>앱 편집</h2>
        <button class="close-btn" @click="closeModal">×</button>
      </div>
      
      <form @submit.prevent="updateApp" class="app-form">
        <div class="form-group">
          <label for="edit-name">앱 이름</label>
          <input 
            id="edit-name"
            v-model="formData.name" 
            type="text" 
            required
            placeholder="앱 이름을 입력하세요"
          />
        </div>

        <div class="form-group">
          <label for="edit-description">설명 (선택사항)</label>
          <textarea 
            id="edit-description"
            v-model="formData.description" 
            placeholder="앱에 대한 간단한 설명을 입력하세요"
            rows="3"
          ></textarea>
        </div>

        <div class="form-group">
          <label for="edit-url">URL</label>
          <input 
            id="edit-url"
            v-model="formData.url" 
            type="url" 
            required
            placeholder="https://example.com"
          />
        </div>

        <div class="form-row">
          <div class="form-group">
            <label for="edit-icon">아이콘</label>
            <div class="icon-selector">
              <select id="edit-icon" v-model="formData.icon">
                <option value="">아이콘 선택</option>
                <option v-for="icon in availableIcons" :key="icon" :value="icon">
                  {{ icon }}
                </option>
              </select>
              <div class="current-icon" v-if="formData.icon && formData.icon !== '�'">{{ formData.icon }}</div>
              <div class="current-icon placeholder" v-else>?</div>
            </div>
          </div>

          <div class="form-group">
            <label for="edit-category">카테고리</label>
            <select id="edit-category" v-model="formData.category">
              <option v-for="(config, category) in categoryConfig" 
                      :key="category" 
                      :value="category">
                {{ config.icon }} {{ category }}
              </option>
            </select>
          </div>
        </div>

        <div class="form-group">
          <label for="edit-color">테마 색상</label>
          <div class="color-picker">
            <div 
              v-for="color in colorPalette" 
              :key="color"
              class="color-option"
              :class="{ active: formData.color === color }"
              :style="{ backgroundColor: color }"
              @click="formData.color = color"
            ></div>
          </div>
        </div>

        <div class="form-actions">
          <button type="button" @click="deleteApp" class="delete-btn">
            🗑️ 삭제
          </button>
          <div class="action-buttons">
            <button type="button" @click="closeModal" class="cancel-btn">
              취소
            </button>
            <button type="submit" class="submit-btn">
              💾 저장
            </button>
          </div>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, watch } from 'vue'
// import { availableIcons, categoryConfig, colorPalette } from '../lib/appData'
import type { App } from '../lib/supabase'

// 임시로 직접 정의
const baseAvailableIcons = [
  '💻', '📱', '🎮', '🛒', '📊', '📚', '🎵', '🏃‍♂️', '🍔', '🧰'
]

const categoryConfig = {
  '생산성': { icon: '💻', color: '#2196f3' },
  '엔터테인먼트': { icon: '🎮', color: '#ff9800' },
  '커뮤니케이션': { icon: '💬', color: '#00bcd4' },
  '유틸리티': { icon: '🔧', color: '#607d8b' },
  '개발': { icon: '⚡', color: '#f44336' },
  '디자인': { icon: '🎨', color: '#9c27b0' },
  '교육': { icon: '📚', color: '#4caf50' },
  '금융': { icon: '💰', color: '#8bc34a' },
  '쇼핑': { icon: '🛒', color: '#ff5722' },
  '스포츠': { icon: '🏃‍♂️', color: '#e91e63' }
}

const colorPalette = [
  '#e91e63', '#2196f3', '#4caf50', '#ff9800', '#9c27b0',
  '#f44336', '#00bcd4', '#8bc34a', '#ff5722', '#607d8b'
]

interface Props {
  app: App
}

interface Emits {
  (e: 'close'): void
  (e: 'update-app', app: Partial<App>): void
  (e: 'delete-app', id: string): void
}

const props = defineProps<Props>()
const emit = defineEmits<Emits>()

// 아이콘 목록을 기본 목록으로 설정 (현재 앱의 아이콘은 포함하지 않음)
const availableIcons = ref<string[]>([...baseAvailableIcons])

const formData = reactive({
  name: props.app.name,
  description: props.app.description,
  url: props.app.url,
  icon: '', // 초기값을 빈 문자열로 설정
  category: props.app.category,
  color: props.app.color
})

// 현재 앱의 아이콘이 기본 목록에 있다면 설정, 없다면 빈 값으로 시작
const initializeIcon = () => {
  if (baseAvailableIcons.includes(props.app.icon)) {
    formData.icon = props.app.icon
  } else {
    // 기본 목록에 없는 아이콘이면 목록에 추가하고 선택
    if (props.app.icon && props.app.icon !== '�') {
      availableIcons.value.unshift(props.app.icon)
      formData.icon = props.app.icon
    }
  }
}

// 초기화
initializeIcon()

// props.app이 변경될 때마다 다시 초기화
watch(() => props.app, () => {
  formData.name = props.app.name
  formData.description = props.app.description
  formData.url = props.app.url
  formData.category = props.app.category
  formData.color = props.app.color
  initializeIcon()
}, { deep: true })

const closeModal = () => {
  emit('close')
}

const updateApp = () => {
  emit('update-app', { ...formData })
}

const deleteApp = () => {
  if (confirm(`"${props.app.name}" 앱을 정말 삭제하시겠습니까?`)) {
    emit('delete-app', props.app.id)
  }
}
</script>

<style scoped>
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  padding: 20px;
}

.modal-content {
  background: white;
  border-radius: 20px;
  width: 100%;
  max-width: 500px;
  max-height: 90vh;
  overflow-y: auto;
  box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 30px 30px 20px;
  border-bottom: 1px solid #e5e7eb;
}

.modal-header h2 {
  margin: 0;
  color: #1f2937;
  font-size: 1.5rem;
  font-weight: 600;
}

.close-btn {
  background: none;
  border: none;
  font-size: 24px;
  color: #6b7280;
  cursor: pointer;
  padding: 5px;
  border-radius: 50%;
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.2s ease;
}

.close-btn:hover {
  background: #f3f4f6;
  color: #374151;
}

.app-form {
  padding: 20px 30px 30px;
}

.form-group {
  margin-bottom: 20px;
}

.form-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 15px;
}

.form-group label {
  display: block;
  margin-bottom: 8px;
  font-weight: 500;
  color: #374151;
}

.form-group input,
.form-group textarea,
.form-group select {
  width: 100%;
  padding: 12px 16px;
  border: 2px solid #e5e7eb;
  border-radius: 12px;
  font-size: 14px;
  transition: border-color 0.3s ease;
  box-sizing: border-box;
}

.form-group input:focus,
.form-group textarea:focus,
.form-group select:focus {
  outline: none;
  border-color: #3b82f6;
}

.icon-selector {
  display: flex;
  align-items: center;
  gap: 10px;
}

.current-icon {
  font-size: 24px;
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #f3f4f6;
  border-radius: 8px;
}

.current-icon.placeholder {
  color: #9ca3af;
  font-weight: bold;
}

.icon-selector select {
  flex: 1;
}

.color-picker {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  gap: 10px;
  margin-top: 8px;
}

.color-option {
  width: 40px;
  height: 40px;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.2s ease;
  border: 3px solid transparent;
}

.color-option:hover {
  transform: scale(1.1);
}

.color-option.active {
  border-color: #1f2937;
  transform: scale(1.15);
}

.form-actions {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 30px;
  padding-top: 20px;
  border-top: 1px solid #e5e7eb;
}

.delete-btn {
  background: #ef4444;
  color: white;
  border: none;
  padding: 12px 20px;
  border-radius: 12px;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.delete-btn:hover {
  background: #dc2626;
}

.action-buttons {
  display: flex;
  gap: 12px;
}

.cancel-btn,
.submit-btn {
  padding: 12px 24px;
  border-radius: 12px;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
}

.cancel-btn {
  background: #f3f4f6;
  color: #6b7280;
  border: none;
}

.cancel-btn:hover {
  background: #e5e7eb;
  color: #374151;
}

.submit-btn {
  background: #3b82f6;
  color: white;
  border: none;
}

.submit-btn:hover {
  background: #2563eb;
}

@media (max-width: 640px) {
  .modal-content {
    margin: 10px;
    max-height: calc(100vh - 20px);
  }
  
  .modal-header,
  .app-form {
    padding: 20px;
  }
  
  .form-row {
    grid-template-columns: 1fr;
  }
  
  .color-picker {
    grid-template-columns: repeat(5, 1fr);
  }
  
  .form-actions {
    flex-direction: column;
    gap: 15px;
  }
  
  .action-buttons {
    width: 100%;
    justify-content: center;
  }
}
</style>
