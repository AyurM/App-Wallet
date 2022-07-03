import 'package:app_wallet/components/app_bar.dart';
import 'package:app_wallet/components/credit_card_slider.dart';
import 'package:flutter/material.dart';

const _titleText = 'Wallet';

class WalletTab extends StatelessWidget {
  const WalletTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WalletAppBar(
        text: _titleText,
        context: context,
        onBackPressed: () {},
      ),
      body: Column(
        children: const [
          SizedBox(height: 30),
          CreditCardSlider(),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
