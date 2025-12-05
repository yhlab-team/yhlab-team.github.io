import 'package:flutter/material.dart';
import 'package:yhlab_web/router.dart';

void main() {
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
