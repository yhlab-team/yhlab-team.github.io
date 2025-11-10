import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const YHLabApp());
}

class YHLabApp extends StatelessWidget {
  const YHLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YHLab - 삶의 흐름을 매끄럽게',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF1E90FF),
        textTheme: GoogleFonts.notoSansKrTextTheme(),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 헤더
            _buildHeader(context),
            // 히어로 섹션
            _buildHeroSection(context),
            // 앱 섹션
            _buildAppsSection(context),
            // 푸터
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  // 헤더
  Widget _buildHeader(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'YHLab',
            style: GoogleFonts.notoSansKr(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF1E90FF),
            ),
          ),
          if (MediaQuery.of(context).size.width > 768)
            Row(
              children: [
                _buildNavLink('홈', () {}),
                const SizedBox(width: 32),
                _buildNavLink('프로덕트', () {}),
                const SizedBox(width: 32),
                _buildNavLink('소개', () {}),
                const SizedBox(width: 32),
                _buildNavLink('연락처', () {}),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildNavLink(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: GoogleFonts.notoSansKr(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF333333),
        ),
      ),
    );
  }

  // 히어로 섹션
  Widget _buildHeroSection(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E90FF), Color(0xFF0066CC)],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: MediaQuery.of(context).size.width > 768 ? 120 : 80,
      ),
      child: Column(
        children: [
          Text(
            'YHLab',
            style: GoogleFonts.notoSansKr(
              fontSize: MediaQuery.of(context).size.width > 768 ? 56 : 40,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '삶의 흐름을 매끄럽게 해주는 윤활유 같은 도구를 만듭니다.',
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSansKr(
              fontSize: MediaQuery.of(context).size.width > 768 ? 20 : 18,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '일상을 더 편리하고 즐겁게 만드는 혁신적인 솔루션을 제공합니다.',
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSansKr(
              fontSize: MediaQuery.of(context).size.width > 768 ? 20 : 18,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 0,
            ).copyWith(
              backgroundColor: WidgetStateProperty.all(const Color(0xFFFF6B6B)),
            ),
            child: Text(
              '앱 둘러보기',
              style: GoogleFonts.notoSansKr(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 앱 섹션
  Widget _buildAppsSection(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      child: Column(
        children: [
          Text(
            'Our Apps',
            style: GoogleFonts.notoSansKr(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 768) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildNemoCard(context)),
                    const SizedBox(width: 30),
                    Expanded(child: _buildTicketDiaryCard(context)),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildNemoCard(context),
                    const SizedBox(height: 30),
                    _buildTicketDiaryCard(context),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  // Nemo 앱 카드
  Widget _buildNemoCard(BuildContext context) {
    return _buildAppCard(
      context: context,
      icon: Icons.psychology,
      title: 'Nemo',
      description:
          '효과적인 간격 반복 학습으로 장기 기억을 돕는 복습 앱입니다. 과학적인 복습 알고리즘으로 학습 효율을 극대화하고, 언제 어디서나 쉽게 지식을 관리할 수 있습니다.',
      appStoreUrl: 'https://apps.apple.com/app/id1547183996',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.Nemo.ParkYoungHo',
    );
  }

  // 티켓다이어리 앱 카드
  Widget _buildTicketDiaryCard(BuildContext context) {
    return _buildAppCard(
      context: context,
      icon: Icons.confirmation_number,
      title: '티켓다이어리',
      description:
          '특별한 순간의 티켓을 디지털 다이어리로 보관하세요. 공연, 영화, 여행의 추억을 티켓과 함께 기록하고, 언제든 되돌아볼 수 있는 나만의 추억 앨범입니다.',
      appStoreUrl: 'https://apps.apple.com/app/id6741766750',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.memorylog.yhlab',
    );
  }

  // 공통 앱 카드 위젯
  Widget _buildAppCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required String appStoreUrl,
    required String playStoreUrl,
  }) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 50,
            offset: const Offset(0, 15),
          ),
        ],
        border: Border.all(color: Colors.transparent, width: 2),
      ),
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          // 앱 아이콘
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1E90FF), Color(0xFF0066CC)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1E90FF).withOpacity(0.3),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(icon, size: 48, color: Colors.white),
          ),
          const SizedBox(height: 20),
          // 앱 이름
          Text(
            title,
            style: GoogleFonts.notoSansKr(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 15),
          // 앱 설명
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSansKr(
              fontSize: 16,
              color: const Color(0xFF666666),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 25),
          // 스토어 링크
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: [
              _buildStoreButton('App Store', Icons.apple, appStoreUrl),
              _buildStoreButton('Play Store', Icons.android, playStoreUrl),
            ],
          ),
        ],
      ),
    );
  }

  // 스토어 버튼
  Widget _buildStoreButton(String text, IconData icon, String url) {
    return ElevatedButton.icon(
      onPressed: () => _launchUrl(url),
      icon: Icon(icon, size: 20),
      label: Text(
        text,
        style: GoogleFonts.notoSansKr(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1E90FF),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 0,
      ),
    );
  }

  // URL 실행
  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $urlString');
    }
  }

  // 푸터
  Widget _buildFooter(BuildContext context) {
    return Container(
      color: const Color(0xFF2C3E50),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        children: [
          Text(
            '© 2024 YHLab. All rights reserved.',
            style: GoogleFonts.notoSansKr(fontSize: 14, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.code, color: Colors.white),
              ),
              const SizedBox(width: 20),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.business, color: Colors.white),
              ),
              const SizedBox(width: 20),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.email, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
