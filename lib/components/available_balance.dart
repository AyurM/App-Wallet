import 'package:flutter/material.dart';

const _titleText = 'Available Balance';

class AvailableBalance extends StatelessWidget {
  final double balance;
  final String symbol;

  const AvailableBalance({Key? key, required this.balance, this.symbol = '€'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$symbol$balance'.replaceFirst('.', ','),
            style: textTheme.headline2),
        const SizedBox(height: 5),
        Text(_titleText, style: textTheme.subtitle1)
      ],
    );
  }
}
