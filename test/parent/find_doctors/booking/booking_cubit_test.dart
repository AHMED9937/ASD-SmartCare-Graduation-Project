import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:asdsmartcare/parent/find_doctors/booking/controllers/booking_cubit.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/controllers/booking_state.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/data/booking_repository.dart'
    as repo;
import 'package:asdsmartcare/parent/find_doctors/booking/models/booking_response.dart';

class MockBookingRepository extends Mock implements repo.BookingRepository {}

class FakeBookingRequest extends Fake implements repo.BookingRequest {}

void main() {
  late MockBookingRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeBookingRequest());
  });

  setUp(() {
    mockRepository = MockBookingRepository();
  });

  group('BookingCubit', () {
    group('loadAvailableSlots', () {
      blocTest<BookingCubit, BookingState>(
        'emits [SlotsLoading, SlotsLoaded] when slots are available',
        build: () {
          final slots = repo.AvailableSlots({
            DateTime(2024, 1, 15): ['9:00 AM', '10:00 AM'],
          });
          when(
            () => mockRepository.getAvailableSlots(
              doctorId: any(named: 'doctorId'),
              date: any(named: 'date'),
            ),
          ).thenAnswer((_) async => repo.BookingSuccess(slots));
          return BookingCubit(repository: mockRepository);
        },
        act: (cubit) => cubit.loadAvailableSlots('doc-123'),
        expect: () => [isA<SlotsLoading>(), isA<SlotsLoaded>()],
        verify: (_) {
          verify(
            () => mockRepository.getAvailableSlots(
              doctorId: 'doc-123',
              date: null,
            ),
          ).called(1);
        },
      );

      blocTest<BookingCubit, BookingState>(
        'emits [SlotsLoading, NoSlotsAvailable] when no slots available',
        build: () {
          const slots = repo.AvailableSlots({});
          when(
            () => mockRepository.getAvailableSlots(
              doctorId: any(named: 'doctorId'),
              date: any(named: 'date'),
            ),
          ).thenAnswer((_) async => const repo.BookingSuccess(slots));
          return BookingCubit(repository: mockRepository);
        },
        act: (cubit) => cubit.loadAvailableSlots('doc-123'),
        expect: () => [isA<SlotsLoading>(), isA<NoSlotsAvailable>()],
      );

      blocTest<BookingCubit, BookingState>(
        'emits [SlotsLoading, SlotsError] on network failure',
        build: () {
          when(
            () => mockRepository.getAvailableSlots(
              doctorId: any(named: 'doctorId'),
              date: any(named: 'date'),
            ),
          ).thenAnswer(
            (_) async => const repo.BookingFailure(
              message: 'Network error',
              type: repo.BookingErrorType.network,
            ),
          );
          return BookingCubit(repository: mockRepository);
        },
        act: (cubit) => cubit.loadAvailableSlots('doc-123'),
        expect: () => [
          isA<SlotsLoading>(),
          isA<SlotsError>().having(
            (s) => s.errorType,
            'errorType',
            repo.BookingErrorType.network,
          ),
        ],
      );

      blocTest<BookingCubit, BookingState>(
        'emits [SlotsLoading, NoSlotsAvailable] on noSlots failure type',
        build: () {
          when(
            () => mockRepository.getAvailableSlots(
              doctorId: any(named: 'doctorId'),
              date: any(named: 'date'),
            ),
          ).thenAnswer(
            (_) async => const repo.BookingFailure(
              message: 'No slots',
              type: repo.BookingErrorType.noSlots,
            ),
          );
          return BookingCubit(repository: mockRepository);
        },
        act: (cubit) => cubit.loadAvailableSlots('doc-123'),
        expect: () => [isA<SlotsLoading>(), isA<NoSlotsAvailable>()],
      );
    });

    group('bookAppointment', () {
      blocTest<BookingCubit, BookingState>(
        'emits [BookingInProgress, BookingComplete] on successful booking',
        build: () {
          final session = BookSession()
            ..message = 'Booking created'
            ..data = (Data()
              ..sId = 'booking-123'
              ..doctorId = 'doc-123'
              ..date = '2024-01-15'
              ..time = '9:00 AM');

          when(
            () => mockRepository.bookAppointment(any()),
          ).thenAnswer((_) async => repo.BookingSuccess(session));
          return BookingCubit(repository: mockRepository);
        },
        act: (cubit) => cubit.bookAppointment(
          doctorId: 'doc-123',
          date: DateTime(2024, 1, 15),
          timeSlot: '9:00 AM',
        ),
        expect: () => [isA<BookingComplete>()],
      );

      blocTest<BookingCubit, BookingState>(
        'emits [BookingInProgress, BookingError] on slot unavailable',
        build: () {
          when(() => mockRepository.bookAppointment(any())).thenAnswer(
            (_) async => const repo.BookingFailure(
              message: 'Slot unavailable',
              type: repo.BookingErrorType.slotUnavailable,
            ),
          );
          return BookingCubit(repository: mockRepository);
        },
        act: (cubit) => cubit.bookAppointment(
          doctorId: 'doc-123',
          date: DateTime(2024, 1, 15),
          timeSlot: '9:00 AM',
        ),
        expect: () => [
          isA<BookingError>().having(
            (e) => e.errorType,
            'errorType',
            repo.BookingErrorType.slotUnavailable,
          ),
        ],
      );
    });

    group('cancelBooking', () {
      blocTest<BookingCubit, BookingState>(
        'emits [CancelInProgress, CancelComplete] on successful cancel',
        build: () {
          when(
            () => mockRepository.cancelBooking(any()),
          ).thenAnswer((_) async => const repo.BookingSuccess(null));
          return BookingCubit(repository: mockRepository);
        },
        act: (cubit) => cubit.cancelBooking('booking-123'),
        expect: () => [isA<CancelInProgress>(), isA<CancelComplete>()],
      );

      blocTest<BookingCubit, BookingState>(
        'emits [CancelInProgress, CancelError] on failure',
        build: () {
          when(() => mockRepository.cancelBooking(any())).thenAnswer(
            (_) async => const repo.BookingFailure(
              message: 'Server error',
              type: repo.BookingErrorType.server,
            ),
          );
          return BookingCubit(repository: mockRepository);
        },
        act: (cubit) => cubit.cancelBooking('booking-123'),
        expect: () => [isA<CancelInProgress>(), isA<CancelError>()],
      );
    });

    group('processCashPayment', () {
      blocTest<BookingCubit, BookingState>(
        'emits [PaymentLoading, PaymentComplete] on success',
        build: () {
          when(
            () => mockRepository.processCashPayment(
              doctorId: any(named: 'doctorId'),
              appointmentId: any(named: 'appointmentId'),
            ),
          ).thenAnswer((_) async => const repo.BookingSuccess(null));
          return BookingCubit(repository: mockRepository);
        },
        act: (cubit) => cubit.processCashPayment(doctorId: 'doc-123'),
        expect: () => [isA<PaymentLoading>(), isA<PaymentComplete>()],
      );

      blocTest<BookingCubit, BookingState>(
        'emits [PaymentLoading, PaymentError] on failure',
        build: () {
          when(
            () => mockRepository.processCashPayment(
              doctorId: any(named: 'doctorId'),
              appointmentId: any(named: 'appointmentId'),
            ),
          ).thenAnswer(
            (_) async => const repo.BookingFailure(
              message: 'Payment failed',
              type: repo.BookingErrorType.payment,
            ),
          );
          return BookingCubit(repository: mockRepository);
        },
        act: (cubit) => cubit.processCashPayment(doctorId: 'doc-123'),
        expect: () => [isA<PaymentLoading>(), isA<PaymentError>()],
      );
    });

    group('helper methods', () {
      test('selectableDates returns empty set initially', () {
        final cubit = BookingCubit(repository: mockRepository);
        expect(cubit.selectableDates, isEmpty);
      });

      test('getSlotsForDate returns empty list initially', () {
        final cubit = BookingCubit(repository: mockRepository);
        expect(cubit.getSlotsForDate(DateTime.now()), isEmpty);
      });

      test('currentSlots is null initially', () {
        final cubit = BookingCubit(repository: mockRepository);
        expect(cubit.currentSlots, isNull);
      });
    });
  });
}
