import 'package:app_wallet/components/app_bottom_nav_bar.dart';
import 'package:app_wallet/data/model/credit_card_input.dart';
import 'package:app_wallet/screens/home_tab.dart';
import 'package:app_wallet/screens/insight_tab.dart';
import 'package:app_wallet/screens/wallet_tab.dart';
import 'package:app_wallet/utils/data_mock_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _kCardStackSize = 3;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController tabController;
  late final List<CreditCardInput> cardsData;
  late final List<double> cardsBalance;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    cardsData = DataMockUtils.getMockCreditCards(_kCardStackSize);
    cardsBalance = DataMockUtils.getMockCardsBalance(_kCardStackSize);
    tabController = TabController(length: 4, vsync: this)
      ..addListener(() => setState(() => currentIndex = tabController.index));
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Stack(
          children: [
            TabBarView(
              controller: tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const HomeTab(),
                WalletTab(
                    cardsData: cardsData,
                    cardsBalance: cardsBalance,
                    onBackPressed: () => _onTabSelect(0)),
                InsightTab(onBackPressed: () => _onTabSelect(0)),
                const Center(child: Text('Profile Tab'))
              ],
            ),
          ],
        ),
        bottomNavigationBar: AppBottomNavBar(
          currentIndex: tabController.index,
          onSelect: _onTabSelect,
        ),
      ),
    );
  }

  void _onTabSelect(int index) => tabController.animateTo(index);

  Future<bool> _onBackPressed() async {
    if (currentIndex != 0) {
      tabController.animateTo(0);
      return false;
    }
    return true;
  }
}
