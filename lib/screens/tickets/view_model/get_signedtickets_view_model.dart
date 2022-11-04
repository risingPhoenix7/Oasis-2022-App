import '/provider/user_details_viewmodel.dart';
import '/utils/error_messages.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';

import '../repository/model/signedTicketsData.dart';
import '../repository/retrofit/getSignedTickets.dart';

class GetSignedTicketsViewModel {
  Future<void> retrieveSignedShows() async {
    SignedTicketResult.error = null;
    String? jwt = UserDetailsViewModel.userDetails.JWT;
    final dio = Dio(); // Provide a dio instance
    dio.interceptors.add(ChuckerDioInterceptor()); //to remove later
    final client = SignedTicketsRestClient(dio);
    SignedTicketResult.signedTickets =
        await client.getCurrentTickets("JWT " + jwt!).then((it) {
      return it;
    }).catchError((Object obj) {
      try {
        final res = (obj as DioError).response;
        SignedTicketResult.error = res?.statusCode.toString();
        if (res?.statusCode == null || res == null) {
          SignedTicketResult.error = ErrorMessages.noInternet;
        } else {
          SignedTicketResult.error =
              getSignedTicketsErrorResponse(res.statusCode, res.statusMessage);
        }
      } catch (e) {
        SignedTicketResult.error = ErrorMessages.unknownError;
      }
      return SignedTicketResult.signedTickets ?? SignedTickets();
    });
  }

  String getSignedTicketsErrorResponse(
      int? responseCode, String? statusMessage) {
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
