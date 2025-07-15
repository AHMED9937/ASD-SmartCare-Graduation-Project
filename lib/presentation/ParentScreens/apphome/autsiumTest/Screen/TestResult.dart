import 'dart:ffi';

import 'package:asdsmartcare/presentation/AsdAppLayouts/screens/ParentNavgationScreen.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/appHome.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/autsiumTest/Screen/AutismCheker.dart';
import 'package:asdsmartcare/presentation/ParentScreens/apphome/autsiumTest/Screen/AutismTest.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/app_Buttons.dart';
import 'package:flutter/material.dart';

// Screen to choose AI evaluation type and show last results
class Testresult extends StatelessWidget {
  final String? degreePrediction;
  final String? autismPrediction;

  const Testresult({
    Key? key,
     this.autismPrediction,
     this.degreePrediction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  floatingActionButton:   FloatingActionButton.extended(
  onPressed: () {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => ParentBottomNavgationScreen()),
      (_) => false,
    );
  },
  icon: const Icon(Icons.local_hospital, color: Colors.white),
  label: const Text(
    'Explore Recommended Doctors',
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
  backgroundColor: const Color(0xFF133E87),
  elevation: 6,
),
floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
 
      appBar: AppBarWithText(context, "Test Result"),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (autismPrediction != null)
                    RecentTest(
                      isFirstTest: true,
                      prediction: autismPrediction!,
                      backToHomeButton: true,
                    ),
                  if (degreePrediction != null)
                    RecentTest(
                      isFirstTest: false,
                      prediction: degreePrediction!,
                      backToHomeButton: true,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToTest(BuildContext context, bool isFirstTest) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => isFirstTest
            ? const AutismTestScreen()
            : const AutismChekerScreen(),
      ),
    );
  }
}

// Widget to display a recent test result and suggested actions
class RecentTest extends StatelessWidget {
  final bool isFirstTest;
  final String prediction;
  final bool backToHomeButton;

  const RecentTest({
    Key? key,
    required this.isFirstTest,
    required this.prediction,
    required this.backToHomeButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final resultText = isFirstTest
        ? (prediction == "1"
            ? "You may have Autism Spectrum Disorder"
            : "You are unlikely to have Autism Spectrum Disorder")
        : "Your autism severity level is $prediction";
          if (prediction == "0") {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: Colors.green.shade50,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextUtils.textHeader(
                "No signs detected. You’re all clear!",
                fontSize: 20,
              ),
              const SizedBox(height: 12),
              TextUtils.textDescription(
                "Keep up with regular check-ins to stay on track.",
                fontSize: 16,
                disTextColor: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }else
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 12),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: TextUtils.textHeader(
                resultText,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 24),
          TextUtils.textHeader("Suggested Actions", fontSize: 18),
          const SizedBox(height: 12),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            color: Colors.green.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.schedule, color: Colors.green),
              title: TextUtils.textDescription(
                "Start early intervention sessions",
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            color: Colors.red.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.medical_services, color: Colors.red),
              title: TextUtils.textDescription(
                "Book a specialist consultation",
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            color: Colors.blue.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.group, color: Colors.blue),
              title: TextUtils.textDescription(
                "Join a parent support group",
              ),
            ),
          ),
          if (backToHomeButton) ...[
            const SizedBox(height: 32), ],
        ],
      ),
    );
  }
}
