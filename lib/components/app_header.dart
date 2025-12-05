import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yh_design_system/atoms/color/colors.dart';

/// 앱 헤더 - 로고와 네비게이션
class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;
    final String currentPath = GoRouterState.of(context).matchedLocation;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 로고
          GestureDetector(
            onTap: () => context.go('/'),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [YHColor.primary, Color(0xFF8B5CF6)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.school,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'YHLab',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: YHColor.primary,
                  ),
                ),
              ],
            ),
          ),
          // 네비게이션
          if (!isMobile)
            Row(
              children: [
                _buildNavButton(context, '메인', '/', currentPath),
                const SizedBox(width: 8),
                _buildNavButton(context, '소개', '/features', currentPath),
              ],
            )
          else
            PopupMenuButton<String>(
              icon: const Icon(Icons.menu),
              onSelected: (path) {
                context.go(path);
              },
              itemBuilder:
                  (context) => const [
                    PopupMenuItem(value: '/', child: Text('메인')),
                    PopupMenuItem(value: '/features', child: Text('소개')),
                  ],
            ),
        ],
      ),
    );
  }

  Widget _buildNavButton(
    BuildContext context,
    String label,
    String path,
    String currentPath,
  ) {
    final bool isSelected = currentPath == path;

    return TextButton(
      onPressed: () => context.go(path),
      style: TextButton.styleFrom(
        backgroundColor:
            isSelected ? YHColor.primary.withAlpha(13) : Colors.transparent,
        foregroundColor: isSelected ? YHColor.primary : const Color(0xFF64748B),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
    );
  }
}
