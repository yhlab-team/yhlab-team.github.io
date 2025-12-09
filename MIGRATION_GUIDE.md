# Flutter 웹에서 Next.js로 마이그레이션 가이드

## 🎉 마이그레이션 완료!

Flutter 웹 프로젝트를 Next.js 14로 성공적으로 전환했습니다.

## ✅ 완료된 작업

1. **프로젝트 구조**
   - Next.js 14 App Router 기반 프로젝트 생성
   - TypeScript 설정
   - Tailwind CSS 설정

2. **페이지 마이그레이션**
   - ✅ 홈페이지 (/)
   - ✅ 블로그 목록 (/blogs)
   - ✅ 블로그 상세 (/blogs/[postId])

3. **컴포넌트 변환**
   - ✅ AppHeader (네비게이션)
   - ✅ AppFooter
   - ✅ HeroSection
   - ✅ WaveHeader (Canvas 애니메이션)
   - ✅ DeveloperCommentSection
   - ✅ FeaturesSection
   - ✅ DownloadSection

4. **블로그 시스템**
   - ✅ MDX 기반 블로그 포스트
   - ✅ 2개의 블로그 글 마이그레이션
     - 망각곡선으로 이해하는 기억의 과학
     - 💰 Nemo로 공부하면서 포인트 받기

5. **SEO 최적화**
   - ✅ 메타 태그 설정
   - ✅ Open Graph 태그
   - ✅ sitemap.xml
   - ✅ robots.txt
   - ✅ 정적 사이트 생성 (SSG)

6. **배포 설정**
   - ✅ GitHub Actions 워크플로우
   - ✅ GitHub Pages 설정
   - ✅ .nojekyll 파일

## 🚀 배포 방법

### 1. GitHub 저장소 생성

```bash
# 현재 위치: /Users/park-youngho/flutterProjects/yhlab-nextjs

# GitHub에서 새 저장소를 생성하거나, 기존 저장소 사용
# 저장소 이름: yhlab-team.github.io (기존과 동일)
```

### 2. 원격 저장소 연결

```bash
git remote add origin https://github.com/yhlab-team/yhlab-team.github.io.git
```

### 3. 배포

```bash
# main 브랜치에 푸시
git push -u origin main

# GitHub Actions가 자동으로:
# 1. 프로젝트 빌드
# 2. out/ 폴더를 GitHub Pages에 배포
```

### 4. GitHub Pages 설정

GitHub 저장소 설정에서:
1. Settings → Pages
2. Source: "GitHub Actions" 선택
3. 자동으로 배포됩니다!

## 📊 Flutter 웹 vs Next.js 비교

| 항목 | Flutter 웹 | Next.js |
|------|-----------|---------|
| **렌더링** | CSR (클라이언트만) | SSG/SSR (서버 사전 렌더링) |
| **SEO** | ❌ 매우 나쁨 | ✅ 완벽 |
| **초기 로딩** | 느림 (큰 번들 크기) | 빠름 (최적화됨) |
| **검색 노출** | ❌ 어려움 | ✅ 우수 |
| **빌드 크기** | 큼 (수 MB) | 작음 (KB 단위) |
| **성능** | 중간 | 우수 |

## 🎯 SEO 개선 효과

### Flutter 웹의 문제점
- 검색 엔진이 JavaScript를 실행해야만 콘텐츠를 볼 수 있음
- 메타 태그가 동적으로 생성되어 크롤러가 인식 못함
- 페이지별 독립적인 메타데이터 설정 어려움

### Next.js의 장점
- ✅ 모든 페이지가 HTML로 사전 렌더링됨
- ✅ 검색 엔진이 즉시 콘텐츠를 읽을 수 있음
- ✅ 각 페이지에 맞춤형 메타 태그 설정
- ✅ sitemap과 robots.txt로 크롤링 최적화

## 📝 새로운 블로그 글 추가하는 방법

### 1. MDX 파일 생성

`content/` 폴더에 새 파일 생성:

```bash
content/my-new-post.mdx
```

### 2. 메타데이터 추가

`lib/data/blog-posts.ts` 파일에 추가:

```typescript
{
  id: 'my-new-post',
  title: '새로운 글 제목',
  subtitle: '부제목',
  excerpt: '요약문...',
  date: '2025년 12월 10일',
  readTime: '5분',
  icon: 'auto_graph',
  tags: ['태그1', '태그2'],
}
```

### 3. 커밋 & 푸시

```bash
git add .
git commit -m "Add new blog post"
git push
```

자동으로 배포됩니다!

## 🔧 로컬 개발

```bash
# 개발 서버 실행
npm run dev

# 브라우저에서 열기
# http://localhost:3000
```

## 📦 프로젝트 구조

```
yhlab-nextjs/
├── app/                    # Next.js 페이지
│   ├── layout.tsx         # 루트 레이아웃 (헤더/푸터 포함)
│   ├── page.tsx           # 홈페이지
│   └── blogs/             # 블로그 페이지
│       ├── page.tsx       # 목록
│       └── [postId]/      # 상세
│           └── page.tsx
├── components/            # 재사용 컴포넌트
│   ├── AppHeader.tsx
│   ├── AppFooter.tsx
│   └── home/             # 홈 섹션들
├── content/              # MDX 블로그 포스트
│   ├── forgetting-curve.mdx
│   └── app-tech-with-nemo.mdx
├── lib/                  # 유틸리티
│   ├── constants/        # 상수 (색상 등)
│   ├── data/            # 데이터
│   └── types/           # TypeScript 타입
└── public/              # 정적 파일
    ├── assets/images/   # 이미지
    ├── sitemap.xml
    └── robots.txt
```

## 🎨 디자인 시스템

기존 Flutter의 `YHColor`를 Next.js로 이식:

```typescript
// lib/constants/colors.ts
export const YHColor = {
  primary: '#2196F3',
  textDefault: '#0F172A',
  textSub: '#64748B',
  textDisabled: '#94A3B8',
};
```

## ⚠️ 주의사항

1. **이미지 경로**
   - Flutter: `assets/images/`
   - Next.js: `/assets/images/` (public 폴더 기준)

2. **라우팅**
   - Flutter: `context.go('/path')`
   - Next.js: `<Link href="/path">` 또는 `router.push('/path')`

3. **상태 관리**
   - 클라이언트 컴포넌트는 파일 상단에 `'use client'` 추가

## 🆘 문제 해결

### 빌드 오류
```bash
# 캐시 삭제
rm -rf .next node_modules
npm install
npm run build
```

### 배포 안 됨
- GitHub Actions 탭에서 에러 확인
- Repository Settings → Pages에서 설정 확인

## 📚 참고 자료

- [Next.js 공식 문서](https://nextjs.org/docs)
- [MDX 문서](https://mdxjs.com/)
- [GitHub Pages 가이드](https://docs.github.com/en/pages)

## 💪 다음 단계

마이그레이션이 완료되었습니다! 이제:

1. ✅ GitHub에 푸시
2. ✅ GitHub Pages 배포 확인
3. ✅ Google Search Console에서 사이트맵 제출
4. ✅ 검색 엔진 노출 확인 (며칠 소요)

---

**축하합니다! 🎉 SEO 최적화된 Next.js 사이트가 준비되었습니다!**


