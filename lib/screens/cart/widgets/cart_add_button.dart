import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../utils/ui_utils.dart';
import '../../food_stalls/repo/model/hive_model/hive_menu_entry.dart';

class CartAddButton extends StatefulWidget {
  CartAddButton(
      {Key? key,
      required this.foodStallName,
      required this.foodStallId,
      required this.menuItemId,
      required this.price,
      required this.menuItemName,
      required this.amount})
      : super(key: key);
  int amount;
  String menuItemName;
  int price;
  String foodStallName;
  int foodStallId;
  int menuItemId;

  @override
  State<CartAddButton> createState() => _CartAddButtonState();
}

class _CartAddButtonState extends State<CartAddButton> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 9.69, vertical: 3.00),
        width: UIUtills().getProportionalWidth(width: 95.00),
        height: UIUtills().getProportionalHeight(height: 30.00),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, 2.36),
              blurRadius: 4.73,
            )
          ],
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(22, 22, 22, 1),
              Color.fromRGBO(45, 45, 45, 1)
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  var box = Hive.box('cartBox');
                  if (widget.amount > 0) {
                    widget.amount--;
                    if (widget.amount == 0) {
                      box.delete(widget.menuItemId);
                    } else {
                      box.put(
                          widget.menuItemId,
                          HiveMenuEntry(
                              menuItemName: widget.menuItemName,
                              price: widget.price,
                              FoodStall: widget.foodStallName,
                              quantity: widget.amount,
                              FoodStallId: widget.foodStallId));
                    }
                  }
                });
              },
              child: const Icon(
                Icons.remove,
                color: Colors.white,
                size: 16,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.00, vertical: 3),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(3),
              //   //color: Colors.white,
              // ),
              child: Text(
                '${widget.amount}',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            InkWell(
              onTap: () {
                var box = Hive.box('cartBox');
                widget.amount++;
                setState(() {
                  box.put(
                      widget.menuItemId,
                      HiveMenuEntry(
                          menuItemName: widget.menuItemName,
                          price: widget.price,
                          FoodStall: widget.foodStallName,
                          quantity: widget.amount,
                          FoodStallId: widget.foodStallId));
                });
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        width: UIUtills().getProportionalWidth(width: 30.00),
      ),
    ]);
  }
}
