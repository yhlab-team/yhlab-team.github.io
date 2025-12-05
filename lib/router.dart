import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yh_design_system/router.dart';
import 'package:yhlab_web/pages/blog_detail.dart';
import 'package:yhlab_web/pages/blog_list.dart';
import 'package:yhlab_web/pages/home.dart';

final class RouteNames {
  static const String home = "/"; // 메인
  static const String blogList = "/blogs"; // 블로그 목록
  static const String blogDetail = "/blogs/:postId"; // 블로그 상세
}

final router = GoRouter(
  initialLocation: RouteNames.home,
  navigatorKey: navigatorKey,
  routes: [
    _homeRoute(),
    _blogListRoute([_blogDetailRoute()]),
  ],
  errorBuilder:
      (context, state) => Scaffold(
        appBar: AppBar(title: const Text("찾을 수 없는 페이지입니다.")),
        body: const Center(child: Text("찾을 수 없는 페이지입니다.")),
      ),
);

GoRoute _homeRoute() => GoRoute(
  name: RouteNames.home,
  path: RouteNames.home,
  builder: (context, state) => const HomePage(),
);

GoRoute _blogListRoute(List<GoRoute> routes) => GoRoute(
  path: RouteNames.blogList,
  name: RouteNames.blogList,
  builder: (context, state) => const BlogListPage(),
  routes: routes,
);

GoRoute _blogDetailRoute() => GoRoute(
  path: ':postId',
  name: RouteNames.blogDetail,
  builder: (context, state) {
    final postId = state.pathParameters['postId'] ?? '';
    return BlogDetailPage(postId: postId);
  },
);
