import '/screens/cart/cartScreen.dart';
import '/screens/food_stalls/repo/model/food_stall_model.dart'
    as menu;
import '/screens/food_stalls/view/food_stall_screen.dart';
import '/utils/ui_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../view_model/menu_screen_viewmodel.dart';
import 'menu_add_buttons.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen(
      {Key? key,
      required this.menuItemList,
      required this.foodStallName,
      required this.image,
      required this.foodStallId})
      : super(key: key);
  List<menu.MenuItem> menuItemList;
  String foodStallName;
  String image;
  int foodStallId;

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<menu.MenuItem> menuItemsFiltered = [];
  List<menu.MenuItem> menuItemsOriginal = [];
  bool isNotEmpty = true;
  final _formKey = GlobalKey<FormState>();
  Map<int, int> menuItemsAmount = {};
  TextEditingController searchController = TextEditingController();

  createSearchFilteredList(String query) {
    menuItemsFiltered =
        MenuScreenViewModel().searchList(query ?? "", widget.menuItemList);
  }

  makeMenuList() {
    menuItemsOriginal = widget.menuItemList;
    menuItemsFiltered = widget.menuItemList;
    menuItemsAmount =
        MenuScreenViewModel().populateListFromHive(menuItemsFiltered);
  }

  //TODO: add a foodstall banner image in backend
  @override
  void initState() {
    makeMenuList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
                Image.network(
                  widget.image,
                  height: UIUtills().getProportionalHeight(height: 202),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: UIUtills().getProportionalHeight(height: 19)),
                  child: Container(
                    height: UIUtills().getProportionalHeight(height: 183),
                    color: const Color.fromRGBO(7, 0, 104, 0.2),
                  ),
                ),
                Container(
                  height: UIUtills().getProportionalHeight(height: 202),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[
                    Color.fromRGBO(0, 0, 0, 0),
                    Color.fromRGBO(0, 0, 0, 0.5),
                    Color.fromRGBO(0, 0, 0, 0.8)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: UIUtills().getProportionalWidth(width: 20),
                      top: UIUtills().getProportionalHeight(height: 126.5)),
                  child: Text(
                    widget.foodStallName,
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: UIUtills().getProportionalWidth(width: 20),
                      top: UIUtills().getProportionalHeight(height: 169.5)),
                  child: Text(
                    "M-Lawns near FD 2",
                    style: GoogleFonts.roboto(
                        textStyle:
                            const TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FoodStallScreen()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: UIUtills().getProportionalWidth(width: 20),
                        top: UIUtills().getProportionalHeight(height: 40)),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: UIUtills().getProportionalHeight(height: 16),
                  left: UIUtills().getProportionalWidth(width: 20),
                  right: UIUtills().getProportionalWidth(width: 20)),
              child: Container(
                height: UIUtills().getProportionalHeight(height: 47),
                width: UIUtills().getProportionalWidth(width: 388),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0, 2.36364),
                          blurRadius: 4.72727)
                    ],
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                        colors: <Color>[
                          Color.fromRGBO(31, 31, 31, 1),
                          Color.fromRGBO(51, 51, 51, 1)
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight)),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            UIUtills().getProportionalWidth(width: 17.22),
                            0,
                            UIUtills().getProportionalWidth(width: 16.41),
                            0),
                        child: const Center(
                            child: Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                      ),
                      Expanded(
                        child: Center(
                          child: Form(
                            key: _formKey,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  createSearchFilteredList(value);
                                });
                              },
                              controller: searchController,
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: UIUtills()
                                      .getProportionalWidth(width: 14)),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelStyle:
                                    GoogleFonts.poppins(color: Colors.white),
                                hintText: "Find amazing food",
                                hintStyle:
                                    GoogleFonts.poppins(color: Colors.white),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      searchController.clear();
                                      setState(() {
                                        createSearchFilteredList("");
                                      });
                                    },
                                    icon: const Icon(Icons.close,
                                        color: Colors.grey, size: 15)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ValueListenableBuilder(
                  valueListenable: Hive.box('cartBox').listenable(),
                  builder: (context, Box box, child) {
                    menuItemsAmount = MenuScreenViewModel()
                        .populateListFromHive(menuItemsFiltered);
                    return ListView.builder(
                      padding: const EdgeInsets.all(0),
                      scrollDirection: Axis.vertical,
                      itemCount: menuItemsFiltered.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                              UIUtills().getProportionalWidth(width: 20),
                              0,
                              UIUtills().getProportionalWidth(width: 20),
                              UIUtills().getProportionalHeight(height: 8)),
                          child: Container(
                            height: 80,
                            width: UIUtills().getProportionalWidth(width: 388),
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromRGBO(157, 141, 255, 0.1),
                                      offset: Offset(0, 2),
                                      blurRadius: 8)
                                ],
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      21, 0, 15.48, 0),
                                  child: Center(
                                      child: SvgPicture.asset(
                                    "assets/images/veg.svg",
                                    color: widget.menuItemList[index].is_veg
                                        ? Colors.green
                                        : Colors.red,
                                  )),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        menuItemsFiltered[index].name,
                                        style: GoogleFonts.poppins(
                                            fontSize: UIUtills()
                                                .getProportionalHeight(
                                                    height: 16),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "₹${menuItemsFiltered[index].price}",
                                        style: GoogleFonts.poppins(
                                            fontSize: UIUtills()
                                                .getProportionalHeight(
                                                    height: 14),
                                            fontWeight: FontWeight.w600,
                                            color: const Color.fromRGBO(
                                                100, 100, 100, 1)),
                                      )
                                    ],
                                  ),
                                ),
                                AddButton(
                                  menuItemName: menuItemsFiltered[index].name,
                                  amount: menuItemsAmount[
                                      menuItemsFiltered[index].id]!,
                                  foodStallId: widget.foodStallId,
                                  price: menuItemsFiltered[index].price,
                                  menuItemId: menuItemsFiltered[index].id,
                                  foodStallName: widget.foodStallName,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        ValueListenableBuilder(
          valueListenable: Hive.box("cartBox").listenable(),
          builder: (context, Box box, child) {
            int total = MenuScreenViewModel().getTotalValue();
            // isNotEmpty = MenuScreenViewModel().checkIfListNotEmpty(menuItems);
            isNotEmpty = (total == 0) ? false : true;
            if (isNotEmpty) {
              return Positioned(
                bottom: 20.00,
                left: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartScreen()));
                  },
                  child: Container(
                    // alignment: Alignment.bottomCenter,
                    width: MediaQuery.of(context).size.width,
                    height: UIUtills().getProportionalHeight(height: 72.00),
                    margin: EdgeInsets.symmetric(
                      horizontal: UIUtills().getProportionalWidth(width: 20.00),
                      vertical: UIUtills().getProportionalHeight(height: 20),
                    ),
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
                          horizontal:
                              UIUtills().getProportionalWidth(width: 40.00)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'View Cart',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0, top: 3),
                                child: Icon(
                                  Icons.shopping_cart,
                                  size: 20,
                                  color: Color.fromRGBO(255, 255, 255, 1),
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
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: UIUtills()
                                      .getProportionalWidth(width: 19.00),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            if (!isNotEmpty) {
              return Container();
            } else {
              return Container();
            }
          },
        )
      ]),
    );
  }
}
