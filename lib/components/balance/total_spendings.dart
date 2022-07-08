import 'package:flutter/material.dart';

const _titleText = 'Total Spendings';

class TotalSpendings extends StatelessWidget {
  final double value;
  final String symbol;

  const TotalSpendings({Key? key, required this.value, this.symbol = '€'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(_titleText, style: textTheme.subtitle1),
        const SizedBox(height: 5),
        Text('$symbol$value'.replaceFirst('.', ','),
            style: textTheme.headline2),
      ],
    );
  }
}
