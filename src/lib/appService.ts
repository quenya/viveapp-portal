import { supabase, type App } from './supabase'

// 모든 앱 조회
export async function getApps(): Promise<App[]> {
  try {
    const { data, error } = await supabase
      .from('vive_apps')
      .select('*')
      .order('created_at', { ascending: false })
    
    if (error) throw error
    return data || []
  } catch (error) {
    console.error('Error fetching apps:', error)
    return []
  }
}

// 새 앱 추가
export async function addApp(app: Omit<App, 'id' | 'created_at' | 'updated_at'>): Promise<App | null> {
  try {
    const { data, error } = await supabase
      .from('vive_apps')
      .insert([app])
      .select()
      .single()
    
    if (error) throw error
    return data
  } catch (error) {
    console.error('Error adding app:', error)
    return null
  }
}

// 앱 업데이트
export async function updateApp(id: string, updates: Partial<App>): Promise<App | null> {
  try {
    const { data, error } = await supabase
      .from('vive_apps')
      .update({
        ...updates,
        updated_at: new Date().toISOString()
      })
      .eq('id', id)
      .select()
      .single()
    
    if (error) throw error
    return data
  } catch (error) {
    console.error('Error updating app:', error)
    return null
  }
}

// 앱 삭제 (소프트 삭제)
export async function deleteApp(id: string): Promise<boolean> {
  try {
    const { error } = await supabase
      .from('vive_apps')
      .delete()
      .eq('id', id)
    
    if (error) throw error
    return true
  } catch (error) {
    console.error('Error deleting app:', error)
    return false
  }
}

// 로컬스토리지에서 데이터 마이그레이션
export async function migrateFromLocalStorage(): Promise<void> {
  try {
    // 기존 로컬스토리지 데이터 확인
    const localData = localStorage.getItem('viveapp-portal-apps')
    if (!localData) return

    const localApps = JSON.parse(localData) as App[]
    
    // Supabase에 데이터가 있는지 확인
    const existingApps = await getApps()
    if (existingApps.length > 0) return // 이미 데이터가 있으면 마이그레이션 안함

    // 로컬 데이터를 Supabase로 이전
    for (const app of localApps) {
      await addApp({
        name: app.name,
        description: app.description,
        url: app.url,
        icon: app.icon,
        category: app.category,
        color: app.color
      })
    }

    console.log('Migration completed successfully')
  } catch (error) {
    console.error('Error during migration:', error)
  }
}
