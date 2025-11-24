import 'package:asdsmartcare/core/cache/cache_helper.dart';
import 'package:asdsmartcare/doctor/appointments/controllers/appointments_cubit.dart';
import 'package:asdsmartcare/doctor/appointments/controllers/appointments_state.dart';
import 'package:asdsmartcare/doctor/appointments/data/appointments_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_helpers.dart';

class MockAppointmentsRepository extends Mock
    implements DoctorAppointmentsRepository {}

void main() {
  late MockAppointmentsRepository mockRepository;
  late DoctorAppointmentListCubit cubit;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({'id': 'doc1', 'token': 'abc'});
    await CacheHelper.init();
  });

  setUp(() {
    mockRepository = MockAppointmentsRepository();
    cubit = DoctorAppointmentListCubit(repository: mockRepository);
  });

  tearDown(() {
    cubit.close();
  });

  group('DoctorAppointmentListCubit', () {
    test('initial state is correct', () {
      expect(cubit.state, isA<GetDoctorAppointmentListInitialStates>());
    });

    blocTest<DoctorAppointmentListCubit, GetDoctorAppointmentListStates>(
      'emits [Loading, Success] when fetchAppointments succeeds',
      build: () {
        final sampleResponse = MockAppointmentData.sampleResponse;
        when(() => mockRepository.getAppointments(
              doctorId: any(named: 'doctorId'),
              status: any(named: 'status'),
            )).thenAnswer((_) async => sampleResponse);
        return cubit;
      },
      act: (cubit) => cubit.fetchAppointments(status: 'all'),
      expect: () => [
        isA<GetDoctorAppointmentListLoadingStates>(),
        isA<GetDoctorAppointmentListSuccessStates>(),
      ],
      verify: (cubit) {
        expect(cubit.appointments, isNotNull);
        expect(cubit.appointments?.message, equals('Success'));
      },
    );

    blocTest<DoctorAppointmentListCubit, GetDoctorAppointmentListStates>(
      'emits [Loading, Failed] when fetchAppointments throws',
      build: () {
        when(() => mockRepository.getAppointments(
              doctorId: any(named: 'doctorId'),
              status: any(named: 'status'),
            )).thenThrow(Exception('API Error'));
        return cubit;
      },
      act: (cubit) => cubit.fetchAppointments(status: 'all'),
      expect: () => [
        isA<GetDoctorAppointmentListLoadingStates>(),
        isA<GetDoctorAppointmentListFailedStates>(),
      ],
    );
  });
}
