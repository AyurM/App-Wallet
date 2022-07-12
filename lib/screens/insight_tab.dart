import 'package:app_wallet/components/app_bar.dart';
import 'package:app_wallet/components/app_tab_bar.dart';
import 'package:app_wallet/res/theme/app_colors.dart';
import 'package:app_wallet/res/theme/constants.dart';
import 'package:app_wallet/screens/insight_stats_tab.dart';
import 'package:flutter/material.dart';

const _titleText = 'Insight';
const _kTabTitles = ['Statistics', 'Savings plan'];

class InsightTab extends StatefulWidget {
  final void Function()? onBackPressed;

  const InsightTab({Key? key, this.onBackPressed}) : super(key: key);

  @override
  State<InsightTab> createState() => _InsightTabState();
}

class _InsightTabState extends State<InsightTab>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      appBar: WalletAppBar(
        text: _titleText,
        context: context,
        onBackPressed: widget.onBackPressed,
        bgColor: AppColors.lightPrimary,
        bottomWidget: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarBottomHeight),
            child:
                AppTabBar(tabTitles: _kTabTitles, controller: tabController)),
      ),
      body: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const InsightStatsTab(),
            Center(child: Text(_kTabTitles[1], style: textTheme.bodyText1)),
          ]),
    );
  }
}
