import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';


class OverloadFour extends StatelessWidget {
  OverloadFour({Key? key}) : super(key: key);

  String text = "Buy official oasis merchandise from the app itself. ";
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 203.27.h),
          child: SvgPicture.asset(
            "assets/images/overload4.svg",
            height: 267.73.h,
            width: 316.w,
          ),
        ),
        Text(
          text,
          style: GoogleFonts.openSans(fontSize: 16.sp, color: Colors.white),
        )
      ],
    );
  }
}