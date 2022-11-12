import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';

import '/provider/user_details_viewmodel.dart';
import '/screens/wallet_screen/Repo/model/add_swd_model.dart';
import '/screens/wallet_screen/Repo/model/balance_model.dart';
import '/screens/wallet_screen/Repo/model/qr_to_id.dart';
import '/screens/wallet_screen/Repo/model/refresh_qr.dart';
import '/screens/wallet_screen/Repo/model/send_money_model.dart';
import '/screens/wallet_screen/Repo/retrofit/balance_retrofit.dart';
import '/screens/wallet_screen/Repo/retrofit/qr_to_id_retrofit.dart';
import '/screens/wallet_screen/Repo/retrofit/refresh_qr_retrofit.dart';
import '/screens/wallet_screen/Repo/retrofit/send_money_retrofit.dart';
import '/screens/wallet_screen/Repo/retrofit/swd_retrofit.dart';
import '/utils/error_messages.dart';

class WalletViewModel {
  static int balance = 0;
  static bool isKindActive = false;
  static int? kindpoints = 0;
  String? jwt = UserDetailsViewModel.userDetails.JWT;
  static String? error;

  Future<String> refreshQrCode(int id) async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    String auth = "JWT $jwt";
    String qr_code;
    final refreshQrRestClient = RefreshQrRestClient(dio);
    try {
      RefreshQrResponseModel refreshQrResponseModel =
          await refreshQrRestClient.refreshQr(auth, RefreshQrPostModel(id: id));
      qr_code = refreshQrResponseModel.qr_code;
    } on DioError catch (e) {
      throw Exception(e.response!.statusCode);
    }
    return qr_code;
  }

  Future<int> getId(String qr_code) async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    String auth = "JWT ${UserDetailsViewModel.userDetails.JWT}";
    int id = -1;
    final qrToIdModelRestClient = QrToIdModelRestClient(dio);
    try {
      QrToIdModel qrToIdModel =
          await qrToIdModelRestClient.getId(auth, qr_code);
      print(qrToIdModel.id);
      id = qrToIdModel.id!;
    } on DioError catch (e) {
      throw Exception(e.response?.statusCode);
    }
    return id;
  }

  Future<void> getBalance() async {
    error = null;
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    String auth = "JWT $jwt";
    final balanceRestClient = BalanceRestClient(dio);
    BalanceModel response = BalanceModel(
        data: BalanceData(
            cash: 0, pg: 0, swd: 0, transfers: 0, kind_active: false, kind_points: 0));
    response = await balanceRestClient.getBalance(auth).then((it) {
      return it;
    }).catchError((Object obj) {
      print('error caught');
      try {
        print('hi');
        final res = (obj as DioError).response;
        error = res?.statusCode.toString();
        if (res?.statusCode == null || res == null) {
          error = ErrorMessages.noInternet;
        } else {
          print('goes here error in wallet');
          error = ErrorMessages.unknownError;
          //TODO: make a handler
        }
      } catch (e) {
        print('goes to unknown error');
        print(e);
        error = ErrorMessages.unknownError;
      }
      return response;
    });
    balance = (response.data?.swd ?? 0) +
        (response.data?.cash ?? 0) +
        (response.data?.transfers ?? 0) +
        (response.data?.pg ?? 0);
    isKindActive = response.data?.kind_active ?? false;
    kindpoints = response.data?.kind_points ?? 0;
// catch (e) {
//   if (e.runtimeType == DioError) {
//     DioError errore = e as DioError;
//     var response = errore.response;
//     if (response == null) {
//       error=ErrorMessages.noInternet;
//       throw Exception("No Connection");
//
//     } else {
//       error=ErrorMessages.unknownError;
//       throw Exception(response.statusCode);
//     }
//   }
// }
  }

  Future<void> addMoney(int amount) async {
    AddSwdPostRequestModel addSwdPostRequestModel =
        AddSwdPostRequestModel(amount: amount);
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    String auth = "JWT $jwt";
    final addMoneyRestClient = AddMoneyRestClient(dio);
    try {
      print('ekjfhwn');
      await addMoneyRestClient.addFromSwd(auth, addSwdPostRequestModel);
      print('ekjfhwnef');
    } catch (e) {
      print('hihello');
      if (e.runtimeType == DioError) {
        DioError error = e as DioError;
        var response = error.response;
        if (response == null) {
          throw Exception("No Connection");
        } else {
          throw Exception(response.statusCode);
        }
      }

      throw Exception("Server error");
    }
  }

  Future<void> sendMoney(int id, int amount) async {
    SendMoneyThroughIdModel sendMoneyThroughIdModel =
        SendMoneyThroughIdModel(id: id, amount: amount);
    final dio = Dio();
    String auth = "JWT $jwt";
    final sendMoneyRestClient = SendMoneyRestClient(dio);
    try {
      await sendMoneyRestClient.postMoneyTransfer(
          sendMoneyThroughIdModel, auth);
    } catch (e) {
      if (e.runtimeType == DioError) {
        DioError error = e as DioError;
        var response = error.response;
        if (response == null) {
          throw Exception("No Connection");
        } else {
          throw Exception(response.statusCode);
        }
      }
    }
    return;
  }
}
