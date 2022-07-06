import 'dart:math';

import 'package:app_wallet/data/model/balance_stat.dart';
import 'package:app_wallet/data/model/user_profile.dart';
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
}
