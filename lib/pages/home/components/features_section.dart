import 'package:flutter/material.dart';
import 'package:yh_design_system/atoms/color/colors.dart';

/// Nemo 기능 소개 섹션
class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: YHColor.primary.withAlpha(13),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Nemo가 특별한 이유',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: YHColor.primary,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            '효과적인 학습을 위한 모든 것',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF0F172A),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 60),

          // 7가지 주요 기능
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [
              FeatureCard(
                icon: Icons.auto_awesome,
                title: 'AI 활용 학습',
                description: '학습 자료를 분석해, 노트와 카드를 자동 생성할 수 있습니다',
                isMobile: isMobile,
              ),
              FeatureCard(
                icon: Icons.psychology_outlined,
                title: '자동 장기기억 형성',
                description: '에빙하우스 망각곡선을 기반. 복습 주기에 맞게 학습을 추천해드립니다',
                isMobile: isMobile,
              ),
              FeatureCard(
                icon: Icons.card_giftcard,
                title: '리워드 & 앱테크',
                description: '출석, 학습, 광고 시청 등 꾸준한 유저분들과의 공생을 위한 리워드 기능',
                isMobile: isMobile,
              ),
              FeatureCard(
                icon: Icons.shuffle,
                title: '메타인지 학습',
                description: '여러 정답·오답을 랜덤 제출, 답 위치 자동 셔플로 정확한 학습 확인',
                isMobile: isMobile,
              ),
              FeatureCard(
                icon: Icons.style_outlined,
                title: '다양한 학습 방식',
                description: '플래시카드, 문제카드(객관식/주관식), 암기 모드, 시험 모드 지원',
                isMobile: isMobile,
              ),
              FeatureCard(
                icon: Icons.share_outlined,
                title: '노트 공유',
                description: '노트를 다른 유저와 공유하거나, 엑셀 추출/가져오기 가능',
                isMobile: isMobile,
              ),
              FeatureCard(
                icon: Icons.more_horiz,
                title: '기본 기능 완비',
                description: 'TTS, 오답노트, 북마크, 다크모드, 아이패드 스플릿뷰 등',
                isMobile: isMobile,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 기능 카드 위젯
class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isMobile;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isMobile ? double.infinity : 340,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: YHColor.primary.withAlpha(26),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, size: 40, color: YHColor.primary),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF64748B),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

