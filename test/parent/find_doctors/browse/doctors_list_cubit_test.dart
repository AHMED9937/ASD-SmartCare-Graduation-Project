import 'package:asdsmartcare/parent/find_doctors/browse/controllers/doctors_list_cubit.dart';
import 'package:asdsmartcare/parent/find_doctors/browse/controllers/doctors_list_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockResponse extends Mock implements Response {}

void main() {
  late DoctorsListCubit doctorsListCubit;

  setUpAll(() {
    // Basic setup if needed
  });

  setUp(() {
    doctorsListCubit = DoctorsListCubit();
  });

  tearDown(() {
    doctorsListCubit.close();
  });

  test('initial state is GetDoctorsListInitialState', () {
    expect(doctorsListCubit.state, isA<GetDoctorsListInitialState>());
  });

  // Note: Since Diohelper and CacheHelper use static methods,
  // they are harder to test without dependency injection.
  // In a real scenario, we'd refactor to use a repository or inject Dio.
  // For this task, we will focus on the UI state transitions.
}
