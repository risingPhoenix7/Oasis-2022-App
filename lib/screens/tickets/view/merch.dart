import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Merch extends StatefulWidget {
  const Merch({Key? key}) : super(key: key);

  @override
  State<Merch> createState() => _MerchState();
}

class _MerchState extends State<Merch> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 61.h),
          child: SvgPicture.asset("assets/images/merch_bg.svg"),
        ),
        CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return Padding(
                padding: (index % 2 == 0)
                    ? EdgeInsets.only(top: 174.h, right: 207.w, left: 20.w)
                    : EdgeInsets.only(top: 260.67.h, left: 222.h),
                child: Container(
                  height: 300.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Color.fromRGBO(209, 154, 8, 1),
                        Color.fromRGBO(254, 219, 126, 1)
                      ]),
                      borderRadius: BorderRadius.circular(22.17.r)),
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: Container(
                      decoration: BoxDecoration(

                          color: Colors.black,
                          borderRadius: BorderRadius.circular(22.17.r)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: SizedBox(
                                height: 203.h,
                                width: 170.w,
                                child: Image.asset(
                                    "assets/images/test_merch.png")),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }, childCount: 1))
          ],
        )
      ],
    );
  }
}
