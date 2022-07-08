import 'package:app_wallet/components/primary_button.dart';
import 'package:app_wallet/res/theme/app_colors.dart';
import 'package:app_wallet/utils/enum_period.dart';
import 'package:flutter/material.dart';

const _kHeight = 44.0;
const _kAnimDuration = Duration(milliseconds: 150);
const _kBorderRadius = 15.0;

class PeriodSelector extends StatefulWidget {
  final Period initialValue;
  final void Function(Period) onChanged;

  const PeriodSelector(
      {Key? key, this.initialValue = Period.week, required this.onChanged})
      : super(key: key);

  @override
  State<PeriodSelector> createState() => _PeriodSelectorState();
}

class _PeriodSelectorState extends State<PeriodSelector> {
  late Period selectedPeriod;

  @override
  void initState() {
    super.initState();
    selectedPeriod = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final buttonWidth = (constraints.maxWidth) / Period.values.length;

      return Container(
        height: _kHeight,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_kBorderRadius),
            color: AppColors.darkPrimary),
        child: Stack(children: [
          _buildActiveOptionDecoration(Size(buttonWidth, _kHeight)),
          SizedBox(
            height: _kHeight,
            child: Row(
                children: Period.values
                    .map((period) => Expanded(
                        child: _OptionButton(
                            text: period.text,
                            isSelected: selectedPeriod == period,
                            onPressed: () => _onOptionSelect(period))))
                    .toList()),
          )
        ]),
      );
    });
  }

  Widget _buildActiveOptionDecoration(Size size) {
    final alignments = [
      Alignment.centerLeft,
      Alignment.center,
      Alignment.centerRight
    ];

    return AnimatedAlign(
      duration: _kAnimDuration,
      curve: Curves.decelerate,
      alignment: alignments[selectedPeriod.index],
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(children: PrimaryButton.getDecorations(_kBorderRadius)),
      ),
    );
  }

  void _onOptionSelect(Period period) {
    if (period == selectedPeriod) {
      return;
    }

    setState(() => selectedPeriod = period);
    widget.onChanged.call(period);
  }
}

class _OptionButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final bool isSelected;

  const _OptionButton(
      {Key? key, required this.text, required this.isSelected, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.button?.copyWith(
        color: isSelected ? AppColors.primaryText87 : AppColors.secondaryText);

    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPressed,
        child: Center(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textStyle,
          ),
        ));
  }
}
