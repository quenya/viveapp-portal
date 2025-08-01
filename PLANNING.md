# 🌟 ViveApp Portal - 개발 플래닝

## 📋 현재 상태 (v1.0)

### ✅ 완성된 기능
- [x] 기본 포탈 대시보드 UI
- [x] 앱 카드 컴포넌트 (아이콘, 이름, 설명, 카테고리)
- [x] 새 앱 추가 모달
- [x] 로컬스토리지 데이터 저장
- [x] 반응형 디자인 (모바일/데스크톱)
- [x] 카드 호버 애니메이션
- [x] 그라데이션 배경 디자인

### 📱 기본 포함 앱
- [x] 볼링 점수 트래커 (https://bowling-score.vercel.app/)

### 🎯 개선 필요 사항
- [ ] Supabase 데이터베이스 연동 (로컬스토리지 → 클라우드)
- [ ] 모바일 UX 최적화 (터치 인터페이스, 제스처)
- [ ] 아이콘 및 테마 색상 표준화
- [ ] GitHub 저장소 설정 및 자동 배포

---

## 🚀 단기 개발 계획 (v1.1 - v1.3)

### v1.1 - 데이터베이스 연동 및 배포
- [ ] **Supabase 설정**
  - 프로젝트 생성 및 테이블 설계 (apps 테이블)
  - 환경변수 설정 (.env 파일)
  - CRUD 작업 함수 구현

- [ ] **데이터 마이그레이션**
  - 로컬스토리지 → Supabase 이전
  - 기본 앱 데이터 시드 작업
  - 오프라인 모드 대응

- [ ] **배포 환경 구축**
  - GitHub 저장소 생성 및 push
  - Vercel 프로젝트 연결
  - 환경변수 설정 (VITE_SUPABASE_URL, VITE_SUPABASE_ANON_KEY)
  - 자동 배포 파이프라인 구축

### v1.2 - 디자인 시스템 구축
- [ ] **아이콘 시스템**
  - 10개 기본 아이콘 확보: ��📱🎮🛒📊📚🎵🏃‍♂️🍔🧰
  - 이모지 대체 아이콘 세트 (Lucide React 등)
  - 카테고리별 기본 아이콘 매핑

- [ ] **테마 색상 팔레트**
  - 10개 테마 색상 정의:
    - #e91e63 (핑크) - 스포츠/건강
    - #2196f3 (블루) - 생산성/업무  
    - #4caf50 (그린) - 교육/학습
    - #ff9800 (오렌지) - 엔터테인먼트
    - #9c27b0 (퍼플) - 창작/디자인
    - #f44336 (레드) - 긴급/중요
    - #00bcd4 (시안) - 소셜/커뮤니케이션
    - #8bc34a (라이트그린) - 라이프스타일
    - #ff5722 (딥오렌지) - 쇼핑/상거래
    - #607d8b (블루그레이) - 기타/유틸리티
  - CSS 변수로 관리
  - 다크모드 호환 색상 정의

- [ ] **모바일 UX 개선**
  - 터치 친화적 버튼 크기 (최소 44px)
  - 스와이프 제스처 지원
  - 모바일 전용 네비게이션
  - 햅틱 피드백 (진동)

### v1.3 - 사용성 개선
- [ ] **앱 편집 기능**
  - 인라인 편집 모드
  - 길게 누르기(Long Press) 편집 모드
  - 실시간 저장

- [ ] **앱 삭제 기능**
  - 스와이프 투 딜리트 (모바일)
  - 삭제 확인 대화상자
  - 소프트 딜리트 (휴지통 기능)

- [ ] **앱 재정렬**
  - 드래그 앤 드롭 (데스크톱)
  - 터치 드래그 (모바일)
  - 즐겨찾기 고정 기능

---

## 🎯 중기 개발 계획 (v2.0 - v2.2)

### v2.0 - 검색 및 필터링
- [ ] **검색 기능**
  - 상단 검색바 추가 (모바일 최적화)
  - 앱 이름, 설명, 카테고리, URL로 검색
  - 실시간 검색 결과 및 하이라이트
  - 검색 히스토리 저장

- [ ] **카테고리 필터**
  - 수평 스크롤 카테고리 탭 (모바일)
  - 카테고리별 색상 구분
  - 전체/생산성/스포츠/엔터테인먼트/교육/쇼핑/기타

- [ ] **정렬 및 뷰 옵션**
  - 이름순, 추가순, 사용빈도순, 색상순
  - 그리드/리스트 뷰 전환
  - 카드 크기 조절 (소형/중형/대형)

### v2.1 - 향상된 UI/UX
- [ ] **다크/라이트 테마**
  - 테마 토글 스위치 (헤더)
  - 시스템 설정 자동 감지
  - CSS 변수로 테마 관리
  - 부드러운 테마 전환 애니메이션

- [ ] **접근성 개선**
  - 키보드 내비게이션 (Tab, Enter, Space)
  - 스크린 리더 지원 (ARIA 라벨)
  - 고대비 모드 지원
  - 폰트 크기 조절 옵션

### v2.2 - PWA (Progressive Web App)
- [ ] **오프라인 지원**
  - Service Worker 구현
  - 앱 데이터 캐싱 전략
  - 오프라인 상태 표시
  - 동기화 대기열 관리

- [ ] **앱 설치**
  - 홈 화면 추가 가능
  - 커스텀 스플래시 스크린
  - 앱 아이콘 및 매니페스트
  - 푸시 알림 (선택사항)

---

## 🌟 장기 비전 (v3.0+)

### v3.0 - 개인화 및 AI
- [ ] **개인화 추천**
  - 사용 패턴 기반 앱 추천
  - 즐겨 사용하는 앱 우선 표시
  - 시간대별 앱 추천

- [ ] **스마트 카테고리**
  - AI 기반 자동 카테고리 분류
  - URL 분석으로 앱 정보 자동 추출
  - 파비콘 자동 수집

### v3.1 - 협업 기능
- [ ] **공유 포탈**
  - 팀/그룹별 앱 컬렉션
  - 공유 링크 생성
  - 권한 관리 (읽기/편집)

- [ ] **커뮤니티 기능**
  - 앱 컬렉션 공유
  - 사용자 리뷰 및 평점
  - 인기 앱 랭킹

---

## 🛠️ 기술 스택 및 도구

### 프론트엔드
- **Vue.js 3** - Composition API, TypeScript
- **Vite** - 빌드 도구 및 개발 서버
- **CSS3** - 반응형 디자인, CSS 변수, 애니메이션

### 백엔드 & 데이터베이스
- **Supabase** - PostgreSQL, 실시간 구독, 인증
- **테이블 설계**:
  ```sql
  CREATE TABLE apps (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    url TEXT NOT NULL,
    icon VARCHAR(10) DEFAULT '📱',
    category VARCHAR(50) DEFAULT '기타',
    color VARCHAR(7) DEFAULT '#607d8b',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    user_id UUID REFERENCES auth.users(id),
    is_active BOOLEAN DEFAULT true,
    sort_order INTEGER DEFAULT 0
  );
  ```

### 배포 및 인프라
- **GitHub** - 소스 코드 버전 관리
- **Vercel** - 자동 배포, CDN, 환경변수 관리
- **환경변수**: 
  - `VITE_SUPABASE_URL`
  - `VITE_SUPABASE_ANON_KEY`

### 디자인 리소스
- **아이콘 팩**: ��📱🎮🛒📊📚🎵🏃‍♂️🍔🧰
- **색상 팔레트**: 10개 테마 색상 (Material Design 기반)
- **타이포그래피**: Inter 폰트 (가독성 최적화)

### 성능 및 최적화
- **번들 크기**: < 200KB (gzipped)
- **로딩 시간**: < 2초 (3G 기준)
- **Lighthouse 점수**: 90+ (모든 영역)
- **모바일 최적화**: 터치 타겟 44px+, 제스처 지원

---

## 📅 개발 일정

### Phase 1 (1주차) - 인프라 구축
- **Day 1-2**: Supabase 프로젝트 설정 및 테이블 설계
- **Day 3-4**: 데이터 CRUD 함수 구현 및 마이그레이션
- **Day 5-7**: GitHub 저장소 생성, Vercel 배포 설정

### Phase 2 (2주차) - 디자인 시스템
- **Day 1-3**: 아이콘 10개 확보 및 컴포넌트 적용
- **Day 4-5**: 테마 색상 10개 정의 및 CSS 변수 적용
- **Day 6-7**: 모바일 UX 개선 (터치, 제스처, 반응형)

### Phase 3 (3주차) - 기능 개선
- **Day 1-3**: 앱 편집/삭제 기능 구현
- **Day 4-5**: 드래그 앤 드롭 재정렬 기능
- **Day 6-7**: 모바일 전용 인터랙션 (스와이프, 롱프레스)

### Phase 4 (4-5주차) - 고급 기능
- **Week 4**: 검색 및 필터링 시스템 구현
- **Week 5**: 다크모드, PWA 기본 설정

### Phase 5 (6주차+) - 최적화 및 확장
- 성능 최적화, 접근성 개선
- 고급 기능 및 AI 통합

---

## 💡 아이디어 백로그

### UI/UX 아이디어
- [ ] 카드 뒤집기 애니메이션 (앞면: 기본 정보, 뒷면: 상세 정보)
- [ ] 마우스 따라다니는 그라데이션 효과
- [ ] 앱 실행 시 로딩 애니메이션
- [ ] 계절별 테마 변경

### 기능 아이디어
- [ ] QR 코드로 앱 공유
- [ ] 단축키 설정 (Ctrl+1, Ctrl+2 등)
- [ ] 앱 실행 로그 저장
- [ ] 관련 앱 추천 시스템

### 통합 아이디어
- [ ] GitHub Pages 자동 배포
- [ ] Chrome 확장 프로그램 버전
- [ ] 모바일 앱 버전 (React Native)
- [ ] Electron 데스크톱 앱

---

## 🎯 성공 지표 (KPI)

### 기술적 성과
- **성능**: 페이지 로드 시간 < 2초 (3G 환경)
- **번들 크기**: < 200KB (gzipped)
- **Lighthouse 점수**: Performance 90+, Accessibility 90+
- **모바일 최적화**: 터치 타겟 최소 44px, 제스처 지원

### 사용성 지표  
- **앱 접근 시간**: 평균 < 3초 (검색 포함)
- **모바일 사용률**: > 60% (반응형 최적화 목표)
- **앱 추가 완료율**: > 80% (모달 폼 개선)
- **재방문율**: > 70% (PWA 설치 유도)

### 데이터 무결성
- **데이터 동기화**: 99.9% 성공률 (Supabase 실시간)
- **오프라인 지원**: 기본 기능 100% 동작
- **백업 안정성**: 자동 백업 성공률 99%

### 접근성 및 호환성
- **WCAG 2.1 AA**: 100% 준수
- **브라우저 지원**: Chrome 90+, Safari 14+, Firefox 88+
- **모바일 지원**: iOS 14+, Android 8+

---

*최종 업데이트: 2025년 7월 26일*
