import 'dart:ui';

import 'package:app_wallet/res/theme/app_colors.dart';
import 'package:app_wallet/res/theme/constants.dart';
import 'package:flutter/material.dart';

const _kIndicatorHeight = 3.0;
const _kIndicatorBlur = 5.0;
const _kUnselectedColor = Color(0xFF393678);

class AppTabBar extends StatelessWidget {
  final TabController controller;
  final List<String> tabTitles;

  const AppTabBar({Key? key, required this.tabTitles, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kHorizontalPadding20,
      child: DecoratedBox(
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: _kUnselectedColor, width: _kIndicatorHeight))),
        child: TabBar(
            controller: controller,
            physics: const NeverScrollableScrollPhysics(),
            indicator: _AppTabIndicator(),
            tabs: tabTitles
                .map((title) => SizedBox(
                      height: kAppBarBottomHeight,
                      child: Center(
                        child: Text(title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(color: AppColors.primaryText87)),
                      ),
                    ))
                .toList()),
      ),
    );
  }
}

class _AppTabIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _AppTabPainter();
}

class _AppTabPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    _drawIndicatorLine(canvas, offset, cfg, addBlur: true);
    _drawIndicatorLine(canvas, offset, cfg, addBlur: false);
  }

  void _drawIndicatorLine(Canvas canvas, Offset offset, ImageConfiguration cfg,
      {bool addBlur = false}) {
    final paint = Paint()
      ..color = AppColors.accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = _kIndicatorHeight;

    if (addBlur) {
      paint.imageFilter =
          ImageFilter.blur(sigmaX: _kIndicatorBlur, sigmaY: _kIndicatorBlur);
    }

    final dy = (cfg.size?.height ?? 0) - _kIndicatorHeight / 2;

    canvas.drawLine(offset + Offset(0, dy),
        offset + Offset(cfg.size?.width ?? 0, dy), paint);
  }
}
