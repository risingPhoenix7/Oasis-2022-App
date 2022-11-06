import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';

import '/screens/cart/cartScreen.dart';
import '/screens/food_stalls/repo/model/food_stall_model.dart' as menu;
import '/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import '../view_model/menu_screen_viewmodel.dart';
import 'food_stall_screen.dart';
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
  FocusNode searchFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  Map<int, int> menuItemsAmount = {};
  TextEditingController searchController = TextEditingController();

  createSearchFilteredList(String? query) {
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
      body: Stack(children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: UIUtills().getProportionalHeight(height: 50),
                  left: UIUtills().getProportionalWidth(width: 20),
                  right: UIUtills().getProportionalWidth(width: 20)),
              child: Center(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: 'https://picsum.photos/388/259',
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaY: 25, sigmaX: 25),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20)),
                                ),
                                width:
                                    UIUtills().getProportionalWidth(width: 388),
                                height: UIUtills()
                                    .getProportionalHeight(height: 97),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: UIUtills()
                                    .getProportionalHeight(height: 16),
                                left:
                                    UIUtills().getProportionalWidth(width: 20)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: widget.foodStallName,
                                      style: GoogleFonts.openSans(
                                          fontSize: 28,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600)),
                                  TextSpan(
                                    text:
                                        "\nChoose from ${widget.menuItemList.length} different dishes",
                                    style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  )
                                ])),
                              ],
                            ),
                          )
                        ],
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
                            top: UIUtills().getProportionalHeight(height: 20)),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(44, 47, 53, 1),
                              borderRadius: BorderRadius.circular(5)),
                          height: UIUtills().getProportionalHeight(height: 36),
                          width: UIUtills().getProportionalWidth(width: 36),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: UIUtills().getProportionalHeight(height: 24),
                  left: UIUtills().getProportionalWidth(width: 20),
                  right: UIUtills().getProportionalWidth(width: 20)),
              child: Container(
                height: UIUtills().getProportionalHeight(height: 47),
                width: UIUtills().getProportionalWidth(width: 388),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromRGBO(248, 216, 72, 0.45)),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0, 2.36364),
                          blurRadius: 4.72727)
                    ],
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                        colors: <Color>[
                          Color.fromRGBO(164, 108, 0, 0.15),
                          Color.fromRGBO(209, 154, 8, 0.15)
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
                                    GoogleFonts.openSans(color: Colors.white),
                                hintText: "Search",
                                hintStyle: GoogleFonts.openSans(
                                    color: Colors.white, fontSize: 16),
                                suffixIcon: IconButton(
                                    splashColor: Colors.transparent,
                                    onPressed: () {
                                      searchController.clear();
                                      setState(() {
                                        createSearchFilteredList("");
                                        searchFocusNode.unfocus();
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
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
              child: ValueListenableBuilder(
                valueListenable: Hive.box('cartBox').listenable(),
                builder: (context, Box box, child) {
                  menuItemsAmount = MenuScreenViewModel()
                      .populateListFromHive(menuItemsFiltered);
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: menuItemsFiltered.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom:
                                UIUtills().getProportionalHeight(height: 8)),
                        child: Column(
                          children: [
                            (index != 0)
                                ? Divider(
                                    color: const Color.fromRGBO(
                                        255, 255, 255, 1),
                                    indent: UIUtills()
                                        .getProportionalWidth(width: 47),
                                    endIndent: UIUtills()
                                        .getProportionalWidth(width: 47),
                                  )
                                : Container(),
                            Container(
                              height: 80,
                              decoration: const BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(157, 141, 255, 0.1),
                                    offset: Offset(0, 2),
                                    blurRadius: 8)
                              ], color: Colors.black),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              37, 0, 20.1, 0),
                                          child: Center(
                                              child: SvgPicture.asset(
                                            "assets/images/Non-Veg.svg",
                                            color: widget.menuItemList[index]
                                                    .is_veg
                                                ? Colors.green
                                                : Colors.red,
                                          )),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                menuItemsFiltered[index].name,
                                                style: GoogleFonts.openSans(
                                                    color: Colors.white,
                                                    fontSize: UIUtills()
                                                        .getProportionalHeight(
                                                            height: 18),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                "₹${menuItemsFiltered[index].price}",
                                                style: GoogleFonts.openSans(
                                                    fontSize: UIUtills()
                                                        .getProportionalHeight(
                                                            height: 16),
                                                    fontWeight:
                                                        FontWeight.w600,
                                                    color:
                                                        const Color.fromRGBO(
                                                            100,
                                                            100,
                                                            100,
                                                            1)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: UIUtills()
                                            .getProportionalWidth(width: 37)),
                                    child: AddButton(
                                      menuItemName:
                                          menuItemsFiltered[index].name,
                                      amount: menuItemsAmount[
                                          menuItemsFiltered[index].id]!,
                                      foodStallId: widget.foodStallId,
                                      price: menuItemsFiltered[index].price,
                                      menuItemId: menuItemsFiltered[index].id,
                                      foodStallName: widget.foodStallName,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        ValueListenableBuilder(
          valueListenable: Hive.box("cartBox").listenable(),
          builder: (context, Box box, child) {
            int total = MenuScreenViewModel().getTotalValue();
            if (total != 0) {
              return Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartScreen()));
                  },
                  child: Container(
                    // alignment: Alignment.bottomCenter,
                    width: MediaQuery.of(context).size.width,
                    height: UIUtills().getProportionalHeight(height: 56.00),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Color.fromRGBO(209, 154, 8, 1),
                        Color.fromRGBO(254, 212, 102, 1),
                        Color.fromRGBO(227, 186, 79, 1),
                        Color.fromRGBO(209, 154, 8, 1),
                        Color.fromRGBO(209, 154, 8, 1),
                      ]),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          blurRadius: 4.38,
                          offset: Offset(0, 4.38),
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(UIUtills().getProportionalWidth(width: 15.00)),
                        topRight: Radius.circular(UIUtills().getProportionalWidth(width: 15))
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
                                  color: Colors.black,
                                  fontSize: UIUtills()
                                      .getProportionalWidth(width: 20.00),
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
                                  color: Colors.black,
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
