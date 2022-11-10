import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis_2022/screens/tickets/repository/model/showsData.dart';
import 'package:oasis_2022/screens/tickets/store_controller.dart';

class Merch extends StatefulWidget {
  const Merch({Key? key}) : super(key: key);

  @override
  State<Merch> createState() => _MerchState();
}

class _MerchState extends State<Merch> {
  ScrollController scrollController = ScrollController();
  double position = 0;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.amber,
      backgroundColor: Colors.black,
      onRefresh: () async {
        await StoreController().initialCall();
        setState(() {});
      },
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 61.h),
            child: SvgPicture.asset(
              "assets/images/merch_bg.svg",
              height: 662.h,
              width: 428.w,
            ),
          ),
          SizedBox(
            height: 561.h,
            child: CustomScrollView(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              slivers: [
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return Padding(
                    padding: (index % 2 == 0)
                        ? EdgeInsets.only(top: 174.h, left: 20.w, bottom: 87.w)
                        : EdgeInsets.only(top: 260.67.h, left: 21.h),
                    child: Container(
                      height: 300.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Color.fromRGBO(254, 219, 126, 1),
                            Color.fromRGBO(209, 154, 8, 1),
                          ]),
                          borderRadius: BorderRadius.circular(22.17.r)),
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(22.17.r)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 10.h, left: 16.08.w),
                                child: SizedBox(
                                    height: 203.h,
                                    width: 170.w,
                                    child: Stack(children: [
                                      CachedNetworkImage(
                                          imageUrl:
                                              (StoreController.carouselItems[
                                                          StoreController
                                                              .itemNumber.value]
                                                      as MerchCarouselItem)
                                                  .merch![index]
                                                  .image_url[0]),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 160.h, left: 27.73.w),
                                        child: Container(
                                          height: 35.56.h,
                                          width: 114.54.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              color: Colors.black),
                                          child: Center(
                                            child: Text(
                                              "BUY",
                                              style: GoogleFonts.openSans(
                                                  color:
                                                      const Color(0xFFE9E9E9),
                                                  fontSize: 13.3.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      )
                                    ])),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 17.h, left: 16.w),
                                child: Text(
                                  (StoreController.carouselItems[StoreController
                                          .itemNumber
                                          .value] as MerchCarouselItem)
                                      .merch![index]
                                      .name!,
                                  style: GoogleFonts.openSans(
                                      color: const Color(0xFFEFEFEF),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.h, left: 16.w),
                                child: Text(
                                  "₹ ${(StoreController.carouselItems[StoreController.itemNumber.value] as MerchCarouselItem).merch![index].price}",
                                  style: GoogleFonts.openSans(
                                      color: const Color(0xFFEFEFEF),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                        childCount: (StoreController.carouselItems[
                                    StoreController.itemNumber.value]
                                as MerchCarouselItem)
                            .merch!
                            .length))
              ],
            ),
          )
        ],
      ),
    );
  }
}
