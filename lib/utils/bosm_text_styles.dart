import '../utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BosmTextStyles {
  static TextStyle robotoExtraBold = GoogleFonts.roboto(
    textStyle: TextStyle(
        color: Colors.black,
        fontSize: UIUtills().getProportionalWidth(width: 24),
        fontWeight: FontWeight.w800),
  );

  static TextStyle poppinsRegular = GoogleFonts.poppins(
    textStyle: TextStyle(
        color: Colors.black,
        fontSize: UIUtills().getProportionalWidth(width: 14),
        fontWeight: FontWeight.w400),
  );
}
