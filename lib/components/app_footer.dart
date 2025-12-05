import 'package:flutter/material.dart';
import 'package:yh_design_system/atoms/color/colors.dart';

/// 앱 푸터
class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF0F172A),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        children: [
          const Text(
            '© 2024 YHLab. All rights reserved.',
            style: TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
          ),
          const SizedBox(height: 16),
          Text(
            'AI로 교육을 혁신하겠습니다',
            style: TextStyle(fontSize: 12, color: YHColor.textSub),
          ),
        ],
      ),
    );
  }
}
