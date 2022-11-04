import '/provider/user_details_viewmodel.dart';
import '/utils/error_messages.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../repository/model/ticketPostBody.dart';
import '../repository/retrofit/postTicket.dart';

class TicketPostViewModel {
  static TicketPostBody ticketPostBody =
      TicketPostBody(individual: {}, combos: {});
  static ValueNotifier<double> totalAmount = ValueNotifier(0);
  static String? error;

  Future<void> postOrders() async {
    error = null;
    String? jwt = UserDetailsViewModel.userDetails.JWT;
    final dio = Dio(); // Provide a dio instance
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = PostTicketRestClient(dio);
    await client.postTicket("JWT $jwt", cleanTicketPostBody()).then((it) async {
      return it;
    }).catchError((Object obj) {
      try {
        final res = (obj as DioError).response;
        if (res?.statusCode == null || res == null) {
          error = ErrorMessages.noInternet;
        } else {
          error = buyTicketsErrorResponse(res.statusCode, res.statusMessage);
        }
      } catch (e) {
        error = ErrorMessages.unknownError;
      }
    });
  }

  TicketPostBody cleanTicketPostBody() {
    TicketPostBody finalTicketPostBody =
        TicketPostBody(individual: {}, combos: {});
    ticketPostBody.individual!.forEach((key, value) {
      if (value != 0) {
        finalTicketPostBody.individual![key] = value;
      }
    });
    ticketPostBody.combos!.forEach((key, value) {
      if (value != 0) {
        finalTicketPostBody.combos![key] = value;
      }
    });
    return finalTicketPostBody;
  }

  String buyTicketsErrorResponse(int? responseCode, String? statusMessage) {
    switch (responseCode) {
      case 400:
        return ErrorMessages.somethingWentWrong;
      case 401:
        return ErrorMessages.invalidUser;
      case 403:
        return ErrorMessages.disabledUser;
      case 404:
        return ErrorMessages.emptyProfile;
      case 412:
        return ErrorMessages.insufficientFunds;
      default:
        return ErrorMessages.unknownError +
            ((statusMessage == null) ? ' ' : (': ' + statusMessage));
    }
  }
}
