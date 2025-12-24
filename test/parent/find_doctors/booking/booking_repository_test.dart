import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:asdsmartcare/parent/find_doctors/booking/data/booking_repository.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late BookingRepositoryImpl repository;

  setUp(() {
    mockDio = MockDio();
    repository = BookingRepositoryImpl(dio: mockDio);
  });

  group('BookingRepository.getAvailableSlots', () {
    const doctorId = 'doc-123';

    test('returns success with slots when API returns valid data', () async {
      // Arrange
      when(() => mockDio.get(
            any(),
            options: any(named: 'options'),
          )).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 200,
            data: {
              'data': [
                {
                  'date': '2024-01-15',
                  'time': ['9:00 AM', '10:00 AM']
                },
                {'date': '2024-01-16', 'time': '11:00 AM'},
              ],
            },
          ));

      // Act
      final result = await repository.getAvailableSlots(doctorId: doctorId);

      // Assert
      expect(result, isA<BookingSuccess<AvailableSlots>>());
      final success = result as BookingSuccess<AvailableSlots>;
      expect(success.data.isNotEmpty, isTrue);
      expect(success.data.availableDates.length, equals(2));
    });

    test('returns success with slots for simple time list format', () async {
      // Arrange
      when(() => mockDio.get(
            any(),
            options: any(named: 'options'),
          )).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 200,
            data: {
              'data': ['9:00 AM', '10:00 AM', '11:00 AM'],
            },
          ));

      // Act
      final result = await repository.getAvailableSlots(doctorId: doctorId);

      // Assert
      expect(result, isA<BookingSuccess<AvailableSlots>>());
      final success = result as BookingSuccess<AvailableSlots>;
      expect(success.data.isNotEmpty, isTrue);
    });

    test('returns noSlots failure when no slots available', () async {
      // Arrange
      when(() => mockDio.get(
            any(),
            options: any(named: 'options'),
          )).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 200,
            data: {'data': []},
          ));

      // Act
      final result = await repository.getAvailableSlots(doctorId: doctorId);

      // Assert
      expect(result, isA<BookingFailure<AvailableSlots>>());
      final failure = result as BookingFailure<AvailableSlots>;
      expect(failure.type, equals(BookingErrorType.noSlots));
    });

    test('returns network failure on connection error', () async {
      // Arrange
      when(() => mockDio.get(
            any(),
            options: any(named: 'options'),
          )).thenThrow(DioException(
        type: DioExceptionType.connectionError,
        requestOptions: RequestOptions(path: ''),
      ));

      // Act
      final result = await repository.getAvailableSlots(doctorId: doctorId);

      // Assert
      expect(result, isA<BookingFailure<AvailableSlots>>());
      final failure = result as BookingFailure<AvailableSlots>;
      expect(failure.type, equals(BookingErrorType.network));
    });

    test('returns unauthorized failure on 401', () async {
      // Arrange
      when(() => mockDio.get(
            any(),
            options: any(named: 'options'),
          )).thenThrow(DioException(
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 401,
        ),
        requestOptions: RequestOptions(path: ''),
      ));

      // Act
      final result = await repository.getAvailableSlots(doctorId: doctorId);

      // Assert
      expect(result, isA<BookingFailure<AvailableSlots>>());
      final failure = result as BookingFailure<AvailableSlots>;
      expect(failure.type, equals(BookingErrorType.unauthorized));
      expect(failure.statusCode, equals(401));
    });
  });

  group('BookingRepository.bookAppointment', () {
    final request = BookingRequest(
      doctorId: 'doc-123',
      date: DateTime(2024, 1, 15),
      timeSlot: '9:00 AM',
    );

    test('returns success when booking succeeds', () async {
      // Arrange
      when(() => mockDio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          )).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 201,
            data: {
              'message': 'Booking created',
              'data': {
                '_id': 'booking-123',
                'doctorId': 'doc-123',
                'date': '2024-01-15',
                'day': 'monday',
                'time': '9:00 AM',
                'status': 'pending',
              },
            },
          ));

      // Act
      final result = await repository.bookAppointment(request);

      // Assert
      expect(result, isA<BookingSuccess>());
    });

    test('returns slotUnavailable failure on 409', () async {
      // Arrange
      when(() => mockDio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          )).thenThrow(DioException(
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 409,
          data: {'message': 'Slot unavailable'},
        ),
        requestOptions: RequestOptions(path: ''),
      ));

      // Act
      final result = await repository.bookAppointment(request);

      // Assert
      expect(result, isA<BookingFailure>());
      final failure = result as BookingFailure;
      expect(failure.type, equals(BookingErrorType.slotUnavailable));
    });

    test('returns validation failure on 400', () async {
      // Arrange
      when(() => mockDio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          )).thenThrow(DioException(
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 400,
          data: {'message': 'Invalid date format'},
        ),
        requestOptions: RequestOptions(path: ''),
      ));

      // Act
      final result = await repository.bookAppointment(request);

      // Assert
      expect(result, isA<BookingFailure>());
      final failure = result as BookingFailure;
      expect(failure.type, equals(BookingErrorType.validation));
      expect(failure.message, contains('Invalid date format'));
    });
  });

  group('BookingRepository.cancelBooking', () {
    const bookingId = 'booking-123';

    test('returns success when cancellation succeeds', () async {
      // Arrange
      when(() => mockDio.get(
            any(),
            options: any(named: 'options'),
          )).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 200,
            data: {'message': 'Booking cancelled'},
          ));

      // Act
      final result = await repository.cancelBooking(bookingId);

      // Assert
      expect(result, isA<BookingSuccess<void>>());
    });

    test('returns failure on server error', () async {
      // Arrange
      when(() => mockDio.get(
            any(),
            options: any(named: 'options'),
          )).thenThrow(DioException(
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
          data: {'message': 'Internal server error'},
        ),
        requestOptions: RequestOptions(path: ''),
      ));

      // Act
      final result = await repository.cancelBooking(bookingId);

      // Assert
      expect(result, isA<BookingFailure<void>>());
      final failure = result as BookingFailure<void>;
      expect(failure.type, equals(BookingErrorType.server));
    });
  });

  group('BookingRepository.generatePaymentSheet', () {
    const appointmentId = 'apt-123';

    test('returns success with stripe data when API succeeds', () async {
      // Arrange
      when(() => mockDio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          )).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 200,
            data: {
              'paymentIntent': 'pi_123',
              'ephemeralKey': 'ek_123',
              'customer': 'cus_123',
              'publishableKey': 'pk_test_123',
            },
          ));

      // Act
      final result = await repository.generatePaymentSheet(appointmentId);

      // Assert
      expect(result, isA<BookingSuccess<StripePaymentData>>());
      final success = result as BookingSuccess<StripePaymentData>;
      expect(success.data.paymentIntent, equals('pi_123'));
      expect(success.data.ephemeralKey, equals('ek_123'));
      expect(success.data.customerId, equals('cus_123'));
      expect(success.data.publishableKey, equals('pk_test_123'));
    });

    test('returns payment failure on error', () async {
      // Arrange
      when(() => mockDio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          )).thenThrow(DioException(
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 402,
          data: {'message': 'Payment required'},
        ),
        requestOptions: RequestOptions(path: ''),
      ));

      // Act
      final result = await repository.generatePaymentSheet(appointmentId);

      // Assert
      expect(result, isA<BookingFailure<StripePaymentData>>());
    });
  });

  group('BookingRepository.processCashPayment', () {
    const doctorId = 'doc-123';

    test('returns success when cash payment processed', () async {
      // Arrange
      when(() => mockDio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          )).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 200,
            data: {'message': 'Cash order created'},
          ));

      // Act
      final result = await repository.processCashPayment(doctorId: doctorId);

      // Assert
      expect(result, isA<BookingSuccess<void>>());
    });
  });

  group('BookingRequest', () {
    test('toJson formats date and day correctly', () {
      final request = BookingRequest(
        doctorId: 'doc-123',
        date: DateTime(2024, 1, 15), // Monday
        timeSlot: '9:00 AM',
      );

      final json = request.toJson();

      expect(json['date'], equals('2024-01-15'));
      expect(json['day'], equals('monday'));
      expect(json['time'], equals('9:00 AM'));
    });
  });

  group('AvailableSlots', () {
    test('getSlotsForDate returns slots for existing date', () {
      final slots = AvailableSlots({
        DateTime(2024, 1, 15): ['9:00 AM', '10:00 AM'],
        DateTime(2024, 1, 16): ['11:00 AM'],
      });

      final result = slots.getSlotsForDate(DateTime(2024, 1, 15));

      expect(result, equals(['9:00 AM', '10:00 AM']));
    });

    test('getSlotsForDate returns empty list for non-existing date', () {
      final slots = AvailableSlots({
        DateTime(2024, 1, 15): ['9:00 AM'],
      });

      final result = slots.getSlotsForDate(DateTime(2024, 1, 20));

      expect(result, isEmpty);
    });

    test('availableDates returns all dates with slots', () {
      final slots = AvailableSlots({
        DateTime(2024, 1, 15): ['9:00 AM'],
        DateTime(2024, 1, 16): ['10:00 AM'],
      });

      expect(slots.availableDates.length, equals(2));
    });

    test('isEmpty returns true for empty slots', () {
      const slots = AvailableSlots({});
      expect(slots.isEmpty, isTrue);
      expect(slots.isNotEmpty, isFalse);
    });
  });

  group('StripePaymentData', () {
    test('fromJson parses correctly', () {
      final json = {
        'paymentIntent': 'pi_123',
        'ephemeralKey': 'ek_123',
        'customer': 'cus_123',
        'publishableKey': 'pk_123',
      };

      final data = StripePaymentData.fromJson(json);

      expect(data.paymentIntent, equals('pi_123'));
      expect(data.ephemeralKey, equals('ek_123'));
      expect(data.customerId, equals('cus_123'));
      expect(data.publishableKey, equals('pk_123'));
    });
  });
}
