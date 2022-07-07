import 'dart:math';
import 'dart:ui' as ui;

import 'package:app_wallet/components/balance/balance_circle.dart';
import 'package:app_wallet/data/model/balance_stat.dart';
import 'package:app_wallet/utils/data_mock_utils.dart';
import 'package:flutter/material.dart';

const _kCutoutXYRatio = 55 / 59;
const _kCircleCutoutRatio = 89 / 110;
const _kCutoutDecorationRelativeHeight = 0.53;
const _kDefaultCutoutHorizontalPadding = 18.0;
const _kDefaultCutoutSpacing = 12.0;
const _kCutoutBorderWidth = 1.0;
const _kCutoutBorderColor = Color(0xFF403C8E);

class BalanceStatistics extends StatelessWidget {
  final Color cutoutBackgroundColor;

  const BalanceStatistics({Key? key, required this.cutoutBackgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = DataMockUtils.getMockBalanceStats();

    return LayoutBuilder(builder: (context, constraints) {
      final cutoutSize = _calcCutoutSize(constraints, data.length);
      final circleRadius = cutoutSize.width * _kCircleCutoutRatio;
      final cutoutDecorationHeight =
          constraints.maxHeight * _kCutoutDecorationRelativeHeight;

      final cutoutClipper = _CircleCutoutClipper(
          horizontalPadding: _kDefaultCutoutHorizontalPadding,
          spacing: _kDefaultCutoutSpacing,
          cutoutSize: cutoutSize,
          cutouts: data.length);

      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ..._buildBalanceCircles(data, circleRadius, cutoutSize.width,
              cutoutDecorationHeight - circleRadius),
          SizedBox(
              height: cutoutDecorationHeight,
              child: CutoutDecoration(
                  cutoutClipper: cutoutClipper,
                  backgroundColor: cutoutBackgroundColor)),
        ],
      );
    });
  }

  List<Widget> _buildBalanceCircles(List<BalanceStat> data, double circleRadius,
      double cutoutXSize, double bottom) {
    final result = <Widget>[];

    for (int i = 0; i < data.length; i++) {
      result.add(Positioned(
        bottom: bottom,
        width: circleRadius * 2,
        left: _kDefaultCutoutHorizontalPadding +
            cutoutXSize * (1 - _kCircleCutoutRatio) * (1 + 2 * i) +
            circleRadius * i * 2 +
            _kDefaultCutoutSpacing * i,
        child: BalanceCircle(
          size: circleRadius * 2,
          data: data[i],
        ),
      ));
    }

    return result;
  }

  Size _calcCutoutSize(BoxConstraints constraints, int amount) {
    final totalCutoutsWidth = constraints.maxWidth -
        _kDefaultCutoutHorizontalPadding * 2 -
        _kDefaultCutoutSpacing * (amount - 1);
    final cutoutXRadius = (totalCutoutsWidth / amount) / 2;
    final cutoutYRadius = cutoutXRadius / _kCutoutXYRatio;
    return Size(cutoutXRadius, cutoutYRadius);
  }
}

class CutoutDecoration extends StatelessWidget {
  final CustomClipper<Path> cutoutClipper;
  final Color backgroundColor;

  const CutoutDecoration(
      {Key? key, required this.cutoutClipper, required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) => CustomPaint(
        foregroundPainter: _CircleCutoutPainter(
          clipper: cutoutClipper,
          backgroundColor: backgroundColor,
        ),
        child: ClipPath(
          clipper: cutoutClipper,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: backgroundColor,
          ),
        ),
      );
}

class _CircleCutoutClipper extends CustomClipper<Path> {
  final double horizontalPadding;
  final double spacing;
  final Size cutoutSize;
  final int cutouts;

  const _CircleCutoutClipper(
      {required this.horizontalPadding,
      required this.spacing,
      required this.cutoutSize,
      this.cutouts = 3});

  @override
  Path getClip(Size size) {
    final Path path = Path();

    for (int i = 0; i < cutouts; i++) {
      _addCutoutToPath(
          path: path,
          cutoutIndex: i,
          xRadius: cutoutSize.width,
          yRadius: cutoutSize.height);
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
  final Color backgroundColor;

  const _CircleCutoutPainter(
      {required this.clipper, required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = ui.Gradient.linear(
          Offset(size.width / 2, 0),
          Offset(size.width / 2, size.height),
          [_kCutoutBorderColor, backgroundColor.withOpacity(0)])
      ..style = ui.PaintingStyle.stroke
      ..strokeWidth = _kCutoutBorderWidth;
    final path = clipper.getClip(size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _CircleCutoutPainter oldDelegate) => false;
}
