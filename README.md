# YHLab - 삶의 흐름을 매끄럽게

Flutter Web으로 제작된 YHLab 공식 웹사이트입니다.

## 🚀 프로젝트 소개

삶의 흐름을 매끄럽게 해주는 윤활유 같은 도구를 만드는 YHLab의 웹사이트입니다.

### 주요 앱

- **Nemo**: 효과적인 간격 반복 학습으로 장기 기억을 돕는 복습 앱
- **티켓다이어리**: 특별한 순간의 티켓을 디지털 다이어리로 보관하는 앱

## 🛠 기술 스택

- **Framework**: Flutter Web
- **언어**: Dart
- **라우팅**: go_router (Path URL Strategy)
- **배포**: GitHub Pages (GitHub Actions)
- **디자인 시스템**: yh_design_system (private)

## 📁 프로젝트 구조

```
yhlab-team.github.io/
├── lib/
│   ├── main.dart              # 앱 진입점
│   ├── router.dart            # 라우터 설정
│   ├── models/
│   │   └── blog_post.dart     # 블로그 데이터 모델
│   ├── data/
│   │   └── blog_posts_data.dart  # 블로그 글 목록
│   ├── pages/
│   │   ├── home.dart          # 홈 페이지
│   │   ├── blog_list.dart     # 블로그 목록
│   │   └── blog_detail.dart   # 블로그 상세
│   └── components/
│       ├── app_header.dart    # 공통 헤더
│       └── app_footer.dart    # 공통 푸터
├── web/
│   ├── index.html             # HTML 템플릿
│   ├── 404.html               # SPA 라우팅 지원
│   ├── sitemap.xml            # 검색엔진용 사이트맵
│   └── robots.txt             # 크롤러 설정
└── tool/
    └── generate_sitemap.dart  # Sitemap 자동 생성
```

## 🏃‍♂️ 로컬 실행

```bash
# 의존성 설치
flutter pub get

# 개발 서버 실행
flutter run -d chrome

# Sitemap 생성 (선택사항)
dart run tool/generate_sitemap.dart

# 웹 빌드
flutter build web --release
```

## ✍️ 블로그 글 작성

### 1. 새 블로그 글 추가

`lib/data/blog_posts_data.dart`에 새 `BlogPost` 추가:

```dart
final List<BlogPost> allBlogPosts = [
  // 기존 글들...
  
  BlogPost(
    id: 'new-post-id',           // URL에 사용될 ID
    title: '글 제목',
    subtitle: '부제목',
    excerpt: '목록에 표시될 발췌문...',
    fullContent: '''전체 내용...''',
    date: '2025년 12월 5일',
    readTime: '3분',
    icon: Icons.lightbulb,
    iconColor: YHColor.primary,
    tags: ['태그1', '태그2'],
  ),
];
```

### 2. Sitemap 자동 업데이트

글을 추가한 후:

```bash
# 로컬에서 sitemap 생성
dart run tool/generate_sitemap.dart

# 확인
cat web/sitemap.xml
```

**배포 시 자동 생성됩니다!** GitHub Actions가 빌드 전에 자동으로 sitemap을 생성하므로 수동으로 할 필요 없습니다.

## 📦 배포

GitHub Actions를 통해 자동으로 배포됩니다.

### 배포 프로세스

1. `main` 브랜치에 푸시
2. GitHub Actions 실행:
   - Private repository 인증 (GH_PAT 사용)
   - 의존성 설치
   - **Sitemap 자동 생성** ✨
   - Flutter Web 빌드
   - GitHub Pages 배포
3. 배포 완료!

### 필수 설정

**GitHub Secret 설정 필요:**
- `GH_PAT`: Private repository 접근용 Personal Access Token
  - Settings → Secrets → Actions → New repository secret
  - `repo` 권한 필요

## 🔍 SEO 설정

- ✅ `sitemap.xml`: 자동 생성
- ✅ `robots.txt`: 검색엔진 크롤링 허용
- ✅ Meta tags: Open Graph, Twitter Card
- ✅ Google Search Console 인증
- ✅ Path URL Strategy (깔끔한 URL)

## 📱 앱 다운로드

### Nemo
- [App Store](https://apps.apple.com/app/id1547183996)
- [Play Store](https://play.google.com/store/apps/details?id=com.Nemo.ParkYoungHo)

### 티켓다이어리
- [App Store](https://apps.apple.com/app/id6741766750)
- [Play Store](https://play.google.com/store/apps/details?id=com.memorylog.yhlab)

## 📄 라이선스

© 2024 YHLab. All rights reserved.
