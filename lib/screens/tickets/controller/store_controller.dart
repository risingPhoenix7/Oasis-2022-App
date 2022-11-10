import 'package:flutter/foundation.dart';
import 'package:oasis_2022/screens/tickets/repository/model/showsData.dart';
import 'package:oasis_2022/screens/tickets/view_model/getAllShows_view_model.dart';

class StoreController {
  static ValueNotifier<int> itemNumber = ValueNotifier(0);

  static List<StoreItemData> storeItem = [];

  static List<String> carouselImage2 = [];

  static List<String> profShowImages = [];

  static List<dynamic> carouselItems = [];

  Future<void> initialCall() async {
    AllShowsData allShowsData;
    allShowsData = await GetShowsViewModel().retrieveAllShowData();
    GetShowsViewModel().fillController(allShowsData);
  }

  int getId(int? merchIndex) {
    if (carouselItems[itemNumber.value].runtimeType == MerchCarouselItem) {
      return (carouselItems[itemNumber.value] as MerchCarouselItem)
          .merch![merchIndex!]
          .id!;
    } else {
      return (carouselItems[itemNumber.value] as StoreItemData).id!;
    }
  }
}
