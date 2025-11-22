import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:asdsmartcare/shared/auth/data/auth_repository.dart';

// Mock Dio
class MockDio extends Mock implements Dio {}

class FakeRequestOptions extends Fake implements RequestOptions {}

void main() {
  late MockDio mockDio;
  late AuthRepository repository;

  setUpAll(() {
    registerFallbackValue(FakeRequestOptions());
  });

  setUp(() {
    mockDio = MockDio();
    repository = AuthRepository.withDio(mockDio);
  });

  /// Helper to create a Future that completes immediately with the response
  Future<Response<dynamic>> successResponse(Map<String, dynamic> data) {
    return Future.value(Response(
      data: data,
      statusCode: 200,
      requestOptions: RequestOptions(path: '/'),
    ));
  }

  group('AuthRepository', () {
    group('login', () {
      test('returns AuthSuccess with parent model on successful parent login',
          () async {
        // Arrange
        when(() => mockDio.post(
              any(),
              data: any(named: 'data'),
            )).thenAnswer((_) => successResponse({
              'token': 'test_token',
              'data': {
                '_id': '123abc',
                'id': '123abc',
                'role': 'parent',
                'email': 'parent@example.com',
                'userName': 'testparent',
              },
            }));

        // Act
        final result = await repository.login(
          email: 'parent@example.com',
          password: 'password123',
        );

        // Assert
        expect(result, isA<AuthSuccess>());
      });

      test('returns AuthSuccess with doctor model on successful doctor login',
          () async {
        // Arrange
        when(() => mockDio.post(
              any(),
              data: any(named: 'data'),
            )).thenAnswer((_) => successResponse({
              'token': 'test_token',
              'data': {
                '_id': '456def',
                'id': '456def',
                'role': 'doctor',
                'email': 'doctor@example.com',
                'userName': 'testdoctor',
              },
            }));

        // Act
        final result = await repository.login(
          email: 'doctor@example.com',
          password: 'password123',
        );

        // Assert
        expect(result, isA<AuthSuccess>());
      });

      test('returns AuthFailure with 401 error message on invalid credentials',
          () async {
        // Arrange
        final dioError = DioException(
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(path: '/login'),
          ),
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/login'),
        );

        when(() => mockDio.post(
              any(),
              data: any(named: 'data'),
            )).thenThrow(dioError);

        // Act
        final result = await repository.login(
          email: 'test@example.com',
          password: 'wrongpassword',
        );

        // Assert
        expect(result, isA<AuthFailure>());
        final failure = result as AuthFailure;
        expect(failure.message, 'Invalid email or password.');
        expect(failure.statusCode, 401);
      });

      test('returns AuthFailure with 404 error message when account not found',
          () async {
        // Arrange
        final dioError = DioException(
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: '/login'),
          ),
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/login'),
        );

        when(() => mockDio.post(
              any(),
              data: any(named: 'data'),
            )).thenThrow(dioError);

        // Act
        final result = await repository.login(
          email: 'nonexistent@example.com',
          password: 'password123',
        );

        // Assert
        expect(result, isA<AuthFailure>());
        final failure = result as AuthFailure;
        expect(failure.message, 'Account not found.');
        expect(failure.statusCode, 404);
      });

      test('returns AuthFailure on connection timeout', () async {
        // Arrange
        final dioError = DioException(
          type: DioExceptionType.connectionTimeout,
          requestOptions: RequestOptions(path: '/login'),
        );

        when(() => mockDio.post(
              any(),
              data: any(named: 'data'),
            )).thenThrow(dioError);

        // Act
        final result = await repository.login(
          email: 'test@example.com',
          password: 'password123',
        );

        // Assert
        expect(result, isA<AuthFailure>());
        final failure = result as AuthFailure;
        expect(failure.message, contains('timed out'));
      });

      test('returns AuthFailure on connection error (no internet)', () async {
        // Arrange
        final dioError = DioException(
          type: DioExceptionType.connectionError,
          requestOptions: RequestOptions(path: '/login'),
        );

        when(() => mockDio.post(
              any(),
              data: any(named: 'data'),
            )).thenThrow(dioError);

        // Act
        final result = await repository.login(
          email: 'test@example.com',
          password: 'password123',
        );

        // Assert
        expect(result, isA<AuthFailure>());
        final failure = result as AuthFailure;
        expect(failure.message, contains('internet'));
      });

      test('returns AuthFailure on 500 server error', () async {
        // Arrange
        final dioError = DioException(
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: '/login'),
          ),
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/login'),
        );

        when(() => mockDio.post(
              any(),
              data: any(named: 'data'),
            )).thenThrow(dioError);

        // Act
        final result = await repository.login(
          email: 'test@example.com',
          password: 'password123',
        );

        // Assert
        expect(result, isA<AuthFailure>());
        final failure = result as AuthFailure;
        expect(failure.message, contains('Server error'));
        expect(failure.statusCode, 500);
      });

      test('returns AuthFailure on 422 with validation message', () async {
        // Arrange
        final dioError = DioException(
          response: Response(
            statusCode: 422,
            data: {'message': 'Email format is invalid'},
            requestOptions: RequestOptions(path: '/login'),
          ),
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/login'),
        );

        when(() => mockDio.post(
              any(),
              data: any(named: 'data'),
            )).thenThrow(dioError);

        // Act
        final result = await repository.login(
          email: 'invalid-email',
          password: 'password123',
        );

        // Assert
        expect(result, isA<AuthFailure>());
        final failure = result as AuthFailure;
        expect(failure.message, 'Email format is invalid');
      });
    });

    group('requestPasswordReset', () {
      test('returns AuthSuccess on successful password reset request',
          () async {
        // Arrange
        when(() => mockDio.post(
              any(),
              data: any(named: 'data'),
            )).thenAnswer((_) => successResponse({'message': 'Email sent'}));

        // Act
        final result = await repository.requestPasswordReset(
          email: 'test@example.com',
        );

        // Assert
        expect(result, isA<AuthSuccess>());
      });

      test('returns AuthFailure when email not found', () async {
        // Arrange
        final dioError = DioException(
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: '/forgot-password'),
          ),
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/forgot-password'),
        );

        when(() => mockDio.post(
              any(),
              data: any(named: 'data'),
            )).thenThrow(dioError);

        // Act
        final result = await repository.requestPasswordReset(
          email: 'nonexistent@example.com',
        );

        // Assert
        expect(result, isA<AuthFailure>());
      });
    });

    group('resetPassword', () {
      test('returns AuthSuccess on successful password reset', () async {
        // Arrange
        when(() => mockDio.post(
                  any(),
                  data: any(named: 'data'),
                ))
            .thenAnswer((_) =>
                successResponse({'message': 'Password reset successful'}));

        // Act
        final result = await repository.resetPassword(
          email: 'test@example.com',
          newPassword: 'newPassword123',
          confirmPassword: 'newPassword123',
        );

        // Assert
        expect(result, isA<AuthSuccess>());
      });

      test('returns AuthFailure when passwords do not match', () async {
        // Arrange
        final dioError = DioException(
          response: Response(
            statusCode: 422,
            data: {'message': 'Passwords do not match'},
            requestOptions: RequestOptions(path: '/reset-password'),
          ),
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/reset-password'),
        );

        when(() => mockDio.post(
              any(),
              data: any(named: 'data'),
            )).thenThrow(dioError);

        // Act
        final result = await repository.resetPassword(
          email: 'test@example.com',
          newPassword: 'password1',
          confirmPassword: 'password2',
        );

        // Assert
        expect(result, isA<AuthFailure>());
        final failure = result as AuthFailure;
        expect(failure.message, 'Passwords do not match');
      });
    });
  });

  group('AuthResult sealed class', () {
    test('AuthSuccess contains data', () {
      final result = AuthSuccess<String>('test_data');
      expect(result.data, equals('test_data'));
    });

    test('AuthFailure contains message and optional status code', () {
      final result = AuthFailure<String>('Error message', statusCode: 401);
      expect(result.message, equals('Error message'));
      expect(result.statusCode, equals(401));
    });

    test('AuthFailure can have null status code', () {
      final result = AuthFailure<String>('Network error');
      expect(result.message, equals('Network error'));
      expect(result.statusCode, isNull);
    });
  });
}
