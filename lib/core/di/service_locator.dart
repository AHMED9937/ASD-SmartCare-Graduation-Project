import 'package:dio/dio.dart';

import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/dio_factory.dart';

/// Manual dependency injection / service locator.
///
/// Provides centralized access to shared services without heavy DI frameworks.
/// All dependencies are lazily initialized on first access.
///
/// Usage:
/// ```dart
/// final dio = ServiceLocator.instance.dio;
/// final authRepo = ServiceLocator.instance.authRepository;
/// ```
class ServiceLocator {
  ServiceLocator._internal();

  static final ServiceLocator _instance = ServiceLocator._internal();

  /// Singleton instance
  static ServiceLocator get instance => _instance;

  /// Alternative getter for convenience
  static ServiceLocator get I => _instance;

  // ─────────────────────────────────────────────────────────────────────────────
  // Core Services
  // ─────────────────────────────────────────────────────────────────────────────

  /// Dio HTTP client instance
  Dio get dio => DioFactory.instance.dio;

  /// Cache helper for local storage
  CacheHelper get cache => CacheHelper();

  // ─────────────────────────────────────────────────────────────────────────────
  // Repositories (lazy initialized)
  // ─────────────────────────────────────────────────────────────────────────────

  // Auth repository - will be added in Phase 4
  // AuthRepository? _authRepository;
  // AuthRepository get authRepository {
  //   _authRepository ??= AuthRepository(dio: dio);
  //   return _authRepository!;
  // }

  // Booking repository - will be added in Phase 5
  // BookingRepository? _bookingRepository;
  // BookingRepository get bookingRepository {
  //   _bookingRepository ??= BookingRepository(dio: dio);
  //   return _bookingRepository!;
  // }

  // ─────────────────────────────────────────────────────────────────────────────
  // Lifecycle Management
  // ─────────────────────────────────────────────────────────────────────────────

  /// Initialize all required services.
  /// Call this in main() before runApp().
  static Future<void> init() async {
    // CacheHelper is already initialized in main()
    // Add other initialization logic here if needed
  }

  /// Reset all services (useful for logout).
  void reset() {
    DioFactory.instance.reset();
    // _authRepository = null;
    // _bookingRepository = null;
  }

  /// Dispose all services (useful for app termination).
  void dispose() {
    reset();
  }
}

/// Extension for easy access in widgets.
///
/// Usage:
/// ```dart
/// context.services.dio
/// ```
// Can be enabled when needed:
// extension ServiceLocatorContext on BuildContext {
//   ServiceLocator get services => ServiceLocator.instance;
// }
