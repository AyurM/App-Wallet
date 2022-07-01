import 'package:app_wallet/components/app_bar.dart';
import 'package:app_wallet/components/credit_card_slider.dart';
import 'package:flutter/material.dart';

class WalletTab extends StatelessWidget {
  const WalletTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WalletAppBar(
        text: 'Wallet',
        context: context,
        onBackPressed: () {},
      ),
      backgroundColor: const Color(0xFF19173D),
      body: SingleChildScrollView(
        child: Column(
          children: const [SizedBox(height: 30), CreditCardSlider()],
        ),
      ),
    );
  }
}