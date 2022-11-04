import '/screens/cart/widgets/cart_add_button.dart';
import '/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class CartItemWidget extends StatefulWidget {
  CartItemWidget(
      {required this.menuItemName,
      required this.isVeg,
      required this.menuItemId,
      required this.foodStallName,
      required this.foodStallId,
      required this.price,
      required this.quantity,
      super.key});

  String menuItemName;
  String foodStallName;
  bool isVeg;
  int foodStallId;
  int price;
  int menuItemId;
  int quantity;

  @override
  State<CartItemWidget> createState() => CartItemWidgetState();
}

class CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('cartBox').listenable(),
        builder: (context, Box box, child) {
          return Column(
            children: [
              SizedBox(
                height: UIUtills().getProportionalHeight(height: 23.29),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: UIUtills().getProportionalWidth(width: 28.33),
                      ),
                      widget.isVeg
                          ? SvgPicture.asset(
                              'assets/images/veg.svg',
                              // width: 13.67,
                              // height: 13.3,
                            )
                          : SvgPicture.asset(
                              'assets/images/Non-Veg.svg',
                              // width: 13.67,
                              // height: 13.3,
                            ),
                      SizedBox(
                        width: UIUtills().getProportionalWidth(width: 20.00),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.menuItemName}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.00,
                              color: Color.fromRGBO(26, 26, 26, 0.9),
                            ),
                          ),
                          SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 3.86),
                          ),
                          Text(
                            '₹ ${widget.price}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  UIUtills().getProportionalWidth(width: 14.00),
                              color: Color.fromRGBO(83, 83, 83, 1),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   width: UIUtills().getProportionalWidth(width: 108.00),
                  // ),
                  CartAddButton(
                    foodStallId: widget.foodStallId,
                    foodStallName: widget.foodStallName,
                    menuItemId: widget.menuItemId,
                    menuItemName: widget.menuItemName,
                    price: widget.price,
                    amount: widget.quantity,
                  )
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: UIUtills().getProportionalHeight(height: 17.86),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 36.00),
                child: Divider(
                  height: 0,
                  thickness: UIUtills().getProportionalHeight(height: 1.00),
                  color: Color.fromRGBO(218, 218, 218, 1),
                ),
              ),
            ],
          );
        });
  }
}
