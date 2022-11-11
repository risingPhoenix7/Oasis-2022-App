import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSnackBar {
  SnackBar oasisSnackBar(String? text) {
    print('sefehsfhjbwfw');
    return SnackBar(
      duration: Duration(milliseconds: 500),
      content: Text(
        text ?? "Unknown Error",
        textAlign: TextAlign.center,
        style: GoogleFonts.openSans(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12.sp),
      ),
      backgroundColor: Colors.amber.withOpacity(0.8),
      behavior: SnackBarBehavior.floating,
    );
  }
}
