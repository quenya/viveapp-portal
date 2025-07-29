-- 간단한 vive_apps 테이블 생성 (문제 해결용)
-- 기존 테이블이 있다면 먼저 삭제하고 다시 생성

DROP TABLE IF EXISTS vive_apps CASCADE;

-- 기본 테이블 생성
CREATE TABLE vive_apps (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  url VARCHAR(500) NOT NULL,
  description TEXT,
  icon VARCHAR(50) DEFAULT '🌐',
  color VARCHAR(7) DEFAULT '#3b82f6',
  category VARCHAR(100) DEFAULT 'general',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- RLS 활성화
ALTER TABLE vive_apps ENABLE ROW LEVEL SECURITY;

-- 모든 사용자 접근 허용 정책
CREATE POLICY "Enable all for all users" ON vive_apps
  FOR ALL USING (true);

-- 업데이트 시간 자동 갱신 함수
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- 트리거 생성
CREATE TRIGGER update_vive_apps_updated_at 
  BEFORE UPDATE ON vive_apps 
  FOR EACH ROW 
  EXECUTE FUNCTION update_updated_at_column();

-- 테스트 데이터 삽입
INSERT INTO vive_apps (name, url, description, icon, color, category) VALUES
('볼링 점수 추적기', 'https://bowling-score-tracker-one.vercel.app/', '볼링 게임의 점수를 추적하고 통계를 확인하세요', '🎳', '#10b981', '엔터테인먼트'),
('구글', 'https://google.com', '전 세계에서 가장 많이 사용되는 검색 엔진', '🌐', '#4285f4', '유틸리티'),
('유튜브', 'https://youtube.com', '동영상을 시청하고 공유하세요', '📺', '#ff0000', '엔터테인먼트');

-- 성공 메시지
SELECT 'vive_apps 테이블이 성공적으로 생성되었습니다!' as message,
       COUNT(*) as inserted_rows
FROM vive_apps;
