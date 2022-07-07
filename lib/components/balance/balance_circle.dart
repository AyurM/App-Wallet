import 'dart:math';
import 'dart:ui' as ui;

import 'package:app_wallet/data/model/balance_stat.dart';
import 'package:flutter/material.dart';

const _kBorderWidthRatio = 16 / 89;
const _kBgColors = [Color(0xFF2D2E53), Color(0xFF201F3F)];
const _kBlurSigma = 5.0;

class BalanceCircle extends StatelessWidget {
  final double size;
  final BalanceStat data;

  const BalanceCircle({Key? key, required this.data, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            painter: _BalanceCirclePainter(
                percent: data.percent, gradientColors: data.colors),
            size: Size.infinite,
          ),
          Text('${data.percent}%',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontWeight: FontWeight.w700))
        ],
      ),
    );
  }
}

class _BalanceCirclePainter extends CustomPainter {
  final int percent;
  final List<Color> gradientColors;

  _BalanceCirclePainter({required this.percent, required this.gradientColors});

  @override
  void paint(Canvas canvas, Size size) {
    final borderWidth = size.width * _kBorderWidthRatio;
    _drawBackgroundCircle(canvas, size, borderWidth);
    _drawPercentArc(canvas, size, borderWidth, addBlur: true);
    _drawPercentArc(canvas, size, borderWidth, addBlur: false);
  }

  void _drawBackgroundCircle(Canvas canvas, Size size, double width) {
    final bgPaint = Paint()
      ..shader = ui.Gradient.linear(
          Offset.zero, Offset(size.width / 2, size.height / 2), _kBgColors)
      ..style = ui.PaintingStyle.stroke
      ..strokeWidth = width;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2),
        size.width / 2 - width / 2, bgPaint);
  }

  void _drawPercentArc(Canvas canvas, Size size, double width,
      {bool addBlur = false}) {
    final arcPaint = Paint()
      ..shader = ui.Gradient.linear(Offset(size.width / 2, 0),
          Offset(size.width / 2, size.height), gradientColors)
      ..style = ui.PaintingStyle.stroke
      ..strokeCap = ui.StrokeCap.round
      ..strokeWidth = width;

    if (addBlur) {
      arcPaint.imageFilter =
          ui.ImageFilter.blur(sigmaX: _kBlurSigma, sigmaY: _kBlurSigma);
    }

    canvas.drawArc(
        Offset(width / 2, width / 2) & Size.square(size.width - width),
        -pi / 2,
        2 * pi * percent / 100,
        false,
        arcPaint);
  }

  @override
  bool shouldRepaint(covariant _BalanceCirclePainter oldDelegate) =>
      percent != oldDelegate.percent;
}
