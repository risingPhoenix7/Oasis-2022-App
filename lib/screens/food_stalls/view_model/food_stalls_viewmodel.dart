import '/screens/food_stalls/repo/model/food_stall_model.dart';
import '/screens/food_stalls/repo/retrofit/get_food_stalls.dart';
import '/utils/error_messages.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';

class FoodStallViewModel {
  static String? error;

  Future<List<FoodStall>> getFoodStalls() async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = FoodStallRestClient(dio);
    List<FoodStall> foodStalls = [];
    error=null;

    foodStalls = await client.getStalls().catchError((Object obj) {
      try {

        final res = (obj as DioError).response;
        error = res?.statusCode.toString();
        if (res?.statusCode == null || res == null) {
          error = ErrorMessages.noInternet;
        } else {
          // error = MiscEventsViewModel.matchesErrorResponse(
          //     res.statusCode, res.statusMessage);
          error = ErrorMessages.unknownError;
        }
      } catch (e) {
        error = ErrorMessages.unknownError;
      }
      if(foodStalls.isEmpty&&error==null){
        print('getting assigned here');
        error=ErrorMessages.stallsAreCurrentlyClosed;
      }
      return foodStalls;
    });
    return foodStalls;
  }
}
