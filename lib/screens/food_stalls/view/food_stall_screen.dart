import '/resources/resources.dart';
import '/screens/food_stalls/repo/model/food_stall_model.dart';
import '/screens/food_stalls/view/menu_screen.dart';
import '/utils/ui_utils.dart';
import '/widgets/app_bar.dart';
import '/widgets/error_dialogue.dart';
import '/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../view_model/food_stalls_viewmodel.dart';
import 'food_stall_tile.dart';
import 'menu_screen2.dart';

class FoodStallScreen extends StatefulWidget {
  const FoodStallScreen({Key? key}) : super(key: key);

  @override
  State<FoodStallScreen> createState() => _FoodStallScreenState();
}

class _FoodStallScreenState extends State<FoodStallScreen> {
  List<FoodStall> foodStall = [];
  late ValueNotifier<bool> isLoading = ValueNotifier(true);

  getList() async {
    foodStall = await FoodStallViewModel().getFoodStalls();
    if (FoodStallViewModel.error != null) {
      print('goes here');
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
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
              title: "Stalls",
              isBackButtonRequired: false,
              isactionButtonRequired: true)),
      body: ValueListenableBuilder(
          valueListenable: isLoading,
          builder: (BuildContext context, bool value, Widget? child) {
            if (isLoading.value) {
              return const Center(child: Loader());
            } else {
              return Stack(
                children: [
                  Positioned(
                      left: UIUtills().getProportionalWidth(width: 126),
                      child: SvgPicture.asset(
                          ImageAssets.background_stalls_ellipse)),
                  foodStall.length==0?Center(child: ErrorDialog(errorMessage: 'Check your connectivity and restart the app to view stalls',isFatalError: true,)) :GridView.builder(
                    padding: EdgeInsets.fromLTRB(
                        UIUtills().getProportionalWidth(width: 20),
                        UIUtills().getProportionalHeight(height: 24),
                        UIUtills().getProportionalWidth(width: 20),
                        0),
                    itemCount: foodStall.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing:
                            UIUtills().getProportionalWidth(width: 20),
                        mainAxisSpacing:
                            UIUtills().getProportionalHeight(height: 28)),
                    itemBuilder: (BuildContext context, int index) {
                      return InkResponse(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MenuScreen2(
                                        menuItemList: foodStall[index].menu,
                                        foodStallName: foodStall[index].name,
                                        image: foodStall[index].image_url,
                                        foodStallId: foodStall[index].id,
                                      )));
                        },
                        child: FoodStallTile(
                          foodStallName: foodStall[index].name,
                          image: foodStall[index].image_url,
                        ),
                      );
                    },
                  )
                ],
              );
            }
          }),
    );
  }
}
