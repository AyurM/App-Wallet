import 'package:app_wallet/components/app_bar.dart';
import 'package:app_wallet/components/balance/available_balance.dart';
import 'package:app_wallet/components/credit_card/add_card_form.dart';
import 'package:app_wallet/components/credit_card/credit_card_slider.dart';
import 'package:app_wallet/res/theme/app_colors.dart';
import 'package:app_wallet/res/theme/constants.dart';
import 'package:flutter/material.dart';

const _titleText = 'Wallet';
const _bottomTitleText = 'Cards';

class WalletTab extends StatelessWidget {
  final void Function()? onBackPressed;

  const WalletTab({Key? key, this.onBackPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: WalletAppBar(
          text: _titleText,
          context: context,
          onBackPressed: onBackPressed,
          bottomWidget: const PreferredSize(
              preferredSize: Size.fromHeight(kAppBarBottomHeight),
              child: _WalletTabBottom()),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              SizedBox(height: 20),
              CreditCardSlider(),
              SizedBox(height: 20),
              AvailableBalance(balance: 1052.84),
              SizedBox(height: 30),
              Padding(
                padding: kHorizontalPadding20,
                child: AddCardForm(),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _WalletTabBottom extends StatelessWidget {
  const _WalletTabBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: kAppBarBottomHeight,
        child: Column(
          children: [
            Text(
              _bottomTitleText,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: AppColors.primaryText87),
            ),
            const Spacer(),
            Container(
                margin: kHorizontalPadding20,
                height: 3,
                width: double.infinity,
                color: const Color(0xFF25225B))
          ],
        ),
      );
}
