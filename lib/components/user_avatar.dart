import 'package:app_wallet/res/theme/app_colors.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String imagePath;
  final double size;
  final double borderWidth;

  const UserAvatar(
      {Key? key,
      required this.imagePath,
      required this.size,
      this.borderWidth = 3.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
        dimension: size,
        child: Stack(alignment: Alignment.center, children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.purple,
                      AppColors.blue.withOpacity(0.5)
                    ])),
          ),
          CircleAvatar(
            radius: size / 2 - borderWidth,
            foregroundImage: AssetImage(imagePath),
          )
        ]));
  }
}
