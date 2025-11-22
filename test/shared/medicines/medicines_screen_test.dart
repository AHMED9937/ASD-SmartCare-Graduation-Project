import 'dart:io';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/shared/medicines/controllers/medicines_cubit.dart';
import 'package:asdsmartcare/shared/medicines/controllers/medicines_state.dart';
import 'package:asdsmartcare/shared/medicines/models/medicine_model.dart';
import 'package:asdsmartcare/shared/medicines/views/medicines_screen.dart';
import 'package:asdsmartcare/shared/medicines/views/widgets/medicine_card.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMedicinesCubit extends MockCubit<AvailableMedicineState>
    implements AvailableMedicineCubit {}

class TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

void main() {
  HttpOverrides.global = TestHttpOverrides();
  late MockMedicinesCubit mockCubit;

  setUp(() {
    mockCubit = MockMedicinesCubit();
    when(() => mockCubit.getAvailableMedicine()).thenReturn(null);
    when(() => mockCubit.searchMedicine(any())).thenReturn(null);
  });

  Widget createWidget() {
    return MaterialApp(
      home: Availablemedicinescreen(cubit: mockCubit),
    );
  }

  group('Medicines Screen Tests', () {
    testWidgets('renders LoadingView when state is loading', (tester) async {
      when(() => mockCubit.state).thenReturn(GetAvailableMedicineLoading());

      await tester.pumpWidget(createWidget());
      expect(find.byType(LoadingView), findsOneWidget);
    });

    testWidgets('renders EmptyView when no items found', (tester) async {
      when(() => mockCubit.state).thenReturn(GetAvailableMedicineSuccess(null));
      when(() => mockCubit.items).thenReturn([]);

      await tester.pumpWidget(createWidget());
      expect(find.byType(EmptyView), findsOneWidget);
    });

    testWidgets('renders MedicineCards on Success', (tester) async {
      final mockData = [
        MedicineData(
          id: '1',
          medicanName: 'Medicine A',
          medicanInfo: 'Info A',
          medicanImage: '',
          pharmacy:
              Pharmacy(id: 'p1', name: 'Pharm A', location: 'Loc A', phone: ''),
        ),
      ];

      when(() => mockCubit.state).thenReturn(GetAvailableMedicineSuccess(null));
      when(() => mockCubit.items).thenReturn(mockData);

      await tester.pumpWidget(createWidget());

      expect(find.text('Medicine A'), findsOneWidget);
      expect(find.byType(MedicineCard), findsOneWidget);
    });

    testWidgets('renders ErrorView on failure', (tester) async {
      when(() => mockCubit.state)
          .thenReturn(GetAvailableMedicineError('Error occurred'));

      await tester.pumpWidget(createWidget());
      expect(find.byType(ErrorView), findsOneWidget);
      expect(find.text('Error occurred'), findsOneWidget);
    });
  });
}
