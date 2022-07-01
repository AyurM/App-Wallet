import 'package:app_wallet/components/outlined_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _kPadding = EdgeInsets.fromLTRB(33, 0, 14, 13);
const _kChipWidth = 60.0;
const _kWavesWidth = 19.0;
const _kBorderRadius = 15.0;

class CreditCard extends StatelessWidget {
  static const aspectRatio = 1.591;

  final String name;
  final String number;
  final DateTime? valid;

  final Gradient gradient;

  const CreditCard.purple(
      {Key? key,
      required this.name,
      this.number = '0000 0000 0000 0000',
      this.valid})
      : gradient = const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFA858EE),
              Color(0xFF6C40D9),
            ]),
        super(key: key);

  const CreditCard.green(
      {Key? key,
      required this.name,
      this.number = '0000 0000 0000 0000',
      this.valid})
      : gradient = const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF70E77E),
              Color(0xFF00A6C2),
            ]),
        super(key: key);

  const CreditCard.blue(
      {Key? key,
      required this.name,
      this.number = '0000 0000 0000 0000',
      this.valid})
      : gradient = const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF00A6C2),
              Color(0xFF1544DF),
            ]),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final cardHeight = constraints.maxWidth / CreditCard.aspectRatio;

      return Container(
        width: constraints.maxWidth,
        height: cardHeight,
        padding: _kPadding,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_kBorderRadius),
            gradient: gradient,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 10,
                  offset: const Offset(5, 5))
            ]),
        child: Stack(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Spacer(flex: 68),
              Row(
                children: [
                  const SizedBox(width: 8),
                  Image.asset('assets/images/card_chip.png',
                      width: _kChipWidth),
                  const SizedBox(width: 24),
                  Image.asset('assets/images/card_waves.png',
                      width: _kWavesWidth)
                ],
              ),
              const SizedBox(height: 11),
              OutlinedText(text: number, fontSize: 24),
              const SizedBox(height: 10),
              _CardValidThru(valid: valid),
              const Spacer(
                flex: 10,
              ),
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    shadows: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 2))
                    ]),
              )
            ]),
            Positioned(
                right: 0,
                bottom: 0,
                child: Image.asset(
                  'assets/images/master_card.png',
                  width: 74,
                ))
          ],
        ),
      );
    });
  }
}

class _CardValidThru extends StatelessWidget {
  final DateTime? valid;

  const _CardValidThru({Key? key, this.valid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String validDate =
        valid == null ? '00/00' : _getValidThruString(valid!);

    return Padding(
      padding: const EdgeInsets.only(left: 100),
      child: Row(
        children: [
          Text(
            'VALID\nTHRU',
            style: GoogleFonts.inter(
              fontSize: 4,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 9),
          OutlinedText(text: validDate, fontSize: 16),
        ],
      ),
    );
  }

  String _getValidThruString(DateTime dateTime) {
    final month =
        dateTime.month > 9 ? '${dateTime.month}' : '0${dateTime.month}';
    final year = dateTime.year % 100;

    return '$month/$year';
  }
}
