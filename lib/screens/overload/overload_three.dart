import 'package:oasis_2022/utils/oasis_text_styles.dart';

import '/resources/resources.dart';

import 'package:flutter/material.dart';

import '/../utils/ui_utils.dart';

class OverloadThree extends StatelessWidget {
  const OverloadThree({Key? key}) : super(key: key);

  final String text =
      'No hassle of payment through multiple platforms as all transactions can take place through our Wallet system. You can even transfer money between different app users.';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: UIUtills().getProportionalHeight(height: 50)),
        SizedBox(
            child: Image.asset(
          ImageAssets.overBoarding3,
          width: UIUtills().getProportionalWidth(width: 436.48),
          height: UIUtills().getProportionalHeight(height: 372),
        )),
        SizedBox(
          height: UIUtills().getProportionalHeight(height: 57),
        ),
        Text("WALLET AND TRANSFER",
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
