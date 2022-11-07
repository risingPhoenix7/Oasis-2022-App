import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oasis_2022/resources/resources.dart';
import 'package:oasis_2022/utils/oasis_text_styles.dart';

import '/utils/scroll_remover.dart';
import '/utils/ui_utils.dart';
import '/widgets/error_dialogue.dart';
import '/widgets/loader.dart';
import '../repository/model/miscEventResult.dart';
import '../view_model/misc_events_view_model.dart';
import 'day_tab.dart';
import 'misc_screen_controller.dart';
import 'single_miscellanous_event.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  MiscEventsViewModel miscEventsViewModel = MiscEventsViewModel();
  bool isLoading = true;
  List<MiscEventData> currentDayMiscEventList = [];
  List<MiscEventData> searchMiscEventList = [];
  FocusNode focusNode = FocusNode();
  TextEditingController searchController = TextEditingController();

  Future<void> updateMiscEventsResult() async {
    await miscEventsViewModel.retrieveMiscEventResult();
    if (MiscEventsViewModel.error == null) {
      if (mounted) {
        setState(() {
          updateCurrentDayMiscEventList();
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
              child: ErrorDialog(errorMessage: MiscEventsViewModel.error!),
            );
          });
    }
  }

  void updateCurrentDayMiscEventList() {
    currentDayMiscEventList = miscEventsViewModel
        .retrieveDayMiscEventData(MiscScreenController.selectedTab.value);
  }

  void updateSearchList(String? a) {
    print('comes here');
    print(a);
    if (a != null) {
      searchMiscEventList = miscEventsViewModel.retrieveSearchMiscEventData(
          MiscScreenController.selectedTab.value, a);
      print(searchMiscEventList);
    }
    setState(() {});
  }

  bool emptyListHandler() {
    if (searchController.text.isEmpty) {
      return currentDayMiscEventList.isEmpty;
    } else {
      return searchMiscEventList.isEmpty;
    }
  }

  List<MiscEventData> requiredListHandler() {
    if (searchController.text.isEmpty) {
      return currentDayMiscEventList;
    } else {
      return searchMiscEventList;
    }
  }

  @override
  void initState() {
    updateMiscEventsResult();
    MiscScreenController.selectedTab.addListener(() {
      if (mounted) {
        setState(() {
          searchController.text.isEmpty
              ? updateCurrentDayMiscEventList()
              : updateSearchList(searchController.text);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: !isLoading
            ? GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: RefreshIndicator(
                  onRefresh: updateMiscEventsResult,
                  child: Stack(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      Positioned(
                        child: Image.asset(ImageAssets.eventBg),
                        right: 0,
                        top: -45,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 34.h, left: 28.w),
                            child: Text(
                              'Events',
                              style: OasisTextStyles.inter500,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 52.h,
                                bottom: 27.5,
                                left: 36.w,
                                right: 36.w),
                            child: Container(
                              height: 50.h,
                              // width: UIUtills()
                              //     .getProportionalWidth(width: 388),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                    color: Color.fromRGBO(248, 216, 72, 0.45),
                                    width: 0.5),
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color.fromRGBO(164, 108, 0, 0.15),
                                      Color.fromRGBO(209, 154, 8, 0.15)
                                    ]),
                              ),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 15.0.w, right: 15.w),
                                      child: Center(
                                          child: SvgPicture.asset(
                                              ImageAssets.searchIcon)),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: TextField(
                                          onChanged: updateSearchList,
                                          focusNode: focusNode,
                                          controller: searchController,
                                          //textAlignVertical: TextAlignVertical.center,
                                          style: OasisTextStyles.openSans300
                                              .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                  fontSize: 16.sp),
                                          cursorColor: Colors.white,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 14.8.h),
                                            border: InputBorder.none,
                                            // labelStyle:
                                            // OasisTextStyles.openSans300.copyWith(fontWeight: FontWeight.w400,color: Color(0xFFC0C0C0),fontSize: 16.sp),
                                            hintText: "Search for events...",
                                            hintStyle: OasisTextStyles
                                                .openSans300
                                                .copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xFFC0C0C0),
                                                    fontSize: 16.sp),
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  searchController.clear();

                                                  focusNode.unfocus();
                                                  setState(() {});
                                                },
                                                icon: SvgPicture.asset(
                                                    ImageAssets.crossIcon)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(36.w, 27.h, 36.w, 34.h),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                      5,
                                      (index) => DayTab(
                                            dayNumber: index + 19,
                                          ))),
                            ),
                          ),
                          ScrollConfiguration(
                            behavior: CustomScrollBehavior(),
                            child: Container(
                              height: 450.h,
                              child: ListView(
                                children: <Widget>[
                                  Column(
                                    children: emptyListHandler()
                                        ? [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 58.0),
                                              child: Text(
                                                'No events of this day',
                                                style: OasisTextStyles
                                                    .openSans300
                                                    .copyWith(
                                                        color: Colors.white),
                                              ),
                                            )
                                          ]
                                        : List.generate(
                                            requiredListHandler().length,
                                            (index) {
                                            return SingleMiscellaneousEvent(
                                              time: requiredListHandler()[index]
                                                      .time ??
                                                  'TBA',
                                              eventName:
                                                  requiredListHandler()[index]
                                                      .name,
                                              eventDescription:
                                                  requiredListHandler()[index]
                                                      .about,
                                              eventConductor:
                                                  requiredListHandler()[index]
                                                      .organiser,
                                              eventLocation:
                                                  requiredListHandler()[index]
                                                      .venue_name,
                                            );
                                          }),
                                    // children: getMiscEventsList(
                                    //     MiscScreenController.selectedTab.value),
                                  ),
                                  SizedBox(
                                    height: UIUtills()
                                        .getProportionalHeight(height: 50),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : const Loader(),
      ),
    );
  }
}
