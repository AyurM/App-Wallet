import 'package:app_wallet/res/theme/app_colors.dart';
import 'package:flutter/material.dart';

const _kButtonSize = Size(127.0, 44.0);
const _kBorderRadius = 15.0;

class PrimaryButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final double? height;
  final TextStyle? textStyle;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const PrimaryButton(
      {Key? key,
      required this.text,
      this.onPressed,
      this.height,
      this.textStyle,
      this.padding,
      this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Stack(
        children: [
          ...getDecorations(_kBorderRadius),
          ClipRRect(
            borderRadius: BorderRadius.circular(_kBorderRadius),
            child: TextButton(
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: _kButtonSize,
              ),
              onPressed: onPressed,
              child: Text(text,
                  maxLines: 1, style: Theme.of(context).textTheme.button),
            ),
          ),
        ],
      ),
    );
  }

  static List<Widget> getDecorations(double borderRadius) => [
        Positioned.fill(
            child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    gradient: AppColors.buttonBorderGradient))),
        Positioned(
            left: 1,
            right: 1,
            top: 1,
            bottom: 1,
            child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    gradient: AppColors.buttonGradient))),
      ];
}
