import 'package:flutter/material.dart';
import 'package:yh_design_system/atoms/color/colors.dart';

/// 개발자 코멘트 섹션
class DeveloperCommentSection extends StatelessWidget {
  const DeveloperCommentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
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
              '사람은 끝없이 망각합니다.\n\n자격증 취득, 면접 준비, 세미나 준비 등\n수 년 전 학습한 것을\n다시 공부한 적 없으신가요?\n\n죽을때 까지 공부할텐데..\n장기기억 형성의 필요성을 느껴\n편리한 복습을 위해 만들었습니다.',
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
    );
  }
}

