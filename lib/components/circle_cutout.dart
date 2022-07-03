import 'dart:math';
import 'dart:ui' as ui;

import 'package:app_wallet/res/theme/app_colors.dart';
import 'package:flutter/material.dart';

const _kCutoutXYRatio = 55 / 59;
const _kDefaultCutoutHorizontalPadding = 18.0;
const _kDefaultCutoutSpacing = 12.0;
const _kCutoutBorderWidth = 1.0;
const _kCutoutBorderColor = Color(0xFF403C8E);

class CircleCutout extends StatelessWidget {
  final int circles;
  final Widget child;

  const CircleCutout({Key? key, required this.child, this.circles = 3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clipper = _CircleCutoutClipper(
        horizontalPadding: _kDefaultCutoutHorizontalPadding,
        spacing: _kDefaultCutoutSpacing,
        circles: circles);

    return CustomPaint(
      foregroundPainter: _CircleCutoutPainter(clipper: clipper),
      child: ClipPath(
        clipper: clipper,
        child: child,
      ),
    );
  }
}

class _CircleCutoutClipper extends CustomClipper<Path> {
  final double horizontalPadding;
  final double spacing;
  final int circles;

  const _CircleCutoutClipper(
      {required this.horizontalPadding,
      required this.spacing,
      this.circles = 3});

  @override
  Path getClip(Size size) {
    final totalCutoutsWidth =
        size.width - horizontalPadding * 2 - spacing * (circles - 1);
    final cutoutXRadius = (totalCutoutsWidth / circles) / 2;
    final cutoutYRadius = cutoutXRadius / _kCutoutXYRatio;

    final Path path = Path();

    for (int i = 0; i < circles; i++) {
      _addCutoutToPath(
          path: path,
          cutoutIndex: i,
          xRadius: cutoutXRadius,
          yRadius: cutoutYRadius);
    }

    path
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;

  void _addCutoutToPath(
      {required Path path,
      required int cutoutIndex,
      required double xRadius,
      required double yRadius}) {
    double cutoutArcStartX =
        horizontalPadding + cutoutIndex * (xRadius * 2 + spacing);
    path
      ..lineTo(cutoutArcStartX, 0)
      ..addArc(
          Rect.fromLTWH(cutoutArcStartX, -yRadius, xRadius * 2, yRadius * 2),
          -pi,
          -pi);
  }
}

class _CircleCutoutPainter extends CustomPainter {
  final CustomClipper<Path> clipper;

  const _CircleCutoutPainter({required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = ui.Gradient.linear(
          Offset(size.width / 2, 0),
          Offset(size.width / 2, size.height * 0.2),
          [_kCutoutBorderColor, AppColors.lightPrimary])
      ..style = ui.PaintingStyle.stroke
      ..strokeWidth = _kCutoutBorderWidth;
    final path = clipper.getClip(size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _CircleCutoutPainter oldDelegate) => false;
}
