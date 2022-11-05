import '/screens/matches/repository/model/miscEventResult.dart';
import '/screens/matches/view/miscellaneous_screen/misc_screen_controller.dart';
import '/screens/matches/view_model/misc_events_view_model.dart';
import '/utils/colors.dart';
import '/utils/scroll_remover.dart';
import '/utils/ui_utils.dart';
import '/widgets/app_bar.dart';
import '/widgets/error_dialogue.dart';
import '/widgets/loader.dart';
import 'package:flutter/material.dart';

import 'day_tab.dart';
import 'single_miscellanous_event.dart';

class MiscellaneousScreen extends StatefulWidget {
  const MiscellaneousScreen({Key? key}) : super(key: key);

  @override
  State<MiscellaneousScreen> createState() => _MiscellaneousScreenState();
}

class _MiscellaneousScreenState extends State<MiscellaneousScreen> {
  MiscEventsViewModel miscEventsViewModel = MiscEventsViewModel();
  bool isLoading = true;
  List<MiscEventData> currentDayMiscEventList = [];

  Future<void> updateMiscEventsResult() async {
    await miscEventsViewModel.retrieveMiscEventResult();
    if (MiscEventResult.error == null) {
      setState(() {
        updateCurrentDayMiscEventList();
        isLoading = false;
      });
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
              child: ErrorDialog(errorMessage: MiscEventResult.error!),
            );
          });
    }
  }

  void updateCurrentDayMiscEventList() async {
    currentDayMiscEventList = miscEventsViewModel
        .retrieveDayMiscEventData(MiscScreenController.selectedTab.value);
  }

  @override
  void initState() {
    if (MiscEventResult.miscEventList == null) {
      updateMiscEventsResult().onError((error, stackTrace) => setState(() {
            isLoading = false;
            print('it goeds here');
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: ErrorDialog(errorMessage: MiscEventResult.error!),
                  );
                });
          }));
    } else {
      updateCurrentDayMiscEventList();
      isLoading = false;
    }
    MiscScreenController.selectedTab.addListener(() {
      setState(() {
        if (mounted) updateCurrentDayMiscEventList();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> updateMiscEventsResult() async {
      print('function called');
      await miscEventsViewModel.retrieveMiscEventResult();
      if (MiscEventResult.error == null) {
        print('went here');
        setState(() {
          updateCurrentDayMiscEventList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: ErrorDialog(errorMessage: MiscEventResult.error!),
              );
            });
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: OasisColors.backgroundColorWhite,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: CustomAppBar(
              title: 'Miscellaneous',
              isactionButtonRequired: false,
              isBackButtonRequired: true,
            )),
        body: !isLoading
            ? RefreshIndicator(
                onRefresh: updateMiscEventsResult,
                child: ScrollConfiguration(
                  behavior: CustomScrollBehavior(),
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            UIUtills().getProportionalWidth(width: 26),
                            UIUtills().getProportionalHeight(height: 25),
                            UIUtills().getProportionalWidth(width: 25.5),
                            UIUtills().getProportionalHeight(height: 23)),
                        child: Container(
                          decoration: BoxDecoration(
                              color: OasisColors.textWhite,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.15),
                                    offset: Offset(0, 2),
                                    blurRadius: 7)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 9.0, vertical: 9),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List.generate(
                                    5,
                                    (index) => DayTab(
                                          dayNumber: index,
                                        ))),
                          ),
                        ),
                      ),
                      Column(
                        children: currentDayMiscEventList.length == 0
                            ? [const Text('No events of this day')]
                            : List.generate(currentDayMiscEventList.length,
                                (index) {
                                return SingleMiscellaneousEvent(
                                  timeStamp: currentDayMiscEventList[index]
                                              .timestamp ==
                                          null
                                      ? null
                                      : currentDayMiscEventList[index]
                                          .timestamp!,
                                  eventName:
                                      currentDayMiscEventList[index].name,
                                  eventDescription:
                                      currentDayMiscEventList[index]
                                          .description,
                                  eventConductor:
                                      currentDayMiscEventList[index].organiser,
                                  eventLocation:
                                      currentDayMiscEventList[index].venue_name,
                                );
                              }),
                        // children: getMiscEventsList(
                        //     MiscScreenController.selectedTab.value),
                      ),
                      SizedBox(
                        height: UIUtills().getProportionalHeight(height: 50),
                      )
                    ],
                  ),
                ),
              )
            : const Loader(),
      ),
    );
  }
}
