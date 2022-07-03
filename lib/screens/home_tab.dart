import 'package:app_wallet/components/app_bar.dart';
import 'package:app_wallet/components/circle_cutout.dart';
import 'package:app_wallet/res/theme/app_colors.dart';
import 'package:flutter/material.dart';

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
          Expanded(
              child: CircleCutout(
                  child: Container(
            width: double.infinity,
            height: double.infinity,
            color: AppColors.lightPrimary.withOpacity(0.5),
          )))
        ],
      ),
    );
  }
}
