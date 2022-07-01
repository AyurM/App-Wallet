import 'package:app_wallet/components/credit_card.dart';
import 'package:flutter/material.dart';

const _kMockName = 'AYUR MARKHAKSHINOV';
const _cardScales = [1.0, 0.886, 0.771];
const _topPositions = [CreditCardStack.firstCardTopPosition, 0.0545, 0.0];
const _kMockNumbers = [
  '1234 5678 9012 3456',
  '0987 6543 2109 8765',
  '5547 1217 0843 6628'
];

class CreditCardStack extends StatelessWidget {
  static const firstCardTopPosition = 0.118;

  final double pageValue;
  final double horizontalSpacing;

  const CreditCardStack(
      {Key? key, required this.pageValue, this.horizontalSpacing = 20.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      final creditCardHeight = (constraints.maxWidth - 2 * horizontalSpacing) /
          CreditCard.aspectRatio;
      final topPositions = [
        creditCardHeight * _topPositions[0],
        creditCardHeight * _topPositions[1] -
            creditCardHeight * (1 - _cardScales[1]) * 0.5,
        creditCardHeight * _topPositions[2] -
            creditCardHeight * (1 - _cardScales[2]) * 0.5
      ];

      return Stack(children: [
        Positioned(
            left: horizontalSpacing,
            right: horizontalSpacing,
            top: _getThirdCardTopPosition(topPositions),
            child: Transform.scale(
                scale: _getThirdCardScale(),
                child: CreditCard.green(
                    name: _kMockName,
                    number: _kMockNumbers[2],
                    valid: DateTime(2030, 5)))),
        Positioned(
            left:
                (pageValue > 1 ? -(pageValue - 1) * constraints.maxWidth : 0) +
                    horizontalSpacing,
            right:
                (pageValue > 1 ? (pageValue - 1) * constraints.maxWidth : 0) +
                    horizontalSpacing,
            top: _getSecondCardTopPosition(topPositions),
            child: Transform.scale(
                scale: _getSecondCardScale(),
                child: CreditCard.blue(
                    name: _kMockName,
                    number: _kMockNumbers[1],
                    valid: DateTime(2027, 11)))),
        Positioned(
            left: -pageValue * constraints.maxWidth + horizontalSpacing,
            right: pageValue * constraints.maxWidth + horizontalSpacing,
            top: topPositions[0],
            child: CreditCard.purple(
                name: _kMockName,
                number: _kMockNumbers[0],
                valid: DateTime(2029, 9))),
      ]);
    }));
  }

  double _getThirdCardTopPosition(List<double> topPositions) {
    final double adjustedPageValue =
        (pageValue > 1 ? pageValue - 1 : pageValue).clamp(0.0, 1.0);
    final int indexAdjustment = pageValue > 1 ? 1 : 0;

    return topPositions[1 - indexAdjustment] -
        (topPositions[1 - indexAdjustment] -
                topPositions[2 - indexAdjustment]) *
            (1 - adjustedPageValue);
  }

  double _getThirdCardScale() {
    final double adjustedPageValue =
        (pageValue > 1 ? pageValue - 1 : pageValue).clamp(0.0, 1.0);
    final int indexAdjustment = pageValue > 1 ? 1 : 0;

    return _cardScales[2 - indexAdjustment] +
        (_cardScales[1 - indexAdjustment] - _cardScales[2 - indexAdjustment]) *
            adjustedPageValue;
  }

  double _getSecondCardScale() =>
      _cardScales[1] +
      (_cardScales[0] - _cardScales[1]) * pageValue.clamp(0.0, 1.0);

  double _getSecondCardTopPosition(List<double> topPositions) =>
      topPositions[0] -
      (topPositions[0] - topPositions[1]) * (1 - pageValue.clamp(0.0, 1.0));
}
