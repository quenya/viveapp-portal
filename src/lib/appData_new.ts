import { type App } from './supabase'

// 기본 포함 앱 목록
export const defaultApps: Omit<App, 'id' | 'created_at' | 'updated_at'>[] = [
  {
    name: '볼링 점수 트래커',
    description: '볼링 게임 점수를 기록하고 통계를 확인하세요',
    url: 'https://bowling-score.vercel.app/',
    icon: '🎳',
    category: '스포츠',
    color: '#e91e63',
    is_active: true,
    sort_order: 0
  },
  // 향후 더 많은 앱들을 추가할 예정
]

// 카테고리별 기본 설정
export const categoryConfig = {
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

// 사용 가능한 아이콘 목록 (10개)
export const availableIcons = [
  '💻', '📱', '🎮', '🛒', '📊', '📚', '🎵', '🏃‍♂️', '🍔', '🧰'
]

// 테마 색상 팔레트
export const colorPalette = [
  '#e91e63', // 핑크 - 스포츠/건강
  '#2196f3', // 블루 - 생산성/업무
  '#4caf50', // 그린 - 교육/학습
  '#ff9800', // 오렌지 - 엔터테인먼트
  '#9c27b0', // 퍼플 - 창작/디자인
  '#f44336', // 레드 - 긴급/중요
  '#00bcd4', // 시안 - 소셜/커뮤니케이션
  '#8bc34a', // 라이트그린 - 라이프스타일
  '#ff5722', // 딥오렌지 - 쇼핑/상거래
  '#607d8b'  // 블루그레이 - 기타/유틸리티
]
