import 'package:flutter/foundation.dart';

class StoreController extends ChangeNotifier {
  ValueNotifier<int> itemNumber = ValueNotifier(2);

  void setValue(int newValue) {
    itemNumber.value = newValue;
    print(itemNumber.value);
    notifyListeners();
  }

  List<String> imageNames = [
    "amit_trivedi",
    "hip_hop",
    "indie_night",
    "indie_night",
    "indie_night"
  ];

  List<String> itemName = [
    "Amit\nTrivedi",
    "SEEDHE MAUT X\nSEVENN",
    "INDIE NIGHT",
    "N2O",
    "MERCH"
  ];

  List<String> imageNamesCarousel = [
    "amit_small",
    "hip_hop_small",
    "indie_night_small",
    "n2o_small",
    "merch_small"
  ];
}
