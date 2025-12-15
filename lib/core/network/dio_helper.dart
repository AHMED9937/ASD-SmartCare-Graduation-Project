import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:asdsmartcare/core/network/api_constants.dart';

/// Lightweight HTTP helper used across the app.
/// Maintains a single Dio instance with shared configuration and logging.
class Diohelper {
  Diohelper._();

  static late Dio dio;

  /// Initialize Dio with sensible defaults and logging interceptor.
  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.apiBaseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: false,
      ),
    );
  }

  static Map<String, dynamic> _headers(String? token) {
    final headers = <String, dynamic>{
      'Authorization': token != null ? 'Bearer $token' : null,
      'Content-Type': 'application/json',
    };
    headers.removeWhere((_, v) => v == null);
    return headers;
  }

  static Future<Response<dynamic>> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    return dio.get(
      url,
      queryParameters: query,
      options: Options(headers: _headers(token)),
    );
  }

  static Future<Response<dynamic>> postData({
    required String url,
    Map<String, dynamic>? query,
    required dynamic data,
    String? token,
  }) async {
    return dio.post(
      url,
      queryParameters: query,
      data: data,
      options: Options(headers: _headers(token)),
    );
  }

  static Future<Response<dynamic>> putData({
    required String url,
    Map<String, dynamic>? query,
    required dynamic data,
    String? token,
  }) async {
    return dio.put(
      url,
      queryParameters: query,
      data: data,
      options: Options(headers: _headers(token)),
    );
  }

  static Future<Response<dynamic>> deleteData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    return dio.delete(
      url,
      queryParameters: query,
      options: Options(headers: _headers(token)),
    );
  }
}








