import 'package:app_wallet/res/theme/app_colors.dart';
import 'package:flutter/material.dart';

const _kPadding = EdgeInsets.all(15);
const _kFractionalOffset = Offset(-0.5, -1.2);
const _kBorderColor = Color(0xFF2E2B72);
const _kBackgroundColor = Color(0xFF1F1D4C);

class InsightGraphPopup extends StatelessWidget {
  final double value;
  final String symbol;

  const InsightGraphPopup({Key? key, required this.value, this.symbol = '€'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: _kFractionalOffset,
      child: Container(
        padding: _kPadding,
        decoration: BoxDecoration(
            color: _kBackgroundColor,
            border: Border.all(color: _kBorderColor),
            borderRadius: BorderRadius.circular(8)),
        child: Text(value.toStringAsFixed(2),
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: AppColors.primaryText87)),
      ),
    );
  }
}
