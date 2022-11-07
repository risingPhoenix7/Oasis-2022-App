import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MoreInfoScreen extends StatefulWidget {
  const MoreInfoScreen({Key? key}) : super(key: key);

  @override
  State<MoreInfoScreen> createState() => _MoreInfoScreenState();
}

class _MoreInfoScreenState extends State<MoreInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SvgPicture.asset("assets/images/events_bg.svg"),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 108.h, left: 24.w),
                child: Text(
                  "See More",
                  style: GoogleFonts.openSans(
                      fontSize: 28.sp, color: Colors.white),
                ),
              ),
              
            ],
          )
        ],
      ),
    );
  }
}
