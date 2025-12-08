import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// 다운로드 CTA 섹션
class DownloadSection extends StatelessWidget {
  const DownloadSection({super.key});

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
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
                DownloadButton(
                  icon: Icons.apple,
                  text: 'App Store에서 다운로드',
                  color: const Color(0xFF000000),
                  url: 'https://apps.apple.com/app/id1547183996',
                  isMobile: isMobile,
                  onPressed: _launchUrl,
                ),
                const SizedBox(height: 20),
                DownloadButton(
                  icon: Icons.android,
                  text: 'Google Play에서 다운로드',
                  color: const Color(0xFF3DDC84),
                  url: 'https://play.google.com/store/apps/details?id=com.Nemo.ParkYoungHo',
                  isMobile: isMobile,
                  onPressed: _launchUrl,
                ),
              ],
            )
          else
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 20,
              runSpacing: 20,
              children: [
                DownloadButton(
                  icon: Icons.apple,
                  text: 'App Store에서 다운로드',
                  color: const Color(0xFF000000),
                  url: 'https://apps.apple.com/app/id1547183996',
                  isMobile: isMobile,
                  onPressed: _launchUrl,
                ),
                DownloadButton(
                  icon: Icons.android,
                  text: 'Google Play에서 다운로드',
                  color: const Color(0xFF3DDC84),
                  url: 'https://play.google.com/store/apps/details?id=com.Nemo.ParkYoungHo',
                  isMobile: isMobile,
                  onPressed: _launchUrl,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

/// 다운로드 버튼 위젯
class DownloadButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final String url;
  final bool isMobile;
  final Future<void> Function(String) onPressed;

  const DownloadButton({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    required this.url,
    required this.isMobile,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isMobile ? double.infinity : 320,
      child: ElevatedButton.icon(
        onPressed: () => onPressed(url),
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

