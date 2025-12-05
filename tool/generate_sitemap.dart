import 'dart:io';

/// Sitemap 자동 생성 스크립트
///
/// 실행 방법:
/// dart run tool/generate_sitemap.dart
void main() async {
  print('🗺️  Sitemap 생성 중...\n');

  // blog_posts_data.dart 파일 읽기
  final blogDataFile = File('lib/data/blog_posts_data.dart');
  if (!await blogDataFile.exists()) {
    print('❌ 오류: lib/data/blog_posts_data.dart 파일을 찾을 수 없습니다.');
    exit(1);
  }

  final content = await blogDataFile.readAsString();

  // 블로그 ID 추출 (id: 'xxx' 패턴 찾기)
  final idPattern = RegExp(r"id:\s*'([^']+)'");
  final matches = idPattern.allMatches(content);
  final blogIds = matches.map((m) => m.group(1)!).toList();

  print('📝 발견된 블로그 글: ${blogIds.length}개');
  for (var id in blogIds) {
    print('   - $id');
  }
  print('');

  // 현재 날짜 (yyyy-MM-dd 형식)
  final now = DateTime.now();
  final today =
      '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

  // Sitemap XML 생성
  final sitemap = StringBuffer();
  sitemap.writeln('<?xml version="1.0" encoding="UTF-8"?>');
  sitemap.writeln(
    '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">',
  );

  // 메인 페이지
  sitemap.writeln('  <!-- 메인 페이지 -->');
  sitemap.writeln('  <url>');
  sitemap.writeln('    <loc>https://yhlab-team.github.io/</loc>');
  sitemap.writeln('    <lastmod>$today</lastmod>');
  sitemap.writeln('    <changefreq>weekly</changefreq>');
  sitemap.writeln('    <priority>1.0</priority>');
  sitemap.writeln('  </url>');
  sitemap.writeln('');

  // 블로그 목록 페이지
  sitemap.writeln('  <!-- 블로그 목록 -->');
  sitemap.writeln('  <url>');
  sitemap.writeln('    <loc>https://yhlab-team.github.io/blogs</loc>');
  sitemap.writeln('    <lastmod>$today</lastmod>');
  sitemap.writeln('    <changefreq>weekly</changefreq>');
  sitemap.writeln('    <priority>0.9</priority>');
  sitemap.writeln('  </url>');
  sitemap.writeln('');

  // 각 블로그 글
  sitemap.writeln('  <!-- 블로그 글 -->');
  for (var id in blogIds) {
    sitemap.writeln('  <url>');
    sitemap.writeln('    <loc>https://yhlab-team.github.io/blogs/$id</loc>');
    sitemap.writeln('    <lastmod>$today</lastmod>');
    sitemap.writeln('    <changefreq>monthly</changefreq>');
    sitemap.writeln('    <priority>0.8</priority>');
    sitemap.writeln('  </url>');
  }

  sitemap.writeln('</urlset>');

  // web/sitemap.xml에 저장
  final sitemapFile = File('web/sitemap.xml');
  await sitemapFile.writeAsString(sitemap.toString());

  print('✅ Sitemap이 성공적으로 생성되었습니다!');
  print('📁 위치: web/sitemap.xml\n');
  print('📊 생성된 URL:');
  print('   - 메인 페이지: 1개');
  print('   - 블로그 목록: 1개');
  print('   - 블로그 글: ${blogIds.length}개');
  print('   - 총합: ${2 + blogIds.length}개\n');
}
