import '/resources/resources.dart';
import '/screens/matches/repository/model/roundData.dart';
import '/screens/matches/view/scoresScreenUI/dropdown_controller.dart';
import '/screens/matches/view/search_screen/filterwidgets/search_dropDownMenu.dart';
import '/screens/matches/view/search_screen/filterwidgets/search_gender_tab.dart';
import '/screens/matches/view_model/matches_view_model.dart';
import '/utils/scroll_remover.dart';
import '/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key, required this.textFieldValue});

  String textFieldValue;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<List<List<RoundData>>> fullList = [];
  List<RoundData> filteredDataList = [];

  @override
  void initState() {
    FilterDropDownController.searchDropDownValue.addListener(() {
      print('listener dropdown called');
      updatedfilteredDataList();
      if (mounted) setState(() {});
    });
    FilterDropDownController.searchGenderValue.addListener(() {
      print('listerner called');
      updatedfilteredDataList();
      if (mounted) setState(() {});
    });
    super.initState();
  }

  void loadData() {
    fullList =
        MatchesViewModel().retrieveSearchFilteredData(widget.textFieldValue);
    print('in load data');
    print(widget.textFieldValue);
    updatedfilteredDataList();
  }

  void updatedfilteredDataList() {
    filteredDataList = FilterDropDownController.searchDropDownValue.value == 2
        ? fullList[FilterDropDownController.searchGenderValue.value][0] +
            fullList[FilterDropDownController.searchGenderValue.value][1]
        : fullList[FilterDropDownController.searchGenderValue.value]
            [FilterDropDownController.searchDropDownValue.value];
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
      body: Container(
        //width: double.infinity,
        height: MediaQuery.of(context).size.height,
        //color: Colors.black,
        color: const Color(0xFFFAFAFF),
        child: ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: ListView(children: [
            SizedBox(
              height: UIUtills().getProportionalHeight(height: 26.00),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [GenderSearchTab(), DropDownSearchMenu()],
            ),
            SizedBox(
              height: UIUtills().getProportionalHeight(height: 33.00),
            ),
            Column(
              children: (filteredDataList.isNotEmpty)
                  ? List.generate(
                      filteredDataList.length,
                      (index) => MatchesViewModel.getCorrectMatchwidget(
                          filteredDataList[index]))
                  : [
                      Padding(
                        padding: EdgeInsets.only(
                            top: UIUtills().getProportionalHeight(height: 20)),
                        child: Center(
                            child: Image.asset(
                          ImageAssets.noEventsImage,
                          height: UIUtills().getProportionalHeight(height: 250),
                          width: UIUtills().getProportionalWidth(width: 350),
                        )),
                      )
                    ],
            ),
            SizedBox(
              height: UIUtills().getProportionalHeight(height: 200),
            )
            //   Column(children:(roundList != null && roundList!.isNotEmpty)?,)(

            // ,
          ]),
        ),
      ),
    );
  }
}
