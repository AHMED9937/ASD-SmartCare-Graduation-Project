import 'package:asdsmartcare/doctor/my_patients/models/patient_model.dart';
import 'package:asdsmartcare/doctor/my_patients/views/widgets/patient_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('PatientCard displays parent and child information',
      (tester) async {
    final child = Childs(childName: 'Jane Doe', age: '6', gender: 'Female');
    final parent = Parents(
      userName: 'John Doe',
      childs: [child],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PatientCard(
            parent: parent,
            child: child,
            onTap: () {},
          ),
        ),
      ),
    );

    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Jane Doe'), findsOneWidget);
    expect(find.text('Age: 6  •  Gender: Female'), findsOneWidget);
  });

  testWidgets('PatientCard displays multiple children if present',
      (tester) async {
    final child1 = Childs(childName: 'Jane Doe', age: '6', gender: 'Female');
    final child2 = Childs(childName: 'Jack Doe', age: '4', gender: 'Male');
    final parent = Parents(
      userName: 'John Doe',
      childs: [child1, child2],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PatientCard(
            parent: parent,
            child: child1,
            onTap: () {},
          ),
        ),
      ),
    );

    expect(find.text('Jane Doe'), findsOneWidget);
    expect(find.text('Jack Doe'), findsNothing);
  });

  testWidgets('PatientCard calls onTap when pressed', (tester) async {
    bool tapped = false;
    final child = Childs(childName: 'Jane', age: '5', gender: 'F');
    final parent = Parents(
      userName: 'John Doe',
      childs: [child],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PatientCard(
            parent: parent,
            child: child,
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(PatientCard));
    expect(tapped, isTrue);
  });
}
