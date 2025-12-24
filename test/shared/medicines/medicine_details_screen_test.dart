import 'dart:io';
import 'package:asdsmartcare/shared/medicines/models/medicine_model.dart';
import 'package:asdsmartcare/shared/medicines/views/medicine_details_screen.dart';
import 'package:asdsmartcare/shared/medicines/views/widgets/pharmacy_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

void main() {
  HttpOverrides.global = TestHttpOverrides();

  final mockMedicine = MedicineData(
    id: '1',
    medicanName: 'Panadol',
    medicanInfo: 'Used for pain relief and fever.',
    medicanImage: '',
    pharmacy: Pharmacy(
      id: 'p1',
      name: 'Care Pharmacy',
      location: 'Downtown Street',
      phone: '123456789',
    ),
  );

  Widget createWidget() {
    return MaterialApp(
      home: MedicenInfo(medicen: mockMedicine),
    );
  }

  group('Medicine Details Screen Tests', () {
    testWidgets('renders all medicine information correctly', (tester) async {
      await tester.pumpWidget(createWidget());

      // Check Title
      expect(find.text('Panadol'), findsOneWidget);

      // Check Description
      expect(find.text('Used for pain relief and fever.'), findsOneWidget);

      // Check Section Titles
      expect(find.text('Description'), findsOneWidget);
      expect(find.text('Available At'), findsOneWidget);

      // Check Pharmacy Card
      expect(find.byType(PharmacyCard), findsOneWidget);
      expect(find.text('Care Pharmacy'), findsOneWidget);
      expect(find.text('Downtown Street'), findsOneWidget);
    });

    testWidgets('renders back button that can be tapped', (tester) async {
      await tester.pumpWidget(createWidget());

      final backButton = find.byIcon(Icons.arrow_back_ios_new_rounded);
      expect(backButton, findsOneWidget);

      await tester.tap(backButton);
      await tester.pump();
      // Verifying pop is harder with just pump, but we check existence of interactive element
    });
  });
}
