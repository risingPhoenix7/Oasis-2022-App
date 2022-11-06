import 'package:google_fonts/google_fonts.dart';
import '/screens/food_stalls/repo/model/food_stall_model.dart';
import '/utils/ui_utils.dart';
import '/widgets/error_dialogue.dart';
import '/widgets/loader.dart';
import 'package:flutter/material.dart';

import '../view_model/food_stalls_viewmodel.dart';
import 'food_stall_tile.dart';
import 'menu_screen2.dart';

class FoodStallScreen2 extends StatefulWidget {
  const FoodStallScreen2({Key? key}) : super(key: key);

  @override
  State<FoodStallScreen2> createState() => _FoodStallScreen2State();
}

class _FoodStallScreen2State extends State<FoodStallScreen2> {
  List<FoodStall> foodStall = [];
  late ValueNotifier<bool> isLoading = ValueNotifier(true);

  getList() async {
    foodStall = await FoodStallViewModel().getFoodStalls();
    if (FoodStallViewModel.error != null) {
      isLoading.value = false;
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: ErrorDialog(errorMessage: FoodStallViewModel.error!),
            );
          });
    } else {
      isLoading.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await getList();
          setState(() {});
        },
        child: ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (BuildContext context, bool value, Widget? child) {
              if (isLoading.value) {
                return const Center(child: Loader());
              } else {
                return Stack(
                  children: [
                    foodStall.isEmpty
                        ? Center(
                            child: ErrorDialog(
                            errorMessage:
                                'Check your connectivity and restart the app to view stalls',
                            isFatalError: true,
                          ))
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: UIUtills()
                                        .getProportionalHeight(height: 80),
                                    left: UIUtills()
                                        .getProportionalWidth(width: 28),
                                    right: UIUtills()
                                        .getProportionalWidth(width: 27.7)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Stalls",
                                      style: GoogleFonts.openSans(
                                          fontSize: 28, color: Colors.white),
                                    ),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.shopping_cart,
                                          color: Colors.white,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: GridView.builder(
                                  padding: EdgeInsets.fromLTRB(
                                      UIUtills()
                                          .getProportionalWidth(width: 20),
                                      UIUtills()
                                          .getProportionalHeight(height: 43),
                                      UIUtills()
                                          .getProportionalWidth(width: 20),
                                      0),
                                  itemCount: foodStall.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 0.81777,
                                          crossAxisSpacing: UIUtills()
                                              .getProportionalWidth(width: 20),
                                          mainAxisSpacing: UIUtills()
                                              .getProportionalHeight(
                                                  height: 24)),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkResponse(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MenuScreen2(
                                                      menuItemList:
                                                          foodStall[index].menu,
                                                      foodStallName:
                                                          foodStall[index].name,
                                                      image: foodStall[index]
                                                          .image_url,
                                                      foodStallId:
                                                          foodStall[index].id,
                                                    )));
                                      },
                                      child: FoodStallTile(
                                        foodStallName: foodStall[index].name,
                                        image: foodStall[index].image_url,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                  ],
                );
              }
            }),
      ),
    );
  }
}
