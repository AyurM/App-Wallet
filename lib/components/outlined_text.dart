import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OutlinedText extends StatelessWidget {
  final String text;
  final double fontSize;
  final double strokeWidth;

  const OutlinedText(
      {Key? key,
      required this.text,
      required this.fontSize,
      this.strokeWidth = 1.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Text(text,
              style: GoogleFonts.inter(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w400,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = strokeWidth
                    ..color = Colors.black.withOpacity(0.1))),
          Text(text,
              style: GoogleFonts.inter(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  shadows: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 8,
                        offset: const Offset(0, 2))
                  ])),
        ],
      );
}
