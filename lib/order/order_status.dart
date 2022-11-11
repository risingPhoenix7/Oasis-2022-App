import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis_2022/notificationservice/local_notification_service.dart';
import 'package:oasis_2022/order/repo/model/order_card_model.dart';
import 'package:oasis_2022/widgets/OasisSnackbar.dart';

import '../resources/resources.dart';
import 'order_screen_viewmodel.dart';

class OrderStatus extends StatefulWidget {
  OrderStatus({Key? key, required this.orderCardModel}) : super(key: key);
  OrderCardModel orderCardModel;

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  String otp = 'View OTP';
  int? newstatus = 0;
  @override
  Widget build(BuildContext context) {
    var OrderId = widget.orderCardModel.orderId.toString();


  Future<void> demo() async {

      DocumentSnapshot documentSnapshot =

      await FirebaseFirestore.instance
          .collection('orders') // suppose you have a collection named "Users"
          .doc(OrderId)
          .get();

        newstatus = await documentSnapshot['status'];


    }

    Stream<DocumentSnapshot> collectionStream = FirebaseFirestore.instance
        .collection('orders')
        .doc(OrderId)
        .snapshots();
    FirebaseFirestore.instance.collection('orders').
    doc(OrderId).
    snapshots().
    listen((event) async {

    await demo();
      print(newstatus);
      if(newstatus == 1) {

        LocalNotificationService.shownotification('Your Order number #$OrderId','Your Order has been accepted!');
      }
      else if(newstatus == 2) {

        LocalNotificationService.shownotification('Your Order number  #$OrderId','Your Order is ready!');
      }
    });
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
          stream: collectionStream,
          builder: (context, snapshot) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Padding(
                padding: EdgeInsets.only(top: 176.h),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 388.w,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage(ImageAssets.backgroundOrd),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(20.r)),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(21.w, 0, 23.w, 0),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 23, 0, 0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Order  #${widget.orderCardModel.orderId.toString()}',
                                          style: GoogleFonts.openSans(
                                            color: const Color.fromRGBO(
                                                148, 148, 148, 1),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp,
                                          ),
                                          textScaleFactor: 1,
                                        ),
                                        GestureDetector(
                                            onTap: (Navigator.of(context).pop),
                                            child: SvgPicture.asset(
                                                'assets/images/cross.svg'))
                                      ]),
                                ),
                                SizedBox(
                                  height: 13.h,
                                ),
                                SvgPicture.asset(
                                    picture(snapshot.data?['status'] ?? 0)),
                                Padding(
                                  padding: EdgeInsets.only(top: 26.h),
                                  child: Text(
                                    '${status(snapshot.data?['status'] ?? 0)}',
                                    style: GoogleFonts.openSans(
                                      color: const Color.fromRGBO(
                                          225, 225, 225, 1),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ),
                                if (snapshot.data?['status']  == 0)
                                  Padding(
                                    padding: EdgeInsets.only(top: 19.h),
                                    child: SvgPicture.asset(
                                        "assets/images/1.svg"),
                                  )
                                else if (snapshot.data?['status'] == 1)
                                  Padding(
                                    padding: EdgeInsets.only(top: 19.h),
                                    child: SvgPicture.asset(
                                        "assets/images/two.svg"),
                                  )
                                else if (snapshot.data?['status']  == 2)
                                  Padding(
                                    padding: EdgeInsets.only(top: 19.h),
                                    child: SvgPicture.asset(
                                        "assets/images/three.svg"),
                                  )
                                else if (snapshot.data?['status']  == 3  || snapshot.data?['status']  == 4)
                                 Container()
                                ,
                                Padding(
                                  padding: EdgeInsets.only(top: 41.h),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight: 110.h,
                                    ),
                                    child: RawScrollbar(
                                      minThumbLength: 30.h,
                                      minOverscrollLength: 20.h,
                                      thumbColor:
                                          Color.fromRGBO(114, 92, 13, 1),
                                      thickness: 2.w,
                                      trackVisibility: true,
                                      thumbVisibility: true,
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: widget.orderCardModel
                                            .menuItemInOrdersScreenList.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 8.h),
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 32.w),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: 196.w,
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Flexible(
                                                                  child: Text(
                                                                    widget
                                                                        .orderCardModel
                                                                        .menuItemInOrdersScreenList[
                                                                            index]
                                                                        .name,
                                                                    style: GoogleFonts.openSans(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 30.w),
                                                            child: Text(
                                                              '₹ ${widget.orderCardModel.menuItemInOrdersScreenList[index].price} x ${widget.orderCardModel.menuItemInOrdersScreenList[index].quantity}',
                                                              style: GoogleFonts.roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: const Color
                                                                          .fromRGBO(
                                                                      100,
                                                                      100,
                                                                      100,
                                                                      1)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 20.w,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    child: Divider(
                                  color: Color.fromRGBO(249, 207, 18, 1),
                                )),
                                Padding(
                                  padding: EdgeInsets.only(left: 32),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: 196.w,
                                        child: Text(
                                          'SubTotal',
                                          // widget
                                          //     .orderCardModel
                                          //     .menuItemInOrdersScreenList[
                                          // index]
                                          //     .name,
                                          style: GoogleFonts.openSans(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(30.w, 0, 0, 0),
                                        child: Text(
                                          '₹ ${widget.orderCardModel.subtotal.round()}',
                                          //'₹ ${widget.orderCardModel.menuItemInOrdersScreenList[index].price} x ${widget.orderCardModel.menuItemInOrdersScreenList[index].quantity}',
                                          style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20.sp,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(0, 33.h, 0, 43.h),
                                  child: GestureDetector(
                                    onTap: () async {
                                      print('tapped');
                                      if (snapshot
                                          .data?['status'] >=
                                          2) {
                                        if (snapshot.data?[
                                        'status'] ==
                                            2) {
                                          otp = widget
                                              .orderCardModel.otp
                                              .toString();
                                          await OrderScreenViewModel()
                                              .makeOtpSeen(widget
                                              .orderCardModel
                                              .orderId!);
                                          print('success');
                                          setState(() {});
                                        }
                                      } else {
                                        var snackBar =
                                       CustomSnackBar().oasisSnackBar('OTP will be available when your order is ready');
                                        ScaffoldMessenger.of(
                                            context)
                                            .showSnackBar(
                                            snackBar);
                                      }

                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      // alignment: Alignment.bottomCenter,
                                      width: 171.w,
                                      height: 52.h,
                                      // margin: EdgeInsets.symmetric(
                                      //     horizontal:
                                      //     UIUtills().getProportionalWidth(width: 20.00)),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color.fromRGBO(209, 154, 8, 1),
                                            Color.fromRGBO(254, 212, 102, 1),
                                            Color.fromRGBO(227, 186, 79, 1),
                                            Color.fromRGBO(209, 154, 8, 1),
                                            Color.fromRGBO(209, 154, 8, 1),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          15.r,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            otp,
                                            style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  String picture(int status) {
    if (status == 4) {
      return "assets/images/cancelled.svg";
    }else if (status == 0) {
      return "assets/images/orderstatusman.svg";}
    else if (status == 1) {
      return "assets/images/accepted.svg";
    } else if (status == 2) {
      return "assets/images/ready.svg";
    } else if (status == 3) {
      return "assets/images/delivered.svg";
    }
    return "Delivered";
  }
  String status(int status) {
    if (status == 4) {
      return "Order Cancelled";
    }else if (status == 0) {
      return "Order Pending";}
    else if (status == 1) {
      return "Your order is being prepared";
    } else if (status == 2) {
      return "Your order is ready for pickup";
    } else if (status == 3) {
      return "Your order has been delivered";
    }
    return "Delivered";
  }

}
