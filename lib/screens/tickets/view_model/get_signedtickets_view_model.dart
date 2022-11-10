import 'package:oasis_2022/screens/tickets/repository/model/showsData.dart';

import '/provider/user_details_viewmodel.dart';
import '/utils/error_messages.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';

import '../repository/model/signedTicketsData.dart';
import '../repository/retrofit/getSignedTickets.dart';

class GetSignedTicketsViewModel {
  Future<SignedTickets> retrieveSignedShows() async {
    String? jwt = UserDetailsViewModel.userDetails.JWT;
    String auth = "JWT $jwt";
    final dio = Dio();
    final client = SignedTicketsRestClient(dio);
    SignedTickets signedTickets = SignedTickets();
    try{
      signedTickets = await client.getCurrentTickets(auth);
    } catch (e){
      if (e.runtimeType == DioError) {
        var code = (e as DioError).response?.statusCode;
        var message = (e).response?.statusMessage;
        throw Exception(message);
      } else {
        throw Exception(e);
      }
    }
    return signedTickets;
  }

  int getUsedTickets(int id, SignedTickets signedTickets){
    int usedTickets = 0;
    for(SignedShow i in signedTickets.shows!){
      if(i.id == id){
        usedTickets = i.used_count!;
      }
    }
    return usedTickets;
  }

  int getUnusedTickets(int id, SignedTickets signedTickets){
    int unusedTickets = 0;
    for(SignedShow i in signedTickets.shows!){
      if(i.id == id){
        unusedTickets = i.unused_count!;
      }
    }
    return unusedTickets;
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
