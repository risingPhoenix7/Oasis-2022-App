import 'package:flutter/material.dart';

class FilterDropDownController {
  static ValueNotifier<int> genderValue =
      ValueNotifier(3); // 0 is boys, 1 is girls and 2 is mixed 3 is all
  static ValueNotifier<int> searchGenderValue =
      ValueNotifier(3); // 0 is boys, 1 is girls and 2 is mixed 3 is all
  static ValueNotifier<int> dropDownValue =
      ValueNotifier(2); // 0 is upcoming, 1 is completed, 2 is all
  static ValueNotifier<int> searchDropDownValue =
      ValueNotifier(2); // 0 is upcoming, 1 is completed, 2 is all
}
