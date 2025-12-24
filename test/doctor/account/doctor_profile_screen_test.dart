import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/doctor/account/controllers/doctor_profile_cubit.dart';
import 'package:asdsmartcare/doctor/account/controllers/doctor_profile_state.dart';
import 'package:asdsmartcare/doctor/account/views/profile_screen.dart';
import 'package:asdsmartcare/doctor/account/models/doctor_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDoctorProfileCubit extends MockCubit<GetDoctorDataStates>
    implements GetDoctorDataCubit {}

void main() {
  late MockDoctorProfileCubit mockProfileCubit;

  setUp(() {
    mockProfileCubit = MockDoctorProfileCubit();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<GetDoctorDataCubit>.value(value: mockProfileCubit),
        ],
        child: const DoctorProfileScreen(),
      ),
    );
  }

  group('DoctorProfileScreen', () {
    testWidgets('displays LoadingView when state is GetDoctorDataLoadingStates',
        (tester) async {
      when(() => mockProfileCubit.state)
          .thenReturn(GetDoctorDataLoadingStates());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(LoadingView), findsOneWidget);
    });

    testWidgets('displays Stat Bar and Details in Success state',
        (tester) async {
      final mockData = GetLoggedDoctorData(
        data: Doctor(
          id: '1',
          parent:
              Parent(userName: 'Dr. Smith', age: 40, email: 'smith@doc.com'),
          speciailization: 'Pediatrician',
          ratingsAverage: 4,
          sessionPrice: 100,
          qualifications: 'MD, PhD',
          medicalLicense: 'url://license',
        ),
      );

      when(() => mockProfileCubit.state)
          .thenReturn(GetDoctorDataSuccsessStates());
      when(() => mockProfileCubit.Cur_Doctor).thenReturn(mockData);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Dr. Smith'), findsOneWidget);
      expect(find.text('Pediatrician'), findsOneWidget);
      expect(find.byType(StatItem), findsNWidgets(3));
      expect(find.text('100 \$'), findsOneWidget);
    });
  });
}
