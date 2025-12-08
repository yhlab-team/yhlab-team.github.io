import 'package:flutter/material.dart';
import 'package:yh_design_system/atoms/color/colors.dart';
import 'package:yh_design_system/atoms/font/fonts.dart';
import 'package:yh_design_system/atoms/text/text.dart';

/// Nemo 아이콘과 타이틀 섹션
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;

    return Column(
      children: [
        // Nemo 아이콘
        Container(
          width: isMobile ? 100 : 140,
          height: isMobile ? 100 : 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
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
      ],
    );
  }
}

