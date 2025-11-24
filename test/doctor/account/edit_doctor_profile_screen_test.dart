import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/doctor/account/controllers/edit_profile_cubit.dart';
import 'package:asdsmartcare/doctor/account/controllers/edit_profile_state.dart';
import 'package:asdsmartcare/doctor/account/models/doctor_model.dart';
import 'package:asdsmartcare/doctor/account/views/edit_profile_screen.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEditDoctorProfileCubit extends MockCubit<EditDoctorProfileState>
    implements EditDoctorProfileCubit {}

void main() {
  late MockEditDoctorProfileCubit mockCubit;
  late GetLoggedDoctorData mockDoctorData;

  setUp(() {
    mockCubit = MockEditDoctorProfileCubit();
    mockDoctorData = GetLoggedDoctorData(
      data: Doctor(
        id: '1',
        parent: Parent(
          userName: 'Dr. Smith',
          age: 40,
          email: 'smith@doc.com',
          address: 'Clinic A',
        ),
      ),
    );

    when(() => mockCubit.nameCtrl)
        .thenReturn(TextEditingController(text: 'Dr. Smith'));
    when(() => mockCubit.ageCtrl).thenReturn(TextEditingController(text: '40'));
    when(() => mockCubit.addressCtrl)
        .thenReturn(TextEditingController(text: 'Clinic A'));
    when(() => mockCubit.departmentCtrl)
        .thenReturn(TextEditingController(text: 'Pediatrician'));
    when(() => mockCubit.qualificationsCtrl)
        .thenReturn(TextEditingController(text: 'MD'));
    when(() => mockCubit.sessionPriceCtrl)
        .thenReturn(TextEditingController(text: '100'));
    when(() => mockCubit.formKey).thenReturn(GlobalKey<FormState>());
    when(() => mockCubit.pickedImage).thenReturn(null);
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: EditDoctorProfileScreen(
        doctorData: mockDoctorData,
        cubit: mockCubit,
      ),
    );
  }

  group('EditDoctorProfileScreen', () {
    testWidgets('renders professional fields correctly', (tester) async {
      when(() => mockCubit.state).thenReturn(EditDoctorProfileInitialState());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Professional Profile'), findsOneWidget);
      expect(
          find.widgetWithText(TextFormField, 'Specialization'), findsOneWidget);
      expect(
          find.widgetWithText(TextFormField, 'Qualifications'), findsOneWidget);
      expect(find.byType(EditableProfileAvatar), findsOneWidget);
      expect(find.byType(AppButton), findsOneWidget);
    });
  });
}
