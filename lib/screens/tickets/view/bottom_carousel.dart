import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis_2022/screens/tickets/store_controller.dart';

class BottomCarousel extends StatefulWidget {
  const BottomCarousel({Key? key}) : super(key: key);

  @override
  State<BottomCarousel> createState() => _BottomCarouselState();
}

class _BottomCarouselState extends State<BottomCarousel> {

  @override
  void initState() {
    StoreController.itemNumber.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24.w),
          child: Text(
            "Store",
            textScaleFactor: 1.0,
            style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 32.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: SizedBox(
            height: 161.h,
            child: CustomScrollView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              slivers: [
                SliverPadding(
                    padding: EdgeInsets.only(left: 13.w),
                    sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 16.w),
                        child: GestureDetector(
                          onTap: (){
                            print("ok");
                            StoreController.itemNumber.value = index;
                            StoreController.itemNumber.notifyListeners();
                          },
                          child: Image.asset(
                              "assets/images/${StoreController().imageNamesCarousel[index]}.png"),
                        ),
                      );
                    }, childCount: StoreController().imageNamesCarousel.length)))
              ],
            ),
          ),
        )
      ],
    );
  }
}
