import 'dart:ui' as ui;

import 'package:app_wallet/res/theme/app_colors.dart';
import 'package:app_wallet/utils/interpolation_utils.dart';
import 'package:flutter/material.dart';

const _kGraphXPadding = 25.0;
const _kGraphTopSafeAreaRelativeHeight = 30;
const _kGraphInterpolationPoints = 12;
const _kGridLineWidth = 1.0;
const _kGraphLineWidth = 3.0;
const _kDashLength = 4.0;
const _xAxisValues = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _kXLabelSize = Size(40.0, 25.0);

class InsightGraph extends StatefulWidget {
  final List<double> values;
  final void Function(int, Offset)? onValueSelected;

  const InsightGraph({Key? key, required this.values, this.onValueSelected})
      : super(key: key);

  @override
  State<InsightGraph> createState() => _InsightGraphState();
}

class _InsightGraphState extends State<InsightGraph> {
  int? selectedIndex;
  double? pxPerUnit;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          if (widget.values.isEmpty) {
            return const SizedBox.expand();
          }

          final maxValue = widget.values.fold<double>(widget.values[0].abs(),
              (previousValue, element) {
            if (element.abs() > previousValue) {
              return element.abs();
            }
            return previousValue;
          });

          pxPerUnit = (constraints.maxHeight - _kXLabelSize.height) *
              (1 - _kGraphTopSafeAreaRelativeHeight / 100) /
              maxValue;

          return GestureDetector(
            onTapDown: (details) =>
                _onTouchGesture(details.localPosition.dx, constraints),
            onPanUpdate: (details) =>
                _onTouchGesture(details.localPosition.dx, constraints),
            child: Column(
              children: [
                const Expanded(
                    flex: _kGraphTopSafeAreaRelativeHeight, child: SizedBox()),
                Expanded(
                  flex: 100 - _kGraphTopSafeAreaRelativeHeight,
                  child: CustomPaint(
                    painter: _InsightGraphPainter(
                      values: widget.values,
                      pxPerUnit: pxPerUnit!,
                    ),
                    size: Size.infinite,
                  ),
                ),
                SizedBox(height: _kXLabelSize.height, child: _buildXAxis())
              ],
            ),
          );
        },
      );

  Widget _buildXAxis() {
    final children = <Widget>[];

    for (int i = 0; i < _xAxisValues.length; i++) {
      children.add(SizedBox(
          width: _kXLabelSize.width,
          child: Text(_xAxisValues[i],
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: selectedIndex == i ? AppColors.accent : null))));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _kGraphXPadding),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children),
    );
  }

  void _onTouchGesture(double gesturePositionX, BoxConstraints constraints) {
    final index = _calcSelectedIndex(gesturePositionX, constraints.maxWidth);
    final offset = _calcPopupOffset(index, constraints);
    widget.onValueSelected?.call(index, offset);
    setState(() => selectedIndex = index);
  }

  int _calcSelectedIndex(double gesturePositionX, double maxWidth) {
    final clampedXPosition = gesturePositionX.clamp(0.0, maxWidth);
    if (clampedXPosition <= _kGraphXPadding) {
      return 0;
    }
    if (clampedXPosition >= maxWidth - _kGraphXPadding) {
      return widget.values.length - 1;
    }
    final stepX = (maxWidth - _kGraphXPadding * 2) / (widget.values.length - 1);
    return ((clampedXPosition - _kGraphXPadding) / stepX)
        .round()
        .clamp(0, widget.values.length - 1);
  }

  Offset _calcPopupOffset(int index, BoxConstraints constraints) {
    final stepX =
        (constraints.maxWidth - _kGraphXPadding * 2 - _kXLabelSize.width) /
            (widget.values.length - 1);
    final dx = _kGraphXPadding + _kXLabelSize.width * 0.5 + index * stepX;
    final dy = constraints.maxHeight -
        _kXLabelSize.height -
        widget.values[index].abs() * (pxPerUnit ?? 0);
    return Offset(dx, dy);
  }
}

class _InsightGraphPainter extends CustomPainter {
  final List<double> values;
  final double pxPerUnit;

  _InsightGraphPainter({
    required this.values,
    required this.pxPerUnit,
  });

  Paint get _graphPaint => Paint()
    ..color = AppColors.accent
    ..strokeWidth = _kGraphLineWidth
    ..strokeJoin = ui.StrokeJoin.round
    ..style = ui.PaintingStyle.stroke;

  double get _graphXSpacing => _kGraphXPadding + _kXLabelSize.width * 0.5;

  @override
  void paint(Canvas canvas, Size size) {
    final graphPoints =
        _getGraphPoints(size, pxPerUnit, _kGraphInterpolationPoints);

    _drawGridLines(canvas, size);
    _drawGraph(canvas, size, graphPoints);
    _drawGraphGradient(canvas, size, graphPoints);
  }

  void _drawGridLines(Canvas canvas, Size size) {
    final stepX = (size.width - _graphXSpacing * 2) / (values.length - 1);

    final Paint gridLinePaint = _getGridLinePaint(size);

    for (int i = 0; i < values.length; i++) {
      final dotCenter = Offset(_graphXSpacing + stepX * i,
          size.height - values[i].abs() * pxPerUnit);

      _drawDashedLine(
          canvas: canvas, size: size, start: dotCenter, paint: gridLinePaint);
    }
  }

  void _drawGraph(Canvas canvas, Size size, List<Offset> points) {
    final Path path = Path()..moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(path, _graphPaint);
  }

  List<Offset> _getGraphPoints(
      Size size, double pxPerMinute, int interpolationPoints) {
    final List<Offset> canvasPoints = [];

    final initialValues = values.map((e) => e.abs()).toList();
    final interpolatedValuesLength =
        values.length + (values.length - 1) * interpolationPoints;

    final xPixelsPerInterpolationPoint =
        (size.width - _graphXSpacing * 2) / (interpolatedValuesLength - 1);

    //Чтобы построить график на всю доступную ширину, необходимо
    //рассчитать точки интерполяции не только между точками initialValues,
    //но и слева от initialValues[0], и справа от initialValues.last
    //на симметричном расстоянии extendValue.
    final extendValue = _graphXSpacing /
        (xPixelsPerInterpolationPoint * (interpolationPoints + 1));
    final interpolatedValues = InterpolationUtils.getInterpolatedValues(
        input: initialValues,
        interpolationPoints: interpolationPoints,
        extendValue: extendValue);

    final yPixelValues = interpolatedValues
        .map((value) => size.height - value.dy * pxPerMinute)
        .toList();

    final xPixelsPerUnit =
        (size.width - _graphXSpacing * 2) / (values.length - 1);

    for (int i = 0; i < yPixelValues.length; i++) {
      canvasPoints.add(Offset(
          xPixelsPerUnit * (interpolatedValues[i].dx + extendValue),
          yPixelValues[i]));
    }

    return canvasPoints;
  }

  void _drawGraphGradient(Canvas canvas, Size size, List<Offset> points) {
    final Paint gradientPaint = _getGraphGradientPaint(size);
    final Path path = Path()
      ..addPolygon(points, false)
      ..lineTo(points.last.dx, size.height)
      ..lineTo(points.first.dx, size.height)
      ..close();

    canvas.drawPath(path, gradientPaint);
  }

  void _drawDashedLine(
      {required Canvas canvas,
      required Size size,
      required Offset start,
      required Paint paint}) {
    final int totalDashes =
        ((size.height - start.dy) / (_kDashLength * 2)).floor();

    for (int i = 0; i < totalDashes; i++) {
      canvas.drawLine(start.translate(0, _kDashLength * (i * 2 + 1)),
          start.translate(0, 2 * _kDashLength * (i + 1)), paint);
    }
  }

  Paint _getGridLinePaint(Size size) => Paint()
    ..shader = ui.Gradient.linear(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      [Colors.white, Colors.white.withOpacity(0)],
    )
    ..style = ui.PaintingStyle.stroke
    ..strokeWidth = _kGridLineWidth;

  Paint _getGraphGradientPaint(Size size) => Paint()
    ..shader = ui.Gradient.linear(
        Offset(size.width / 2, -size.height * 1.1),
        Offset(size.width / 2, size.height * 1.1),
        [AppColors.accent, AppColors.accent.withOpacity(0)],
        [0.3, 0.95]);

  @override
  bool shouldRepaint(_InsightGraphPainter oldDelegate) =>
      values != oldDelegate.values;
}
