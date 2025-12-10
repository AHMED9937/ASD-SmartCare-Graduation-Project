import 'package:asdsmartcare/doctor/sessions/list/controllers/sessions_list_cubit.dart';
import 'package:asdsmartcare/doctor/sessions/list/controllers/sessions_list_state.dart';
import 'package:asdsmartcare/core/network/dio_helper.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late DoctorSessionListCubit cubit;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    Diohelper.dio = mockDio;
    cubit = DoctorSessionListCubit();
  });

  tearDown(() {
    cubit.close();
  });

  group('DoctorSessionListCubit', () {
    test('initial state is correct', () {
      expect(cubit.state, isA<GetDoctorSessionListInitialStates>());
    });

    blocTest<DoctorSessionListCubit, GetDoctorSessionListStates>(
      'emits [Loading, Success] when fetchSessions succeeds',
      build: () {
        when(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
            data: any(named: 'data'),
            cancelToken: any(named: 'cancelToken'),
            onReceiveProgress: any(named: 'onReceiveProgress'),
          ),
        ).thenAnswer(
          (_) async => Response(
            data: {'data': []},
            requestOptions: RequestOptions(path: ''),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.fetchSessions(status: 'upcoming'),
      expect: () => [
        isA<GetDoctorSessionListLoadingStates>(),
        isA<GetDoctorSessionListSuccessStates>(),
      ],
    );

    blocTest<DoctorSessionListCubit, GetDoctorSessionListStates>(
      'emits [Loading, Failed] when fetchSessions fails',
      build: () {
        when(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
            options: any(named: 'options'),
            data: any(named: 'data'),
            cancelToken: any(named: 'cancelToken'),
            onReceiveProgress: any(named: 'onReceiveProgress'),
          ),
        ).thenThrow(DioException(requestOptions: RequestOptions(path: '')));
        return cubit;
      },
      act: (cubit) => cubit.fetchSessions(status: 'upcoming'),
      expect: () => [
        isA<GetDoctorSessionListLoadingStates>(),
        isA<GetDoctorSessionListFailedStates>(),
      ],
    );
  });
}
