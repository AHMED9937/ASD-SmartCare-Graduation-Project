import 'package:dio/dio.dart';

import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/core/network/dio_factory.dart';
import 'package:asdsmartcare/shared/auth/login/models/login_doctor_response.dart';
import 'package:asdsmartcare/shared/auth/login/models/login_parent_response.dart';

/// Result type for auth operations.
sealed class AuthResult<T> {}

/// Successful auth result with data.
class AuthSuccess<T> extends AuthResult<T> {
  final T data;
  AuthSuccess(this.data);
}

/// Failed auth result with error message.
class AuthFailure<T> extends AuthResult<T> {
  final String message;
  final int? statusCode;
  AuthFailure(this.message, {this.statusCode});
}

/// Repository for handling authentication-related API calls.
///
/// Responsibilities:
/// - Login/logout API calls
/// - Token management coordination
/// - Error mapping for auth endpoints
///
/// Usage:
/// ```dart
/// final repo = AuthRepository();
/// final result = await repo.login(email: 'user@example.com', password: '123');
/// switch (result) {
///   case AuthSuccess(:final data):
///     // Handle success
///   case AuthFailure(:final message):
///     // Handle error
/// }
/// ```
class AuthRepository {
  final Dio _dio;

  /// Creates an [AuthRepository] with default Dio instance.
  AuthRepository() : _dio = DioFactory.instance.dio;

  /// Creates an [AuthRepository] with custom Dio instance (for testing).
  AuthRepository.withDio(this._dio);

  /// Perform login with email and password.
  ///
  /// Returns [AuthSuccess] with user model on success.
  /// Returns [AuthFailure] with error message on failure.
  Future<AuthResult<dynamic>> login({
    required String email,
    required String password,
    String? role,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      final data = response.data;
      if (data == null) {
        return AuthFailure('Invalid response from server');
      }

      // Determine user type from response or provided role
      final responseRole = data['data']?['role'] as String?;
      final userRole = responseRole ?? role;

      if (userRole == 'parent') {
        return AuthSuccess(LoginParentModel.fromJson(data));
      } else {
        return AuthSuccess(LoginDoctorModel.fromJson(data));
      }
    } on DioException catch (e) {
      return AuthFailure(
        _mapDioError(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return AuthFailure('An unexpected error occurred: ${e.toString()}');
    }
  }

  /// Request password reset email.
  Future<AuthResult<void>> requestPasswordReset({
    required String email,
  }) async {
    try {
      await _dio.post(
        ApiConstants.forgotPasswordEmail,
        data: {'email': email},
      );

      return AuthSuccess(null);
    } on DioException catch (e) {
      return AuthFailure(
        _mapDioError(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return AuthFailure('An unexpected error occurred.');
    }
  }

  /// Reset password with new password.
  Future<AuthResult<void>> resetPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      await _dio.post(
        ApiConstants.ResetPassword,
        data: {
          'email': email,
          'password': newPassword,
          'confirmPassword': confirmPassword,
        },
      );

      return AuthSuccess(null);
    } on DioException catch (e) {
      return AuthFailure(
        _mapDioError(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return AuthFailure('An unexpected error occurred.');
    }
  }

  /// Map Dio errors to user-friendly messages.
  String _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out. Please try again.';

      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        switch (statusCode) {
          case 400:
            return 'Invalid request. Please check your input.';
          case 401:
            return 'Invalid email or password.';
          case 403:
            return 'Access denied. Please contact support.';
          case 404:
            return 'Account not found.';
          case 422:
            // Try to extract validation message
            final data = e.response?.data;
            if (data is Map && data['message'] != null) {
              return data['message'].toString();
            }
            return 'Invalid input. Please check your details.';
          case 429:
            return 'Too many attempts. Please try again later.';
          case 500:
          case 502:
          case 503:
            return 'Server error. Please try again later.';
          default:
            return 'Something went wrong. Please try again.';
        }

      case DioExceptionType.cancel:
        return 'Request was cancelled.';

      case DioExceptionType.badCertificate:
        return 'Security error. Please contact support.';

      case DioExceptionType.unknown:
        if (e.error?.toString().contains('SocketException') == true) {
          return 'No internet connection. Please check your network.';
        }
        return 'An unexpected error occurred.';
    }
  }
}
