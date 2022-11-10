import 'package:intl/intl.dart';

import '../order/Custom_expansion_tile.dart' as cet;
import '../order/order_screen_viewmodel.dart';
import '../order/repo/model/order_card_model.dart';
import '../utils/ui_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Order_card extends StatefulWidget {
  Order_card({Key? key, required this.orderCardModel}) : super(key: key);
  OrderCardModel orderCardModel;

  @override
  State<Order_card> createState() => _Order_cardState();
}

class _Order_cardState extends State<Order_card>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  String otp = 'View OTP';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _animation = Tween(begin: 0.0, end: .5)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    var OrderId = widget.orderCardModel.orderId.toString();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    Stream<DocumentSnapshot> collectionStream = FirebaseFirestore.instance
        .collection('orders')
        .doc(OrderId)
        .snapshots();
    return StreamBuilder<DocumentSnapshot>(
        stream: collectionStream,
        builder: (context, snapshot) {
          return Column(
            children: [
              Container(
                // height: 300,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(116, 126, 241, 0.05),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: cet.ExpansionTile(
                    controller: _controller,
                    title: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: UIUtills()
                                        .getProportionalWidth(width: 8)),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 10, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                'Order  #${widget.orderCardModel.orderId ?? 0}',
                                                style: GoogleFonts.poppins(
                                                  fontSize: UIUtills()
                                                      .getProportionalHeight(
                                                          height: 14),
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color.fromRGBO(
                                                      61, 61, 61, 1),
                                                )),
                                            Column(
                                              children: [
                                                InkWell(
                                                  onTap: () async {
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
                                                        setState(() {});
                                                      }
                                                    } else {
                                                      var snackBar =
                                                          const SnackBar(
                                                        duration: Duration(
                                                            seconds: 2),
                                                        content: SizedBox(
                                                            height: 25,
                                                            child: Center(
                                                                child: Text(
                                                                    "OTP will be available when your order is ready"))),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackBar);
                                                    }
                                                  },
                                                  child: Text(otp,
                                                      style: TextStyle(
                                                        fontSize: UIUtills()
                                                            .getProportionalWidth(
                                                                width: 14),
                                                        color: const Color
                                                                .fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: 1,
                                                  height: 1,
                                                ),
                                                const SizedBox(
                                                  height: 1.5,
                                                ),
                                                Container(
                                                  height: 1,
                                                  color: Colors.black,
                                                  width: 60,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        thickness: 1,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Image.asset(
                                          //   'assets/images/PIC.png',
                                          //   height: UIUtills()
                                          //       .getProportionalHeight(
                                          //           height: 60),
                                          //   width: UIUtills()
                                          //       .getProportionalWidth(
                                          //           width: 60),
                                          // ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0,
                                                      0,
                                                      UIUtills()
                                                          .getProportionalWidth(
                                                              width: 20),
                                                      0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                          widget.orderCardModel
                                                              .foodStallName,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 16,
                                                                  color: Color(
                                                                      0xFF232323),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: UIUtills()
                                                      .getProportionalHeight(
                                                          height: 3),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          "${widget.orderCardModel.itemCount} items",
                                                          style: GoogleFonts.poppins(
                                                              fontSize: 11,
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  136,
                                                                  136,
                                                                  136,
                                                                  1),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                      // SvgPicture.asset(
                                                      //     'assets/images/dot.svg'),
                                                      Text(DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
                                                          //DateTime.parse(widget.orderCardModel.timeStamp)),

                                                          style: GoogleFonts.poppins(
                                                              fontSize: 11,
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  136,
                                                                  136,
                                                                  136,
                                                                  1),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                      // SvgPicture.asset(
                                                      //     'assets/images/dot.svg'),
                                                      Text('',
                                                          style: GoogleFonts.poppins(
                                                              fontSize: 11,
                                                              color: const Color
                                                                      .fromRGBO(
                                                                  136,
                                                                  136,
                                                                  136,
                                                                  1),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: UIUtills()
                                                      .getProportionalHeight(
                                                          height: 3),
                                                ),
                                                Text(
                                                  foodStatus(snapshot
                                                          .data?['status'] ??
                                                      0),
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    color: statusColor(snapshot
                                                            .data?['status'] ??
                                                        0),
                                                    fontSize: UIUtills()
                                                        .getProportionalWidth(
                                                            width: 11),
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 0.48,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: UIUtills().getProportionalHeight(height: 20),
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                            child: Divider(
                              thickness: 1,
                            )),
                        Row(
                          children: [
                            SizedBox(
                              width:
                                  UIUtills().getProportionalWidth(width: 129),
                            ),
                            Text('Details',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color:
                                        const Color.fromRGBO(116, 126, 241, 1),
                                    fontWeight: FontWeight.w500)),
                            RotationTransition(
                              turns: _animation,
                              child: const Center(
                                child: Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: Color.fromRGBO(116, 126, 241, 1),
                                  size: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    children: [
                      Column(
                        children: [
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: widget.orderCardModel
                                .menuItemInOrdersScreenList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: UIUtills()
                                        .getProportionalHeight(height: 8)),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(right: 8),
                                    //   child: SvgPicture.asset(
                                    //     'assets/images/veg.svg',
                                    //     height: 18,
                                    //     width: 18,
                                    //   ),
                                    // ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: UIUtills()
                                                  .getProportionalWidth(
                                                      width: 200),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      widget
                                                          .orderCardModel
                                                          .menuItemInOrdersScreenList[
                                                              index]
                                                          .name,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ),
                                                  Text(
                                                    '₹ ${widget.orderCardModel.menuItemInOrdersScreenList[index].price}',
                                                    style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: const Color
                                                                .fromRGBO(
                                                            100, 100, 100, 1)),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: UIUtills()
                                                      .getProportionalWidth(
                                                          width: 30)),
                                              child: Text(
                                                'Qty : ${widget.orderCardModel.menuItemInOrdersScreenList[index].quantity}',
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w500,
                                                    color: const Color.fromRGBO(
                                                        100, 100, 100, 1)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: UIUtills()
                                          .getProportionalWidth(width: 20),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Subtotal',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                Text(
                                  '₹ ${widget.orderCardModel.subtotal}',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: UIUtills().getProportionalHeight(height: 15),
              )
            ],
          );
        });
  }

  String foodStatus(int status) {
    if (status == 4) {
      return "Cancelled";
    } else if (status == 1) {
      return "Accepted";
    } else if (status == 0) {
      return "Pending";
    } else if (status == 2) {
      return "Ready";
    } else if (status == 3) {
      return "Delivered";
    }
    return "Delivered";
  }

  Color statusColor(int status) {
    if (status == 4) {
      return Color(0xffE10000);
    } else if (status == 1) {
      return Color(0xff00CE78);
    } else if (status == 0) {
      return Color(0xffE1B000);
    } else if (status == 2) {
      return Color(0xff188E05);
    } else {
      return Color(0xffCDCDCD);
    }
  }
}
