import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import '../../../utils/ui_utils.dart';
import '../repo/model/hive_model/hive_menu_entry.dart';

class AddButton extends StatefulWidget {
  AddButton(
      {Key? key,
      required this.menuItemName,
      required this.amount,
      required this.foodStallId,
      required this.price,
      required this.menuItemId,
      required this.foodStallName})
      : super(key: key);
  int amount;
  String menuItemName;
  int price;
  String foodStallName;
  int foodStallId;
  int menuItemId;

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: (widget.amount == 0)
          ? Padding(
              padding: EdgeInsets.only(
                  left: UIUtills().getProportionalWidth(width: 27.7),
                  right: UIUtills().getProportionalWidth(width: 22)),
              child: InkWell(
                onTap: () {
                  setState(() {
                    widget.amount++;
                    var box = Hive.box('cartBox');
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
                splashColor: Colors.transparent,
                child: Container(
                  height: UIUtills().getProportionalHeight(height: 30),
                  width: UIUtills().getProportionalWidth(width: 90),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Text(
                    "Add+",
                    style: GoogleFonts.poppins(
                        fontSize: UIUtills().getProportionalHeight(height: 16),
                        fontWeight: FontWeight.w500),
                  )),
                ),
              ),
            )
          : Padding(
              padding: EdgeInsets.only(
                  left: UIUtills().getProportionalWidth(width: 27.7),
                  right: UIUtills().getProportionalWidth(width: 22)),
              child: Container(
                height: UIUtills().getProportionalHeight(height: 30),
                width: UIUtills().getProportionalWidth(width: 90),
                //padding: const EdgeInsets.symmetric(horizontal: 9.69),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0, 2.36364),
                          blurRadius: 4.72727)
                    ],
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(colors: <Color>[
                      Color.fromRGBO(22, 22, 22, 1),
                      Color.fromRGBO(45, 45, 45, 1)
                    ])),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                UIUtills().getProportionalWidth(width: 8)),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          var box = Hive.box('cartBox');
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
                        });
                      },
                    ),
                    Text(
                      "${widget.amount}",
                      style:
                          GoogleFonts.roboto(color: Colors.white, fontSize: 16),
                    ),
                    InkWell(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                UIUtills().getProportionalWidth(width: 8)),
                        child: Text(
                          "+",
                          style: GoogleFonts.roboto(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          widget.amount++;
                          var box = Hive.box('cartBox');
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
                    ),
                  ],
                ),
              )),
    );
  }
}
