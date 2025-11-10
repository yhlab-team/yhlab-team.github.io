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
- **배포**: GitHub Pages (GitHub Actions)
- **패키지**:
  - `google_fonts`: Noto Sans KR 폰트
  - `url_launcher`: 스토어 링크 연동

## 🏃‍♂️ 로컬 실행

```bash
# 의존성 설치
flutter pub get

# 개발 서버 실행
flutter run -d chrome

# 웹 빌드
flutter build web --release
```

## 📦 배포

GitHub Actions를 통해 자동으로 배포됩니다.

1. `main` 브랜치에 푸시
2. GitHub Actions가 자동으로 빌드
3. GitHub Pages에 배포 완료

## 📱 앱 다운로드

### Nemo
- [App Store](https://apps.apple.com/app/id1547183996)
- [Play Store](https://play.google.com/store/apps/details?id=com.Nemo.ParkYoungHo)

### 티켓다이어리
- [App Store](https://apps.apple.com/app/id6741766750)
- [Play Store](https://play.google.com/store/apps/details?id=com.memorylog.yhlab)

## 📄 라이선스

© 2024 YHLab. All rights reserved.
