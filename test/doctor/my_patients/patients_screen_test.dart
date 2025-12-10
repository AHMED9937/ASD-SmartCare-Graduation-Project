import 'package:asdsmartcare/doctor/my_patients/controllers/patients_list_cubit.dart';
import 'package:asdsmartcare/doctor/my_patients/controllers/patients_list_state.dart';
import 'package:asdsmartcare/doctor/my_patients/models/patient_model.dart';
import 'package:asdsmartcare/doctor/my_patients/views/patients_screen.dart';
import 'package:asdsmartcare/doctor/my_patients/views/widgets/patient_card.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRegisteredChildrenListCubit
    extends MockCubit<GetRegisteredChildrenListStates>
    implements RegisteredChildrenListCubit {}

void main() {
  late MockRegisteredChildrenListCubit mockCubit;

  setUp(() {
    mockCubit = MockRegisteredChildrenListCubit();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<RegisteredChildrenListCubit>.value(
        value: mockCubit,
        child: const RegisteredChildrenView(),
      ),
    );
  }

  testWidgets('renders loading indicator when state is loading', (
    tester,
  ) async {
    when(
      () => mockCubit.state,
    ).thenReturn(GetRegisteredChildrenListLoadingStates());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('renders error message when state is failed', (tester) async {
    when(
      () => mockCubit.state,
    ).thenReturn(GetRegisteredChildrenListFailedStates());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Failed to load registered children.'), findsOneWidget);
  });

  testWidgets('renders empty message when no patients found', (tester) async {
    when(
      () => mockCubit.state,
    ).thenReturn(GetRegisteredChildrenListSuccsessStates());
    when(
      () => mockCubit.registeredchildren,
    ).thenReturn(RegisteredChildren(parents: []));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('No patients found'), findsOneWidget);
  });

  testWidgets('renders list of patients when state is success', (tester) async {
    final mockData = RegisteredChildren(
      parents: [
        Parents(
          id: '1',
          userName: 'Parent 1',
          childs: [Childs(childName: 'Child 1', age: '5', gender: 'Male')],
        ),
        Parents(
          id: '2',
          userName: 'Parent 2',
          childs: [Childs(childName: 'Child 2', age: '7', gender: 'Female')],
        ),
      ],
    );

    when(
      () => mockCubit.state,
    ).thenReturn(GetRegisteredChildrenListSuccsessStates());
    when(() => mockCubit.registeredchildren).thenReturn(mockData);

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(PatientCard), findsNWidgets(2));
    expect(find.text('Parent 1'), findsOneWidget);
    expect(find.text('Parent 2'), findsOneWidget);
    expect(find.text('Child 1'), findsOneWidget);
    expect(find.text('Child 2'), findsOneWidget);
  });
}
