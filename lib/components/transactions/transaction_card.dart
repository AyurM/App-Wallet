import 'package:app_wallet/data/model/transaction_data.dart';
import 'package:app_wallet/res/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const _kImageSize = 50.0;
const _kLogoScale = 0.65;
const _kValueLabelSize = Size(100.0, 44.0);
const _kLogoBgColor = Colors.white;

class TransactionCard extends StatelessWidget {
  final TransactionData data;

  const TransactionCard({Key? key, required this.data}) : super(key: key);

  static final _dateFormat = DateFormat('MMMM d, y');

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
        padding: const EdgeInsets.all(1),
        decoration: const ShapeDecoration(
            shape: StadiumBorder(),
            gradient: LinearGradient(
                colors: [Color(0xFF2D296E), AppColors.darkPrimary])),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: const ShapeDecoration(
              shape: StadiumBorder(), color: AppColors.darkPrimary),
          child: Row(children: [
            _TransactionLogo(imagePath: data.imagePath),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryText87)),
                  const SizedBox(height: 3),
                  Text(_dateFormat.format(data.dateTime),
                      style: textTheme.subtitle2)
                ],
              ),
            ),
            const SizedBox(width: 15),
            _TransactionValue(data: data)
          ]),
        ));
  }
}

class _TransactionLogo extends StatelessWidget {
  final String imagePath;

  const _TransactionLogo({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(_kImageSize / 2),
        child: SizedBox.square(
          dimension: _kImageSize,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(color: _kLogoBgColor),
              Image.asset(
                imagePath,
                width: _kImageSize * _kLogoScale,
                height: _kImageSize * _kLogoScale,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      );
}

class _TransactionValue extends StatelessWidget {
  final TransactionData data;

  const _TransactionValue({Key? key, required this.data}) : super(key: key);

  String get _text =>
      '${data.type == TransactionType.income ? '+' : '-'}${data.currency}${data.value.toStringAsFixed(2)}'
          .replaceFirst('.', ',');

  @override
  Widget build(BuildContext context) => Container(
        width: _kValueLabelSize.width,
        height: _kValueLabelSize.height,
        decoration: const ShapeDecoration(
            shape: StadiumBorder(side: BorderSide(color: Color(0xFF25225B)))),
        child: Center(
          child: Text(_text, style: Theme.of(context).textTheme.button),
        ),
      );
}
