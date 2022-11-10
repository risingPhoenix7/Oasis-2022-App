import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis_2022/screens/food_stalls/view_model/cached_food_stalls_viewmodel.dart';
import 'package:oasis_2022/utils/error_messages.dart';

import '/screens/food_stalls/repo/model/food_stall_model.dart';
import '/utils/ui_utils.dart';
import '/widgets/error_dialogue.dart';
import '/widgets/loader.dart';
import '../view_model/food_stalls_viewmodel.dart';
import 'food_stall_tile.dart';
import 'menu_screen.dart';

class FoodStallScreen extends StatefulWidget {
  const FoodStallScreen({Key? key}) : super(key: key);

  @override
  State<FoodStallScreen> createState() => _FoodStallScreenState();
}

class _FoodStallScreenState extends State<FoodStallScreen> {
  List<FoodStall> foodStall = [];
  CachedFoodStallsViewModel cachedFoodStallEventsViewModel =
      CachedFoodStallsViewModel();
  bool isLoading = true;
  bool isStallsClosed = false;

  Future<void> updateFoodStallResult() async {
    cachedFoodStallEventsViewModel.retrieveFoodStallNetworkResult();
    checkFoodStallResult();
  }

  void checkFoodStallResult() {
    if (FoodStallViewModel.error == null) {
      if (mounted) {
        setState(() {
          foodStall = CachedFoodStallsViewModel.listFoodStalls;
          isLoading = false;
        });
      }
    } else {
      //return MiscEventResult.error;
      setState(() {
        isLoading = false;
      });
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: ErrorDialog(errorMessage: FoodStallViewModel.error!),
            );
          });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cachedFoodStallEventsViewModel.getFoodStalls();
    });
    CachedFoodStallsViewModel.status.addListener(() {
      print('klisadygfdef');
      print(CachedFoodStallsViewModel.statusInt);
      if (CachedFoodStallsViewModel.statusInt == 2) {
        isStallsClosed=false;
        print('should refresh now after reading from network call');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(milliseconds: 500),
            content: SizedBox(
                height: 25, child: Center(child: Text("Fetched latest data"))),
          ));
        }
        checkFoodStallResult();
      } else if (CachedFoodStallsViewModel.statusInt == 1) {
        isStallsClosed=false;
        print('should refresh now after reading from local db');
        setState(() {
          foodStall = CachedFoodStallsViewModel.listFoodStalls;
          isLoading = false;
          print('vghvjvhbkhb');
        });
      } else if (CachedFoodStallsViewModel.statusInt == 4) {
        print('should show empty stall');
        setState(() {
          isStallsClosed = true;
          isLoading = false;
          print('fhfhf');
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: !isLoading
          ? RefreshIndicator(
              onRefresh: updateFoodStallResult,
              child: isStallsClosed
                  ? ListView(
                      children: [
                        Center(
                          child: ErrorDialog(
                              isFatalError: true,
                              errorMessage:
                              FoodStallViewModel.error),
                        )
                      ],
                    )
                  : Stack(
                      children: [
                        Column(
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
                                        fontSize: 28,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
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
                                    UIUtills().getProportionalWidth(width: 20),
                                    UIUtills()
                                        .getProportionalHeight(height: 43),
                                    UIUtills().getProportionalWidth(width: 20),
                                    0),
                                itemCount: foodStall.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.81777,
                                        crossAxisSpacing: UIUtills()
                                            .getProportionalWidth(width: 20),
                                        mainAxisSpacing: UIUtills()
                                            .getProportionalHeight(height: 24)),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkResponse(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MenuScreen(
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
                    ),
            )
          : const Loader(),
    );
  }
}
