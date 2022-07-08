import 'dart:math';

import 'package:app_wallet/data/model/balance_stat.dart';
import 'package:app_wallet/data/model/transaction_data.dart';
import 'package:app_wallet/data/model/user_profile.dart';
import 'package:app_wallet/utils/enum_period.dart';
import 'package:flutter/material.dart';

const _kMinBalancePercent = 10;
const _kMaxBalancePercent = 80;
const _kBalanceCount = 3;

class DataMockUtils {
  DataMockUtils._();

  static final _random = Random();

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
      id: 1,
      name: 'Ayur Markhakshinov',
      imagePath: 'assets/images/user_avatar.jpg');

  static List<TransactionData> getMockTransactions() {
    final now = DateTime.now();

    return [
      TransactionData(
          title: 'Shell',
          imagePath: 'assets/images/logo_shell.png',
          value: 87.41,
          dateTime: DateTime(now.year, now.month, now.day - 1),
          type: TransactionType.expense),
      TransactionData(
          title: 'Amazon',
          imagePath: 'assets/images/logo_amazon.png',
          value: 142.80,
          dateTime: DateTime(now.year, now.month, now.day - 1),
          type: TransactionType.expense),
      TransactionData(
          title: 'Apple',
          imagePath: 'assets/images/logo_apple.png',
          value: 328.0,
          dateTime: DateTime(now.year, now.month, now.day - 2),
          type: TransactionType.expense),
      TransactionData(
          title: 'Carrefour',
          imagePath: 'assets/images/logo_carrefour.png',
          value: 112.43,
          dateTime: DateTime(now.year, now.month, now.day - 2),
          type: TransactionType.expense),
      TransactionData(
          title: 'Transfer',
          imagePath: 'assets/images/logo_transfer.png',
          value: 1670.0,
          dateTime: DateTime(now.year, now.month, now.day - 2),
          type: TransactionType.income),
      TransactionData(
          title: 'Carrefour',
          imagePath: 'assets/images/logo_carrefour.png',
          value: 112.43,
          dateTime: DateTime(now.year, now.month, now.day - 3),
          type: TransactionType.expense),
      TransactionData(
          title: 'Shell',
          imagePath: 'assets/images/logo_shell.png',
          value: 32.87,
          dateTime: DateTime(now.year, now.month, now.day - 3),
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
}
