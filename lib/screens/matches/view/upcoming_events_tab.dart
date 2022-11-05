import '/resources/resources.dart';
import '/utils/bosm_text_styles.dart';
import '/utils/common_functions.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/ui_utils.dart';

class UpcomingEventsTab extends StatelessWidget {
  UpcomingEventsTab(
      {Key? key,
      required this.id,
      required this.team1_college_name,
      required this.team2_college_name,
      required this.venue_name,
      required this.sport_name,
      required this.dateTime})
      : super(key: key);
  final int id;
  final String team1_college_name;
  final String team2_college_name;
  final DateTime dateTime;
  final String sport_name;
  final String venue_name;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomLeft,
        width: UIUtills().getProportionalWidth(width: 278),
        height: UIUtills().getProportionalHeight(height: 305),
        child: Stack(children: <Widget>[
          Image.asset(
            ImageAssets.getSportImageFromId(id),
            width: UIUtills().getProportionalWidth(width: 288),
            height: UIUtills().getProportionalHeight(height: 305),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: UIUtills().getProportionalWidth(width: 25),
                bottom: UIUtills().getProportionalWidth(width: 30)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sport_name,
                  style: BosmTextStyles.robotoExtraBold.copyWith(
                      fontSize: UIUtills().getProportionalWidth(width: 28),
                      color: OasisColors.textWhite),
                ),
                Text('${team1_college_name} vs ${team2_college_name}',
                    style: BosmTextStyles.poppinsRegular.copyWith(
                        fontSize: UIUtills().getProportionalWidth(width: 11),
                        color: OasisColors.textWhite)),
                Text(
                    CommonFunctions.getCorrectTimeString(dateTime) +
                        ' ' +
                        venue_name,
                    style: BosmTextStyles.poppinsRegular.copyWith(
                        fontSize: UIUtills().getProportionalWidth(width: 11),
                        color: OasisColors.textWhite))
              ],
            ),
          )
        ]));
  }
}
