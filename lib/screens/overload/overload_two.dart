import 'package:flutter/material.dart';
import 'package:oasis_2022/resources/resources.dart';
import 'package:oasis_2022/utils/oasis_text_styles.dart';

import '../../utils/ui_utils.dart';

class OverloadTwo extends StatelessWidget {
  const OverloadTwo({Key? key}) : super(key: key);

  final String text =
      'Forget about the hassle of standing in long queues to order from the variety of stalls available. Place orders and get live updates about your order status on the app.';

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
          ImageAssets.overBoarding2,
          width: UIUtills().getProportionalWidth(width: 332.89),
          height: UIUtills().getProportionalHeight(height: 367.65),
        ),
        SizedBox(
          height: UIUtills().getProportionalHeight(height: 30),
        ),
        Text("ORDER FOOD",
            textAlign: TextAlign.center,
            style: OasisTextStyles.robotoExtraBold),
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
