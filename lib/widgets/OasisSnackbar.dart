import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSnackBar {
  SnackBar oasisSnackBar(String? text) {
    return SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(
        text ?? "Unknown Error",
        textAlign: TextAlign.center,
        style: GoogleFonts.openSans(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.sp),
      ),
      backgroundColor: Colors.amber.withOpacity(0.9),
      behavior: SnackBarBehavior.floating,
    );
  }
}
