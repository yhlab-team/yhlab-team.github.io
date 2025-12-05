import 'package:flutter/material.dart';
import 'package:yh_design_system/atoms/color/colors.dart';
import 'package:yhlab_web/components/app_header.dart';
import 'package:yhlab_web/components/app_footer.dart';

/// 소개 페이지 - AI, 망각곡선, 메타인지 핵심 기능 소개
final class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const AppHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20 : 60,
                  vertical: isMobile ? 60 : 100,
                ),
                child: Column(
                  children: [
                    Text(
                      'Nemo의 핵심 기능',
                      style: TextStyle(
                        fontSize: isMobile ? 36 : 48,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '과학적 근거와 최신 기술로 완성된 학습 솔루션',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 16 : 20,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 80),

                    // 기능 카드들
                    _buildFeatureSection(
                      icon: Icons.psychology,
                      iconColor: YHColor.primary,
                      title: 'AI 기반 학습',
                      subtitle: '인공지능이 당신의 학습을 분석합니다',
                      description:
                          '머신러닝 알고리즘이 당신의 학습 패턴을 분석하고 최적의 복습 시점을 제안합니다. '
                          '개인의 기억력과 학습 속도에 맞춰 완벽하게 조정된 학습 경험을 제공합니다.',
                      features: ['개인 맞춤형 학습 스케줄', '실시간 학습 성과 분석', '지능형 콘텐츠 추천'],
                      isMobile: isMobile,
                    ),

                    SizedBox(height: isMobile ? 60 : 100),

                    _buildFeatureSection(
                      icon: Icons.auto_graph,
                      iconColor: const Color(0xFFEC4899),
                      title: '망각곡선 기반 복습',
                      subtitle: '에빙하우스의 망각곡선을 활용한 과학적 복습',
                      description:
                          '인간의 기억은 시간이 지나면서 자연스럽게 희미해집니다. '
                          'Nemo는 망각곡선 이론에 기반하여 최적의 복습 시점을 계산하고, '
                          '장기 기억으로 전환될 수 있도록 효과적인 간격 반복 학습을 지원합니다.',
                      features: [
                        '과학적으로 증명된 복습 주기',
                        '장기 기억 형성 최적화',
                        '효율적인 학습 시간 관리',
                      ],
                      isMobile: isMobile,
                    ),

                    SizedBox(height: isMobile ? 60 : 100),

                    _buildFeatureSection(
                      icon: Icons.self_improvement,
                      iconColor: const Color(0xFF10B981),
                      title: '메타인지 향상',
                      subtitle: '스스로의 학습을 이해하고 조절하는 능력',
                      description:
                          '메타인지는 자신의 사고 과정을 인식하고 통제하는 능력입니다. '
                          'Nemo는 학습 과정을 시각화하고 피드백을 제공하여 '
                          '자신의 학습 상태를 객관적으로 파악하고 효과적으로 조절할 수 있게 돕습니다.',
                      features: [
                        '학습 진행 상황 시각화',
                        '자기 평가 및 성찰 도구',
                        '학습 전략 개선 제안',
                      ],
                      isMobile: isMobile,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const AppFooter(),
        ],
      ),
    );
  }

  Widget _buildFeatureSection({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String description,
    required List<String> features,
    required bool isMobile,
  }) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 32 : 48),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, size: 40, color: iconColor),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: isMobile ? 24 : 28,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF475569),
              height: 1.8,
            ),
          ),
          const SizedBox(height: 24),
          ...features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: iconColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      feature,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF475569),
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
