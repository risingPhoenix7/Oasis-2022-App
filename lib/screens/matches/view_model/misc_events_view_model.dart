import '/provider/user_details_viewmodel.dart';
import '/screens/matches/repository/model/miscEventResult.dart';
import '/screens/matches/repository/retrofit/getMiscEvents.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';

import '../../../utils/error_messages.dart';

class MiscEventsViewModel {
  Future<void> retrieveMiscEventResult() async {
    final dio = Dio();
    MiscEventResult.error = null;
    String? jwt = UserDetailsViewModel.userDetails.JWT;
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = MiscEventRestClient(dio);

    MiscEventResult.miscEventList =
        await client.getAllMiscEvents("JWT " + jwt!).then((it) {
      return it;
    }).catchError((Object obj) {
      print('non-200 error goes here.');
      try {
        print('hi');
        final res = (obj as DioError).response;
        MiscEventResult.error = res?.statusCode.toString();
        if (res?.statusCode == null || res == null) {
          MiscEventResult.error = ErrorMessages.noInternet;
        } else {
          print('goes here error in misc result');
          MiscEventResult.error =
              matchesErrorResponse(res.statusCode, res.statusMessage);
          print(MiscEventResult.error);
        }
      } catch (e) {
        MiscEventResult.error = ErrorMessages.unknownError;
      }
      return MiscEventResult.miscEventList ?? <MiscEventData>[];
    });
  }

  List<MiscEventData> retrieveDayMiscEventData(int day_no) {
    List<MiscEventData> miscEventList = [];
    if (MiscEventResult.miscEventList == null) {
      return <MiscEventData>[];
    } else {
      for (int i = 0; i < MiscEventResult.miscEventList!.length; i++) {
        if (MiscEventResult.miscEventList![i].day == day_no) {
          miscEventList.add(MiscEventResult.miscEventList![i]);
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
