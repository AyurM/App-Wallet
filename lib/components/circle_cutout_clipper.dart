import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

const _kCircles = 3;
const _kCutoutXYRatio = 55 / 59;

class CircleCutoutClipper extends CustomClipper<Path> {
  final double horizontalPadding;
  final double spacing;

  const CircleCutoutClipper(
      {required this.horizontalPadding, required this.spacing});

  @override
  Path getClip(Size size) {
    final xSize =
        (size.width - horizontalPadding * 2 - spacing * (_kCircles - 1)) /
            _kCircles;
    final ySize = (xSize / 2) / _kCutoutXYRatio;
    final Path path = Path();
    path.lineTo(horizontalPadding, 0);
    path.addArc(Rect.fromLTWH(horizontalPadding, -ySize, xSize, ySize * 2),
        degToRad(-180), degToRad(-180));
    path
      ..lineTo(horizontalPadding + xSize + spacing, 0)
      ..addArc(
          Rect.fromLTWH(
              horizontalPadding + xSize + spacing, -ySize, xSize, ySize * 2),
          degToRad(-180),
          degToRad(-180))
      ..lineTo(horizontalPadding + xSize * 2 + spacing * 2, 0)
      ..addArc(
          Rect.fromLTWH(horizontalPadding + xSize * 2 + spacing * 2, -ySize,
              xSize, ySize * 2),
          degToRad(-180),
          degToRad(-180))
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 0);

    return path;
  }

  double degToRad(double deg) => deg * (pi / 180.0);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class CircleCutout extends StatelessWidget {
  final CustomClipper<Path> clipper;
  final Widget child;

  const CircleCutout({Key? key, required this.clipper, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Rebuilding CircleCutout');
    return CustomPaint(
      painter: _CircleCutoutPainter(clipper: clipper),
      child: ClipPath(
        clipper: const CircleCutoutClipper(horizontalPadding: 18, spacing: 12),
        child: child,
      ),
    );
  }
}

class _CircleCutoutPainter extends CustomPainter {
  final CustomClipper<Path> clipper;

  const _CircleCutoutPainter({required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    print('Repainting _CircleCutoutPainter');
    final Paint paint = Paint()
      ..shader = ui.Gradient.linear(
          Offset(size.width / 2, 0),
          Offset(size.width / 2, size.height * 0.2),
          [Colors.white, Colors.white.withOpacity(0)])
      ..style = ui.PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..blendMode = BlendMode.overlay;
    final path = clipper.getClip(size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _CircleCutoutPainter oldDelegate) => false;
}
