import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yh_design_system/router.dart';
import 'package:yhlab_web/pages/features.dart';
import 'package:yhlab_web/pages/home.dart';

final class RouteNames {
  static const String home = "/"; // 메인
  static const String features = "/features"; // 소개
}

final router = GoRouter(
  initialLocation: RouteNames.home,
  navigatorKey: navigatorKey,
  routes: [_homeRoute(), _featuresRoute()],
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

GoRoute _featuresRoute() => GoRoute(
  path: RouteNames.features,
  name: RouteNames.features,
  builder: (context, state) => const FeaturesPage(),
);
