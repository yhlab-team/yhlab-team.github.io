import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yh_design_system/atoms/color/colors.dart';
import 'package:yh_design_system/organisms/scaffold/scaffold.dart';
import 'package:yhlab_web/components/app_header.dart';
import 'package:yhlab_web/components/app_footer.dart';
import 'package:yhlab_web/data/blog_posts_data.dart';
import 'package:yhlab_web/models/blog_post.dart';

/// 블로그 목록 페이지 - 블로그 글 목록 형태로 Nemo 소개
final class BlogListPage extends StatelessWidget {
  const BlogListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;
    final double maxWidth = isMobile ? double.infinity : 900;

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
                      vertical: isMobile ? 60 : 80,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [YHColor.primary.withAlpha(13), Colors.white],
                      ),
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: maxWidth),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nemo Library',
                              style: TextStyle(
                                fontSize: isMobile ? 36 : 48,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '학습 과학과 Nemo의 이야기',
                              style: TextStyle(
                                fontSize: isMobile ? 16 : 20,
                                color: const Color(0xFF64748B),
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // 블로그 글 목록
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 20 : 60,
                      vertical: isMobile ? 40 : 60,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: maxWidth),
                        child: Column(
                          children:
                              allBlogPosts.map((post) {
                                return _buildBlogPostCard(
                                  context: context,
                                  post: post,
                                  isMobile: isMobile,
                                );
                              }).toList(),
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

  /// 블로그 글 카드 위젯
  Widget _buildBlogPostCard({
    required BuildContext context,
    required BlogPost post,
    required bool isMobile,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            context.go('/blogs/${post.id}');
          },
          child: Padding(
            padding: EdgeInsets.all(isMobile ? 24 : 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 아이콘과 제목
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: post.iconColor.withAlpha(26),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(post.icon, size: 28, color: post.iconColor),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.title,
                            style: TextStyle(
                              fontSize: isMobile ? 22 : 26,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF0F172A),
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            post.subtitle,
                            style: TextStyle(
                              fontSize: isMobile ? 14 : 16,
                              color: const Color(0xFF64748B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 발췌문
                Text(
                  post.excerpt,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF475569),
                    height: 1.7,
                  ),
                  maxLines: isMobile ? 10 : null,
                  overflow: isMobile ? TextOverflow.ellipsis : null,
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

                const SizedBox(height: 16),

                // 날짜와 읽기 시간
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: const Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      post.date,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: const Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${post.readTime} 읽기',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '자세히 보기',
                      style: TextStyle(
                        fontSize: 14,
                        color: post.iconColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.arrow_forward, size: 16, color: post.iconColor),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
