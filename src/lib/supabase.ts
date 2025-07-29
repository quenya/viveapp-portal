import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL
const supabaseKey = import.meta.env.VITE_SUPABASE_ANON_KEY

if (!supabaseUrl || !supabaseKey) {
  throw new Error('Missing Supabase environment variables')
}

export const supabase = createClient(supabaseUrl, supabaseKey)

// 타입 정의
export interface App {
  id: string
  name: string
  description?: string  // 선택사항으로 변경
  url: string
  icon: string
  category: string
  color: string
  created_at?: string
  updated_at?: string
  user_id?: string
  is_active?: boolean
  sort_order?: number
}
