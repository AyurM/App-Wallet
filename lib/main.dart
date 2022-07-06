import 'package:app_wallet/res/theme/app_colors.dart';
import 'package:app_wallet/res/theme/text_theme.dart';
import 'package:app_wallet/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Wallet Demo',
      theme: ThemeData.dark().copyWith(
          textTheme: appTextTheme,
          scaffoldBackgroundColor: AppColors.darkPrimary),
      home: const HomeScreen(),
    );
  }
}
