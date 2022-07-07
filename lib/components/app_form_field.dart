import 'package:app_wallet/res/theme/app_colors.dart';
import 'package:flutter/material.dart';

const _kPadding = EdgeInsets.symmetric(horizontal: 12, vertical: 15);
const _kBorderRadius = 15.0;

class AppFormField extends StatelessWidget {
  final String labelText;

  const AppFormField({Key? key, required this.labelText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TextFormField(
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: textTheme.button,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_kBorderRadius),
              borderSide: const BorderSide(color: Color(0xFF221F67))),
          filled: true,
          fillColor: AppColors.darkPrimary.withOpacity(0.5),
          contentPadding: _kPadding),
    );
  }
}
