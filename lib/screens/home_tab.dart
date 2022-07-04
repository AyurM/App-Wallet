import 'package:app_wallet/components/app_bar.dart';
import 'package:app_wallet/components/balance_statistics.dart';
import 'package:app_wallet/res/theme/app_colors.dart';
import 'package:flutter/material.dart';

const _kBalanceStatsAspectRatio = 0.372;

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WalletAppBar(
        text: 'Home',
        context: context,
        onBackPressed: () {},
      ),
      body: Column(
        children: [
          const SizedBox(height: 120),
          SizedBox(
            height:
                MediaQuery.of(context).size.width * _kBalanceStatsAspectRatio,
            child: BalanceStatistics(
              cutoutBackgroundColor: AppColors.lightPrimary.withOpacity(0.5),
            ),
          ),
          Expanded(
              child: Container(
            color: AppColors.lightPrimary.withOpacity(0.5),
          ))
        ],
      ),
    );
  }
}
