import 'package:app_wallet/components/app_bar.dart';
import 'package:app_wallet/components/balance/available_balance.dart';
import 'package:app_wallet/components/credit_card/add_card_form.dart';
import 'package:app_wallet/components/credit_card/credit_card_slider.dart';
import 'package:app_wallet/data/model/credit_card_input.dart';
import 'package:app_wallet/res/theme/app_colors.dart';
import 'package:app_wallet/res/theme/constants.dart';
import 'package:flutter/material.dart';

const _titleText = 'Wallet';
const _bottomTitleText = 'Cards';

class WalletTab extends StatefulWidget {
  final List<CreditCardInput> cardsData;
  final List<double> cardsBalance;
  final void Function()? onBackPressed;

  const WalletTab(
      {Key? key,
      required this.cardsData,
      required this.cardsBalance,
      this.onBackPressed})
      : super(key: key);

  @override
  State<WalletTab> createState() => _WalletTabState();
}

class _WalletTabState extends State<WalletTab>
    with AutomaticKeepAliveClientMixin {
  int selectedIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: WalletAppBar(
          text: _titleText,
          context: context,
          onBackPressed: widget.onBackPressed,
          bottomWidget: const PreferredSize(
              preferredSize: Size.fromHeight(kAppBarBottomHeight),
              child: _WalletTabBottom()),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              CreditCardSlider(
                cardsData: widget.cardsData,
                onChanged: _onCardChange,
              ),
              const SizedBox(height: 20),
              AvailableBalance(balance: widget.cardsBalance[selectedIndex]),
              const SizedBox(height: 30),
              const Padding(
                padding: kHorizontalPadding20,
                child: AddCardForm(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _onCardChange(int index) {
    if (index == selectedIndex) {
      return;
    }

    setState(() => selectedIndex = index);
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
