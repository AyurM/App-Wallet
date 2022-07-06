import 'package:app_wallet/res/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _kTextOpacity = 0.87;

TextTheme appTextTheme = TextTheme(
  headline1: GoogleFonts.inter(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      color: AppColors.primaryText.withOpacity(_kTextOpacity)),
  headline2: GoogleFonts.inter(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: AppColors.primaryText.withOpacity(_kTextOpacity)),
  headline3: GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: AppColors.primaryText.withOpacity(_kTextOpacity)),
  headline4: GoogleFonts.inter(
      fontSize: 20, fontWeight: FontWeight.w400, color: AppColors.primaryText),
  bodyText1: GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.primaryText),
  bodyText2: GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.primaryText),
  button: GoogleFonts.inter(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: AppColors.primaryText.withOpacity(_kTextOpacity)),
  subtitle1: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.secondaryText),
  subtitle2: GoogleFonts.inter(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: AppColors.secondaryText),
);
