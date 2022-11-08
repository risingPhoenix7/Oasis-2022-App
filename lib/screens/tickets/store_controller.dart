import 'package:flutter/foundation.dart';

class StoreController {
  static ValueNotifier<int> itemNumber = ValueNotifier(1);

  List<String> merchImage = ["test_merch", "test_merch", "test_merch"];

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
