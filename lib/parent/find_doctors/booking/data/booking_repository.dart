import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/core/network/api_constants.dart';
import 'package:asdsmartcare/core/network/dio_factory.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/models/booking_response.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Result Types (sealed classes for type-safe error handling)
// ─────────────────────────────────────────────────────────────────────────────

/// Sealed result type for booking operations.
sealed class BookingResult<T> {
  const BookingResult();
}

/// Successful booking operation result.
final class BookingSuccess<T> extends BookingResult<T> {
  final T data;
  const BookingSuccess(this.data);
}

/// Failed booking operation result.
final class BookingFailure<T> extends BookingResult<T> {
  final String message;
  final BookingErrorType type;
  final int? statusCode;

  const BookingFailure({
    required this.message,
    required this.type,
    this.statusCode,
  });
}

/// Types of booking errors for granular handling.
enum BookingErrorType {
  /// Network connectivity issues
  network,

  /// Server returned an error
  server,

  /// Unauthorized (token expired/invalid)
  unauthorized,

  /// No available slots
  noSlots,

  /// Slot already booked
  slotUnavailable,

  /// Validation error
  validation,

  /// Payment required/failed
  payment,

  /// Unknown error
  unknown,
}

// ─────────────────────────────────────────────────────────────────────────────
// Data Models
// ─────────────────────────────────────────────────────────────────────────────

/// Represents available appointment slots organized by date.
class AvailableSlots {
  final Map<DateTime, List<String>> slotsByDate;

  const AvailableSlots(this.slotsByDate);

  /// Get slots for a specific date.
  List<String> getSlotsForDate(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);
    return List.unmodifiable(slotsByDate[normalized] ?? []);
  }

  /// Get all dates that have available slots.
  Set<DateTime> get availableDates => slotsByDate.keys.toSet();

  /// Check if any slots are available.
  bool get isEmpty => slotsByDate.isEmpty;

  /// Check if slots exist.
  bool get isNotEmpty => slotsByDate.isNotEmpty;
}

/// Request model for booking an appointment.
class BookingRequest {
  final String doctorId;
  final DateTime date;
  final String timeSlot;

  const BookingRequest({
    required this.doctorId,
    required this.date,
    required this.timeSlot,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': DateFormat('yyyy-MM-dd').format(date),
      'day': DateFormat('EEEE').format(date).toLowerCase(),
      'time': timeSlot,
    };
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Repository Interface
// ─────────────────────────────────────────────────────────────────────────────

/// Repository for booking-related API operations.
///
/// Handles:
/// - Fetching available appointment slots
/// - Booking appointments
/// - Canceling bookings
/// - Payment operations
abstract class BookingRepository {
  /// Get available appointment slots for a doctor.
  Future<BookingResult<AvailableSlots>> getAvailableSlots({
    required String doctorId,
    DateTime? date,
  });

  /// Book an appointment with a doctor.
  Future<BookingResult<BookSession>> bookAppointment(BookingRequest request);

  /// Cancel an existing booking.
  Future<BookingResult<void>> cancelBooking(String bookingId);

  /// Generate Stripe payment sheet for a booking.
  Future<BookingResult<StripePaymentData>> generatePaymentSheet(
    String appointmentId,
  );

  /// Process cash payment for a booking.
  Future<BookingResult<void>> processCashPayment({
    required String doctorId,
    String? appointmentId,
  });
}

/// Stripe payment data returned from the server.
class StripePaymentData {
  final String paymentIntent;
  final String? ephemeralKey;
  final String? customerId;
  final String? publishableKey;

  const StripePaymentData({
    required this.paymentIntent,
    this.ephemeralKey,
    this.customerId,
    this.publishableKey,
  });

  factory StripePaymentData.fromJson(Map<String, dynamic> json) {
    // Handle both flat response and nested 'data' field
    final Map<String, dynamic> data =
        json.containsKey('data') ? json['data'] as Map<String, dynamic> : json;

    return StripePaymentData(
      paymentIntent: data['paymentIntent'] as String? ??
          data['client_secret'] as String? ??
          data['payment_intent'] as String? ??
          data['clientSecret'] as String? ??
          '',
      ephemeralKey: data['ephemeralKey'] as String? ??
          data['ephemeral_key'] as String? ??
          data['ephemeralSecret'] as String? ??
          data['ephemeral_secret'] as String?,
      customerId: data['customer'] as String? ??
          data['customerId'] as String? ??
          data['customer_id'] as String?,
      publishableKey: data['publishableKey'] as String? ??
          data['publishable_key'] as String? ??
          data['publishable_Key'] as String?,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Repository Implementation
// ─────────────────────────────────────────────────────────────────────────────

/// Default implementation of [BookingRepository] using Dio.
class BookingRepositoryImpl implements BookingRepository {
  final Dio _dio;

  BookingRepositoryImpl({Dio? dio}) : _dio = dio ?? DioFactory.instance.dio;

  String? get _token => CacheHelper.getData(key: 'token');

  @override
  Future<BookingResult<AvailableSlots>> getAvailableSlots({
    required String doctorId,
    DateTime? date,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.GetAvailableApoimentForSpacificDoctor(doctorId),
        options: Options(headers: {'Authorization': 'Bearer $_token'}),
      );

      final json = response.data as Map<String, dynamic>;
      final slots = _parseAvailableSlots(json, forDate: date);

      if (slots.isEmpty) {
        return const BookingFailure(
          message: 'No available appointments for this doctor.',
          type: BookingErrorType.noSlots,
        );
      }

      return BookingSuccess(slots);
    } on DioException catch (e) {
      return _mapDioError(e);
    } catch (e) {
      return BookingFailure(
        message: e.toString(),
        type: BookingErrorType.unknown,
      );
    }
  }

  @override
  Future<BookingResult<BookSession>> bookAppointment(
    BookingRequest request,
  ) async {
    try {
      final response = await _dio.post(
        ApiConstants.BookAppointmentForSpecificDoctor(request.doctorId),
        data: request.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $_token'}),
      );

      final session = BookSession.fromJson(response.data);
      return BookingSuccess(session);
    } on DioException catch (e) {
      // Check for slot unavailable error
      if (e.response?.statusCode == 409 ||
          (e.response?.data?['message']
                  ?.toString()
                  .toLowerCase()
                  .contains('unavailable') ??
              false)) {
        return const BookingFailure(
          message:
              'This time slot is no longer available. Please select another.',
          type: BookingErrorType.slotUnavailable,
        );
      }
      return _mapDioError(e);
    } catch (e) {
      return BookingFailure(
        message: e.toString(),
        type: BookingErrorType.unknown,
      );
    }
  }

  @override
  Future<BookingResult<void>> cancelBooking(String bookingId) async {
    try {
      await _dio.get(
        ApiConstants.CancelBooking(bookingId),
        options: Options(headers: {'Authorization': 'Bearer $_token'}),
      );

      return const BookingSuccess(null);
    } on DioException catch (e) {
      return _mapDioError(e);
    } catch (e) {
      return BookingFailure(
        message: e.toString(),
        type: BookingErrorType.unknown,
      );
    }
  }

  @override
  Future<BookingResult<StripePaymentData>> generatePaymentSheet(
    String appointmentId,
  ) async {
    try {
      final response = await _dio.post(
        ApiConstants.genratePaymentSheet(appointmentId),
        data: {
          'appointmentId': appointmentId,
          'appointment_id': appointmentId,
          'id': appointmentId,
        },
        options: Options(headers: {'Authorization': 'Bearer $_token'}),
      );

      if (response.statusCode != 200) {
        final serverMessage =
            (response.data is Map) ? response.data['message'] : null;
        return BookingFailure(
          message: serverMessage ?? 'Failed to generate payment sheet.',
          type: BookingErrorType.payment,
          statusCode: response.statusCode,
        );
      }

      final data = StripePaymentData.fromJson(response.data);

      // Robustness check
      if (data.paymentIntent.isEmpty) {
        return const BookingFailure(
          message: 'Invalid payment data received from server.',
          type: BookingErrorType.payment,
        );
      }

      return BookingSuccess(data);
    } on DioException catch (e) {
      return _mapDioError(e);
    } catch (e) {
      return BookingFailure(
        message: e.toString(),
        type: BookingErrorType.payment,
      );
    }
  }

  @override
  Future<BookingResult<void>> processCashPayment({
    required String doctorId,
    String? appointmentId,
  }) async {
    try {
      await _dio.post(
        ApiConstants.CreateSessionCashOrder,
        data: {
          'doctor': doctorId,
          'doctorId': doctorId, // Some endpoints use snake_case or camelCase
          if (appointmentId != null) 'appointment': appointmentId,
          if (appointmentId != null) 'session': appointmentId,
        },
        options: Options(headers: {'Authorization': 'Bearer $_token'}),
      );

      return const BookingSuccess(null);
    } on DioException catch (e) {
      return _mapDioError(e);
    } catch (e) {
      return BookingFailure(
        message: e.toString(),
        type: BookingErrorType.payment,
      );
    }
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Private Helpers
  // ─────────────────────────────────────────────────────────────────────────────

  /// Parse available slots from API response.
  AvailableSlots _parseAvailableSlots(
    Map<String, dynamic> json, {
    DateTime? forDate,
  }) {
    final Map<DateTime, List<String>> slotsMap = {};
    final raw = json['data'] as List<dynamic>? ?? [];

    if (raw.isEmpty) {
      return const AvailableSlots({});
    }

    // Case A: Simple list of time strings ["5:00 AM", "6:00 AM", ...]
    if (raw.first is String) {
      final times = raw.cast<String>();
      final date = forDate ?? DateTime.now();
      final normalized = DateTime(date.year, date.month, date.day);
      slotsMap[normalized] = times;
      return AvailableSlots(slotsMap);
    }

    // Case B & C: List of objects with date and time fields
    for (final item in raw.cast<Map<String, dynamic>>()) {
      final dateStr = item['date'] as String;
      DateTime parsed;

      try {
        parsed = DateTime.parse(dateStr);
      } catch (_) {
        final parts = dateStr.split('-');
        parsed = DateTime(
          int.parse(parts[0]),
          int.parse(parts[1]),
          int.parse(parts[2]),
        );
      }

      final normalized = DateTime(parsed.year, parsed.month, parsed.day);

      // Handle both List<String> and String time formats
      final timeField = item['time'];
      List<String> slotList;

      if (timeField is List) {
        slotList = timeField.cast<String>();
      } else if (timeField is String) {
        slotList = [timeField];
      } else {
        continue;
      }

      slotsMap.putIfAbsent(normalized, () => []).addAll(slotList);
    }

    return AvailableSlots(slotsMap);
  }

  /// Map Dio exceptions to booking failures.
  BookingFailure<T> _mapDioError<T>(DioException e) {
    final statusCode = e.response?.statusCode;
    final serverMessage = _extractServerMessage(e);

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return BookingFailure(
          message: 'Network error. Please check your connection.',
          type: BookingErrorType.network,
          statusCode: statusCode,
        );

      case DioExceptionType.badResponse:
        if (statusCode == 401) {
          return BookingFailure(
            message: 'Session expired. Please log in again.',
            type: BookingErrorType.unauthorized,
            statusCode: statusCode,
          );
        }
        if (statusCode == 422 || statusCode == 400) {
          return BookingFailure(
            message: serverMessage ?? 'Invalid request. Please try again.',
            type: BookingErrorType.validation,
            statusCode: statusCode,
          );
        }
        return BookingFailure(
          message: serverMessage ?? 'Server error. Please try again later.',
          type: BookingErrorType.server,
          statusCode: statusCode,
        );

      case DioExceptionType.cancel:
        return const BookingFailure(
          message: 'Request cancelled.',
          type: BookingErrorType.unknown,
        );

      default:
        return BookingFailure(
          message: serverMessage ?? 'An unexpected error occurred.',
          type: BookingErrorType.unknown,
          statusCode: statusCode,
        );
    }
  }

  /// Extract error message from server response.
  String? _extractServerMessage(DioException e) {
    try {
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        return data['message'] as String? ??
            data['error'] as String? ??
            data['msg'] as String?;
      }
    } catch (_) {}
    return null;
  }
}
