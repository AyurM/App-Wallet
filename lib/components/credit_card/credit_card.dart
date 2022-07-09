import 'package:app_wallet/components/outlined_text.dart';
import 'package:app_wallet/data/model/credit_card_input.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _kPadding = EdgeInsets.fromLTRB(33, 0, 14, 13);
const _kRelativeChipWidth = 0.171;
const _kRelativeWavesWidth = 0.054;
const _kRelativeLogoWidth = 0.211;
const _kBorderRadius = 15.0;

class CreditCard extends StatelessWidget {
  static const aspectRatio = 1.591;

  final CreditCardInput data;

  final Gradient gradient;

  const CreditCard.purple({Key? key, required this.data})
      : gradient = const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFA858EE),
              Color(0xFF6C40D9),
            ]),
        super(key: key);

  const CreditCard.green({Key? key, required this.data})
      : gradient = const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF70E77E),
              Color(0xFF00A6C2),
            ]),
        super(key: key);

  const CreditCard.blue({Key? key, required this.data})
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
                      width: constraints.maxWidth * _kRelativeChipWidth),
                  const SizedBox(width: 24),
                  Image.asset('assets/images/card_waves.png',
                      width: constraints.maxWidth * _kRelativeWavesWidth)
                ],
              ),
              const SizedBox(height: 11),
              OutlinedText(text: data.cardNumber, fontSize: 24),
              const SizedBox(height: 10),
              _CardValidThru(valid: data.expirationDate),
              const Spacer(
                flex: 10,
              ),
              Text(
                data.ownerName,
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
                  width: constraints.maxWidth * _kRelativeLogoWidth,
                ))
          ],
        ),
      );
    });
  }
}

class _CardValidThru extends StatelessWidget {
  final DateTime valid;

  const _CardValidThru({Key? key, required this.valid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String validDate = _getValidThruString(valid);

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
