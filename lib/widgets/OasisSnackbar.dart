import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSnackBar {
  SnackBar oasisSnackBar(String? text) {
    return SnackBar(
      content: Text(
        text ?? "Unknown Error",
        textAlign: TextAlign.center,
        style: GoogleFonts.openSans(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.sp),
      ),
      backgroundColor: Colors.amber.withOpacity(0.8),
      behavior: SnackBarBehavior.floating,
    );
  }
}
