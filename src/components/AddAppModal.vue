<template>
  <div class="modal-overlay" @click="$emit('close')">
    <div class="modal" @click.stop>
      <div class="modal-header">
        <h2>새 앱 추가</h2>
        <button class="close-btn" @click="$emit('close')">×</button>
      </div>
      
      <form @submit.prevent="handleSubmit" class="modal-form">
        <div class="form-group">
          <label for="name">앱 이름</label>
          <input 
            id="name"
            v-model="form.name" 
            type="text" 
            required 
            placeholder="예: Todo 앱"
          />
        </div>
        
        <div class="form-group">
          <label for="description">설명 (선택사항)</label>
          <textarea 
            id="description"
            v-model="form.description" 
            placeholder="앱에 대한 간단한 설명을 입력하세요"
            rows="3"
          ></textarea>
        </div>
        
        <div class="form-group">
          <label for="url">URL</label>
          <input 
            id="url"
            v-model="form.url" 
            type="url" 
            required 
            placeholder="https://example.com"
          />
        </div>
        
        <div class="form-row">
          <div class="form-group">
            <label for="icon">아이콘</label>
            <div class="icon-selector">
              <select id="icon" v-model="form.icon" required>
                <option value="">아이콘 선택</option>
                <option v-for="icon in availableIcons" :key="icon" :value="icon">
                  {{ icon }}
                </option>
              </select>
              <div class="current-icon" v-if="form.icon && form.icon !== '�'">{{ form.icon }}</div>
              <div class="current-icon placeholder" v-else>?</div>
            </div>
          </div>
          
          <div class="form-group">
            <label for="category">카테고리</label>
            <select id="category" v-model="form.category" required>
              <option value="">카테고리 선택</option>
              <option v-for="(config, category) in categoryConfig" 
                      :key="category" 
                      :value="category">
                {{ config.icon }} {{ category }}
              </option>
            </select>
          </div>
        </div>
        
        <div class="form-group">
          <label for="color">테마 색상</label>
          <div class="color-palette">
            <div 
              v-for="color in colorPalette" 
              :key="color"
              class="color-option"
              :class="{ active: form.color === color }"
              :style="{ backgroundColor: color }"
              @click="form.color = color"
            ></div>
          </div>
        </div>
        
        <div class="modal-actions">
          <button type="button" @click="$emit('close')" class="cancel-btn">
            취소
          </button>
          <button type="submit" class="submit-btn">
            추가
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup lang="ts">
import { reactive } from 'vue'
// import { availableIcons, categoryConfig, colorPalette } from '../lib/appData'

interface AppForm {
  name: string
  description?: string
  url: string
  icon: string
  category: string
  color: string
}

// 임시로 직접 정의
const availableIcons = [
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

const emit = defineEmits<{
  close: []
  'add-app': [app: AppForm]
}>()

const form = reactive<AppForm>({
  name: '',
  description: '',
  url: '',
  icon: '�',
  category: '',
  color: '#2196f3'
})

const handleSubmit = () => {
  emit('add-app', { ...form })
}
</script>

<style scoped>
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.modal {
  background: white;
  border-radius: 16px;
  width: 90%;
  max-width: 500px;
  max-height: 90vh;
  overflow-y: auto;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1.5rem;
  border-bottom: 1px solid #ecf0f1;
}

.modal-header h2 {
  margin: 0;
  color: #2c3e50;
}

.close-btn {
  background: none;
  border: none;
  font-size: 1.5rem;
  cursor: pointer;
  color: #95a5a6;
  padding: 0;
  width: 2rem;
  height: 2rem;
  display: flex;
  align-items: center;
  justify-content: center;
}

.close-btn:hover {
  color: #e74c3c;
}

.modal-form {
  padding: 1.5rem;
}

.form-group {
  margin-bottom: 1.5rem;
}

.form-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;
}

.form-group label {
  display: block;
  margin-bottom: 0.5rem;
  font-weight: 600;
  color: #2c3e50;
}

.form-group input,
.form-group textarea,
.form-group select {
  width: 100%;
  padding: 0.75rem;
  border: 2px solid #ecf0f1;
  border-radius: 8px;
  font-size: 1rem;
  transition: border-color 0.2s ease;
  box-sizing: border-box;
}

.form-group input:focus,
.form-group textarea:focus,
.form-group select:focus {
  outline: none;
  border-color: #667eea;
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

.color-palette {
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

.modal-actions {
  display: flex;
  gap: 1rem;
  justify-content: flex-end;
  margin-top: 2rem;
}

.cancel-btn,
.submit-btn {
  padding: 0.75rem 1.5rem;
  border-radius: 8px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s ease;
}

.cancel-btn {
  background: #ecf0f1;
  border: none;
  color: #7f8c8d;
}

.cancel-btn:hover {
  background: #d5dbdb;
}

.submit-btn {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border: none;
  color: white;
}

.submit-btn:hover {
  transform: scale(1.05);
  box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
}

@media (max-width: 768px) {
  .modal {
    width: 95%;
    margin: 1rem;
  }
  
  .form-row {
    grid-template-columns: 1fr;
  }
  
  .modal-actions {
    flex-direction: column;
  }
}
</style>
