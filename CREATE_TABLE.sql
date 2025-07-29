-- ViveApp Portal 데이터베이스 설정
-- Supabase SQL Editor에서 실행하세요

-- 1. vive_apps 테이블 생성
CREATE TABLE vive_apps (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  url VARCHAR(500) NOT NULL,
  description TEXT,
  icon VARCHAR(50) DEFAULT '🌐',
  color VARCHAR(7) DEFAULT '#3b82f6',
  category VARCHAR(100) DEFAULT 'general',
  is_active BOOLEAN DEFAULT true,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. RLS (Row Level Security) 활성화
ALTER TABLE vive_apps ENABLE ROW LEVEL SECURITY;

-- 3. 정책 생성 (모든 사용자 접근 허용)
CREATE POLICY "Enable read access for all users" ON vive_apps
  FOR SELECT USING (true);

CREATE POLICY "Enable insert for all users" ON vive_apps
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Enable update for all users" ON vive_apps
  FOR UPDATE USING (true);

CREATE POLICY "Enable delete for all users" ON vive_apps
  FOR DELETE USING (true);

-- 4. 업데이트 시간 자동 갱신 함수
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- 5. 트리거 생성
CREATE TRIGGER update_vive_apps_updated_at 
  BEFORE UPDATE ON vive_apps 
  FOR EACH ROW 
  EXECUTE FUNCTION update_updated_at_column();

-- 6. 기본 데이터 삽입
INSERT INTO vive_apps (name, url, description, icon, color, category, sort_order) VALUES
('볼링 점수 추적기', 'https://bowling-score-tracker-one.vercel.app/', '볼링 게임의 점수를 추적하고 통계를 확인하세요', '🎳', '#10b981', 'entertainment', 0),
('날씨 앱', 'https://weather.com', '실시간 날씨 정보를 확인하세요', '🌤️', '#3b82f6', 'utility', 1),
('할일 관리', 'https://todoist.com', '할일을 체계적으로 관리하세요', '📝', '#8b5cf6', 'productivity', 2),
('음악 스트리밍', 'https://spotify.com', '좋아하는 음악을 들어보세요', '🎵', '#1db954', 'entertainment', 3),
('이메일', 'https://gmail.com', '이메일을 확인하고 관리하세요', '📧', '#ea4335', 'communication', 4),
('유튜브', 'https://youtube.com', '동영상을 시청하고 공유하세요', '📺', '#ff0000', 'entertainment', 5),
('구글 드라이브', 'https://drive.google.com', '파일을 안전하게 저장하고 공유하세요', '💾', '#4285f4', 'productivity', 6),
('넷플릭스', 'https://netflix.com', '영화와 드라마를 즐겨보세요', '🎬', '#e50914', 'entertainment', 7),
('깃허브', 'https://github.com', '코드를 관리하고 협업하세요', '⚡', '#333333', 'development', 8),
('노션', 'https://notion.so', '생각을 정리하고 문서를 작성하세요', '📋', '#000000', 'productivity', 9);

-- 완료 메시지 출력
SELECT 'vive_apps 테이블이 성공적으로 생성되었습니다!' as message;
