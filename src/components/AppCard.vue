<template>
  <div class="app-card" :style="{ borderLeftColor: app.color }">
    <div class="app-icon">{{ app.icon }}</div>
    <div class="app-content">
      <h3 class="app-name">{{ app.name }}</h3>
      <p v-if="app.description" class="app-description">{{ app.description }}</p>
      <p v-else class="app-description no-description">설명이 없습니다</p>
      <div class="app-meta">
        <span class="app-category">{{ app.category }}</span>
        <span class="app-url">{{ getDomain(app.url) }}</span>
      </div>
    </div>
    <div class="app-actions">
      <button class="edit-btn" @click.stop="$emit('edit')" title="편집">
        ⚙️
      </button>
      <button class="launch-btn" @click.stop="$emit('click')">
        실행 →
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
interface App {
  id: string
  name: string
  description?: string  // 선택사항으로 변경
  url: string
  icon: string
  category: string
  color: string
}

defineProps<{
  app: App
}>()

defineEmits<{
  click: []
  edit: []
}>()

const getDomain = (url: string) => {
  try {
    return new URL(url).hostname
  } catch {
    return url
  }
}
</script>

<style scoped>
.app-card {
  background: white;
  border-radius: 16px;
  padding: 1.5rem;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
  border-left: 4px solid #e91e63;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  flex-direction: column;
  min-height: 200px;
}

.app-card:hover {
  transform: translateY(-8px);
  box-shadow: 0 16px 48px rgba(0, 0, 0, 0.15);
}

.app-icon {
  font-size: 3rem;
  margin-bottom: 1rem;
  text-align: center;
}

.app-content {
  flex: 1;
  margin-bottom: 1rem;
}

.app-name {
  font-size: 1.4rem;
  font-weight: 600;
  margin: 0 0 0.5rem 0;
  color: #2c3e50;
}

.app-description {
  color: #7f8c8d;
  font-size: 0.9rem;
  line-height: 1.5;
  margin: 0 0 1rem 0;
}

.app-description.no-description {
  color: #bdc3c7;
  font-style: italic;
  opacity: 0.7;
}

.app-meta {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1rem;
}

.app-category {
  background: #ecf0f1;
  color: #34495e;
  padding: 0.25rem 0.75rem;
  border-radius: 12px;
  font-size: 0.8rem;
  font-weight: 500;
}

.app-url {
  color: #95a5a6;
  font-size: 0.8rem;
  font-family: monospace;
}

.app-actions {
  display: flex;
  justify-content: flex-end;
  gap: 8px;
}

.edit-btn {
  background: #f3f4f6;
  color: #6b7280;
  border: none;
  padding: 0.5rem;
  border-radius: 8px;
  font-size: 16px;
  cursor: pointer;
  transition: all 0.3s ease;
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.edit-btn:hover {
  background: #e5e7eb;
  color: #374151;
  transform: translateY(-2px);
}

.launch-btn {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border: none;
  padding: 0.75rem 1.5rem;
  border-radius: 8px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s ease;
}

.launch-btn:hover {
  transform: scale(1.05);
  box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
}

@media (max-width: 768px) {
  .app-card {
    padding: 1rem;
    min-height: 180px;
  }
  
  .app-icon {
    font-size: 2.5rem;
  }
  
  .app-name {
    font-size: 1.2rem;
  }
  
  .app-meta {
    flex-direction: column;
    align-items: flex-start;
    gap: 0.5rem;
  }
}
</style>
