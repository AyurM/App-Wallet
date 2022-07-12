import 'package:equations/equations.dart';
import 'package:flutter/material.dart';

const _kExtendDeltaY = 10.0;

class InterpolationUtils {
  InterpolationUtils._();

  ///[interpolationPoints] - количество точек интерполяции, добавляемых между двумя соседними
  ///точками в исходном наборе значений [input].
  ///Если [extendValue] != null, то будут рассчитаны точки интерполяции за пределами
  ///исходного набора [input] - от f(-extendValue) до f(input.length - 1 + extendValue).
  ///Шаг между значениями из набора [input] считается равным 1.
  static List<Offset> getInterpolatedValues(
      {required List<double> input,
      required int interpolationPoints,
      double? extendValue}) {
    final polynomial = _getPolyInterpolation(input, extendValue);
    final result = _calculateInterpolatedPoints(
        polynomial, input, interpolationPoints, extendValue);
    return result;
  }

  static Interpolation _getPolyInterpolation(
      List<double> input, double? extendValue) {
    final nodes = <InterpolationNode>[];
    for (int i = 0; i < input.length; i++) {
      nodes.add(InterpolationNode(x: i.toDouble(), y: input[i]));
    }
    if (extendValue != null) {
      nodes.insert(
          0, InterpolationNode(x: -extendValue, y: input[0] - _kExtendDeltaY));
      nodes.add(InterpolationNode(
          x: input.length - 1 + extendValue,
          y: input[input.length - 1] - _kExtendDeltaY));
    }

    return PolynomialInterpolation(nodes: nodes);
  }

  static List<Offset> _calculateInterpolatedPoints(Interpolation interpolation,
      List<double> input, int interpolationPoints, double? extendValue) {
    final result = <Offset>[];

    for (int i = 0; i < input.length - 1; i++) {
      result.add(Offset(i.toDouble(), input[i]));
      for (int j = 1; j <= interpolationPoints; j++) {
        final x = i + j / (interpolationPoints + 1);
        result.add(Offset(x, interpolation.compute(x)));
      }
    }
    result.add(Offset(input.length - 1, input[input.length - 1]));

    if (extendValue != null) {
      final interpStep = 1 / interpolationPoints;
      final paddingInterpPoints = (extendValue * interpolationPoints).floor();

      //Добавить точки интерполяции слева от начала исходного набора
      for (int i = paddingInterpPoints; i > 0; i--) {
        final x = -interpStep * (paddingInterpPoints - i + 1);
        result.insert(0, Offset(x, interpolation.compute(x)));
      }

      //Добавить точки интерполяции справа от конца исходного набора
      for (int i = 1; i <= paddingInterpPoints; i++) {
        final x = input.length - 1 + interpStep * i;
        result.add(Offset(x, interpolation.compute(x)));
      }

      //Добавить крайние точки
      result.insert(0, Offset(-extendValue, input[0] - _kExtendDeltaY));
      result.add(Offset(input.length - 1 + extendValue,
          input[input.length - 1] - _kExtendDeltaY));
    }

    return result;
  }
}
