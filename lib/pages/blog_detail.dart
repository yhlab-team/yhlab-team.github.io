import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yh_design_system/organisms/scaffold/scaffold.dart';
import 'package:yhlab_web/components/app_header.dart';
import 'package:yhlab_web/components/app_footer.dart';
import 'package:yhlab_web/data/blog_posts_data.dart';
import 'package:yhlab_web/models/blog_post.dart';

/// 블로그 글 상세 페이지
final class BlogDetailPage extends StatelessWidget {
  final String postId;

  const BlogDetailPage({super.key, required this.postId});

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;
    final double maxWidth = isMobile ? double.infinity : 800;

    // postId로 해당 블로그 글 찾기
    BlogPost? foundPost;
    try {
      foundPost = allBlogPosts.firstWhere((p) => p.id == postId);
    } catch (e) {
      foundPost = allBlogPosts.isNotEmpty ? allBlogPosts.first : null;
    }

    // 글을 찾지 못한 경우
    if (foundPost == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("글을 찾을 수 없습니다")),
        body: const Center(child: Text("존재하지 않는 글입니다.")),
      );
    }

    // non-nullable로 재선언
    final BlogPost post = foundPost;

    return YHScaffold(
      body: Column(
        children: [
          const AppHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 헤더 섹션
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 20 : 60,
                      vertical: isMobile ? 40 : 60,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [post.iconColor.withAlpha(20), Colors.white],
                      ),
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: maxWidth),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 뒤로가기 버튼
                            InkWell(
                              onTap: () => context.pop(),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.arrow_back,
                                    size: 20,
                                    color: const Color(0xFF64748B),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '목록으로',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: const Color(0xFF64748B),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 32),

                            // 아이콘
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: post.iconColor.withAlpha(26),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                post.icon,
                                size: 48,
                                color: post.iconColor,
                              ),
                            ),

                            const SizedBox(height: 24),

                            // 제목
                            Text(
                              post.title,
                              style: TextStyle(
                                fontSize: isMobile ? 28 : 40,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF0F172A),
                                height: 1.2,
                              ),
                            ),

                            const SizedBox(height: 16),

                            // 부제
                            Text(
                              post.subtitle,
                              style: TextStyle(
                                fontSize: isMobile ? 16 : 20,
                                color: const Color(0xFF64748B),
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                              ),
                            ),

                            const SizedBox(height: 24),

                            // 메타 정보
                            Wrap(
                              spacing: 16,
                              runSpacing: 8,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: const Color(0xFF94A3B8),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      post.date,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF94A3B8),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 16,
                                      color: const Color(0xFF94A3B8),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      '${post.readTime} 읽기',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF94A3B8),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // 태그
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children:
                                  post.tags.map((tag) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: post.iconColor.withAlpha(26),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        tag,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: post.iconColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // 본문 섹션
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 20 : 60,
                      vertical: isMobile ? 40 : 60,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: maxWidth),
                        child: SelectionArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 구분선
                              Container(
                                height: 1,
                                color: const Color(0xFFE2E8F0),
                              ),

                              const SizedBox(height: 40),

                              // 본문 내용
                              ...post.fullContent.split('\n\n').map((
                                paragraph,
                              ) {
                                if (paragraph.trim().isEmpty) {
                                  return const SizedBox.shrink();
                                }

                                // 제목 스타일 (### 으로 시작)
                                if (paragraph.startsWith('### ')) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      top: 32,
                                      bottom: 16,
                                    ),
                                    child: Text(
                                      paragraph.substring(4),
                                      style: TextStyle(
                                        fontSize: isMobile ? 22 : 26,
                                        fontWeight: FontWeight.w900,
                                        color: const Color(0xFF0F172A),
                                        height: 1.3,
                                      ),
                                    ),
                                  );
                                }

                                // 소제목 스타일 (## 으로 시작)
                                if (paragraph.startsWith('## ')) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      top: 40,
                                      bottom: 16,
                                    ),
                                    child: Text(
                                      paragraph.substring(3),
                                      style: TextStyle(
                                        fontSize: isMobile ? 24 : 30,
                                        fontWeight: FontWeight.w900,
                                        color: const Color(0xFF0F172A),
                                        height: 1.3,
                                      ),
                                    ),
                                  );
                                }

                                // 일반 단락
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 24),
                                  child: Text(
                                    paragraph,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Color(0xFF334155),
                                      height: 1.8,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                );
                              }),

                              const SizedBox(height: 40),

                              // 구분선
                              Container(
                                height: 1,
                                color: const Color(0xFFE2E8F0),
                              ),

                              const SizedBox(height: 40),

                              // CTA 섹션 - Nemo 다운로드
                              Container(
                                padding: EdgeInsets.all(isMobile ? 32 : 40),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      post.iconColor.withAlpha(26),
                                      post.iconColor.withAlpha(13),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: post.iconColor.withAlpha(51),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.rocket_launch,
                                      size: 48,
                                      color: post.iconColor,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Nemo와 함께 시작하세요',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: isMobile ? 22 : 26,
                                        fontWeight: FontWeight.w900,
                                        color: const Color(0xFF0F172A),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      '과학적으로 검증된 학습법으로\n더 효율적인 공부를 경험해보세요',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: isMobile ? 15 : 17,
                                        color: const Color(0xFF64748B),
                                        height: 1.6,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    // 다운로드 버튼들
                                    if (isMobile)
                                      Column(
                                        children: [
                                          _buildDownloadButton(
                                            icon: Icons.apple,
                                            text: 'App Store에서 다운로드',
                                            color: const Color(0xFF000000),
                                            url:
                                                'https://apps.apple.com/app/id1547183996',
                                            isMobile: isMobile,
                                          ),
                                          const SizedBox(height: 16),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          _buildDownloadButton(
                                            icon: Icons.apple,
                                            text: 'App Store에서 다운로드',
                                            color: const Color(0xFF000000),
                                            url:
                                                'https://apps.apple.com/app/id1547183996',
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

                              const SizedBox(height: 60),

                              // 목록으로 돌아가기 버튼
                              Center(
                                child: OutlinedButton.icon(
                                  onPressed: () => context.pop(),
                                  icon: const Icon(Icons.arrow_back, size: 20),
                                  label: const Text('글 목록으로 돌아가기'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: const Color(0xFF64748B),
                                    side: const BorderSide(
                                      color: Color(0xFFE2E8F0),
                                      width: 2,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isMobile ? 24 : 32,
                                      vertical: isMobile ? 14 : 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const AppFooter(),
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
      width: isMobile ? double.infinity : 280,
      child: ElevatedButton.icon(
        onPressed: () => _launchUrl(url),
        icon: Icon(icon, size: 24),
        label: Text(
          text,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 6,
          shadowColor: color.withAlpha(128),
        ),
      ),
    );
  }
}
