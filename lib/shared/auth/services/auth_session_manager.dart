import 'dart:async';

import 'package:flutter/material.dart';

import 'package:asdsmartcare/app/router/app_router.dart';
import 'package:asdsmartcare/core/cache/cache_helper.dart';

/// Global callback type for session expiry events.
typedef SessionExpiredCallback = void Function();

/// Manages auth session state and handles token expiry globally.
///
/// This service:
/// - Tracks auth session validity
/// - Triggers logout on token expiry
/// - Provides global navigation to login screen
///
/// Usage:
/// ```dart
/// // Set up in main.dart:
/// AuthSessionManager.instance.setNavigatorKey(navigatorKey);
/// AuthSessionManager.instance.onSessionExpired = () => showReLoginDialog();
///
/// // Called from Dio interceptor on 401:
/// AuthSessionManager.instance.handleSessionExpired();
/// ```
class AuthSessionManager {
  AuthSessionManager._internal();

  static final AuthSessionManager _instance = AuthSessionManager._internal();

  /// Singleton instance
  static AuthSessionManager get instance => _instance;

  /// Navigator key for global navigation
  GlobalKey<NavigatorState>? _navigatorKey;

  /// Callback when session expires (can be used to show dialog)
  SessionExpiredCallback? onSessionExpired;

  /// Prevent multiple session expired handlers from firing
  bool _isHandlingExpiry = false;

  /// Set the navigator key for global navigation.
  void setNavigatorKey(GlobalKey<NavigatorState> key) {
    _navigatorKey = key;
  }

  /// Handle session expiry (called from Dio interceptor).
  ///
  /// This method:
  /// 1. Clears cached auth data
  /// 2. Resets Dio instance
  /// 3. Triggers callback or navigates to login
  Future<void> handleSessionExpired() async {
    // Prevent multiple triggers
    if (_isHandlingExpiry) return;
    _isHandlingExpiry = true;

    try {
      // Clear all auth-related cached data
      await _clearAuthData();

      // Trigger callback if set
      if (onSessionExpired != null) {
        onSessionExpired!();
      } else {
        // Default: navigate to login
        _navigateToLogin();
      }
    } finally {
      // Reset after a delay to allow UI to update
      Future.delayed(const Duration(seconds: 2), () {
        _isHandlingExpiry = false;
      });
    }
  }

  /// Clear all auth-related cached data.
  Future<void> _clearAuthData() async {
    await CacheHelper.removeData(key: 'token');
    await CacheHelper.removeData(key: 'role');
    await CacheHelper.removeData(key: 'id');
  }

  /// Navigate to login screen, clearing navigation stack.
  void _navigateToLogin() {
    final navigator = _navigatorKey?.currentState;
    if (navigator != null) {
      navigator.pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
    }
  }

  /// Check if user is currently logged in.
  bool get isLoggedIn {
    final token = CacheHelper.getData(key: 'token');
    return token != null && token.toString().isNotEmpty;
  }

  /// Get current user role.
  String? get currentRole {
    return CacheHelper.getData(key: 'role') as String?;
  }

  /// Perform logout (user-initiated).
  Future<void> logout() async {
    await _clearAuthData();
    _navigateToLogin();
  }
}
