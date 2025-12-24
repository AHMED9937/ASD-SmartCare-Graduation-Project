import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/account/controllers/edit_profile_cubit.dart';
import 'package:asdsmartcare/parent/account/controllers/edit_profile_state.dart';
import 'package:asdsmartcare/parent/account/models/parent_model.dart';
import 'package:asdsmartcare/parent/account/views/edit_profile_screen.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEditParentProfileCubit extends MockCubit<EditParentProfileState>
    implements EditParentProfileCubit {}

void main() {
  late MockEditParentProfileCubit mockCubit;
  late GetLoggedParentData mockParentData;

  setUp(() {
    mockCubit = MockEditParentProfileCubit();
    mockParentData = GetLoggedParentData(
      data: Parent(
        id: '1',
        userName: 'John Doe',
        phone: '123456789',
        email: 'john@example.com',
        age: 30,
        address: '123 St',
      ),
    );

    // Default mock behavior
    when(() => mockCubit.nameCtrl)
        .thenReturn(TextEditingController(text: 'John Doe'));
    when(() => mockCubit.phoneCtrl)
        .thenReturn(TextEditingController(text: '123456789'));
    when(() => mockCubit.emailCtrl)
        .thenReturn(TextEditingController(text: 'john@example.com'));
    when(() => mockCubit.ageCtrl).thenReturn(TextEditingController(text: '30'));
    when(() => mockCubit.addressCtrl)
        .thenReturn(TextEditingController(text: '123 St'));
    when(() => mockCubit.pickedImage).thenReturn(null);
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: EditParentProfileScreen(
        parentD: mockParentData,
        cubit: mockCubit,
      ),
    );
  }

  group('EditParentProfileScreen', () {
    testWidgets('renders all fields and sections', (tester) async {
      when(() => mockCubit.state).thenReturn(EditParentProfileInitialState());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Edit Profile'), findsOneWidget);
      expect(find.text('Personal Information'), findsOneWidget);
      expect(find.text('Contact Details'), findsOneWidget);

      expect(find.byType(EditableProfileAvatar), findsOneWidget);
      expect(find.byType(AppButton), findsOneWidget);
    });

    testWidgets('shows loading state on Save Changes button', (tester) async {
      when(() => mockCubit.state).thenReturn(EditParentProfileLoadingState());

      await tester.pumpWidget(createWidgetUnderTest());

      final saveButton = find.byType(AppButton);
      expect(saveButton, findsOneWidget);
      final appButton = tester.widget<AppButton>(saveButton);
      expect(appButton.isLoading, isTrue);
    });
  });
}
