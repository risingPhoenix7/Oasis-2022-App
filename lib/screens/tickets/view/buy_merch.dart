import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis_2022/screens/tickets/controller/store_controller.dart';
import 'package:oasis_2022/screens/tickets/repository/model/showsData.dart';

import '../../../widgets/OasisSnackbar.dart';
import '../repository/model/ticketPostBody.dart';
import '../view_model/tickets_post_view_model.dart';

class BuyMerch extends StatefulWidget {
  const BuyMerch(
      {Key? key,
      required this.id,
      required this.name,
      required this.price,
      required this.imageUrl,
      required this.amountPurchased,
      required this.available})
      : super(key: key);
  final int id;
  final String name;
  final int price;
  final String imageUrl;
  final int amountPurchased;
  final bool available;
  @override
  State<BuyMerch> createState() => _BuyMerchState();
}

class _BuyMerchState extends State<BuyMerch> {
  int selectedIndex = 0;

  @override
  void initState() {
    StoreController.itemNumber.addListener(() {
      if (!mounted) {}
      setState(() {});
    });
    StoreController.itemBoughtOrRefreshed.addListener(() {
      if (!mounted) {}
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
        height: 545.h,
        width: 388.w,
        child: Stack(children: [
          Image.asset(
            "assets/images/buy_tickets_bg.png",
            height: 545.h,
            width: 388.w,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 27.h, left: 75.w),
                    child: Text(
                      "Number of ${widget.name}",
                      style: GoogleFonts.openSans(
                          fontSize: 24.sp, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 27.h, left: 35.w),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 28.r,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  height: 286.h,
                  width: 290.w,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 23.h),
                child: SizedBox(
                  height: 28.h,
                  child: Center(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            selectedIndex = index;
                            setState(() {});
                          },
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: (index == 0) ? 0 : 8.w),
                            child: Container(
                              width: 28.h,
                              decoration: BoxDecoration(
                                  color: (selectedIndex == index)
                                      ? Colors.yellow
                                      : Colors.transparent,
                                  shape: BoxShape.circle),
                              child: Center(
                                child: ShaderMask(
                                  blendMode: BlendMode.srcIn,
                                  shaderCallback: (bounds) {
                                    return (selectedIndex == index)
                                        ? const LinearGradient(colors: [
                                            Colors.black,
                                            Colors.black
                                          ]).createShader(Rect.fromLTWH(
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
                                  child: Text(
                                    "${index + 1}",
                                    style:
                                        GoogleFonts.openSans(fontSize: 20.sp),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 5,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 32.h),
                child: GestureDetector(
                  onTap: () async {
                    if (widget.available) {
                      TicketPostBody ticketPostBody =
                          TicketPostBody(individual: {}, combos: {});
                      ticketPostBody.individual![widget.id.toString()] =
                          (selectedIndex + 1);
                      try {
                        await TicketPostViewModel().postOrders(ticketPostBody);
                        await StoreController().initialCall();
                        StoreController.itemBoughtOrRefreshed.value =
                            !StoreController.itemBoughtOrRefreshed.value;
                        if (!mounted) {}
                        Navigator.pop(context);
                      } catch (e) {
                        var snackbar = CustomSnackBar().oasisSnackBar(e.toString());
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                    } else {}
                  },
                  child: Container(
                    height: 52.h,
                    width: 171.w,
                    decoration: BoxDecoration(
                        gradient: widget.available
                            ? const LinearGradient(colors: [
                                Color.fromRGBO(209, 154, 8, 1),
                                Color.fromRGBO(254, 212, 102, 1),
                                Color.fromRGBO(227, 186, 79, 1),
                                Color.fromRGBO(209, 154, 8, 1),
                                Color.fromRGBO(209, 154, 8, 1),
                              ])
                            : const LinearGradient(colors: [
                                Color.fromRGBO(148, 145, 137, 1),
                                Color.fromRGBO(146, 143, 135, 1),
                                Color.fromRGBO(152, 150, 143, 1),
                                Color.fromRGBO(149, 146, 138, 1),
                                Color.fromRGBO(131, 125, 110, 1),
                                Color.fromRGBO(126, 126, 125, 1)
                              ]),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Center(
                      child: Text(
                        widget.available ? "Confirm" : "Sold Out",
                        style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Text(
                  "Already Purchased - ${widget.amountPurchased}",
                  style: GoogleFonts.openSans(
                      color: const Color(0xFFACACAC), fontSize: 12.sp),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
