import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';

import '../../../utils/error_messages.dart';
import '../repository/model/miscEventResult.dart';
import '../repository/retrofit/getMiscEvents.dart';

class MiscEventsViewModel {
  static String? error;
  static List<MiscEventData>? miscEventList = <MiscEventData>[];

  Future<void> retrieveMiscEventResult() async {
    List<MiscEventCategory>? miscEventCategoryList;
    final dio = Dio();
    error = null;
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = MiscEventRestClient(dio);

    miscEventCategoryList = await client.getAllMiscEvents().then((it) {
print('fewjf');
      print(it.length);
      return it;
    }).catchError((Object obj) {
      print('non-200 error goes here.');
      try {
        print('hi');
        final res = (obj as DioError).response;
        error = res?.statusCode.toString();
        if (res?.statusCode == null || res == null) {
          error = ErrorMessages.noInternet;
        } else {
          print('goes here error in misc result');
          error = matchesErrorResponse(res.statusCode, res.statusMessage);
          print(error);
        }
      } catch (e) {
        error = ErrorMessages.unknownError;
      }
      return miscEventCategoryList ?? <MiscEventCategory>[];
    });

    for (MiscEventCategory miscEventCategory in miscEventCategoryList) {
      if (miscEventCategory.events != null) {
        miscEventList!.addAll(miscEventCategory.events!);
      }
       // miscEventList.sort((a,b)=>{
       //   if(a.time=='')
       // });
    }
    print(miscEventList?.length);
  }

  List<MiscEventData> retrieveDayMiscEventData(int day_no) {
    List<MiscEventData> assortedMiscEventList = [];
    for (int i = 0; i < miscEventList!.length; i++) {
      var a = miscEventList![i].date_time;
      if (a == null || a.isEmpty) {
        a = '19T';
      }
      print(a.indexOf('T'));
      if (a.indexOf('T') == 3) {
        if (a.substring(0, 3) == day_no.toString()) {
          assortedMiscEventList.add(miscEventList![i]);
        }
      } else {
        if (day_no == 19) assortedMiscEventList.add(miscEventList![i]);
      }
    }
print(assortedMiscEventList.length);
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
