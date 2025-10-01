import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/shared/auth/services/auth_session_manager.dart';

/// Factory for creating and configuring Dio instances.
///
/// Features:
/// - Singleton pattern for reuse
/// - Base URL configuration from [ApiConstants]
/// - Auth header injection via interceptor
/// - Dev-only logging
/// - Consistent error mapping
///
/// Usage:
/// ```dart
/// final dio = DioFactory.instance.dio;
/// final response = await dio.get('/endpoint');
/// ```
class DioFactory {
  DioFactory._internal();

  static final DioFactory _instance = DioFactory._internal();

  /// Singleton instance
  static DioFactory get instance => _instance;

  Dio? _dio;

  /// Get the configured Dio instance.
  Dio get dio {
    _dio ??= _createDio();
    return _dio!;
  }

  /// Create and configure a new Dio instance.
  Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.apiBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        contentType: 'application/json',
        responseType: ResponseType.json,
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    // Add auth interceptor
    dio.interceptors.add(_AuthInterceptor());

    // Add logging interceptor (debug mode only)
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: false,
          error: true,
          compact: true,
        ),
      );
    }

    // Add error handling interceptor
    dio.interceptors.add(_ErrorInterceptor());

    return dio;
  }

  /// Reset the Dio instance (useful for logout/token refresh).
  void reset() {
    _dio = null;
  }
}

/// Interceptor to inject auth headers automatically.
class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Get token from cache
    final String? token = CacheHelper.getData(key: 'token');

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // Ensure content type is set
    options.headers['Content-Type'] ??= 'application/json';

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle 401 Unauthorized - token expired/invalid
    if (err.response?.statusCode == 401) {
      debugPrint('⚠️ Auth token expired or invalid');
      // Trigger global session expiry handler
      AuthSessionManager.instance.handleSessionExpired();
    }
    handler.next(err);
  }
}

/// Interceptor for consistent error handling and mapping.
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final errorMessage = _mapDioError(err);
    debugPrint('❌ API Error: $errorMessage');

    // Create a more informative error
    final mappedError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: errorMessage,
      message: errorMessage,
    );

    handler.next(mappedError);
  }

  String _mapDioError(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.sendTimeout:
        return 'Request timeout. Please try again.';
      case DioExceptionType.receiveTimeout:
        return 'Server took too long to respond. Please try again.';
      case DioExceptionType.badCertificate:
        return 'Security certificate error. Please contact support.';
      case DioExceptionType.badResponse:
        return _mapStatusCode(err.response?.statusCode);
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';
      case DioExceptionType.unknown:
        return err.message ?? 'An unexpected error occurred.';
    }
  }

  String _mapStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Session expired. Please log in again.';
      case 403:
        return 'Access denied. You don\'t have permission.';
      case 404:
        return 'Resource not found.';
      case 409:
        return 'Conflict. The resource already exists.';
      case 422:
        return 'Validation error. Please check your input.';
      case 429:
        return 'Too many requests. Please wait and try again.';
      case 500:
        return 'Server error. Please try again later.';
      case 502:
        return 'Bad gateway. Server is temporarily unavailable.';
      case 503:
        return 'Service unavailable. Please try again later.';
      default:
        return 'Server error (code: $statusCode). Please try again.';
    }
  }
}
