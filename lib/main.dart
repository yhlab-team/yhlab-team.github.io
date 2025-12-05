import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:yhlab_web/router.dart';

void main() {
  // Flutter Web에서 깔끔한 URL 사용 (해시 제거)
  usePathUrlStrategy();
  runApp(const YHLabApp());
}

final class YHLabApp extends StatelessWidget {
  const YHLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF2196F3), // YHColor.primary와 동일
        cardTheme: const CardThemeData(surfaceTintColor: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
