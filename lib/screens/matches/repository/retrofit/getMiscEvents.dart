import '/screens/matches/repository/model/miscEventResult.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../../utils/urls.dart';

part 'getMiscEvents.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class MiscEventRestClient {
  factory MiscEventRestClient(Dio dio, {String baseUrl}) = _MiscEventRestClient;

  @GET(kMiscEventPath)
  Future<List<MiscEventData>> getAllMiscEvents(
      @Header("Authorization") String JWT);
}
