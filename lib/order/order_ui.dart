import '../order/controller/cart_and_order_controller.dart';
import '../order/order_card.dart';
import '../order/order_screen_viewmodel.dart';
import '../order/repo/model/get_orders_model.dart';
import '../order/repo/model/order_card_model.dart';
import '../utils/ui_utils.dart';
import '../widgets/app_bar.dart';
import '../widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/error_dialogue.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<GetOrderResult> orderResultList = [];
  List<OrderCardModel> orderCardList = [];
  ValueNotifier<bool> isLoading = ValueNotifier(true);

  @override
  void initState() {
    getOrderResult();
    CartAndOrderController.newOrder.addListener(() {
      isLoading.value = true;
    });
    super.initState();
  }

  Future<bool> checkConnection() async {
    bool gotError;
    try {
      await getOrderResult();
      gotError = false;
    } catch (_) {
      gotError = true;
    }
    return gotError;
  }

  Future<void> getOrderResult() async {
    orderResultList = await OrderScreenViewModel().getOrders();
    orderCardList = OrderScreenViewModel().changeDataModel(orderResultList);
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      bool gotError = await checkConnection();
      if (gotError) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: ErrorDialog(),
              );
            });
      }
    });
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: CustomAppBar(
              title: "Orders",
              isactionButtonRequired: false,
              isBackButtonRequired: true,
            )),
        body: ValueListenableBuilder(
          valueListenable: isLoading,
          builder: (context, bool value, child) {
            getOrderResult();
            if (isLoading.value) {
              return const Center(child: Loader());
            } else {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: const Color(0XFFFAFAFF),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        10, UIUtills().getProportionalHeight(height: 20), 9, 0),
                    child: (orderCardList.isEmpty)
                        ? Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/EmptyCart.svg',
                                height: UIUtills()
                                    .getProportionalHeight(height: 212.18),
                                width: UIUtills()
                                    .getProportionalWidth(width: 255.7),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: UIUtills()
                                        .getProportionalHeight(height: 27.82)),
                                child: Text(
                                  "No Orders",
                                  style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          fontSize: UIUtills()
                                              .getProportionalWidth(width: 28),
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFFB9B8B8))),
                                ),
                              )
                            ],
                          ))
                        : CustomScrollView(
                            shrinkWrap: true,
                            slivers: <Widget>[
                              SliverPadding(
                                padding: const EdgeInsets.all(10),
                                sliver: SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                  return Order_card(
                                    orderCardModel: orderCardList[index],
                                  );
                                }, childCount: orderCardList.length)),
                              )
                            ],
                          )),
              );
            }
          },
        ));
  }
}
