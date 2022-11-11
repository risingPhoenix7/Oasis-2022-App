import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis_2022/resources/resources.dart';
import 'package:oasis_2022/utils/oasis_text_styles.dart';
import 'package:flutter/material.dart';

import '../../utils/ui_utils.dart';

class OverloadOne extends StatelessWidget {
  const OverloadOne({Key? key}) : super(key: key);

  final String text =
      "Forget about the hassle of standing in long queues to order from the available stalls.Place orders and get live updates about the status of your order on the app.";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 203.27.h),
          child: SvgPicture.asset("assets/images/overload1.svg", height: 267.73.h, width: 316.w,),
        ),
        Text(
          text,
          style: GoogleFonts.openSans(fontSize: 16.sp, color: Colors.white),
        )
      ],
    );
  }
}
