import 'package:app_wallet/components/balance/total_spendings.dart';
import 'package:app_wallet/components/period_selector.dart';
import 'package:app_wallet/res/theme/constants.dart';
import 'package:app_wallet/utils/data_mock_utils.dart';
import 'package:app_wallet/utils/enum_period.dart';
import 'package:flutter/material.dart';

class InsightStatsTab extends StatefulWidget {
  const InsightStatsTab({Key? key}) : super(key: key);

  @override
  State<InsightStatsTab> createState() => _InsightStatsTabState();
}

class _InsightStatsTabState extends State<InsightStatsTab> {
  Period period = Period.week;

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
        TotalSpendings(value: DataMockUtils.getMockSpendings(period))
      ],
    );
  }

  void _onPeriodChanged(Period selectedPeriod) {
    setState(() => period = selectedPeriod);
  }
}
