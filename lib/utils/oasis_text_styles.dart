import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/ui_utils.dart';

class OasisTextStyles {
  static TextStyle robotoExtraBold = GoogleFonts.roboto(
    textStyle: TextStyle(
        color: Colors.black,
        fontSize: UIUtills().getProportionalWidth(width: 24),
        fontWeight: FontWeight.w800),
  );
  static TextStyle openSans600 = GoogleFonts.openSans(
      textStyle: TextStyle(
          color: Colors.black,
          fontSize: 23.31.sp,
          fontWeight: FontWeight.w600));

  static TextStyle inter500 = GoogleFonts.openSans(
      textStyle: TextStyle(
          color: Colors.white,
          fontSize: 28.sp,
          fontWeight: FontWeight.w500));

  static TextStyle openSans300 = GoogleFonts.openSans(
    textStyle: TextStyle(
        color: Colors.black, fontSize: 17.47.sp, fontWeight: FontWeight.w300),
  );

  static TextStyle poppinsRegular = GoogleFonts.poppins(
    textStyle: TextStyle(
        color: Colors.black,
        fontSize: UIUtills().getProportionalWidth(width: 14),
        fontWeight: FontWeight.w400),
  );
}
