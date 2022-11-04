import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../../utils/urls.dart';
import '../model/roundData.dart';
import '../model/sportData.dart';

part 'getAllMatches.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class MatchesRestClient {
  factory MatchesRestClient(Dio dio, {String baseUrl}) = _MatchesRestClient;

  @GET(kRoundsPath)
  Future<List<RoundData>> getAllMatches(@Header("Authorization") String JWT);

  @GET(kSportsPath)
  Future<List<SportsData>> getAllSports(@Header("Authorization") String JWT);
}
