import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/doctor/my_patients/controllers/patients_list_cubit.dart';
import 'package:asdsmartcare/doctor/my_patients/controllers/patients_list_state.dart';
import 'package:asdsmartcare/doctor/my_patients/views/widgets/session_form.dart';
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
    when(
      () => mockCubit.state,
    ).thenReturn(GetRegisteredChildrenListinitialStates());
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<RegisteredChildrenListCubit>.value(
          value: mockCubit,
          child: const SessionForm(parentId: 'parent_123'),
        ),
      ),
    );
  }

  testWidgets('renders all form fields', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Session Number'), findsOneWidget);
    expect(find.text('Session Date'), findsOneWidget);
    expect(find.text('Status of Session'), findsOneWidget);
    expect(find.text('Comments'), findsOneWidget);
    expect(find.text('Create Session'), findsOneWidget);
  });

  testWidgets('shows validation errors when submitting empty form', (
    tester,
  ) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.text('Create Session'));
    await tester.pump();

    expect(
      find.text('Required'),
      findsNWidgets(2),
    ); // Number, Status (Date is not a TextFormField so it doesn't show 'Required' the same way)
  });

  testWidgets('calls CreateSession when form is valid', (tester) async {
    when(() => mockCubit.CreateSession(any())).thenAnswer((_) async {});

    await tester.pumpWidget(createWidgetUnderTest());

    // Fill Session Number
    await tester.enterText(
      find.widgetWithText(AppTextField, 'Session Number'),
      '1',
    );

    // Select Date
    await tester.tap(find.text('Select Date'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // For Status
    await tester.tap(find.text('Select status'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('done').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Create Session'));

    verify(() => mockCubit.CreateSession(any())).called(1);
  });

  testWidgets('shows success state when session is created', (tester) async {
    whenListen(
      mockCubit,
      Stream.fromIterable([
        GetRegisteredChildrenListinitialStates(),
        CreatSessionLoadingStates(),
        CreatSessionSuccsessStates(),
      ]),
      initialState: GetRegisteredChildrenListinitialStates(),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    // Manually emit success state to test UI response
    when(() => mockCubit.state).thenReturn(CreatSessionSuccsessStates());
    await tester.pump();

    expect(find.text('Session Created!'), findsOneWidget);
    expect(find.text('Create Another'), findsOneWidget);
  });
}
