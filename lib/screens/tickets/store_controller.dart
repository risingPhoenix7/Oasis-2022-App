import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:oasis_2022/screens/tickets/repository/model/showsData.dart';

class StoreController {
  static ValueNotifier<int> itemNumber = ValueNotifier(0);
  static ValueNotifier<bool> isMerch = ValueNotifier(false);

  static List<StoreItemData> storeItem = [];

  static List<String> carouselImage = [
    "amit_small",
    "hip_hop_small",
    "indie_night_small",
    "n2o_small",
    "merch_small"
  ];

  int getId(int? merchIndex) {
    if (carouselItems[itemNumber.value].runtimeType == MerchCarouselItem) {
      return (carouselItems[itemNumber.value] as MerchCarouselItem)
          .merch![merchIndex!]
          .id!;
    } else {
      return (carouselItems[itemNumber.value] as StoreItemData).id!;
    }
  }

  static List<String> carouselImage2 = [];

  static List<String> profShowImages = [];

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

  static List<dynamic> carouselItems = [];
}
