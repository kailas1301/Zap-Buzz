import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubHeadingTextWidget extends StatelessWidget {
  const SubHeadingTextWidget({
    super.key,
    required this.title,
    this.textColor,
    this.textsize,
  });
  final String title;
  final Color? textColor;
  final double? textsize;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.openSans(
        fontSize: textsize ?? 16,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
    );
  }
}

class AppBarTextWidget extends StatelessWidget {
  const AppBarTextWidget({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.openSans(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
