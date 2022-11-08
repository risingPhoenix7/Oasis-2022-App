import 'package:dio/dio.dart';
import 'package:oasis_2022/screens/kindstore/repository/model/kind_store_catalog_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../utils/urls.dart';

part "kind_store_catalog_retrofit.g.dart";

@RestApi(baseUrl: kBaseUrl)
abstract class KindStoreCatalogRestClient {
  factory KindStoreCatalogRestClient(Dio dio, {String baseUrl}) =
      _KindStoreCatalogRestClient;

  @GET("/kind-store/items")
  Future<KindStoreResult> getKindStoreItems();
}
