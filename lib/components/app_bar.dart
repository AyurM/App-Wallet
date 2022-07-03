import 'package:app_wallet/res/theme/app_colors.dart';
import 'package:app_wallet/res/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _kAppBarButtonSize = 36.0;
const _kBorderRadius = 8.0;

class WalletAppBar extends AppBar {
  final String text;
  final IconData? leadingIcon;
  final void Function()? onMorePressed;
  final void Function()? onBackPressed;
  final BuildContext context;
  final Color? bgColor;
  final Widget? customAction;

  WalletAppBar(
      {Key? key,
      required this.text,
      required this.context,
      this.leadingIcon,
      this.bgColor,
      this.onBackPressed,
      this.onMorePressed,
      this.customAction})
      : super(
            key: key,
            leading: AppBarButton(
              iconData: leadingIcon ?? Icons.chevron_left_outlined,
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
              hasHorizontalPadding: true,
            ),
            actions: [
              if (customAction != null) customAction,
              AppBarButton(
                iconData: Icons.more_vert_rounded,
                onPressed: onMorePressed ?? () {},
                hasHorizontalPadding: true,
              )
            ],
            title: Text(text));

  @override
  bool? get centerTitle => true;

  @override
  Color? get backgroundColor => bgColor ?? AppColors.darkPrimary;

  @override
  double? get elevation => 0;

  @override
  double? get leadingWidth =>
      _kAppBarButtonSize +
      kHorizontalPadding20.left +
      kHorizontalPadding20.right;

  @override
  TextStyle? get titleTextStyle => GoogleFonts.inter(
      fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white);
}

class AppBarButton extends StatelessWidget {
  final IconData iconData;
  final double? iconSize;
  final void Function()? onPressed;
  final bool hasHorizontalPadding;
  const AppBarButton(
      {Key? key,
      required this.iconData,
      this.iconSize,
      this.onPressed,
      this.hasHorizontalPadding = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: hasHorizontalPadding ? kHorizontalPadding20.left : 0,
            vertical: (kToolbarHeight - _kAppBarButtonSize) / 2),
        child: Ink(
          width: _kAppBarButtonSize,
          height: _kAppBarButtonSize,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_kBorderRadius),
              color: AppColors.darkPrimary),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(_kBorderRadius),
            child: Center(
                child: Icon(
              iconData,
              size: iconSize,
              color: Colors.white,
            )),
          ),
        ),
      );
}
