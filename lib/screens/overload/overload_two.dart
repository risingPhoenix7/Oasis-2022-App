import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis_2022/resources/resources.dart';
import 'package:oasis_2022/utils/oasis_text_styles.dart';

import '../../utils/ui_utils.dart';

class OverloadTwo extends StatelessWidget {
  const OverloadTwo({Key? key}) : super(key: key);
  final String text =
      "Keep a track of all the amazing events happening around the campus. You can even bookmark your favourite events so that you dont miss any of them.";
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 203.27.h),
          child: SvgPicture.asset(
            "assets/images/overload2.svg",
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
