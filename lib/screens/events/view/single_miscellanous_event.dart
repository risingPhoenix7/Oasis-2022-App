import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oasis_2022/resources/resources.dart';
import 'package:oasis_2022/utils/colors.dart';
import 'package:oasis_2022/utils/oasis_text_styles.dart';

class SingleMiscellaneousEvent extends StatelessWidget {
  SingleMiscellaneousEvent(
      {Key? key,
      required this.time,
      required this.eventName,
      required this.eventDescription,
      required this.eventConductor,
      required this.eventLocation})
      : super(key: key);

  String? time;
  String? eventName;
  String? eventDescription;
  String? eventConductor;
  String? eventLocation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0.h),
      child: Container(
        width: 388.w,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageAssets.eventCardBg), fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(21.w,26.h,37.w,27.h),
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(eventName ?? 'TBA',
                  style: OasisTextStyles.openSansSubHeading
                      .copyWith(color: Colors.white)),
              SizedBox(height: 12.h),
              Text(eventConductor ?? 'DEPARTMENT',
                  style: OasisTextStyles.openSansSubHeading.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: OasisColors.primaryYellow)),
              SizedBox(height: 13.h),
              Text(
                eventDescription ??
                    'NA',
                style: OasisTextStyles.openSans600
                    .copyWith(fontSize: 14.sp, color: Colors.white),
                maxLines: 4,
              ),
              SizedBox(height: 19.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(ImageAssets.locationIcon,color: Colors.white),
                  Text(eventLocation ?? 'TBA',
                      style: OasisTextStyles.openSans300
                          .copyWith(fontSize: 12.sp,color: Colors.white)),
                  SvgPicture.asset(ImageAssets.timeicon,color: Colors.white,),
                  SizedBox(width: 90.w),
                  Text(time ?? 'TBA',
                      style: OasisTextStyles.openSans300
                          .copyWith(fontSize: 12.sp,color: Colors.white)),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
