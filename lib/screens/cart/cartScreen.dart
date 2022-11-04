import '/order/controller/cart_and_order_controller.dart';
import '/order/order_ui.dart';
import '/screens/cart/repo/model/cart_screen_model.dart';
import '/screens/cart/repo/model/post_order_response_model.dart';
import '/screens/cart/viewmodel/cart_viewmodel.dart';
import '/screens/cart/widgets/cartWidget.dart';
import '/screens/wallet_screen/view_model/wallet_viewmodel.dart';
import '/utils/error_messages.dart';
import '/utils/ui_utils.dart';
import '/widgets/app_bar.dart';
import '/widgets/error_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  List<FoodStallInCartScreen> foodStallist = [];
  Map<int, FoodStallInCartScreen> foodStallWithDetailsMap = {};
  List<int> foodStallIdList = [];
  int total = 0;
  List<int> subTotallist = [];
  bool isPostingOrder = false;

  @override
  void initState() {
    foodStallWithDetailsMap = CartScreenViewModel().getValuesForScreen();
    foodStallIdList = CartScreenViewModel().getIdList(foodStallWithDetailsMap);
    total = CartScreenViewModel().getTotalValue(foodStallWithDetailsMap);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
              title: "Cart",
              isactionButtonRequired: false,
              isBackButtonRequired: true)),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: Hive.box('cartBox').listenable(),
          builder: (context, Box box, child) {
            foodStallWithDetailsMap =
                CartScreenViewModel().getValuesForScreen();
            foodStallIdList =
                CartScreenViewModel().getIdList(foodStallWithDetailsMap);
            total =
                CartScreenViewModel().getTotalValue(foodStallWithDetailsMap);
            if (foodStallWithDetailsMap.isEmpty ||
                box.values.isEmpty ||
                box.keys.isEmpty ||
                box.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/EmptyCart.svg',
                      height: UIUtills().getProportionalHeight(height: 212.18),
                      width: UIUtills().getProportionalWidth(width: 255.7),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: UIUtills().getProportionalHeight(height: 27.82)),
                      child: Text(
                        "Empty Cart",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize:
                                    UIUtills().getProportionalWidth(width: 28),
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFB9B8B8))),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return SizedBox(
                height: UIUtills().getProportionalHeight(height: 926),
                child: Stack(
                  children: [
                    CustomScrollView(
                      shrinkWrap: true,
                      slivers: <Widget>[
                        SliverPadding(
                          padding: const EdgeInsets.all(20.0),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              return cartWidget(
                                foodStallId: foodStallIdList[index],
                                menuList: foodStallWithDetailsMap[
                                        foodStallIdList[index]]!
                                    .menuList,
                                foodStallName: foodStallWithDetailsMap[
                                        foodStallIdList[index]]!
                                    .foodStall,
                              );
                            }, childCount: foodStallWithDetailsMap.length),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 20.00,
                      left: 0,
                      right: 0,
                      child: isPostingOrder
                          ? const Center(
                              child: LinearProgressIndicator(
                                color: Colors.black,
                                backgroundColor: Colors.transparent,
                              ),
                            )
                          : InkWell(
                              onTap: () async {
                                if (!isPostingOrder) {
                                  setState(() {
                                    isPostingOrder = true;
                                  });
                                  if (box.isNotEmpty) {
                                    var orderdict = CartScreenViewModel()
                                        .getPostRequestBody();
                                    try {
                                      await WalletViewModel().getBalance();
                                      if (WalletViewModel.error != null) {
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              return Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: ErrorDialog(
                                                    errorMessage:
                                                        WalletViewModel.error!),
                                              );
                                            });
                                      } else {
                                        if (WalletViewModel.balance >= total) {
                                          OrderResult orderResult =
                                              await CartScreenViewModel()
                                                  .postOrder(orderdict);
                                          if (CartScreenViewModel.error ==
                                              null) {
                                            if (orderResult.id != null) {
                                              CartAndOrderController
                                                  .newOrder.value = false;
                                              CartAndOrderController.newOrder
                                                  .notifyListeners();
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return const AlertDialog(
                                                      content: Text(
                                                        'Order placed successfully!',
                                                      ),
                                                    );
                                                  });
                                              if (!mounted) {}
                                              PersistentNavBarNavigator
                                                  .pushNewScreenWithRouteSettings(
                                                context,
                                                settings: const RouteSettings(
                                                    name: 'order'),
                                                screen: OrderScreen(),
                                                withNavBar: true,
                                                pageTransitionAnimation:
                                                    PageTransitionAnimation
                                                        .cupertino,
                                              );
                                              box.clear();
                                            } else {
                                              isPostingOrder = false;
                                              setState(() {});
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: ErrorDialog(
                                                          errorMessage:
                                                              'Order Invalid'),
                                                    );
                                                  });
                                            }
                                          } else {
                                            isPostingOrder = false;
                                            setState(() {});
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: ErrorDialog(
                                                        errorMessage:
                                                            CartScreenViewModel
                                                                .error!),
                                                  );
                                                });
                                          }
                                        } else {
                                          isPostingOrder = false;
                                          setState(() {});

                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: ErrorDialog(
                                                      errorMessage: ErrorMessages
                                                          .insufficientFunds),
                                                );
                                              });
                                        }
                                      }
                                    } catch (e) {
                                      print('goes into this');
                                      isPostingOrder = false;
                                      setState(() {});
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return Align(
                                              alignment: Alignment.bottomCenter,
                                              child: ErrorDialog(
                                                  errorMessage:
                                                      WalletViewModel.error ??
                                                          ErrorMessages
                                                              .unknownError),
                                            );
                                          });
                                    }
                                  } else {
                                    isPostingOrder = false;
                                    setState(() {});
                                    return showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return Align(
                                            alignment: Alignment.bottomCenter,
                                            child: ErrorDialog(
                                                errorMessage: 'Cart empty'),
                                          );
                                        });
                                  }
                                }
                              },
                              child: Container(
                                // alignment: Alignment.bottomCenter,
                                width:
                                    UIUtills().getProportionalWidth(width: 428),
                                height: UIUtills()
                                    .getProportionalHeight(height: 72.00),
                                margin: EdgeInsets.symmetric(
                                    horizontal: UIUtills()
                                        .getProportionalWidth(width: 20.00)),
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
                                    UIUtills()
                                        .getProportionalWidth(width: 15.00),
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
                                      Row(
                                        children: [
                                          Text(
                                            '₹ $total',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              fontSize: UIUtills()
                                                  .getProportionalWidth(
                                                      width: 19.00),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
