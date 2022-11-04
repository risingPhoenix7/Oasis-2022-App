import '/appDrawer/appDrawer.dart';
import '/resources/resources.dart';
import '/screens/matches/repository/model/matchesResult.dart';
import '/screens/matches/view/miscellaneous_tab.dart';
import '/screens/matches/view/search_screen/searchScreen.dart';
import '/screens/matches/view_model/matches_view_model.dart';
import '/utils/bosm_text_styles.dart';
import '/utils/colors.dart';
import '/utils/scroll_remover.dart';
import '/utils/ui_utils.dart';
import '/widgets/error_dialogue.dart';
import '/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'sports_tab.dart';
import 'upcoming_events_tab.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({Key? key}) : super(key: key);

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  MatchesViewModel matchesViewModel = MatchesViewModel();
  bool isLoading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();
  Map<int, bool> isFilled = {};

  Future<void> updateEventsList() async {
    print('called here');
    await matchesViewModel.updateMatchesResult();
    if (MatchesResult.error != null) {
      print('goes here');
      setState(() {
        isLoading = false;
      });
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: ErrorDialog(errorMessage: MatchesResult.error!),
            );
          });
    } else {
      setState(() {
        updateHive();
        isLoading = false;
      });
    }
  }

  updateHive() {
    var notifBox = Hive.box('subscribeBox');
    print(notifBox.isEmpty);
    for (int i in notifBox.keys) {
      var tempValue = notifBox.get(i);
      isFilled[i] = tempValue;
    }
  }

  // Future<List<RoundData>?> populateSportsRoundData(int sport_index) async {
  //   await updateEventsList();
  //   return matchesViewModel.retrieveSportData( sport_index);
  // }

  @override
  void initState() {
    updateEventsList();
    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        focusNode.unfocus();
      }
      setState(() {
        print('changed');
        print(searchController.text);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        drawer: const AppDrawerMenu(),
        backgroundColor: BosmColors.backgroundColorWhite,
        resizeToAvoidBottomInset: false,
        body: Builder(builder: (BuildContext context) {
          return !isLoading
              ? RefreshIndicator(
                  onRefresh: updateEventsList,
                  child: SizedBox(
                    height: screenHeight,
                    child: ScrollConfiguration(
                      behavior: CustomScrollBehavior(),
                      child: ListView(
                        children: <Widget>[
                          Stack(
                            clipBehavior: Clip.hardEdge,
                            children: [
                              Positioned(
                                left:
                                    UIUtills().getProportionalWidth(width: 170),
                                bottom: UIUtills()
                                    .getProportionalHeight(height: 750),
                                child: SizedBox(
                                  height: screenHeight,
                                  width: screenWidth,
                                  child: Container(
                                    width: UIUtills()
                                        .getProportionalWidth(width: 480),
                                    height: UIUtills()
                                        .getProportionalHeight(height: 480),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromRGBO(202, 208, 229, 0.2),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: UIUtills()
                                                .getProportionalHeight(
                                                    height: 26),
                                            bottom: UIUtills()
                                                .getProportionalHeight(
                                                    height: 20),
                                            left: UIUtills()
                                                .getProportionalWidth(
                                                    width: 8)),
                                        child: IconButton(
                                          icon: SvgPicture.asset(
                                            ImageAssets.hamburgerIcon,
                                            width: UIUtills()
                                                .getProportionalWidth(
                                                    width: 22),
                                            height: UIUtills()
                                                .getProportionalHeight(
                                                    height: 14.19),
                                          ),
                                          onPressed: () {
                                            Scaffold.of(context).openDrawer();
                                            _scaffoldKey.currentState
                                                ?.openDrawer();
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 18.0,
                                            left: UIUtills()
                                                .getProportionalWidth(
                                                    width: 20)),
                                        child: Text('DISCOVER EVENTS',
                                            style:
                                                BosmTextStyles.robotoExtraBold),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: UIUtills().getProportionalHeight(
                                              height: 18),
                                          left: UIUtills()
                                              .getProportionalWidth(width: 20),
                                        ),
                                        child: Container(
                                          height: UIUtills()
                                              .getProportionalHeight(
                                                  height: 47),
                                          width: UIUtills()
                                              .getProportionalWidth(width: 388),
                                          decoration: BoxDecoration(
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.25),
                                                    offset: Offset(0, 2.36364),
                                                    blurRadius: 4.72727)
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              gradient: const LinearGradient(
                                                  colors: <Color>[
                                                    Color.fromRGBO(
                                                        31, 31, 31, 1),
                                                    Color.fromRGBO(
                                                        51, 51, 51, 1)
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight)),
                                          child: Center(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      UIUtills()
                                                          .getProportionalWidth(
                                                              width: 17.22),
                                                      0,
                                                      UIUtills()
                                                          .getProportionalWidth(
                                                              width: 16.41),
                                                      0),
                                                  child: const Center(
                                                      child: Icon(
                                                    Icons.search,
                                                    color: Colors.white,
                                                  )),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: TextField(
                                                      focusNode: focusNode,
                                                      controller:
                                                          searchController,
                                                      style: GoogleFonts.poppins(
                                                          color: Colors.white,
                                                          fontSize: UIUtills()
                                                              .getProportionalHeight(
                                                                  height: 16)),
                                                      cursorColor: Colors.white,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        labelStyle:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .white),
                                                        hintText:
                                                            "Find amazing events by college",
                                                        hintStyle:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .white),
                                                        suffixIcon: IconButton(
                                                            onPressed: () {
                                                              searchController
                                                                  .clear();
                                                              focusNode.unfocus();
                                                            },
                                                            icon: const Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.grey,
                                                                size: 15)),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  searchController.text.isEmpty
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              left: UIUtills()
                                                  .getProportionalWidth(
                                                      width: 20),
                                              top: UIUtills()
                                                  .getProportionalHeight(
                                                      height: 30)),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: UIUtills()
                                                          .getProportionalHeight(
                                                              height: 20)),
                                                  child: Text('UPCOMING EVENTS',
                                                      style: BosmTextStyles
                                                          .robotoExtraBold
                                                          .copyWith(
                                                              fontSize: UIUtills()
                                                                  .getProportionalWidth(
                                                                      width:
                                                                          20),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800)),
                                                ),
                                                SizedBox(
                                                  height: UIUtills()
                                                      .getProportionalHeight(
                                                          height: 305),
                                                  child: Stack(
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      children: [
                                                        Positioned(
                                                          left: UIUtills()
                                                              .getProportionalWidth(
                                                                  width: -12),
                                                          top: UIUtills()
                                                              .getProportionalHeight(
                                                                  height: 10),
                                                          child: Image.asset(
                                                              ImageAssets
                                                                  .gloryImage,
                                                              height: UIUtills()
                                                                  .getProportionalHeight(
                                                                      height:
                                                                          290),
                                                              width: UIUtills()
                                                                  .getProportionalWidth(
                                                                      width:
                                                                          105)),
                                                        ),
                                                        ListView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          children: <Widget>[
                                                            SizedBox(
                                                              width: UIUtills()
                                                                  .getProportionalWidth(
                                                                      width:
                                                                          100),
                                                            ),
                                                            Row(
                                                                children: MatchesResult.upcomingEvents ==
                                                                        null
                                                                    ? [
                                                                        SizedBox(
                                                                          width:
                                                                              UIUtills().getProportionalWidth(width: 20),
                                                                        ),
                                                                        Image
                                                                            .asset(
                                                                          ImageAssets
                                                                              .noUpcomingEventsImage,
                                                                          height:
                                                                              UIUtills().getProportionalHeight(height: 247),
                                                                          width:
                                                                              UIUtills().getProportionalWidth(width: 201.21),
                                                                        )
                                                                      ]
                                                                    : List.generate(
                                                                        MatchesResult
                                                                            .upcomingEvents!
                                                                            .length,
                                                                        (index) => UpcomingEventsTab(
                                                                            id: MatchesResult.upcomingEvents![index].sport_id!,
                                                                            team1_college_name: MatchesResult.upcomingEvents![index].team1_college_name!,
                                                                            team2_college_name: MatchesResult.upcomingEvents![index].team2_college_name!,
                                                                            venue_name: MatchesResult.upcomingEvents![index].venue_name!,
                                                                            sport_name: MatchesResult.upcomingEvents![index].sport_name!,
                                                                            dateTime: DateTime.parse(MatchesResult.upcomingEvents![index].timestamp!))))
                                                          ],
                                                        )
                                                      ]),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      right: UIUtills()
                                                          .getProportionalWidth(
                                                              width: 16.46)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            top: UIUtills()
                                                                .getProportionalHeight(
                                                                    height: 20),
                                                            bottom: UIUtills()
                                                                .getProportionalHeight(
                                                                    height:
                                                                        24)),
                                                        child: Text(
                                                          'OTHER EVENTS',
                                                          style: BosmTextStyles
                                                              .robotoExtraBold
                                                              .copyWith(
                                                                  fontSize: UIUtills()
                                                                      .getProportionalWidth(
                                                                          width:
                                                                              20)),
                                                        ),
                                                      ),
                                                      const MiscellaneousTab(),
                                                      Column(
                                                        children: (MatchesResult
                                                                        .sportsList ==
                                                                    null ||
                                                                MatchesResult
                                                                    .sportsList!
                                                                    .isEmpty)
                                                            ? [
                                                              SizedBox(height:UIUtills().getProportionalHeight(height: 50)),
                                                          Center(
                                                            child: Image
                                                                .asset(
                                                              ImageAssets
                                                                  .noUpcomingEventsImage,
                                                              height:
                                                              UIUtills().getProportionalHeight(height: 450),
                                                              width:
                                                              UIUtills().getProportionalWidth(width: 400),
                                                            ),
                                                          )
                                                              ]
                                                            : List.generate(
                                                                MatchesResult
                                                                    .sportsList!
                                                                    .length,
                                                                (index) =>
                                                                    SportsTab(
                                                                      sportName: MatchesResult
                                                                          .sportsList![
                                                                              index]
                                                                          .name!,
                                                                      sportId: MatchesResult
                                                                          .sportsList![
                                                                              index]
                                                                          .id!,
                                                                      isFilled: isFilled[MatchesResult
                                                                              .sportsList?[index]
                                                                              .id] ??
                                                                          false,
                                                                    )),
                                                      ),
                                                      // SportsTab(),
                                                      const SizedBox(
                                                        height: 50,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ]))
                                      : SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.8,
                                          child: SearchScreen(
                                              textFieldValue:
                                                  searchController.text),
                                        ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : const Loader();
        }),
      ),
    );
  }
}
