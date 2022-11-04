import '/screens/matches/view/scoresScreenUI/dropdown_controller.dart';
import '/utils/bosm_text_styles.dart';
import '/utils/colors.dart';
import '/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class GenderIndividualTab extends StatefulWidget {
  GenderIndividualTab({Key? key, required this.tabName, required this.tabId})
      : super(key: key);
  String tabName;
  int tabId;

  @override
  State<GenderIndividualTab> createState() => _GenderIndividualTabState();
}

class _GenderIndividualTabState extends State<GenderIndividualTab> {
  bool isClicked = true;

  @override
  void initState() {
    FilterDropDownController.genderValue.addListener(() {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  clickHandler() {
    isClicked
        ? FilterDropDownController.genderValue.value = 3
        : FilterDropDownController.genderValue.value = widget.tabId;
  }

  @override
  Widget build(BuildContext context) {
    isClicked = FilterDropDownController.genderValue.value == widget.tabId;
    return GestureDetector(
      onTap: clickHandler,
      child: Container(
          width: UIUtills().getProportionalWidth(width: 72),
          height: UIUtills().getProportionalHeight(height: 36),
          child: Stack(children: <Widget>[
            Positioned(
                top: 0,
                left: 0,
                child: Container(
                    width: UIUtills().getProportionalWidth(width: 72),
                    height: UIUtills().getProportionalHeight(height: 36),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      // boxShadow: [
                      //   BoxShadow(
                      //       color: Color.fromRGBO(0, 0, 0, 0.25),
                      //       blurRadius: 7.400000095367432)
                      // ],
                      gradient: isClicked
                          ? LinearGradient(
                              begin: Alignment(-1, -1.2066167620616852e-8),
                              end: Alignment(
                                  -1.0285575946511472e-8, -0.02777777798473835),
                              colors: [
                                  Color.fromRGBO(45, 45, 45, 1),
                                  Color.fromRGBO(0, 0, 0, 1)
                                ])
                          : null,
                    ))),
            Center(
              child: Text(widget.tabName,
                  textAlign: TextAlign.left,
                  style: BosmTextStyles.poppinsRegular.copyWith(
                      color: isClicked ? BosmColors.textWhite : Colors.black,
                      fontWeight: FontWeight.w500)),
            ),
          ])),
    );
  }
}
