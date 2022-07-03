import 'dart:ui';

import 'package:app_wallet/res/theme/app_colors.dart';
import 'package:app_wallet/res/theme/app_icons.dart';
import 'package:app_wallet/res/theme/constants.dart';
import 'package:flutter/material.dart';

const _icons = [AppIcons.home, AppIcons.wallet, AppIcons.graph, AppIcons.user];
const _kIconSize = 24.0;

class AppBottomNavBar extends StatelessWidget {
  final void Function(int) onSelect;
  final int currentIndex;

  const AppBottomNavBar(
      {Key? key, required this.currentIndex, required this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
      width: double.infinity,
      height: kBottomNavBarHeight,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            AppColors.lightPrimary.withOpacity(0.85),
            AppColors.darkPrimary
          ])),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _buildNavButtons()),
    );
  }

  List<Widget> _buildNavButtons() {
    final result = <Widget>[];

    for (int i = 0; i < _icons.length; i++) {
      result.add(_NavIconButton(
          iconData: _icons[i],
          isSelected: currentIndex == i,
          onPressed: () => onSelect(i)));
    }

    return result;
  }
}

class _NavIconButton extends StatelessWidget {
  final IconData iconData;
  final bool isSelected;
  final void Function()? onPressed;

  const _NavIconButton(
      {Key? key,
      required this.iconData,
      required this.isSelected,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox.square(
        dimension: _kIconSize,
        child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              if (isSelected) ...[
                Container(
                  width: _kIconSize * 2,
                  height: _kIconSize * 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accent.withOpacity(0.7),
                  ),
                ),
                ClipRect(
                  clipper: MyClip(),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 10, sigmaY: 10, tileMode: TileMode.decal),
                    child: const SizedBox.square(
                      dimension: _kIconSize * 2,
                    ),
                  ),
                )
              ],
              Icon(
                iconData,
                color: isSelected ? AppColors.accent : Colors.white,
              ),
            ]),
      ),
    );
  }
}

class MyClip extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return const Rect.fromLTWH(
        -(kBottomNavigationBarHeight - _kIconSize) / 2,
        -(kBottomNavigationBarHeight - _kIconSize) / 2,
        kBottomNavigationBarHeight,
        kBottomNavigationBarHeight);
  }

  @override
  bool shouldReclip(oldClipper) => true;
}
