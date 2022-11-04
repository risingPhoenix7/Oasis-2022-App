import '/screens/matches/view/miscellaneous_screen/misc_screen_controller.dart';
import '/utils/bosm_text_styles.dart';
import '/utils/colors.dart';
import '/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class DayTab extends StatefulWidget {
  DayTab({Key? key, required this.dayNumber}) : super(key: key);
  final int dayNumber;

  @override
  State<DayTab> createState() => _DayTabState();
}

class _DayTabState extends State<DayTab> {
  @override
  void initState() {
    MiscScreenController.selectedTab.addListener(() {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    bool isSelected =
        MiscScreenController.selectedTab.value == widget.dayNumber;
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          MiscScreenController.selectedTab.value = widget.dayNumber;
        }
      },
      child: Container(
        width: (screenWidth - 25.5 * 2 - 18) / 5 - 1,
        height: UIUtills().getProportionalHeight(height: 82),
        decoration: isSelected
            ? BoxDecoration(
                gradient: BosmColors.verticalBlackgradient,
                borderRadius: BorderRadius.circular(
                    UIUtills().getProportionalWidth(width: 10)),
              )
            : const BoxDecoration(color: BosmColors.textWhite),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              child: Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: BosmColors.textWhite,
                ),
              ),
            ),
            Text(
              'DAY',
              style: BosmTextStyles.poppinsRegular.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? BosmColors.textWhite
                      : const Color(0xFF575757)),
            ),
            Text(
              widget.dayNumber.toString(),
              style: BosmTextStyles.poppinsRegular.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? BosmColors.textWhite
                      : const Color(0xFF575757),
                  fontSize: UIUtills().getProportionalWidth(width: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
