import 'package:dio/dio.dart';

import 'api_provider_consts.dart';

class ApiProvider {
  final Dio _dio = Dio();

  ApiProvider() {
    _dio.options.baseUrl = ApiProviderConsts.apiBaseUrl;
    _dio.options.headers[ApiProviderConsts.acceptHeaderKey] =
        ApiProviderConsts.acceptHeaderBody;
  }

  void addHeaders(Map<String, String> headers) {
    _dio.options.headers = <String, dynamic>{
      ..._dio.options.headers,
      ...headers,
    };
  }

  void setTokenRefresher(Future<String> Function() refresher) {
    _dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          if (error.response?.statusCode == 401) {
            try {
              final String newToken = await refresher();

              error.requestOptions.headers[ApiProviderConsts
                      .autorizationHeaderKey] =
                  ApiProviderConsts.autorizationHeaderBody(newToken);

              final Response<dynamic> response = await _dio.fetch(
                error.requestOptions,
              );

              return handler.resolve(response);
            } catch (e) {
              return handler.next(error);
            }
          }

          // Pass non-401 errors along as usual
          return handler.next(error);
        },
      ),
    );
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
