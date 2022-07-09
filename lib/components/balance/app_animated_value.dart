import 'package:flutter/material.dart';

const _kAnimOffsetDx = 50.0;

class AppAnimatedValue extends StatelessWidget {
  final AnimationController animationController;
  final String text;

  const AppAnimatedValue(
      {Key? key, required this.animationController, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          final value = Curves.easeInOut.transform(animationController.value);
          return Transform.translate(
            offset: Offset(_kAnimOffsetDx * (1 - value), 0),
            child: Opacity(opacity: value, child: child),
          );
        },
        child: Text(text, style: Theme.of(context).textTheme.headline2),
      );
}
