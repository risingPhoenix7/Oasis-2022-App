import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../store_controller.dart';
import 'banner_details.dart';

class ProfShow extends StatefulWidget {
  const ProfShow({Key? key}) : super(key: key);

  @override
  State<ProfShow> createState() => _ProfShowState();
}

class _ProfShowState extends State<ProfShow> {
  @override
  void initState() {
    StoreController.itemNumber.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 43.h, left: 8.w),
          child: Container(
            child: Image.asset(
                "assets/images/${StoreController().imageNames[StoreController.itemNumber.value]}.png"),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 180.h),
          child: Container(
            height: 356.h,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 438.h, left: 20.w),
          child: const BannerDetails(),
        ),
      ],
    );
  }
}
