# � WebApp Portal Dashboard

Vue.js + TypeScript로 구축된 모던 웹 앱 포털 대시보드입니다. 다양한 웹 애플리케이션을 한 곳에서 관리하고 접근할 수 있는 중앙화된 포털을 제공합니다.

## ✨ 주요 기능

- **📱 반응형 디자인**: 모바일과 데스크톱 모두에서 완벽하게 작동
- **🎨 카드 기반 레이아웃**: 직관적이고 모던한 UI/UX
- **📊 카테고리 관리**: 10개의 사전 정의된 카테고리로 앱 분류
- **🎯 CRUD 기능**: 앱 추가, 편집, 삭제 기능
- **🎨 색상 팔레트**: 10가지 테마 색상으로 개인화
- **🔍 아이콘 선택**: 10개의 엄선된 이모지 아이콘
- **💾 데이터베이스 연동**: Supabase를 통한 실시간 데이터 저장
- **⚡ 빠른 성능**: Vite 기반의 빠른 개발 및 빌드

## 🛠 기술 스택

- **Frontend**: Vue.js 3 (Composition API)
- **Language**: TypeScript
- **Build Tool**: Vite
- **Database**: Supabase (PostgreSQL)
- **Styling**: CSS3 (모듈화된 스타일)
- **Icons**: 이모지 기반 아이콘 시스템

## 🚀 시작하기

### 필수 요구사항

- Node.js (v16 이상)
- npm 또는 yarn
- Supabase 계정

### 설치

1. 저장소 클론
```bash
git clone https://github.com/yourusername/viveapp-portal.git
cd viveapp-portal
```

2. 의존성 설치
```bash
npm install
```

3. 환경 변수 설정
`.env` 파일을 생성하고 Supabase 설정 추가:
```env
VITE_SUPABASE_URL=your_supabase_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
```

4. 데이터베이스 테이블 생성
Supabase에서 다음 SQL을 실행:
```sql
CREATE TABLE vive_apps (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  url TEXT NOT NULL,
  icon TEXT NOT NULL,
  category TEXT NOT NULL,
  color TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()) NOT NULL
);
```

5. 개발 서버 실행
```bash
npm run dev
```

### 빌드
```bash
npm run build
```

## 📁 프로젝트 구조

```
src/
├── components/
│   ├── AddAppModal.vue      # 새 앱 추가 모달
│   ├── AppCard.vue          # 앱 카드 컴포넌트
│   └── EditAppModal.vue     # 앱 편집 모달
├── lib/
│   ├── appService.ts        # 앱 CRUD 서비스
│   └── supabase.ts          # Supabase 클라이언트 설정
├── App.vue                  # 메인 애플리케이션
└── main.ts                  # 애플리케이션 진입점
```

## 🎨 카테고리 시스템

다음 10개 카테고리를 지원합니다:

1. **💻 생산성** - 업무 및 생산성 도구
2. **🎮 엔터테인먼트** - 게임 및 미디어
3. **💬 커뮤니케이션** - 메신저 및 소셜
4. **🔧 유틸리티** - 도구 및 유틸리티
5. **⚡ 개발** - 개발 도구 및 IDE
6. **🎨 디자인** - 디자인 및 크리에이티브
7. **📚 교육** - 학습 및 교육 자료
8. **💰 금융** - 금융 및 결제 서비스
9. **🛒 쇼핑** - 쇼핑 및 이커머스
10. **🏃‍♂️ 스포츠** - 스포츠 및 피트니스

## 🎯 사용법

1. **앱 추가**: "+" 버튼을 클릭하여 새 앱 추가
2. **앱 편집**: 카드의 편집 버튼을 클릭하여 수정
3. **앱 삭제**: 편집 모달에서 삭제 버튼 사용
4. **앱 실행**: 카드를 클릭하여 해당 웹 앱으로 이동

## 🤝 기여하기

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다.

## 🙏 감사의 말

- [Vue.js](https://vuejs.org/) - 반응형 웹 애플리케이션 프레임워크
- [Vite](https://vitejs.dev/) - 빠른 빌드 도구
- [Supabase](https://supabase.com/) - 오픈소스 백엔드 플랫폼
- [TypeScript](https://www.typescriptlang.org/) - 타입 안전성

---

⭐ 이 프로젝트가 도움이 되었다면 스타를 눌러주세요!

### 미리보기

```bash
npm run preview
```

## 📱 사용 방법

1. **앱 보기**: 메인 대시보드에서 등록된 모든 앱을 카드 형태로 확인
2. **앱 실행**: 카드를 클릭하거나 "실행" 버튼을 클릭하여 앱을 새 탭에서 열기
3. **앱 추가**: "새 앱 추가" 카드를 클릭하여 새로운 웹앱 등록
4. **자동 저장**: 추가한 앱들은 자동으로 브라우저에 저장됨

## 🎨 기본 포함 앱

- **볼링 점수 트래커**: 볼링 게임 점수 기록 및 통계 확인

## 📂 프로젝트 구조

```
src/
├── components/
│   ├── AppCard.vue      # 앱 카드 컴포넌트
│   └── AddAppModal.vue  # 앱 추가 모달
├── App.vue              # 메인 애플리케이션
├── main.ts              # 앱 진입점
└── style.css            # 글로벌 스타일
```

## 🔧 커스터마이징

앱을 추가할 때 다음을 설정할 수 있습니다:
- 앱 이름과 설명
- URL 주소
- 이모지 아이콘
- 카테고리 (생산성, 스포츠, 엔터테인먼트 등)
- 테마 색상

## 📄 라이선스

MIT License
