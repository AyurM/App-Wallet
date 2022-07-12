import 'dart:math';

import 'package:app_wallet/data/model/balance_stat.dart';
import 'package:app_wallet/data/model/credit_card_input.dart';
import 'package:app_wallet/data/model/transaction_data.dart';
import 'package:app_wallet/data/model/user_profile.dart';
import 'package:app_wallet/utils/enum_period.dart';
import 'package:app_wallet/utils/enum_transaction_type.dart';
import 'package:flutter/material.dart';

const _kMinBalancePercent = 10;
const _kMaxBalancePercent = 80;
const _kBalanceCount = 3;
const _kMockOwnerName = 'Ayur Markhakshinov';

class DataMockUtils {
  DataMockUtils._();

  static final _random = Random();
  static final _now = DateTime.now();

  static List<BalanceStat> getMockBalanceStats() {
    final balanceValues = List<int>.generate(
        _kBalanceCount,
        (_) =>
            _random.nextInt(_kMaxBalancePercent - _kMinBalancePercent + 1) +
            _kMinBalancePercent);

    const balanceColors = [
      [Color(0xFF6C40D9), Color(0xFFA858EE)],
      [Color(0xFF1544DF), Color(0xFF00A6C2)],
      [Color(0xFF00A6C2), Color(0xFF70E77E)],
    ];

    final result = <BalanceStat>[];
    for (int i = 0; i < _kBalanceCount; i++) {
      result.add(
          BalanceStat(percent: balanceValues[i], colors: balanceColors[i]));
    }
    return result;
  }

  static UserProfile getMockUser() => const UserProfile(
      id: 1, name: _kMockOwnerName, imagePath: 'assets/images/user_avatar.jpg');

  static List<TransactionData> getMockTransactions() {
    return [
      TransactionData(
          title: 'Shell',
          imagePath: 'assets/images/logo_shell.png',
          value: 87.41,
          dateTime: DateTime(_now.year, _now.month, _now.day - 1),
          type: TransactionType.expense),
      TransactionData(
          title: 'Amazon',
          imagePath: 'assets/images/logo_amazon.png',
          value: 142.80,
          dateTime: DateTime(_now.year, _now.month, _now.day - 1),
          type: TransactionType.expense),
      TransactionData(
          title: 'Apple',
          imagePath: 'assets/images/logo_apple.png',
          value: 328.0,
          dateTime: DateTime(_now.year, _now.month, _now.day - 2),
          type: TransactionType.expense),
      TransactionData(
          title: 'Carrefour',
          imagePath: 'assets/images/logo_carrefour.png',
          value: 112.43,
          dateTime: DateTime(_now.year, _now.month, _now.day - 2),
          type: TransactionType.expense),
      TransactionData(
          title: 'Transfer',
          imagePath: 'assets/images/logo_transfer.png',
          value: 1670.0,
          dateTime: DateTime(_now.year, _now.month, _now.day - 2),
          type: TransactionType.income),
      TransactionData(
          title: 'Carrefour',
          imagePath: 'assets/images/logo_carrefour.png',
          value: 112.43,
          dateTime: DateTime(_now.year, _now.month, _now.day - 3),
          type: TransactionType.expense),
      TransactionData(
          title: 'Shell',
          imagePath: 'assets/images/logo_shell.png',
          value: 32.87,
          dateTime: DateTime(_now.year, _now.month, _now.day - 3),
          type: TransactionType.expense),
    ];
  }

  static double getMockSpendings(Period period) {
    switch (period) {
      case Period.week:
        return 1348.97;
      case Period.month:
        return 3509.15;
      case Period.year:
        return 42897.68;
    }
  }

  static List<double> getMockCardsBalance(int size) => List<double>.generate(
      size, (index) => _random.nextDouble() * 1000 + _random.nextInt(4) * 1000);

  static List<CreditCardInput> getMockCreditCards(int amount) =>
      List<CreditCardInput>.generate(
          amount, (index) => _getMockCreditCardInput());

  static CreditCardInput _getMockCreditCardInput() {
    final expDate = DateTime(_now.year + 1 + _random.nextInt(6),
        _random.nextInt(12) + 1, _random.nextInt(31));

    final mockCode = _random.nextInt(1000).toString().padLeft(3, '0');

    return CreditCardInput(
        cardNumber: _getMockCreditCardNumber(),
        ownerName: _kMockOwnerName.toUpperCase(),
        expirationDate: expDate,
        code: mockCode);
  }

  static String _getMockCreditCardNumber() {
    final buffer = StringBuffer();

    for (int i = 0; i < 4; i++) {
      final randomNumber = _random.nextInt(10000);
      buffer.write(randomNumber.toString().padLeft(4, '0'));
      if (i != 3) {
        buffer.write(' ');
      }
    }

    return buffer.toString();
  }

  static List<double> getMockInsightGraphValues() {
    final result = <double>[];
    result.add(_random.nextDouble() * 100 + 100);

    for (int i = 1; i < 7; i++) {
      result.add(result[i - 1] +
          _random.nextDouble() * 25 * (_random.nextBool() ? 1 : -1));
    }
    return result;
  }
}
