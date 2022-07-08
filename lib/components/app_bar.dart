import 'package:app_wallet/components/user_avatar.dart';
import 'package:app_wallet/data/model/user_profile.dart';
import 'package:app_wallet/res/theme/app_colors.dart';
import 'package:app_wallet/res/theme/constants.dart';
import 'package:flutter/material.dart';

const _kAppBarButtonSize = 36.0;
const _kBorderRadius = 8.0;
const _kWelcomeText = 'Welcome back!';
const _kUserAvatarSize = 50.0;

class WalletAppBar extends AppBar {
  final String text;
  final IconData? leadingIcon;
  final void Function()? onMorePressed;
  final void Function()? onBackPressed;
  final BuildContext context;
  final Color? bgColor;
  final Widget? customAction;
  final PreferredSizeWidget? bottomWidget;

  WalletAppBar(
      {Key? key,
      required this.text,
      required this.context,
      this.leadingIcon,
      this.bgColor,
      this.onBackPressed,
      this.onMorePressed,
      this.bottomWidget,
      this.customAction})
      : super(
            key: key,
            bottom: bottomWidget,
            leading: AppBarButton(
              iconData: leadingIcon ?? Icons.chevron_left_outlined,
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
              hasHorizontalPadding: true,
              backgroundColor: bgColor,
            ),
            actions: [
              if (customAction != null) customAction,
              AppBarButton(
                iconData: Icons.more_vert_rounded,
                onPressed: onMorePressed ?? () {},
                hasHorizontalPadding: true,
                backgroundColor: bgColor,
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
  TextStyle? get titleTextStyle => Theme.of(context).textTheme.headline3;
}

class HomeTabAppBar extends AppBar {
  final UserProfile userProfile;
  final void Function()? onMorePressed;
  final BuildContext context;
  final Color? bgColor;

  HomeTabAppBar({
    Key? key,
    required this.userProfile,
    required this.context,
    this.bgColor,
    this.onMorePressed,
  }) : super(
            titleSpacing: 0,
            toolbarHeight: kExtendedToolbarHeight,
            key: key,
            leading: Padding(
              padding: EdgeInsets.only(
                  left: kHorizontalPadding20.left,
                  right: kHorizontalPadding10.right),
              child: UserAvatar(
                  imagePath: userProfile.imagePath, size: _kUserAvatarSize),
            ),
            actions: [
              AppBarButton(
                iconData: Icons.more_vert_rounded,
                onPressed: onMorePressed ?? () {},
                hasHorizontalPadding: true,
                backgroundColor: bgColor,
              )
            ],
            title:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(_kWelcomeText,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 3),
              Text(userProfile.name,
                  style: Theme.of(context).textTheme.subtitle2)
            ]));

  @override
  bool? get centerTitle => false;

  @override
  Color? get backgroundColor => bgColor ?? AppColors.darkPrimary;

  @override
  double? get elevation => 0;

  @override
  double? get leadingWidth =>
      _kUserAvatarSize + kHorizontalPadding20.left + kHorizontalPadding10.right;

  @override
  TextStyle? get titleTextStyle => Theme.of(context).textTheme.headline3;
}

class AppBarButton extends StatelessWidget {
  final IconData iconData;
  final double? iconSize;
  final void Function()? onPressed;
  final bool hasHorizontalPadding;
  final Color? backgroundColor;

  const AppBarButton(
      {Key? key,
      required this.iconData,
      this.iconSize,
      this.onPressed,
      this.backgroundColor,
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
              color: backgroundColor ?? AppColors.darkPrimary),
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
