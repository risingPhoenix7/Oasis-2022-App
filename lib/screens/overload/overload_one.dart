import 'dart:ui';

import 'package:oasis_2022/utils/oasis_text_styles.dart';

import '/resources/resources.dart';

import 'package:flutter/material.dart';

import '/../utils/ui_utils.dart';

class OverloadOne extends StatelessWidget {
  const OverloadOne({Key? key}) : super(key: key);

  final String text =
      "Be updated with scores of all matches.    Use the search and filters features to find matches by college, gender and time.";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: UIUtills().getProportionalHeight(height: 50),
        ),
        Image.asset(
          ImageAssets.overBoarding1,
          height: UIUtills().getProportionalHeight(height: 333),
          width: UIUtills().getProportionalWidth(width: 410.48),
        ),
        SizedBox(
          height: UIUtills().getProportionalHeight(height: 46),
        ),
        Text("VIEW SCORES AND RESULTS",
            textAlign: TextAlign.center, style: OasisTextStyles.robotoExtraBold),
        SizedBox(
          height: UIUtills().getProportionalHeight(height: 12),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(text,
              textAlign: TextAlign.center,
              style: OasisTextStyles.poppinsRegular.copyWith(
                  fontSize: UIUtills().getProportionalWidth(width: 16),
                  fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
