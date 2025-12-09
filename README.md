# YHLab - Nemo 학습 앱 홍보 사이트

Next.js 14로 만든 Nemo 학습 앱 소개 및 블로그 사이트입니다.

## 기술 스택

- **Next.js 14** (App Router)
- **TypeScript**
- **Tailwind CSS**
- **MDX** (블로그 포스트)
- **GitHub Pages** (배포)

## 주요 기능

- ✅ **완벽한 SEO**: SSG(Static Site Generation)로 모든 페이지가 사전 렌더링됩니다
- ✅ **빠른 로딩**: 정적 사이트로 최적화된 성능
- ✅ **블로그 시스템**: MDX 기반 마크다운 블로그
- ✅ **반응형 디자인**: 모바일, 태블릿, 데스크톱 모두 지원

## 로컬 개발

```bash
# 의존성 설치
npm install

# 개발 서버 실행
npm run dev

# 프로덕션 빌드
npm run build

# 빌드된 사이트 미리보기
npm run start
```

## 배포

GitHub Actions를 통해 자동 배포됩니다.

1. `main` 브랜치에 푸시
2. GitHub Actions가 자동으로 빌드
3. GitHub Pages에 자동 배포

## 블로그 글 추가하는 방법

1. `content/` 폴더에 새로운 `.mdx` 파일 생성
2. `lib/data/blog-posts.ts` 파일에 메타데이터 추가
3. 커밋 & 푸시

## 프로젝트 구조

```
yhlab-nextjs/
├── app/                    # Next.js App Router 페이지
│   ├── blogs/             # 블로그 페이지
│   ├── layout.tsx         # 루트 레이아웃
│   └── page.tsx           # 홈페이지
├── components/            # React 컴포넌트
│   ├── home/             # 홈페이지 섹션 컴포넌트
│   ├── AppHeader.tsx     # 헤더
│   └── AppFooter.tsx     # 푸터
├── content/              # MDX 블로그 포스트
├── lib/                  # 유틸리티 & 데이터
│   ├── constants/        # 상수 (색상 등)
│   ├── data/            # 블로그 데이터
│   └── types/           # TypeScript 타입
└── public/              # 정적 파일 (이미지, 아이콘 등)
```

## SEO 최적화

- ✅ 모든 페이지에 메타 태그 설정
- ✅ Open Graph 태그 설정
- ✅ sitemap.xml 생성
- ✅ robots.txt 설정
- ✅ 의미있는 URL 구조

## Flutter 웹에서 Next.js로 전환한 이유

Flutter 웹은 클라이언트 사이드 렌더링(CSR)만 지원하여 SEO에 치명적인 약점이 있습니다. 
검색 엔진이 콘텐츠를 제대로 크롤링하지 못해 검색 노출이 어렵습니다.

Next.js는 SSG/SSR을 통해 완벽한 SEO를 제공하며, 블로그나 랜딩 페이지에 최적화되어 있습니다.

## 라이센스

© 2024 YHLab. All rights reserved.
