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

    for (MiscEventCategory miscEventCategory in miscEventCategoryList) {
      if (miscEventCategory.events != null) {
        miscEventList!.addAll(miscEventCategory.events!);
      }
      // miscEventList.sort((a,b)=>{
      //   if(a.time=='')
      // });
    }

  }

  List<MiscEventData> retrieveDayMiscEventData(int day_no) {
    List<MiscEventData> assortedMiscEventList = [];
    for (int i = 0; i < miscEventList!.length; i++) {
      String a = miscEventList![i].date_time ?? '2022-11-23T19:42:24z';

      try {
        DateTime.parse(a);
        if (day_no == DateTime.parse(a).day) {
          assortedMiscEventList.add(miscEventList![i]);
        }
      } catch (e) {
        if (day_no == 19) assortedMiscEventList.add(miscEventList![i]);
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
