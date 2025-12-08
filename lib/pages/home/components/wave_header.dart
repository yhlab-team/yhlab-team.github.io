import 'package:flutter/material.dart';
import 'package:yh_design_system/atoms/color/colors.dart';

/// 물결치는 상단 장식 위젯
class WaveHeader extends StatefulWidget {
  const WaveHeader({super.key});

  @override
  State<WaveHeader> createState() => _WaveHeaderState();
}

class _WaveHeaderState extends State<WaveHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    // 위젯이 완전히 마운트된 후 애니메이션 시작
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _waveController.repeat();
      }
    });
  }

  @override
  void dispose() {
    _waveController.stop();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;

    return AnimatedBuilder(
      animation: _waveController,
      builder: (context, child) {
        if (!mounted) {
          return const SizedBox.shrink();
        }
        return Stack(
          children: [
            CustomPaint(
              size: Size(
                MediaQuery.of(context).size.width,
                isMobile ? 120 : 150,
              ),
              painter: _WaveHeaderPainter(
                animationValue: _waveController.value,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      YHColor.primary.withAlpha(26),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// 물결 모양의 헤더를 그리는 CustomPainter
class _WaveHeaderPainter extends CustomPainter {
  final double animationValue;

  _WaveHeaderPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = YHColor.primary.withAlpha(38)
          ..style = PaintingStyle.fill;

    final path = Path();

    // 첫 번째 물결 (큰 물결) - 좌에서 우로 이동
    final waveOffset1 = animationValue * size.width;
    path.moveTo(-size.width + waveOffset1, size.height * 0.5);

    // 3개의 큰 물결 생성 (화면 밖까지 그려서 끊김 없이)
    for (int i = -1; i < 4; i++) {
      final double waveWidth = size.width / 3;
      final double startX = waveWidth * i - size.width + waveOffset1;
      final double endX = waveWidth * (i + 1) - size.width + waveOffset1;
      final double controlX1 = startX + waveWidth * 0.25;
      final double controlX2 = startX + waveWidth * 0.75;
      final double controlY1 = size.height * 0.2;
      final double controlY2 = size.height * 0.8;

      path.cubicTo(
        controlX1,
        controlY1,
        controlX2,
        controlY2,
        endX,
        size.height * 0.5,
      );
    }

    path.lineTo(size.width * 2, 0);
    path.lineTo(-size.width, 0);
    path.close();

    canvas.drawPath(path, paint);

    // 두 번째 물결 (더 진한 색) - 우에서 좌로 이동 (반대 방향)
    final paint2 =
        Paint()
          ..color = YHColor.primary.withAlpha(51)
          ..style = PaintingStyle.fill;

    final path2 = Path();
    final waveOffset2 = (1 - animationValue) * size.width;
    path2.moveTo(-size.width + waveOffset2, size.height * 0.6);

    // 2개의 물결 생성 (위상 차이, 화면 밖까지)
    for (int i = -1; i < 3; i++) {
      final double waveWidth = size.width / 2;
      final double startX = waveWidth * i - size.width + waveOffset2;
      final double endX = waveWidth * (i + 1) - size.width + waveOffset2;
      final double controlX1 = startX + waveWidth * 0.3;
      final double controlX2 = startX + waveWidth * 0.7;
      final double controlY1 = size.height * 0.3;
      final double controlY2 = size.height * 0.9;

      path2.cubicTo(
        controlX1,
        controlY1,
        controlX2,
        controlY2,
        endX,
        size.height * 0.6,
      );
    }

    path2.lineTo(size.width * 2, 0);
    path2.lineTo(-size.width, 0);
    path2.close();

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant _WaveHeaderPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

