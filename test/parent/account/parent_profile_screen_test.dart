import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/account/controllers/parent_profile_cubit.dart';
import 'package:asdsmartcare/parent/account/controllers/parent_profile_state.dart';
import 'package:asdsmartcare/parent/account/views/profile_screen.dart';
import 'package:asdsmartcare/parent/account/models/parent_model.dart';
import 'package:asdsmartcare/parent/my_children/controllers/children_list_cubit.dart';
import 'package:asdsmartcare/parent/my_children/controllers/children_list_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockParentProfileCubit extends MockCubit<GetParentDataStates>
    implements GetParentDataCubit {}

class MockChildrenListCubit extends MockCubit<ParentChildrenListStates>
    implements ParentChildrenListCubit {}

void main() {
  late MockParentProfileCubit mockProfileCubit;

  setUp(() {
    mockProfileCubit = MockParentProfileCubit();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<GetParentDataCubit>.value(value: mockProfileCubit),
        ],
        child: const ParentProfileScreen(),
      ),
    );
  }

  group('ParentProfileScreen', () {
    testWidgets(
      'displays LoadingView when state is GetParentDataLoadingStates',
      (tester) async {
        when(
          () => mockProfileCubit.state,
        ).thenReturn(GetParentDataLoadingStates());

        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.byType(LoadingView), findsOneWidget);
      },
    );

    testWidgets('displays ErrorView when state is GetParentDataFailedStates', (
      tester,
    ) async {
      when(
        () => mockProfileCubit.state,
      ).thenReturn(GetParentDataFailedStates());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ErrorView), findsOneWidget);
    });

    testWidgets('displays Success state with ParentProfileBody', (
      tester,
    ) async {
      final mockData = GetLoggedParentData(
        data: Parent(
          id: '1',
          userName: 'Test Parent',
          email: 'test@example.com',
          age: 30,
          childs: [],
        ),
      );

      when(
        () => mockProfileCubit.state,
      ).thenReturn(GetParentDataSuccessStates());
      when(() => mockProfileCubit.currentParent).thenReturn(mockData);

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Test Parent'), findsOneWidget);
      expect(find.text('Guardian'), findsOneWidget);
      expect(find.text('Personal Details'), findsOneWidget);
    });
  });
}
