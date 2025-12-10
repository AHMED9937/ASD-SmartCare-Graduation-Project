import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:asdsmartcare/parent/find_doctors/booking/data/booking_repository.dart'
    as repo;
import 'package:asdsmartcare/parent/find_doctors/booking/controllers/booking_state.dart';

/// Cubit for managing the booking flow.
///
/// Handles:
/// - Loading available appointment slots
/// - Creating bookings
/// - Canceling bookings
/// - Payment processing (Stripe and cash)
class BookingCubit extends Cubit<BookingState> {
  final repo.BookingRepository _repository;

  /// Current available slots (cached for UI access).
  repo.AvailableSlots? _currentSlots;

  BookingCubit({repo.BookingRepository? repository})
    : _repository = repository ?? repo.BookingRepositoryImpl(),
      super(const BookingInitial()) {
    debugPrint('onCreate -- BookingCubit');
  }

  static BookingCubit get(BuildContext context) => BlocProvider.of(context);

  /// Get available slots from the current state.
  repo.AvailableSlots? get currentSlots => _currentSlots;

  /// Get selectable dates from current slots.
  Set<DateTime> get selectableDates => _currentSlots?.availableDates ?? {};

  /// Get slots for a specific date.
  List<String> getSlotsForDate(DateTime date) {
    return _currentSlots?.getSlotsForDate(date) ?? [];
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Load Available Slots
  // ─────────────────────────────────────────────────────────────────────────────

  /// Load available appointment slots for a doctor.
  Future<void> loadAvailableSlots(String doctorId, {DateTime? date}) async {
    emit(const SlotsLoading());

    final result = await _repository.getAvailableSlots(
      doctorId: doctorId,
      date: date,
    );

    switch (result) {
      case repo.BookingSuccess<repo.AvailableSlots>(:final data):
        _currentSlots = data;
        if (data.isEmpty) {
          emit(const NoSlotsAvailable());
        } else {
          emit(SlotsLoaded(data));
        }

      case repo.BookingFailure<repo.AvailableSlots>(
        :final message,
        :final type,
      ):
        if (type == repo.BookingErrorType.noSlots) {
          emit(const NoSlotsAvailable());
        } else {
          emit(SlotsError(message: message, errorType: type));
        }
    }
  }

  /// Legacy method name for backward compatibility.
  void getDoctorsAppointments(String doctorId, {DateTime? onDate}) {
    loadAvailableSlots(doctorId, date: onDate);
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Book Appointment
  // ─────────────────────────────────────────────────────────────────────────────

  /// Book an appointment with a doctor.
  Future<void> bookAppointment({
    required String doctorId,
    required DateTime date,
    required String timeSlot,
  }) async {
    final slots = _currentSlots;
    if (slots != null) {
      emit(BookingInProgress(slots));
    }

    final request = repo.BookingRequest(
      doctorId: doctorId,
      date: date,
      timeSlot: timeSlot,
    );

    final result = await _repository.bookAppointment(request);

    switch (result) {
      case repo.BookingSuccess(:final data):
        emit(BookingComplete(data));

      case repo.BookingFailure(:final message, :final type):
        emit(
          BookingError(message: message, errorType: type, slots: _currentSlots),
        );
    }
  }

  /// Legacy method name for backward compatibility.
  void bookWithDoctor({
    required String doctorId,
    required DateTime date,
    required String timeSlot,
  }) {
    bookAppointment(doctorId: doctorId, date: date, timeSlot: timeSlot);
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Cancel Booking
  // ─────────────────────────────────────────────────────────────────────────────

  /// Cancel an existing booking.
  Future<void> cancelBooking(String bookingId) async {
    emit(const CancelInProgress());

    final result = await _repository.cancelBooking(bookingId);

    switch (result) {
      case repo.BookingSuccess():
        emit(const CancelComplete());

      case repo.BookingFailure(:final message):
        emit(CancelError(message));
    }
  }

  /// Legacy method name for backward compatibility.
  // ignore: non_constant_identifier_names
  void CancelBooking(String id) => cancelBooking(id);

  // ─────────────────────────────────────────────────────────────────────────────
  // Payment Processing
  // ─────────────────────────────────────────────────────────────────────────────

  /// Generate and present Stripe payment sheet.
  Future<void> processStripePayment(String appointmentId) async {
    emit(const PaymentLoading());

    final result = await _repository.generatePaymentSheet(appointmentId);

    switch (result) {
      case repo.BookingSuccess<repo.StripePaymentData>(:final data):
        try {
          // Initialize Stripe if a key is provided by the server
          if (data.publishableKey != null && data.publishableKey!.isNotEmpty) {
            Stripe.publishableKey = data.publishableKey!;
            await Stripe.instance.applySettings();
          }

          // Initialize payment sheet
          await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: data.paymentIntent,
              customerEphemeralKeySecret: data.ephemeralKey,
              customerId: data.customerId,
              merchantDisplayName: 'ASD SmartCare',
              googlePay: const PaymentSheetGooglePay(
                merchantCountryCode: 'EG',
                currencyCode: 'EGP',
                testEnv: true,
              ),
            ),
          );

          // Present payment sheet
          await Stripe.instance.presentPaymentSheet();
          emit(const PaymentComplete());
        } on StripeException catch (e) {
          emit(
            PaymentError(
              e.error.localizedMessage ?? 'Payment failed. Please try again.',
            ),
          );
        } catch (e) {
          emit(PaymentError('An unexpected error occurred: $e'));
        }

      case repo.BookingFailure(:final message):
        emit(PaymentError(message));
    }
  }

  /// Legacy method name for backward compatibility.
  Future<void> generateStripePaymentSheet(String appointmentId) =>
      processStripePayment(appointmentId);

  /// Process a cash payment.
  Future<void> processCashPayment({
    required String doctorId,
    String? appointmentId,
  }) async {
    emit(const PaymentLoading());

    final result = await _repository.processCashPayment(
      doctorId: doctorId,
      appointmentId: appointmentId,
    );

    switch (result) {
      case repo.BookingSuccess():
        emit(const PaymentComplete());

      case repo.BookingFailure(:final message):
        emit(PaymentError(message));
    }
  }

  /// Legacy method name for backward compatibility.
  void cashPayments(String id) => processCashPayment(doctorId: id);

  @override
  Future<void> close() {
    debugPrint('onClose -- BookingCubit');
    return super.close();
  }
}
