import 'package:flutter/material.dart';
import 'package:yh_design_system/organisms/scaffold/scaffold.dart';
import 'package:yhlab_web/components/app_footer.dart';
import 'package:yhlab_web/components/app_header.dart';
import 'package:yhlab_web/pages/home/components/developer_comment_section.dart';
import 'package:yhlab_web/pages/home/components/download_section.dart';
import 'package:yhlab_web/pages/home/components/features_section.dart';
import 'package:yhlab_web/pages/home/components/hero_section.dart';
import 'package:yhlab_web/pages/home/components/wave_header.dart';

/// 메인 페이지 - Nemo 소개 및 다운로드
final class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return YHScaffold(
      body: Column(
        children: [
          const AppHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const WaveHeader(),
                  const SizedBox(height: 40),
                  const HeroSection(),
                  const DeveloperCommentSection(),
                  const FeaturesSection(),
                  const DownloadSection(),
                  const AppFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
