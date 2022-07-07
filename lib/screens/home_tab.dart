import 'package:app_wallet/components/app_bar.dart';
import 'package:app_wallet/components/balance/available_balance.dart';
import 'package:app_wallet/components/balance/balance_statistics.dart';

import 'package:app_wallet/components/transactions/transaction_list.dart';
import 'package:app_wallet/res/theme/app_colors.dart';

import 'package:app_wallet/utils/data_mock_utils.dart';
import 'package:flutter/material.dart';

const _kBalanceStatsAspectRatio = 0.372;

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mockUser = DataMockUtils.getMockUser();
    final transactions = DataMockUtils.getMockTransactions();

    return Scaffold(
      appBar: HomeTabAppBar(
        context: context,
        userProfile: mockUser,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 42),
            const AvailableBalance(balance: 8098.74),
            const SizedBox(height: 5),
            SizedBox(
              height:
                  MediaQuery.of(context).size.width * _kBalanceStatsAspectRatio,
              child: BalanceStatistics(
                cutoutBackgroundColor: AppColors.lightPrimary.withOpacity(0.5),
              ),
            ),
            TransactionList(data: transactions),
          ],
        ),
      ),
    );
  }
}
