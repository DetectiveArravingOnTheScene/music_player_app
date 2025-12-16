import 'package:dio/dio.dart';

import 'api_provider_strings.dart';

class ApiProvider {
  final Dio _dio = Dio();

  ApiProvider() {
    _dio.options.baseUrl = ApiProviderStrings.apiBaseUrl;
    _dio.options.headers[ApiProviderStrings.acceptHeaderKey] =
        ApiProviderStrings.acceptHeaderBody;
  }

  void setAuthToken(String token) {
    _dio.options.headers[ApiProviderStrings.autorizationHeaderKey] =
        ApiProviderStrings.autorizationHeaderBody(token);
  }

  Future<Response<T>> get<T>({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.get<T>(url, queryParameters: queryParameters);
  }

  Future<Response<TResponse>> post<TPayload, TResponse>({
    required String url,
    TPayload? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.post<TResponse>(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<TResponse>> put<TPayload, TResponse>({
    required String url,
    TPayload? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.put<TResponse>(
      url,
      data: data,
      queryParameters: queryParameters,
    );
  }

  Future<Response<TResponse>> delete<TPayload, TResponse>({
    required String url,
    TPayload? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.delete<TResponse>(
      url,
      data: data,
      queryParameters: queryParameters,
    );
  }
}
