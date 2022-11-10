import '../model/miscEventResult.dart';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../../utils/urls.dart';

part 'getMiscEvents.g.dart';

@RestApi(baseUrl: "https://bits-oasis.org/2022/main")
abstract class MiscEventRestClient {
  factory MiscEventRestClient(Dio dio, {String baseUrl}) = _MiscEventRestClient;

  @GET(kMiscEventPath)
  Future<List<MiscEventCategory>> getAllMiscEvents();
}
