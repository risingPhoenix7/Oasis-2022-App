import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oasis_2022/screens/tickets/repository/model/showsData.dart';

import '../controller/store_controller.dart';
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
      if(!mounted){}
      setState(() {});
    });
    StoreController.itemBought.addListener(() {
      if(!mounted){}
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.amber,
      backgroundColor: Colors.black,
      onRefresh: () async {
        await StoreController().initialCall();
        setState(() {});
        StoreController.itemNumber.addListener(() {
          setState(() {});
        });
      },
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 43.h, left: 8.w),
            child: CachedNetworkImage(
              imageUrl: (StoreController
                          .carouselItems[StoreController.itemNumber.value]
                      as StoreItemData)
                  .image_url[1],
              placeholder: (context, url) => const CircularProgressIndicator(
                color: Colors.black,
              ),
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
      ),
    );
  }
}
