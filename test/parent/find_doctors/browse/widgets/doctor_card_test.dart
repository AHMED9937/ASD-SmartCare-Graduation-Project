import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:asdsmartcare/parent/find_doctors/browse/models/doctor_model.dart';
import 'package:asdsmartcare/parent/find_doctors/browse/views/widgets/doctor_card.dart';

void main() {
  group('DoctorCard Tests', () {
    final mockDoctor = Doctor(
      id: '1',
      parent: Parent(userName: 'Dr. Test'),
      speciailization: 'Behavioral Therapist',
      sessionPrice: 450,
      ratingsAverage: 4.8,
      ratingQuantity: 120,
    );

    testWidgets('renders doctor information correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: DoctorCard(doctor: mockDoctor)),
          ),
        ),
      );

      expect(find.text('Dr. Test'), findsOneWidget);
      expect(find.text('Behavioral Therapist'), findsOneWidget);
      expect(find.text('Book'), findsOneWidget);
      expect(find.byType(RichText), findsWidgets);
    });

    testWidgets('displays placeholder when image is null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DoctorCard(doctor: mockDoctor),
          ),
        ),
      );

      expect(find.byType(Icon), findsWidgets);
      expect(find.byIcon(Icons.person_rounded), findsOneWidget);
    });
  });
}
