import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:oasis_2022/screens/tickets/controller/store_controller.dart';
import 'package:oasis_2022/screens/tickets/repository/model/showsData.dart';
import 'package:oasis_2022/screens/tickets/repository/model/ticketPostBody.dart';
import 'package:oasis_2022/screens/tickets/view_model/tickets_post_view_model.dart';

import '../../../widgets/OasisSnackbar.dart';

class BuyTicket extends StatefulWidget {
  const BuyTicket({Key? key}) : super(key: key);

  @override
  State<BuyTicket> createState() => _BuyTicketState();
}

class _BuyTicketState extends State<BuyTicket> {
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
                    padding: EdgeInsets.only(top: 27.h, left: 70.w),
                    child: Text(
                      "Select Number of Tickets",
                      style: GoogleFonts.openSans(
                          fontSize: 20.sp, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 27.h, left: 30.w),
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
                padding: EdgeInsets.only(top: 87.h),
                child: SvgPicture.asset("assets/images/ticket.svg"),
              ),
              Padding(
                padding: EdgeInsets.only(top: 51.74.h),
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
                      itemCount: 10,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 33.2.h),
                child: Text(
                  "₹ ${(selectedIndex + 1) * (StoreController.carouselItems[StoreController.itemNumber.value] as StoreItemData).price!}",
                  style: GoogleFonts.openSans(
                      color: const Color(0xFFE6E6E6),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: GestureDetector(
                  onTap: () async {
                    TicketPostBody ticketPostBody =
                        TicketPostBody(individual: {}, combos: {});
                    ticketPostBody.individual![
                            "${(StoreController.carouselItems[StoreController.itemNumber.value] as StoreItemData).id}"] =
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
                  },
                  child: Container(
                    height: 52.h,
                    width: 171.w,
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
                        "Confirm",
                        style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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
