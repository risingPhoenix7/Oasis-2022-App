import '/provider/user_details_viewmodel.dart';
import '/utils/error_messages.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';

import '../repository/model/showsData.dart';
import '../repository/retrofit/getAllShows.dart';

class GetShowsViewModel {
  Future<void> retrieveAllShowData() async {
    ShowsResult.error = null;
    String? jwt = UserDetailsViewModel.userDetails.JWT;
    final dio = Dio(); // Provide a dio instance
    dio.interceptors.add(ChuckerDioInterceptor()); //to remove later
    final client = AllShowsRestClient(dio);
    ShowsResult.allShowsData =
        await client.getAllShows("JWT " + jwt!).then((it) {
      return it;
    }).catchError((Object obj) {
      try {
        final res = (obj as DioError).response;
        ShowsResult.error = res?.statusCode.toString();
        if (res?.statusCode == null || res == null) {
          ShowsResult.error = ErrorMessages.noInternet;
        } else {
          ShowsResult.error =
              getShowsErrorResponse(res.statusCode, res.statusMessage);
        }
      } catch (e) {
        ShowsResult.error = ErrorMessages.unknownError;
      }
      return ShowsResult.allShowsData ??
          AllShowsData(<TicketData>[], <CombosData>[]);
    });
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
