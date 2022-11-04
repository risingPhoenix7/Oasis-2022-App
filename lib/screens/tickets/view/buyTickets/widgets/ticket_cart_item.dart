import '/resources/resources.dart';
import '/screens/tickets/repository/model/showsData.dart';
import '/screens/tickets/view_model/tickets_post_view_model.dart';
import '/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TicketCartItem extends StatefulWidget {
  const TicketCartItem(
      {Key? key,
      required this.isCombo,
      required this.show_id,
      required this.index})
      : super(key: key);

  final bool isCombo;
  final int show_id;
  final int index;

  @override
  State<TicketCartItem> createState() => _TicketCartItemState();
}

class _TicketCartItemState extends State<TicketCartItem> {
  int quantity = 0;
  TicketData? showsData;
  CombosData? combosData;

  void getShowOrComboData() {
    if (widget.isCombo) {
      combosData = ShowsResult.allShowsData?.combos?[widget.index];

      TicketPostViewModel.ticketPostBody.combos?[widget.show_id.toString()] = 0;
    } else {
      showsData = ShowsResult.allShowsData?.shows?[widget.index];

      TicketPostViewModel
          .ticketPostBody.individual?[widget.show_id.toString()] = 0;
    }
  }

  @override
  void initState() {
    getShowOrComboData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // quantity = TicketPostViewModel
    //         .ticketPostBody.individual?[widget.index.toString()] ??
    //     0;
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: UIUtills().getProportionalHeight(height: 06.00)),
      width: UIUtills().getProportionalWidth(width: 388.00),
      height: UIUtills().getProportionalHeight(height: 80.00),
      // padding: EdgeInsets.symmetric(
      //   horizontal: UIUtills().getProportionalWidth(width: 20.00),
      // ),
      padding: EdgeInsets.only(
        left: UIUtills().getProportionalWidth(width: 16.00),
        right: UIUtills().getProportionalWidth(width: 22.00),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(
          UIUtills().getProportionalWidth(width: 12.00),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.05),
            offset: Offset(
              0,
              UIUtills().getProportionalHeight(height: 2.00),
            ),
            blurRadius: UIUtills().getProportionalWidth(width: 15.00),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                ImageAssets.ticketsIcon,
              ),
              SizedBox(
                width: UIUtills().getProportionalWidth(width: 16.23),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: UIUtills().getProportionalWidth(width: 200),
                    child: Text(
                      widget.isCombo
                          ? (combosData?.name ?? 'NA')
                          : (showsData?.name ?? 'NA'),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: Color.fromRGBO(26, 26, 26, 0.95),
                        fontWeight: FontWeight.w600,
                        fontSize: UIUtills().getProportionalWidth(width: 16.00),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: UIUtills().getProportionalHeight(height: 4.00),
                  ),
                  Text(
                    "₹ " +
                        (widget.isCombo
                            ? (combosData?.price.toString() ?? 'NA')
                            : (showsData?.price.toString() ?? 'NA')),
                    style: GoogleFonts.poppins(
                      color: Color.fromRGBO(100, 100, 100, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: UIUtills().getProportionalWidth(width: 14.00),
                    ),
                  ),
                ],
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3.00),
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
                    if (quantity > 0) {
                      setState(() {
                        quantity--;
                        if (widget.isCombo) {
                          TicketPostViewModel.ticketPostBody
                              .combos?[widget.show_id.toString()] = quantity;
                        } else {
                          TicketPostViewModel.ticketPostBody
                                  .individual?[widget.show_id.toString()] =
                              quantity;
                        }
                        TicketPostViewModel.totalAmount.value -= widget.isCombo
                            ? combosData!.price!.toInt()
                            : showsData!.price!.toInt();
                        TicketPostViewModel.totalAmount.notifyListeners();
                      });
                    }
                  },
                  child: SizedBox(
                    width: UIUtills().getProportionalWidth(width: 30),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 0),
                  // padding: EdgeInsets.symmetric(
                  //     horizontal: UIUtills().getProportionalWidth(width: 12.00),
                  //     vertical: UIUtills().getProportionalHeight(height: 3.00)),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(3),
                  //   //color: Colors.white,
                  // ),
                  child: Text(
                    quantity.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      quantity++;
                      if (widget.isCombo) {
                        TicketPostViewModel.ticketPostBody
                            .combos?[widget.show_id.toString()] = quantity;
                      } else {
                        TicketPostViewModel.ticketPostBody
                            .individual?[widget.show_id.toString()] = quantity;
                      }
                      TicketPostViewModel.totalAmount.value += widget.isCombo
                          ? combosData!.price!.toInt()
                          : showsData!.price!.toInt();
                      TicketPostViewModel.totalAmount.notifyListeners();
                    });

                    setState(() {});
                  },
                  child: SizedBox(
                    width: UIUtills().getProportionalWidth(width: 30),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
