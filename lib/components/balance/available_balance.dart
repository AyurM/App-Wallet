import 'package:app_wallet/components/balance/app_animated_value.dart';
import 'package:flutter/material.dart';

const _titleText = 'Available Balance';
const _kAnimDuration = Duration(milliseconds: 250);

class AvailableBalance extends StatefulWidget {
  final double balance;
  final String symbol;

  const AvailableBalance({Key? key, required this.balance, this.symbol = '€'})
      : super(key: key);

  @override
  State<AvailableBalance> createState() => _AvailableBalanceState();
}

class _AvailableBalanceState extends State<AvailableBalance>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: _kAnimDuration, vsync: this)..forward();
  }

  @override
  void didUpdateWidget(covariant AvailableBalance oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.balance != widget.balance) {
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
        AppAnimatedValue(
            animationController: animationController,
            text: '${widget.symbol}${widget.balance.toStringAsFixed(2)}'
                .replaceFirst('.', ',')),
        const SizedBox(height: 5),
        Text(_titleText, style: Theme.of(context).textTheme.subtitle1)
      ],
    );
  }
}
