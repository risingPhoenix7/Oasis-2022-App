import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis_2022/screens/tickets/controller/store_controller.dart';
import 'package:oasis_2022/screens/tickets/repository/model/showsData.dart';
import 'package:oasis_2022/screens/tickets/view/bottom_carousel.dart';
import 'package:oasis_2022/screens/tickets/view/merch.dart';
import 'package:oasis_2022/screens/tickets/view/prof_show.dart';
import 'package:oasis_2022/utils/scroll_remover.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen>
    with TickerProviderStateMixin {
  ValueNotifier<bool> isLoading = ValueNotifier(true);
  bool fadeAnimationGoingDark = true;

  late final AnimationController fadeController = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  );
  late final Animation<double> _fadeAnimation =
      Tween<double>(begin: 1.0, end: 0.0).animate(fadeController);

  Future<void> controllerInitialize() async {
    await StoreController().initialCall();
    isLoading.value = false;
  }

  @override
  void initState() {
    controllerInitialize();
    StoreController.itemNumber.addListener(() {
      if (!mounted) {}
      setState(() {});
    });
    StoreController.itemBoughtOrRefreshed.addListener(() {
      if (!mounted) {}
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: Colors.amber,
        backgroundColor: Colors.black,
        onRefresh: () async {
          isLoading.value = true;
          await StoreController().initialCall();
          StoreController.itemBoughtOrRefreshed.value =
              !StoreController.itemBoughtOrRefreshed.value;
          for (int i = 0; i < StoreController.carouselItems.length; i++) {
            if (StoreController.carouselItems[i].runtimeType == StoreItemData) {
              print((StoreController.carouselItems[i] as StoreItemData).name);
            }
          }
          print("********************");
          print(StoreController.carouselImage2);
          isLoading.value = false;
        },
        child: ValueListenableBuilder(
          valueListenable: isLoading,
          builder: (BuildContext context, bool value, Widget? child) {
            if (value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ScrollConfiguration(
                behavior: CustomScrollBehavior(),
                child: ListView(children: [
                  StoreController.carouselItems.isEmpty
                      ? Center(
                          child: Text(
                            "Store is empty right now",
                            style: GoogleFonts.openSans(
                                color: Colors.white, fontSize: 25.sp),
                          ),
                        )
                      : SizedBox(
                          height: 1.sh,
                          child: Stack(children: [
                            FadeTransition(
                              opacity: _fadeAnimation,
                              child: (StoreController
                                          .carouselItems[
                                              StoreController.itemNumber.value]
                                          .runtimeType ==
                                      MerchCarouselItem)
                                  ? const Merch()
                                  : const ProfShow(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 600.h,
                              ),
                              child: const BottomCarousel(),
                            )
                          ]),
                        ),
                ]),
              );
            }
          },
        ),
      ),
    );
  }
}
