import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:asdsmartcare/shared/auth/login/controllers/login_state.dart';
import 'package:asdsmartcare/shared/auth/login/models/login_doctor_response.dart';
import 'package:asdsmartcare/shared/auth/login/models/login_parent_response.dart';

/// Cubit for managing login state and orchestrating auth flow.
///
/// Responsibilities:
/// - Handle login API calls
/// - Parse response based on user role (parent/doctor)
/// - Emit appropriate states (loading, success, error)
///
/// Usage:
/// ```dart
/// BlocProvider(
///   create: (_) => UserLoginCubit(),
///   child: BlocConsumer<UserLoginCubit, UserLoginState>(
///     listener: (context, state) {
///       if (state is LoginSuccess) { /* navigate */ }
///       if (state is LoginError) { /* show error */ }
///     },
///     builder: (context, state) {
///       if (state is LoginLoading) { /* show loading */ }
///       return LoginForm();
///     },
///   ),
/// )
/// ```
class UserLoginCubit extends Cubit<UserLoginState> {
  UserLoginCubit() : super(LoginInitial());

  /// Static accessor for BlocProvider.of pattern.
  ///
  /// @deprecated Prefer using `context.read<UserLoginCubit>()`.
  static UserLoginCubit get(dynamic context) => BlocProvider.of(context);

  /// Request timeout duration
  static const Duration _requestTimeout = Duration(seconds: 30);

  /// Perform login with email and password.
  ///
  /// Emits:
  /// - [LoginLoading] immediately
  /// - [LoginSuccess] with user model on success
  /// - [LoginError] with error message on failure
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());

    try {
      final response = await Diohelper.postData(
        url: ApiConstants.login,
        data: {
          'email': email,
          'password': password,
        },
      ).timeout(
        _requestTimeout,
        onTimeout: () => throw Exception('Login request timed out'),
      );

      final data = response.data;
      if (data == null) {
        emit(LoginError('Invalid response from server'));
        return;
      }

      // Determine user type from cached role or response
      final cachedRole = CacheHelper.getData(key: 'role');
      final responseRole = data['data']?['role'] as String?;
      final role = responseRole ?? cachedRole;

      if (role == 'parent') {
        final parentModel = LoginParentModel.fromJson(data);
        emit(LoginSuccess(parentModel));
      } else {
        final doctorModel = LoginDoctorModel.fromJson(data);
        emit(LoginSuccess(doctorModel));
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint('Login failed: $e');
        debugPrint('Stack trace: $stackTrace');
      }

      String errorMessage;
      if (e.toString().contains('timed out')) {
        errorMessage = 'Connection timed out. Please try again.';
      } else if (e.toString().contains('SocketException') ||
          e.toString().contains('Network')) {
        errorMessage = 'No internet connection. Please check your network.';
      } else if (e.toString().contains('401') ||
          e.toString().contains('unauthorized')) {
        errorMessage = 'Invalid email or password.';
      } else {
        errorMessage = 'Login failed. Please try again.';
      }

      emit(LoginError(errorMessage));
    }
  }

  /// Reset to initial state.
  void reset() {
    emit(LoginInitial());
  }
}
