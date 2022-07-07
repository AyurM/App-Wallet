import 'dart:math';

import 'package:app_wallet/components/credit_card/credit_card.dart';
import 'package:flutter/material.dart';

const _kMockName = 'AYUR MARKHAKSHINOV';
const _cardScales = [1.0, 0.886, 0.771];
const _relativeTopPositions = [
  CreditCardStack.firstCardTopPosition,
  0.0545,
  0.0
];
const _kMockNumbers = [
  '1234 5678 9012 3456',
  '0987 6543 2109 8765',
  '5547 1217 0843 6628',
];

final mockValidDates = [
  DateTime(2029, 9),
  DateTime(2027, 11),
  DateTime(2030, 5),
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

      final topPositionsInPixels = List<double>.generate(
          _cardScales.length,
          (index) =>
              creditCardHeight * _relativeTopPositions[index] -
              creditCardHeight * (1 - _cardScales[index]) * 0.5);

      return Stack(
          children: List<Widget>.generate(
              _kMockNumbers.length,
              (index) => _getCreditCard(_kMockNumbers.length - 1 - index,
                  topPositionsInPixels, constraints.maxWidth)));
    }));
  }

  double _getCardScale(int cardIndex) {
    if (cardIndex == 0) {
      return _cardScales[cardIndex];
    }

    final int indexAdjustment = _calcIndexAdjustment(cardIndex);
    final double adjustedPageValue =
        (pageValue - indexAdjustment).clamp(0.0, 1.0);

    return _cardScales[cardIndex - indexAdjustment] +
        (_cardScales[cardIndex - 1 - indexAdjustment] -
                _cardScales[cardIndex - indexAdjustment]) *
            adjustedPageValue;
  }

  double _getCardTopPosition(int cardIndex, List<double> topPositions) {
    if (cardIndex == 0) {
      return topPositions[cardIndex];
    }

    final int indexAdjustment = _calcIndexAdjustment(cardIndex);
    final double adjustedPageValue =
        (pageValue - indexAdjustment).clamp(0.0, 1.0);

    return topPositions[cardIndex - 1 - indexAdjustment] -
        (topPositions[cardIndex - 1 - indexAdjustment] -
                topPositions[cardIndex - indexAdjustment]) *
            (1 - adjustedPageValue);
  }

  double _getCardSidePosition(int cardIndex, double maxWidth,
      {bool isLeft = true}) {
    if (cardIndex == _cardScales.length) {
      return horizontalSpacing;
    }

    final double adjustedPageValue =
        pageValue > cardIndex ? (pageValue - cardIndex) * (isLeft ? -1 : 1) : 0;

    return adjustedPageValue * maxWidth + horizontalSpacing;
  }

  int _calcIndexAdjustment(int cardIndex) =>
      pageValue > cardIndex - 1 ? max(0, cardIndex - 1) : max(0, cardIndex - 2);

  Widget _getCreditCard(int index, List<double> topPositions, double maxWidth) {
    Widget card;

    if (index % 3 == 0) {
      card = CreditCard.purple(
          name: _kMockName,
          number: _kMockNumbers[index],
          valid: mockValidDates[index]);
    } else if (index % 3 == 1) {
      card = CreditCard.blue(
          name: _kMockName,
          number: _kMockNumbers[index],
          valid: mockValidDates[index]);
    } else {
      card = CreditCard.green(
          name: _kMockName,
          number: _kMockNumbers[index],
          valid: mockValidDates[index]);
    }

    return Positioned(
        left: _getCardSidePosition(index, maxWidth),
        right: _getCardSidePosition(index, maxWidth, isLeft: false),
        top: _getCardTopPosition(index, topPositions),
        child: Transform.scale(
          scale: _getCardScale(index),
          child: card,
        ));
  }
}
