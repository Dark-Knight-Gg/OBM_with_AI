import 'package:flutter/material.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/core/constants/color_app.dart';

class BodySplashWidget extends StatelessWidget {
  const BodySplashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Stack(
        children: [
          _BackgroundLayer(),
          _CenterContent(),
          _FooterAttribution(),
        ],
    );
  }
}

class _BackgroundLayer extends StatelessWidget {
  const _BackgroundLayer();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: ColorApp.colorF7F9FB),
        Positioned.fill(
          child: CustomPaint(painter: _DotPatternPainter()),
        ),
      ],
    );
  }
}

class _DotPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFCBD5E1).withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;

    const double dotRadius = 1.0;
    const double spacing = 20.0;

    final cols = (size.width / spacing).ceil();
    final rows = (size.height / spacing).ceil();

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        canvas.drawCircle(
          Offset(col * spacing, row * spacing),
          dotRadius,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CenterContent extends StatelessWidget {
  const _CenterContent();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 48),
            const _MainBranding(),
            const SizedBox(height: 24),
            const _SubHeadline(),
            const SizedBox(height: 48),
            const _Slogan(),
          ],
        ),
      ),
    );
  }
}

class _MainBranding extends StatelessWidget {
  const _MainBranding();

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: const Text(
        'DAS OBM',
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 64,
          fontWeight: FontWeight.w900,
          letterSpacing: -1.28,
          height: 1.0,
          color: ColorApp.colorBrandBlue,
        ),
      ),
    );
  }
}

class _SubHeadline extends StatelessWidget {
  const _SubHeadline();

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Text(
        AppStrings.heThongQuanTriCoHoiDieuHanhKinhDoanh,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.5,
          height: 1.3,
          color: ColorApp.color404751,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _Slogan extends StatelessWidget {
  const _Slogan();

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Text(
        AppStrings.slogan,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
          height: 1.4,
          color: ColorApp.color00677F,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _FooterAttribution extends StatelessWidget {
  const _FooterAttribution();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 48,
      left: 0,
      right: 0,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: child,
            ),
          );
        },
        child: const _FooterContent(),
      ),
    );
  }
}

class _FooterContent extends StatelessWidget {
  const _FooterContent();

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: Column(
        children: [
          Text(
            AppStrings.enterpriseEdition,
            style: const TextStyle(
              fontFamily: 'JetBrains Mono',
              fontSize: 11,
              fontWeight: FontWeight.w400,
              letterSpacing: 2.0,
              height: 1.2,
              color: ColorApp.color707882,
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: ColorApp.color404751,
              ),
              children: [
                const TextSpan(text: 'Powered by '),
                TextSpan(
                  text: 'Trung tâm DAS',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: ColorApp.color005F9E,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
