// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postPaytm.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _PostPaytmRestClient implements PostPaytmRestClient {
  _PostPaytmRestClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://bits-oasis.org/2022/main';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<PaytmResponseMessage> postPaytm(
    JWT,
    paytmResponse,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': JWT};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(paytmResponse.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PaytmResponseMessage>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/wallet/monetary/confirm_paytm_payment',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PaytmResponseMessage.fromJson(_result.data!);
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
