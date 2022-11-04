import '/screens/tickets/repository/model/showsData.dart';
import '/screens/tickets/view/buyTickets/widgets/ticket_cart_item.dart';
import '/screens/tickets/view/controller/tickets_controller.dart';
import '/screens/tickets/view_model/tickets_post_view_model.dart';
import '/utils/ui_utils.dart';
import '/widgets/error_dialogue.dart';
import 'package:flutter/material.dart';

class BuyTicketsBody extends StatefulWidget {
  const BuyTicketsBody({super.key});

  @override
  State<BuyTicketsBody> createState() => _BuyTicketsBodyState();
}

class _BuyTicketsBodyState extends State<BuyTicketsBody> {
  ValueNotifier<bool> isPostingOrder = ValueNotifier(false);

  @override
  void initState() {
    TicketPostViewModel.totalAmount.value = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            CustomScrollView(
              shrinkWrap: true,
              slivers: <Widget>[
                SliverPadding(
                  padding: EdgeInsets.only(
                      top: UIUtills().getProportionalHeight(height: 14.00)),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      print(index);
                      print(ShowsResult.allShowsData?.shows?.length);
                      print(ShowsResult.allShowsData?.combos?.length);
                      return TicketCartItem(
                        show_id: ShowsResult.allShowsData!.shows![index].id!,
                        index: index,
                        isCombo: false,
                      );
                    },
                        childCount:
                            ShowsResult.allShowsData?.shows?.length ?? 0),
                  ),
                ),
                // SliverList(
                //   delegate: SliverChildBuilderDelegate(
                //       (BuildContext context, int index) {
                //     print('combos');
                //     return TicketCartItem(
                //         index: index,
                //         show_id: ShowsResult.allShowsData!.combos![index].id!,
                //         isCombo: true);
                //   }, childCount: ShowsResult.allShowsData?.combos?.length ?? 0),
                // ),
              ],
            ),
            // Padding(
            //   padding:  EdgeInsets.only(top: UIUtills().getProportionalHeight(height: 14.00)),
            //   child: ListView(
            //     scrollDirection: Axis.vertical,
            //     shrinkWrap: true,
            //     children: [
            //       TicketCartItem(quantity: 5),
            //       TicketCartItem(quantity: 5),
            //       TicketCartItem(quantity: 5),
            //       TicketCartItem(quantity: 5),
            //       TicketCartItem(quantity: 5),
            //     ],
            //   ),
            // ),
            ValueListenableBuilder(
                valueListenable: isPostingOrder,
                builder: (context, value, child) {
                  return Positioned(
                    bottom: 20.00,
                    left: 0,
                    right: 0,
                    child: isPostingOrder.value
                        ? const Center(
                            child: LinearProgressIndicator(
                              color: Colors.black,
                              backgroundColor: Colors.transparent,
                            ),
                          )
                        : InkWell(
                            onTap: () async {
                              if (!isPostingOrder.value) {
                                isPostingOrder.value = true;

                                if (TicketPostViewModel.totalAmount.value !=
                                    0) {
                                  print('here at tickets post');
                                  await TicketPostViewModel().postOrders();
                                  print(TicketPostViewModel.error);
                                  // if (orderResult.id != null) {
                                  //   CartAndOrderController.newOrder.value =
                                  //   false;
                                  //   CartAndOrderController.newOrder
                                  //       .notifyListeners();
                                  if (TicketPostViewModel.error == null) {
                                    isPostingOrder.value = false;
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Align(
                                            alignment: Alignment.bottomCenter,
                                            child: ErrorDialog(
                                              isSuccesspopup: true,
                                              errorMessage:
                                                  'Tickets bought successfully',
                                            ),
                                          );
                                        });

                                    Navigator.of(context).pop();
                                    TicketsController.refreshTicketsPageBool
                                        .notifyListeners();
                                  } else {
                                    isPostingOrder.value = false;
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return Align(
                                            alignment: Alignment.bottomCenter,
                                            child: ErrorDialog(
                                                errorMessage:
                                                    TicketPostViewModel.error!),
                                          );
                                        });
                                  }
                                  //   box.clear();
                                  // } else {
                                  //   showDialog(
                                  //       context: context,
                                  //       builder: (BuildContext context) {
                                  //         return const AlertDialog(
                                  //           content: Text(
                                  //             'Order invalid',
                                  //           ),
                                  //         );
                                  //       });
                                  // }
                                } else {
                                  isPostingOrder.value = false;
                                  return showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return Align(
                                            alignment: Alignment.bottomCenter,
                                            child: ErrorDialog(
                                                errorMessage:
                                                    'No ticket Selected'));
                                      });
                                  ;
                                }
                              }
                            },
                            child: Container(
                              // alignment: Alignment.bottomCenter,
                              width:
                                  UIUtills().getProportionalWidth(width: 428),
                              height: UIUtills()
                                  .getProportionalHeight(height: 72.00),
                              // margin: EdgeInsets.symmetric(
                              //     horizontal:
                              //         UIUtills().getProportionalWidth(width: 20.00)),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromRGBO(45, 45, 45, 1),
                                    Color.fromRGBO(0, 0, 0, 1)
                                  ],
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                    blurRadius: 4.38,
                                    offset: Offset(0, 4.38),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(
                                  UIUtills().getProportionalWidth(width: 15.00),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: UIUtills()
                                        .getProportionalWidth(width: 40.00)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Pay Now',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 1),
                                            fontSize: UIUtills()
                                                .getProportionalWidth(
                                                    width: 20.00),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 8.0, top: 3),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 20,
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable:
                                          TicketPostViewModel.totalAmount,
                                      builder: (context, amount, child) {
                                        return Text(
                                          '₹ $amount',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 1),
                                            fontSize: UIUtills()
                                                .getProportionalWidth(
                                                    width: 19.00),
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                  );
                }),
            // Positioned(
            //   bottom: 10.00,
            //   left: 0,
            //   right: 0,
            //   child: InkWell(
            //     onTap: () {},
            //     child: Container(
            //       // alignment: Alignment.bottomCenter,
            //       width: UIUtills().getProportionalWidth(width: 428),
            //       height: UIUtills().getProportionalHeight(height: 72.00),
            //       // margin: EdgeInsets.symmetric(
            //       //     horizontal:
            //       //         UIUtills().getProportionalWidth(width: 20.00)),
            //       decoration: BoxDecoration(
            //         gradient: const LinearGradient(
            //           colors: [
            //             Color.fromRGBO(45, 45, 45, 1),
            //             Color.fromRGBO(0, 0, 0, 1)
            //           ],
            //         ),
            //         boxShadow: const [
            //           BoxShadow(
            //             color: Color.fromRGBO(0, 0, 0, 0.25),
            //             blurRadius: 4.38,
            //             offset: Offset(0, 4.38),
            //           ),
            //         ],
            //         borderRadius: BorderRadius.circular(
            //           UIUtills().getProportionalWidth(width: 15.00),
            //         ),
            //       ),
            //       child: Padding(
            //         padding: EdgeInsets.symmetric(
            //             horizontal:
            //                 UIUtills().getProportionalWidth(width: 40.00)),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Row(
            //               children: [
            //                 Text(
            //                   'Pay Now',
            //                   style: TextStyle(
            //                     fontWeight: FontWeight.w800,
            //                     color: const Color.fromRGBO(255, 255, 255, 1),
            //                     fontSize: UIUtills()
            //                         .getProportionalWidth(width: 20.00),
            //                   ),
            //                 ),
            //                 const Padding(
            //                   padding: EdgeInsets.only(left: 8.0, top: 3),
            //                   child: Icon(
            //                     Icons.arrow_forward_ios,
            //                     size: 20,
            //                     color: Color.fromRGBO(255, 255, 255, 1),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             Row(
            //               children: [
            //                 Text(
            //                   '₹ 2400',
            //                   style: TextStyle(
            //                     fontWeight: FontWeight.w700,
            //                     color: const Color.fromRGBO(255, 255, 255, 1),
            //                     fontSize: UIUtills()
            //                         .getProportionalWidth(width: 19.00),
            //                   ),
            //                 ),
            //               ],
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
