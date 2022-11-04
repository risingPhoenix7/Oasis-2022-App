import '/resources/resources.dart';
import '/screens/matches/repository/model/matchesResult.dart';
import '/screens/matches/repository/model/roundData.dart';
import '/screens/matches/view/scoresScreenUI/dropdown_controller.dart';
import '/screens/matches/view/scoresScreenUI/widgets/filterwidgets/dropDownMenu.dart';
import '/screens/matches/view/scoresScreenUI/widgets/filterwidgets/gender_tab.dart';
import '/screens/matches/view_model/matches_view_model.dart';
import '/utils/scroll_remover.dart';
import '/utils/ui_utils.dart';
import '/widgets/app_bar.dart';
import '/widgets/error_dialogue.dart';
import 'package:flutter/material.dart';

class ScoresScreen extends StatefulWidget {
  ScoresScreen({Key? key, required this.sportName, required this.sportId});

  final String sportName;
  final int sportId;

  @override
  State<ScoresScreen> createState() => _ScoresScreenState();
}

class _ScoresScreenState extends State<ScoresScreen> {
  List<List<List<RoundData>>> fullList = [];
  List<RoundData> filteredDataList = [];

  @override
  void initState() {
    loadData();
    FilterDropDownController.dropDownValue.addListener(() {
      print(FilterDropDownController.genderValue.value);
      print(FilterDropDownController.dropDownValue.value);
      updatedfilteredDataList();
      if (mounted) setState(() {});
    });
    FilterDropDownController.genderValue.addListener(() {
      print(FilterDropDownController.genderValue.value);
      print(FilterDropDownController.dropDownValue.value);
      updatedfilteredDataList();
      if (mounted) setState(() {});
    });
    super.initState();
  }

  void loadData() {
    fullList = MatchesViewModel().retrieveFilteredData(widget.sportId);
    updatedfilteredDataList();
  }

  void updatedfilteredDataList() {
    filteredDataList = FilterDropDownController.dropDownValue.value == 2
        ? fullList[FilterDropDownController.genderValue.value][0] +
            fullList[FilterDropDownController.genderValue.value][1]
        : fullList[FilterDropDownController.genderValue.value]
            [FilterDropDownController.dropDownValue.value];
  }

  Future<void> refreshData() async {
    await MatchesViewModel().updateMatchesResult();

    if (MatchesResult.error != null) {
      setState(() {});
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
      loadData();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    print('at scores screen');
    print(filteredDataList.isNotEmpty && filteredDataList != null);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: CustomAppBar(
              title: widget.sportName,
              isactionButtonRequired: false,
              isBackButtonRequired: true,
            )),
        body: RefreshIndicator(
          onRefresh: refreshData,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: UIUtills().getProportionalWidth(width: 20.00),
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            color: const Color(0xFFFAFAFF),
            child: ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: ListView(children: [
                SizedBox(
                  height: UIUtills().getProportionalHeight(height: 26.00),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [GenderTab(), DropDownMenu()],
                ),
                SizedBox(
                  height: UIUtills().getProportionalHeight(height: 33.00),
                ),
                Column(
                  children: (filteredDataList.isNotEmpty &&
                          filteredDataList != null)
                      ? List.generate(
                          filteredDataList.length,
                          (index) => MatchesViewModel.getCorrectMatchwidget(
                              filteredDataList[index]))
                      : [
                          Padding(
                            padding: EdgeInsets.only(
                                top: UIUtills()
                                    .getProportionalHeight(height: 168)),
                            child: Center(
                                child: Image.asset(
                              ImageAssets.noEventsImage,
                              height:
                                  UIUtills().getProportionalHeight(height: 274),
                              width:
                                  UIUtills().getProportionalWidth(width: 363),
                            )),
                          )
                        ],
                )
                //   Column(children:(roundList != null && roundList!.isNotEmpty)?,)(

                // ,
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
