import '/screens/cart/viewmodel/cart_viewmodel.dart';
import '/screens/cart/widgets/cartItemWidget.dart';
import '/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../repo/model/cart_screen_model.dart';

class cartWidget extends StatefulWidget {
  cartWidget(
      {super.key,
      required this.foodStallName,
      required this.menuList,
      required this.foodStallId});

  String foodStallName;
  int foodStallId;
  List<MenuItemInCartScreen> menuList;

  @override
  State<cartWidget> createState() => _cartWidgetState();
}

class _cartWidgetState extends State<cartWidget> {
  int subTotal = 0;

  @override
  void initState() {
    subTotal = CartScreenViewModel().getSubTotal(widget.foodStallId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('cartBox').listenable(),
        builder: (context, Box box, child) {
          subTotal = CartScreenViewModel().getSubTotal(widget.foodStallId);
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(157, 141, 255, 0.15),
                      offset: Offset(0, 2),
                      blurRadius: 8.00,
                    ),
                  ],
                  color: Color.fromRGBO(255, 255, 255, 1),
                  border: Border.all(
                    width: 1.0,
                    color: Color.fromRGBO(218, 218, 218, 0.5),
                  ),
                  borderRadius: BorderRadius.circular(
                    UIUtills().getProportionalWidth(width: 10.00),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: UIUtills().getProportionalHeight(height: 28.00),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          // height: UIUtills().getProportionalHeight(height: 28.00),
                          width: UIUtills().getProportionalWidth(width: 28.00),
                        ),
                        Text(
                          widget.foodStallName,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24.00,
                            color: Color.fromRGBO(31, 31, 31, 1),
                          ),
                        ),
                        SizedBox(
                          width: UIUtills().getProportionalWidth(width: 6.00),
                          // height: UIUtills().getProportionalHeight(height: 28.00),
                        ),
                        Text(
                          '(${widget.menuList.length} items)',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize:
                                UIUtills().getProportionalWidth(width: 11.00),
                            color: Color.fromRGBO(0, 0, 0, 0.75),
                          ),
                        )
                      ],
                    ),
                    Container(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CartItemWidget(
                              menuItemId: widget.menuList[index].menuItemId,
                              foodStallName: widget.foodStallName,
                              foodStallId: widget.foodStallId,
                              menuItemName: widget.menuList[index].menuItemName,
                              isVeg: true,
                              price: widget.menuList[index].menuItemPrice,
                              quantity:
                                  widget.menuList[index].menuItemQuantity);
                        },
                        itemCount: widget.menuList.length,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: UIUtills().getProportionalHeight(height: 25.29),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width:
                                  UIUtills().getProportionalWidth(width: 36.00),
                            ),
                            Text(
                              'SubTotal',
                              style: TextStyle(
                                fontSize: UIUtills()
                                    .getProportionalWidth(width: 20.00),
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '₹ ${subTotal}',
                              style: TextStyle(
                                fontSize: UIUtills()
                                    .getProportionalWidth(width: 20.00),
                                fontWeight: FontWeight.w800,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              ),
                            ),
                            SizedBox(
                              width:
                                  UIUtills().getProportionalWidth(width: 36.00),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: UIUtills().getProportionalHeight(height: 31.00),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: UIUtills().getProportionalHeight(height: 16.00),
              ),
            ],
          );
        });
  }
}
