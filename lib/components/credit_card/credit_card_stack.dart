import 'dart:math';

import 'package:app_wallet/components/credit_card/credit_card.dart';
import 'package:app_wallet/data/model/credit_card_input.dart';
import 'package:flutter/material.dart';

const _cardScales = [1.0, 0.886, 0.771];
const _relativeTopPositions = [
  CreditCardStack.firstCardTopPosition,
  0.0545,
  0.0
];

class CreditCardStack extends StatelessWidget {
  static const firstCardTopPosition = 0.118;

  final List<CreditCardInput> cardsData;
  final double pageValue;
  final double horizontalSpacing;

  const CreditCardStack(
      {Key? key,
      required this.cardsData,
      required this.pageValue,
      this.horizontalSpacing = 20.0})
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
              cardsData.length,
              (index) => _buildCreditCard(
                  data: cardsData[index],
                  index: cardsData.length - 1 - index,
                  topPositions: topPositionsInPixels,
                  maxWidth: constraints.maxWidth)));
    }));
  }

  double _calcCardScale(int cardIndex) {
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

  double _calcCardTopPosition(int cardIndex, List<double> topPositions) {
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

  double _calcCardSidePosition(int cardIndex, double maxWidth,
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

  Widget _buildCreditCard(
      {required CreditCardInput data,
      required int index,
      required List<double> topPositions,
      required double maxWidth}) {
    Widget card;

    if (index % 3 == 0) {
      card = CreditCard.purple(data: data);
    } else if (index % 3 == 1) {
      card = CreditCard.blue(data: data);
    } else {
      card = CreditCard.green(data: data);
    }

    return Positioned(
        left: _calcCardSidePosition(index, maxWidth),
        right: _calcCardSidePosition(index, maxWidth, isLeft: false),
        top: _calcCardTopPosition(index, topPositions),
        child: Transform.scale(
          scale: _calcCardScale(index),
          child: card,
        ));
  }
}
