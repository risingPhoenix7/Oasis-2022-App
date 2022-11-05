// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getPaytm.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _PaytmRestClient implements PaytmRestClient {
  _PaytmRestClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://bits-oasis.org/2022/main';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<PaytmResult> getPaytm(
    JWT,
    paytmAmountData,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': JWT};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(paytmAmountData.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<PaytmResult>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/wallet/monetary/get_paytm_checksum',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PaytmResult.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
