import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension CustomTextExtension on String {
  Text buildText({
    double fontSize = 16.0,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black,
  }) {
    return Text(
      this,
      style: GoogleFonts.openSans(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ), // Change to your desired Google Font
    );
  }
}