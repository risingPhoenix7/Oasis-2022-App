import '/utils/ui_utils.dart';
import 'package:flutter/material.dart';

import 'search_gender_individual_tab.dart';

class GenderSearchTab extends StatefulWidget {
  const GenderSearchTab({Key? key}) : super(key: key);

  @override
  State<GenderSearchTab> createState() => _GenderSearchTabState();
}

class _GenderSearchTabState extends State<GenderSearchTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SearchGenderIndividualTab(
            tabName: 'BOYS',
            tabId: 0,
          ),
          SearchGenderIndividualTab(
            tabName: 'GIRLS',
            tabId: 1,
          ),
          SearchGenderIndividualTab(
            tabName: 'MIXED',
            tabId: 2,
          ),
        ],
      ),
      width: UIUtills().getProportionalWidth(width: 230.8),
      height: UIUtills().getProportionalHeight(height: 54),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              offset: Offset(0, 4),
              blurRadius: 6.00,
            ),
          ],
          borderRadius: BorderRadius.circular(
            UIUtills().getProportionalWidth(width: 14.8),
          ),
          border: Border.all(
            width: 0.8,
            color: const Color.fromRGBO(218, 218, 218, 0.5),
          ),
          color: Color.fromRGBO(255, 255, 255, 1)),
    );
  }
}
