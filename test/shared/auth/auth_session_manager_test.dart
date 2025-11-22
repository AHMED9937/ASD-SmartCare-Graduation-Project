import 'package:flutter_test/flutter_test.dart';

import 'package:asdsmartcare/shared/auth/services/auth_session_manager.dart';

void main() {
  group('AuthSessionManager', () {
    test('is a singleton', () {
      final instance1 = AuthSessionManager.instance;
      final instance2 = AuthSessionManager.instance;

      expect(identical(instance1, instance2), isTrue);
    });

    test('onSessionExpired callback can be set', () {
      var callbackCalled = false;

      AuthSessionManager.instance.onSessionExpired = () {
        callbackCalled = true;
      };

      // Callback should not be called yet
      expect(callbackCalled, isFalse);

      // Note: We can't fully test handleSessionExpired without
      // mocking CacheHelper, but we can verify the callback is settable
      expect(AuthSessionManager.instance.onSessionExpired, isNotNull);
    });

    test('isLoggedIn returns false when no token', () {
      // Without proper CacheHelper mock, this will return false
      // In a real test, we'd mock CacheHelper
      expect(AuthSessionManager.instance.isLoggedIn, isFalse);
    });

    test('currentRole returns null when no role cached', () {
      // Without proper CacheHelper mock, this will return null
      expect(AuthSessionManager.instance.currentRole, isNull);
    });
  });
}
