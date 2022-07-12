import 'package:app_wallet/components/app_tab_bar.dart';
import 'package:app_wallet/components/balance/insight_graph.dart';
import 'package:app_wallet/components/balance/insight_graph_popup.dart';
import 'package:app_wallet/components/balance/total_spendings.dart';
import 'package:app_wallet/components/period_selector.dart';
import 'package:app_wallet/res/theme/app_colors.dart';
import 'package:app_wallet/res/theme/constants.dart';
import 'package:app_wallet/utils/data_mock_utils.dart';
import 'package:app_wallet/utils/enum_period.dart';
import 'package:app_wallet/utils/enum_transaction_type.dart';
import 'package:flutter/material.dart';

class InsightStatsTab extends StatefulWidget {
  const InsightStatsTab({Key? key}) : super(key: key);

  @override
  State<InsightStatsTab> createState() => _InsightStatsTabState();
}

class _InsightStatsTabState extends State<InsightStatsTab>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  late final List<double> graphValues;
  Period period = Period.week;

  int? selectedIndex;
  Offset? popupOffset;

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: TransactionType.values.length, vsync: this);
    graphValues = DataMockUtils.getMockInsightGraphValues();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
            padding: kHorizontalPadding20,
            child: PeriodSelector(
                initialValue: period, onChanged: _onPeriodChanged)),
        const SizedBox(height: 33),
        TotalSpendings(value: DataMockUtils.getMockSpendings(period)),
        const SizedBox(height: 33),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 15, bottom: 20),
            decoration: const BoxDecoration(
                color: AppColors.darkPrimary,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              children: [
                AppTabBar(
                    tabTitles: TransactionType.values
                        .map((value) => value.title)
                        .toList(),
                    controller: tabController),
                Expanded(
                    child: Stack(
                  children: [
                    InsightGraph(
                        values: graphValues,
                        onValueSelected: _onGraphValueSelected),
                    if (popupOffset != null && selectedIndex != null)
                      Positioned(
                          left: popupOffset!.dx,
                          top: popupOffset!.dy,
                          child: InsightGraphPopup(
                              value: graphValues[selectedIndex!]))
                  ],
                ))
              ],
            ),
          ),
        )
      ],
    );
  }

  void _onPeriodChanged(Period selectedPeriod) {
    setState(() => period = selectedPeriod);
  }

  void _onGraphValueSelected(int index, Offset offset) {
    if (index == selectedIndex && popupOffset != null) {
      return;
    }

    setState(() {
      selectedIndex = index;
      popupOffset = offset;
    });
  }
}
