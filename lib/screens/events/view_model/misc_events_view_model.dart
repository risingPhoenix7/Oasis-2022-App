import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';

import '../../../utils/error_messages.dart';
import '../repository/model/miscEventResult.dart';
import '../repository/retrofit/getMiscEvents.dart';

class MiscEventsViewModel {
  static String? error;
  static List<MiscEventData> miscEventList = <MiscEventData>[];
  Map<int, List<int>> miscEventSortedMap = {}; //19:[1,3,4,6],20:[]....

  Future<void> retrieveMiscEventResult() async {
    miscEventList = <MiscEventData>[];
    miscEventSortedMap = {};
    List<MiscEventCategory>? miscEventCategoryList;
    final dio = Dio();
    error = null;
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = MiscEventRestClient(dio);

    miscEventCategoryList = await client.getAllMiscEvents().then((it) {
      return it;
    }).catchError((Object obj) {
      try {
        final res = (obj as DioError).response;
        error = res?.statusCode.toString();
        if (res?.statusCode == null || res == null) {
          error = ErrorMessages.noInternet;
        } else {
          error = matchesErrorResponse(res.statusCode, res.statusMessage);
        }
      } catch (e) {
        error = ErrorMessages.unknownError;
      }
      return miscEventCategoryList ?? <MiscEventCategory>[];
    });
    int indexPosition = 0;
    for (MiscEventCategory miscEventCategory in miscEventCategoryList) {
      if (miscEventCategory.events != null) {
        for (MiscEventData miscevent in miscEventCategory.events!) {
          String a = miscevent.date_time ?? '2022-11-23T19:42:24z';

          try {
            var p = DateTime.parse(a);
            if (!(miscEventSortedMap.containsKey(p.day))) {
              miscEventSortedMap.putIfAbsent(p.day, () => [indexPosition]);
            } else {
              miscEventSortedMap.update(p.day, (oldList) {
                oldList.add(indexPosition);
                return oldList;
              });
            }
          } catch (e) {
            //TBA
            if (!(miscEventSortedMap.containsKey(19))) {
              miscEventSortedMap.putIfAbsent(19, () => [indexPosition]);
            } else {
              miscEventSortedMap.update(19, (oldList) {
                oldList.add(indexPosition);
                return oldList;
              });
            }
          }
          indexPosition++;
          miscEventList.add(miscevent);
        }
      }
    }
  }

  List<MiscEventData> retrieveSearchMiscEventData(int day_no, String text) {
    List<MiscEventData> searchedMiscEventList = [];
    text = text.toLowerCase();
    if (miscEventSortedMap.containsKey(day_no)) {
      for (int element in miscEventSortedMap[day_no] ?? []) {
        if (((miscEventList[element].name == null)
                ? false
                : miscEventList[element].name!.toLowerCase().contains(text)) ||
            ((miscEventList[element].organiser == null)
                ? false
                : miscEventList[element]
                    .organiser!
                    .toLowerCase()
                    .contains(text)) ||
            ((miscEventList[element].about == null)
                ? false
                : miscEventList[element].about!.toLowerCase().contains(text)))
          searchedMiscEventList.add(miscEventList[element]);
      }
    }
    return searchedMiscEventList;
  }

  List<MiscEventData> retrieveDayMiscEventData(int day_no) {
    List<MiscEventData> assortedMiscEventList = [];
    if (miscEventSortedMap.containsKey(day_no)) {
      for (var element in miscEventSortedMap[day_no] ?? []) {
        assortedMiscEventList.add(miscEventList[element]);
      }
    }
    return assortedMiscEventList;
  }

  static String matchesErrorResponse(int? responseCode, String? statusMessage) {
    switch (responseCode) {
      case 400:
        return ErrorMessages.emptyUsernamePassword;
      case 401:
        return ErrorMessages.invalidUser;
      case 403:
        return ErrorMessages.disabledUser;
      case 404:
        return ErrorMessages.emptyProfile;
      default:
        return ErrorMessages.unknownError +
            ((statusMessage == null) ? '' : statusMessage);
    }
  }
}
