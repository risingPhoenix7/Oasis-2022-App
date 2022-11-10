import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class BuyTicket extends StatefulWidget {
  const BuyTicket({Key? key}) : super(key: key);

  @override
  State<BuyTicket> createState() => _BuyTicketState();
}

class _BuyTicketState extends State<BuyTicket> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
        height: 545.h,
        width: 388.w,
        child: Stack(children: [
          SvgPicture.asset(
            "assets/images/dialog_box_bg.svg",
            height: 545.h,
            width: 388.w,
          ),
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 27.h, left: 70.w),
                    child: Text(
                      "Select Number of Tickets",
                      style: GoogleFonts.openSans(
                          fontSize: 20.sp, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 27.h, left: 30.w),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 28.r,
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 108.h),
                child: SvgPicture.asset("assets/images/ticket.svg"),
              ),
              Padding(
                padding: EdgeInsets.only(top: 82.78.h),
                child: SizedBox(
                  width: 342.28.w,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          selectedIndex = index;
                          setState(() {});
                        },
                        child: Container(
                          height: 28.h,
                          decoration: BoxDecoration(
                              color: (selectedIndex == index)
                                  ? Colors.yellow
                                  : Colors.transparent,
                              shape: BoxShape.circle),
                          child: ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (bounds) {
                              return (selectedIndex == index)
                                  ? const LinearGradient(colors: [Colors.black])
                                      .createShader(Rect.fromLTWH(
                                          0, 0, bounds.width, bounds.height))
                                  : const LinearGradient(colors: [
                                      Color.fromRGBO(209, 154, 8, 1),
                                      Color.fromRGBO(254, 212, 102, 1),
                                      Color.fromRGBO(227, 186, 79, 1),
                                      Color.fromRGBO(209, 154, 8, 1),
                                      Color.fromRGBO(209, 154, 8, 1),
                                    ]).createShader(Rect.fromLTWH(
                                      0, 0, bounds.width, bounds.height));
                            },
                            child: Text("${index + 1}"),
                          ),
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 9,
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
