import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const darkPrimary = Color(0xFF19173D);
  static const lightPrimary = Color(0xFF262450);
  static const accent = Color(0xFF00A6C2);
  static const primaryText = Colors.white;
  static const primaryText87 = Color(0xDEFFFFFF);
  static const secondaryText = Color(0xFFCAC9DF);
  static const purple = Color(0xFFA858EE);
  static const purple2 = Color(0xFF6C40D9);
  static const cyan = Color(0xFF00A6C2);
  static const blue = Color(0xFF1544DF);
  static const green = Color(0xFF70E77E);

  static const buttonGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.accent, AppColors.blue]);

  static const buttonBorderGradient =
      LinearGradient(colors: [Color(0xFF01D3E1), Color(0xFF2067EF)]);
}
