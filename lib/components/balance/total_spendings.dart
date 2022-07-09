import 'package:app_wallet/components/balance/app_animated_value.dart';
import 'package:flutter/material.dart';

const _titleText = 'Total Spendings';
const _kAnimDuration = Duration(milliseconds: 250);

class TotalSpendings extends StatefulWidget {
  final double value;
  final String symbol;

  const TotalSpendings({Key? key, required this.value, this.symbol = '€'})
      : super(key: key);

  @override
  State<TotalSpendings> createState() => _TotalSpendingsState();
}

class _TotalSpendingsState extends State<TotalSpendings>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: _kAnimDuration, vsync: this)..forward();
  }

  @override
  void didUpdateWidget(covariant TotalSpendings oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(_titleText, style: Theme.of(context).textTheme.subtitle1),
        const SizedBox(height: 5),
        AppAnimatedValue(
            animationController: animationController,
            text: '${widget.symbol}${widget.value}'.replaceFirst('.', ',')),
      ],
    );
  }
}
