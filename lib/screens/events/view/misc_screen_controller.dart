import 'package:flutter/material.dart';

class MiscScreenController {
  static ValueNotifier<int> selectedTab = ValueNotifier(
      (DateTime.now().day < 24 && DateTime.now().day > 18)
          ? (DateTime.now().day)
          : 19);
}
