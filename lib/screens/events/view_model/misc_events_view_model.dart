import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:oasis_2022/provider/user_details_viewmodel.dart';

import '../../../utils/error_messages.dart';
import '../repository/model/miscEventResult.dart';
import '../repository/retrofit/getMiscEvents.dart';

class MiscEventsViewModel {
  static String? error;
  static List<MiscEventData>? miscEventList;

  Future<void> retrieveMiscEventResult() async {
    final dio = Dio();
    error = null;
    String? jwt = UserDetailsViewModel.userDetails.JWT;
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = MiscEventRestClient(dio);

    miscEventList = await client.getAllMiscEvents("JWT " + jwt!).then((it) {
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
      return miscEventList ?? <MiscEventData>[];
    });
  }

  List<MiscEventData> retrieveDayMiscEventData(int day_no) {
    List<MiscEventData> miscEventList = [];
    if (miscEventList == null) {
      return <MiscEventData>[];
    } else {
      for (int i = 0; i < miscEventList.length; i++) {
        if (miscEventList[i].day == day_no) {
          miscEventList.add(miscEventList[i]);
        }
      }
    }
    return miscEventList;
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
