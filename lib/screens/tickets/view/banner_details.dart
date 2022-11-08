import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis_2022/screens/tickets/store_controller.dart';

class BannerDetails extends StatefulWidget {
  const BannerDetails({Key? key}) : super(key: key);

  @override
  State<BannerDetails> createState() => _BannerDetailsState();
}

class _BannerDetailsState extends State<BannerDetails> {

  @override
  void initState() {
    super.initState();
    StoreController.itemNumber.addListener(() {
      setState(() {
        print("here");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 387.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => const LinearGradient(colors: [
              Color.fromRGBO(207, 150, 0, 1),
              Color.fromRGBO(174, 186, 102, 1),
            ], transform: GradientRotation(161.5)).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
            child: Text(
              StoreController().itemName[StoreController.itemNumber.value],
              style: GoogleFonts.openSans(
                  fontSize: 36.sp, fontWeight: FontWeight.bold, height: 1.1.h),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 5.h)),
                  Text(
                    "6:00 PM | South Park",
                    textScaleFactor: 1.0,
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "Tickets Used 2",
                        textScaleFactor: 1.0,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.openSans(
                            fontSize: 15.sp, color: const Color(0xFFD3D3D3)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 21.w),
                        child: Text(
                          "Tickets Left 2",
                          textScaleFactor: 1.0,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.openSans(
                              fontSize: 15.sp, color: const Color(0xFFD3D3D3)),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Container(
                height: 46.h,
                width: 132.w,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color.fromRGBO(209, 154, 8, 1),
                      Color.fromRGBO(254, 212, 102, 1),
                      Color.fromRGBO(227, 186, 79, 1),
                      Color.fromRGBO(209, 154, 8, 1),
                      Color.fromRGBO(209, 154, 8, 1),
                    ]),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Center(
                  child: Text(
                    "Buy Tickets",
                    style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
