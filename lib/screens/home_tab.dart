import 'package:app_wallet/components/app_bar.dart';
import 'package:app_wallet/components/circle_cutout_clipper.dart';
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
                  clipper: const CircleCutoutClipper(
                      horizontalPadding: 18, spacing: 12),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: const Color(0xFF262450).withOpacity(0.5),
                  )))
        ],
      ),
    );
  }
}
