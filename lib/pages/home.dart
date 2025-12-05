import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yh_design_system/atoms/color/colors.dart';
import 'package:yh_design_system/atoms/font/fonts.dart';
import 'package:yh_design_system/atoms/text/text.dart';
import 'package:yh_design_system/organisms/scaffold/scaffold.dart';
import 'package:yhlab_web/components/app_header.dart';
import 'package:yhlab_web/components/app_footer.dart';

/// 메인 페이지 - Nemo 소개 및 다운로드
final class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;

    return YHScaffold(
      body: Column(
        children: [
          const AppHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  // Nemo 아이콘
                  Container(
                    width: isMobile ? 100 : 140,
                    height: isMobile ? 100 : 140,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      // boxShadow: YHBoxShadow.neumorphicShadow(
                      //   spreadRadius: 6,
                      //   blurRadius: 2,
                      // ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(51),
                          blurRadius: 40,
                          offset: const Offset(0, 20),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        'assets/images/nemo_icon.png',
                        width: isMobile ? 100 : 140,
                        height: isMobile ? 100 : 140,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  YHText(
                    text: "Nemo",
                    font: isMobile ? YHFont.bold48 : YHFont.bold72,
                    color: YHColor.textDefault,
                  ),
                  // const SizedBox(height: 12),
                  YHText(
                    text: "Note + Memo",
                    font: isMobile ? YHFont.regular16 : YHFont.regular20,
                    color: YHColor.textSub,
                  ),
                  const SizedBox(height: 28),
                  YHText(
                    text: "📌📑 학습부터 장기기억, 💰 앱테크까지",
                    font: isMobile ? YHFont.bold24 : YHFont.bold32,
                    color: YHColor.textDefault,
                  ),
                  const SizedBox(height: 16),
                  YHText(
                    text: "평생 공부시대의 든든한 파트너!",
                    font: isMobile ? YHFont.regular16 : YHFont.regular20,
                    color: YHColor.textDefault,
                  ),
                  const SizedBox(height: 40),

                  // 개발자 코멘트 섹션
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(13),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 20 : 60,
                      vertical: isMobile ? 60 : 80,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.format_quote,
                          size: isMobile ? 40 : 60,
                          color: YHColor.primary.withAlpha(75),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          '개발자 코멘트',
                          style: TextStyle(
                            fontSize: isMobile ? 20 : 24,
                            fontWeight: FontWeight.w700,
                            color: YHColor.primary,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 800),
                          child: Text(
                            '사람은 끝없이 망각합니다.\n\n자격증 취득을 위해, 수 년 전 학습한 것을\n다시 공부한 적 없으신가요?\n\n죽을때 까지 공부할텐데..\n장기기억 형성의 필요성을 느껴\n편리한 복습을 위해 만든 앱 입니다.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isMobile ? 16 : 18,
                              color: const Color(0xFF475569),
                              height: 1.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Nemo 기능 소개 섹션
                  Container(
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
                            _buildFeatureCard(
                              icon: Icons.auto_awesome,
                              title: 'AI 활용 학습',
                              description: '학습 자료를 분석해, 노트와 카드를 자동 생성할 수 있습니다',
                              isMobile: isMobile,
                            ),
                            _buildFeatureCard(
                              icon: Icons.psychology_outlined,
                              title: '자동 장기기억 형성',
                              description:
                                  '에빙하우스 망각곡선을 기반. 복습 주기에 맞게 학습을 추천해드립니다',
                              isMobile: isMobile,
                            ),
                            _buildFeatureCard(
                              icon: Icons.card_giftcard,
                              title: '리워드 & 앱테크',
                              description:
                                  '출석, 학습, 광고 시청 등 꾸준한 유저분들과의 공생을 위한 리워드 기능',
                              isMobile: isMobile,
                            ),
                            _buildFeatureCard(
                              icon: Icons.shuffle,
                              title: '메타인지 학습',
                              description:
                                  '여러 정답·오답을 랜덤 제출, 답 위치 자동 셔플로 정확한 학습 확인',
                              isMobile: isMobile,
                            ),
                            _buildFeatureCard(
                              icon: Icons.style_outlined,
                              title: '다양한 학습 방식',
                              description:
                                  '플래시카드, 문제카드(객관식/주관식), 암기 모드, 시험 모드 지원',
                              isMobile: isMobile,
                            ),
                            _buildFeatureCard(
                              icon: Icons.share_outlined,
                              title: '노트 공유',
                              description: '노트를 다른 유저와 공유하거나, 엑셀 추출/가져오기 가능',
                              isMobile: isMobile,
                            ),
                            _buildFeatureCard(
                              icon: Icons.more_horiz,
                              title: '기본 기능 완비',
                              description: 'TTS, 오답노트, 북마크, 다크모드, 아이패드 스플릿뷰 등',
                              isMobile: isMobile,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // 다운로드 CTA 섹션
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 20 : 60,
                      vertical: isMobile ? 80 : 120,
                    ),
                    child: Column(
                      children: [
                        Text(
                          '지금 바로 시작해야 더 많이 기억할 수 있어요',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'iOS와 Android에서 무료로 다운로드',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isMobile ? 16 : 20,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 60),

                        // 다운로드 버튼들
                        if (isMobile)
                          Column(
                            children: [
                              _buildDownloadButton(
                                icon: Icons.apple,
                                text: 'App Store에서 다운로드',
                                color: const Color(0xFF000000),
                                url: 'https://apps.apple.com/app/id1547183996',
                                isMobile: isMobile,
                              ),
                              const SizedBox(height: 20),
                              _buildDownloadButton(
                                icon: Icons.android,
                                text: 'Google Play에서 다운로드',
                                color: const Color(0xFF3DDC84),
                                url:
                                    'https://play.google.com/store/apps/details?id=com.Nemo.ParkYoungHo',
                                isMobile: isMobile,
                              ),
                            ],
                          )
                        else
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildDownloadButton(
                                icon: Icons.apple,
                                text: 'App Store에서 다운로드',
                                color: const Color(0xFF000000),
                                url: 'https://apps.apple.com/app/id1547183996',
                                isMobile: isMobile,
                              ),
                              const SizedBox(width: 20),
                              _buildDownloadButton(
                                icon: Icons.android,
                                text: 'Google Play에서 다운로드',
                                color: const Color(0xFF3DDC84),
                                url:
                                    'https://play.google.com/store/apps/details?id=com.Nemo.ParkYoungHo',
                                isMobile: isMobile,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),

                  const AppFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required bool isMobile,
  }) {
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

  Widget _buildDownloadButton({
    required IconData icon,
    required String text,
    required Color color,
    required String url,
    required bool isMobile,
  }) {
    return SizedBox(
      width: isMobile ? double.infinity : 320,
      child: ElevatedButton.icon(
        onPressed: () => _launchUrl(url),
        icon: Icon(icon, size: 28),
        label: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          shadowColor: color.withAlpha(128),
        ),
      ),
    );
  }
}
