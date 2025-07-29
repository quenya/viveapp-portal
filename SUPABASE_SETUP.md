# Supabase 프로젝트 설정 가이드

## 1. Supabase 프로젝트 생성

1. [https://supabase.com](https://supabase.com)에 접속
2. "Start your project" 또는 "New project" 클릭
3. GitHub 계정으로 로그인
4. 프로젝트 정보 입력:
   - Name: `viveapp-portal`
   - Database Password: 강력한 비밀번호 생성 (저장해두세요!)
   - Region: `Northeast Asia (Seoul)` 선택
   - Pricing plan: `Free tier` 선택

## 2. 데이터베이스 테이블 생성

프로젝트 생성 후 SQL Editor에서 다음 쿼리를 실행하세요:

```sql
-- 앱 정보를 저장할 테이블 생성
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

-- RLS (Row Level Security) 활성화
ALTER TABLE vive_apps ENABLE ROW LEVEL SECURITY;

-- 모든 사용자가 읽기 가능하도록 정책 생성 (현재는 인증 없이)
CREATE POLICY "Enable read access for all users" ON vive_apps
  FOR SELECT USING (true);

-- 모든 사용자가 삽입 가능하도록 정책 생성
CREATE POLICY "Enable insert for all users" ON vive_apps
  FOR INSERT WITH CHECK (true);

-- 모든 사용자가 업데이트 가능하도록 정책 생성
CREATE POLICY "Enable update for all users" ON vive_apps
  FOR UPDATE USING (true);

-- 모든 사용자가 삭제 가능하도록 정책 생성
CREATE POLICY "Enable delete for all users" ON vive_apps
  FOR DELETE USING (true);

-- 업데이트 시간 자동 갱신을 위한 함수 생성
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
```

## 3. 환경 변수 설정

프로젝트의 Settings → API에서 다음 정보를 복사하세요:

1. **Project URL**: `https://xxxxxxxxxx.supabase.co`
2. **anon public key**: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...`

`.env` 파일을 다음과 같이 업데이트하세요:

```
VITE_SUPABASE_URL=여기에_프로젝트_URL_입력
VITE_SUPABASE_ANON_KEY=여기에_ANON_PUBLIC_KEY_입력
```

## 4. 기본 데이터 삽입 (선택사항)

SQL Editor에서 기본 앱들을 삽입할 수 있습니다:

```sql
INSERT INTO vive_apps (name, url, description, icon, color, category) VALUES
('볼링 점수 추적기', 'https://bowling-score-tracker-one.vercel.app/', '볼링 게임의 점수를 추적하고 통계를 확인하세요', '🎳', '#10b981', 'entertainment'),
('날씨 앱', 'https://weather.com', '실시간 날씨 정보를 확인하세요', '🌤️', '#3b82f6', 'utility'),
('할일 관리', 'https://todoist.com', '할일을 체계적으로 관리하세요', '📝', '#8b5cf6', 'productivity'),
('음악 스트리밍', 'https://spotify.com', '좋아하는 음악을 들어보세요', '🎵', '#1db954', 'entertainment'),
('이메일', 'https://gmail.com', '이메일을 확인하고 관리하세요', '📧', '#ea4335', 'communication');
```

## 5. 연결 테스트

프로젝트 루트에서 다음 명령어로 개발 서버를 실행하세요:

```bash
npm run dev
```

브라우저에서 `http://localhost:5173`에 접속하여 앱이 정상적으로 로드되는지 확인하세요.

## 6. 문제 해결

### 연결 오류가 발생하는 경우:
1. `.env` 파일의 URL과 키가 정확한지 확인
2. Supabase 프로젝트가 활성 상태인지 확인
3. 브라우저 개발자 도구에서 네트워크 탭 확인

### RLS 정책 오류가 발생하는 경우:
1. SQL Editor에서 정책이 올바르게 생성되었는지 확인
2. 필요시 정책을 삭제하고 다시 생성

```sql
-- 기존 정책 삭제 (필요시)
DROP POLICY IF EXISTS "Enable read access for all users" ON vive_apps;
DROP POLICY IF EXISTS "Enable insert for all users" ON vive_apps;
DROP POLICY IF EXISTS "Enable update for all users" ON vive_apps;
DROP POLICY IF EXISTS "Enable delete for all users" ON vive_apps;
```

## 다음 단계

1. ✅ Supabase 프로젝트 생성
2. ✅ 데이터베이스 테이블 생성
3. ✅ 환경 변수 설정
4. ✅ 연결 테스트
5. 🔄 GitHub 저장소 생성 및 코드 푸시
6. 🔄 Vercel 배포 설정
7. 🔄 도메인 연결 (선택사항)
