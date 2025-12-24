import 'package:asdsmartcare/parent/find_doctors/booking/data/booking_repository.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/models/booking_response.dart';

// Re-export repository types used in states for convenience
export 'package:asdsmartcare/parent/find_doctors/booking/data/booking_repository.dart'
    show AvailableSlots, BookingErrorType, StripePaymentData;

// ─────────────────────────────────────────────────────────────────────────────
// Booking States (sealed class hierarchy)
// ─────────────────────────────────────────────────────────────────────────────

/// Base state for the booking flow.
sealed class BookingState {
  const BookingState();
}

/// Initial state before any action.
final class BookingInitial extends BookingState {
  const BookingInitial();
}

// ─────────────────────────────────────────────────────────────────────────────
// Slots Loading States
// ─────────────────────────────────────────────────────────────────────────────

/// Loading available slots.
final class SlotsLoading extends BookingState {
  const SlotsLoading();
}

/// Successfully loaded available slots.
final class SlotsLoaded extends BookingState {
  final AvailableSlots slots;
  const SlotsLoaded(this.slots);
}

/// Failed to load available slots.
final class SlotsError extends BookingState {
  final String message;
  final BookingErrorType errorType;

  const SlotsError({
    required this.message,
    this.errorType = BookingErrorType.unknown,
  });
}

/// No slots available for the doctor.
final class NoSlotsAvailable extends BookingState {
  const NoSlotsAvailable();
}

// ─────────────────────────────────────────────────────────────────────────────
// Booking Operation States
// ─────────────────────────────────────────────────────────────────────────────

/// Creating a booking.
final class BookingInProgress extends BookingState {
  /// Current available slots (preserved for UI display).
  final AvailableSlots slots;

  const BookingInProgress(this.slots);
}

/// Booking created successfully.
final class BookingComplete extends BookingState {
  final BookSession session;

  const BookingComplete(this.session);
}

/// Booking failed.
final class BookingError extends BookingState {
  final String message;
  final BookingErrorType errorType;

  /// Preserve slots so user can retry with different selection.
  final AvailableSlots? slots;

  const BookingError({
    required this.message,
    this.errorType = BookingErrorType.unknown,
    this.slots,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// Cancel Booking States
// ─────────────────────────────────────────────────────────────────────────────

/// Canceling a booking.
final class CancelInProgress extends BookingState {
  const CancelInProgress();
}

/// Booking canceled successfully.
final class CancelComplete extends BookingState {
  const CancelComplete();
}

/// Booking cancellation failed.
final class CancelError extends BookingState {
  final String message;
  const CancelError(this.message);
}

// ─────────────────────────────────────────────────────────────────────────────
// Payment States
// ─────────────────────────────────────────────────────────────────────────────

/// Generating payment sheet.
final class PaymentLoading extends BookingState {
  const PaymentLoading();
}

/// Payment sheet ready for presentation.
final class PaymentReady extends BookingState {
  final StripePaymentData paymentData;
  const PaymentReady(this.paymentData);
}

/// Payment completed successfully.
final class PaymentComplete extends BookingState {
  const PaymentComplete();
}

/// Payment failed.
final class PaymentError extends BookingState {
  final String message;
  const PaymentError(this.message);
}

// ─────────────────────────────────────────────────────────────────────────────
// Legacy State Aliases (for backward compatibility)
// ─────────────────────────────────────────────────────────────────────────────

/// @deprecated Use [SlotsLoading] instead.
typedef LoadeDoctorAvailableDatesLoading = SlotsLoading;

/// @deprecated Use [SlotsLoaded] instead.
typedef LoadeDoctorAvailableDatesSuccess = SlotsLoaded;

/// @deprecated Use [SlotsError] instead.
typedef LoadeDoctorAvailableDatesError = SlotsError;

/// @deprecated Use [BookingInProgress] instead.
typedef BookingLoading = BookingInProgress;

/// @deprecated Use [BookingComplete] instead.
typedef BookingSuccess = BookingComplete;

/// @deprecated Use [CancelInProgress] instead.
typedef CancelBookingLoading = CancelInProgress;

/// @deprecated Use [CancelComplete] instead.
typedef CancelBookingSuccess = CancelComplete;

/// @deprecated Use [CancelError] instead.
typedef CancelBookingError = CancelError;

/// @deprecated Use [PaymentLoading] instead.
typedef GenrateSPSLoading = PaymentLoading;

/// @deprecated Use [PaymentComplete] instead.
typedef GenrateSPSSuccess = PaymentComplete;

/// @deprecated Use [PaymentError] instead.
typedef GenrateSPSError = PaymentError;

/// @deprecated Use [PaymentLoading] instead.
typedef GenrateCSCOLoading = PaymentLoading;

/// @deprecated Use [PaymentComplete] instead.
typedef GenrateCSCOsuccess = PaymentComplete;

/// @deprecated Use [PaymentError] instead.
typedef GenrateCSCOError = PaymentError;
