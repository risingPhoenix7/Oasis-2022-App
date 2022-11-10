import 'package:flutter/cupertino.dart';
import 'package:oasis_2022/screens/tickets/store_controller.dart';

import '/provider/user_details_viewmodel.dart';
import '/utils/error_messages.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';

import '../repository/model/showsData.dart';
import '../repository/retrofit/getAllShows.dart';

class GetShowsViewModel {
  Future<AllShowsData> retrieveAllShowData() async {
    String? jwt = UserDetailsViewModel.userDetails.JWT;
    String? auth = "JWT $jwt";
    AllShowsData allShowsData = AllShowsData([], []);
    final dio = Dio(); // Provide a dio instance
    final client = AllShowsRestClient(dio);
    try {
      allShowsData = await client.getAllShows(auth);
    } catch (e) {
      if (e.runtimeType == DioError) {
        var code = (e as DioError).response?.statusCode;
        var message = (e).response?.statusMessage;
        throw Exception(message);
      } else {
        throw Exception(e);
      }
    }
    for(StoreItemData i in allShowsData.shows!){
      print(i.name);
    }
    return allShowsData;
  }

  void fillController(AllShowsData allShowsData) {
    // filling carouselItem
    MerchCarouselItem merchCarouselItem = MerchCarouselItem(
        imageAsset: "assets/images/merch_small.png", merch: []);
    List<StoreItemData> merchItems = [];
    for (StoreItemData i in allShowsData.shows ?? []) {
      if (!i.is_merch!) {
        StoreController.carouselItems.add(i);
      } else {
        merchItems.add(i);
      }
    }
    for (StoreItemData i in merchItems) {
      merchCarouselItem.merch!.add(i);
    }
    if(merchItems.isNotEmpty){
      StoreController.carouselItems.add(merchCarouselItem);
    }
    //filling carousel image
    print(StoreController.carouselItems);
    for (StoreItemData i in allShowsData.shows ?? []) {
      if (!i.is_merch!) {
        StoreController.carouselImage2.add(i.image_url[0]);
      }
    }
    int k = 0;
    for(StoreItemData i in allShowsData.shows ?? []){
      if(i.is_merch! && (k==0)){
        k=1;
        StoreController.carouselImage2.add("assets/images/merch_small.png");
      }
    }
    print(StoreController.carouselImage2);
  }

  String getShowsErrorResponse(int? responseCode, String? statusMessage) {
    switch (responseCode) {
      case 400:
        return ErrorMessages.unknownError;
      case 401:
        return ErrorMessages.unknownError;
      case 403:
        return ErrorMessages.unknownError;
      case 404:
        return ErrorMessages.unknownError;
      default:
        return ErrorMessages.unknownError +
            ((statusMessage == null) ? '' : statusMessage);
    }
  }
}
