import 'package:app_wallet/components/transactions/transaction_card.dart';
import 'package:app_wallet/data/model/transaction_data.dart';
import 'package:app_wallet/res/theme/app_colors.dart';
import 'package:flutter/material.dart';

const _titleText = 'My transactions';

class TransactionList extends StatelessWidget {
  final List<TransactionData> data;

  const TransactionList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      color: AppColors.lightPrimary.withOpacity(0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_titleText,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w700, color: AppColors.primaryText87)),
          const SizedBox(height: 20),
          ..._buildWidgetList(data)
        ],
      ),
    );
  }

  List<Widget> _buildWidgetList(List<TransactionData> data) {
    final result = <Widget>[];

    for (int i = 0; i < data.length; i++) {
      result.add(TransactionCard(data: data[i]));

      if (i != data.length - 1) {
        result.add(const SizedBox(height: 20));
      }
    }

    return result;
  }
}
