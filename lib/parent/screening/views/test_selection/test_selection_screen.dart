import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/screening/test/views/autism_checker_screen.dart';
import 'package:asdsmartcare/parent/screening/test/views/autism_test_screen.dart';
import 'package:asdsmartcare/parent/screening/views/test_selection/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// Screen for selecting which AI test to take.
///
/// This screen displays available autism screening tests and allows
/// the user to navigate to the selected test.
///
/// Follows SOLID principles:
/// - Single Responsibility: Only handles screen scaffold and navigation
/// - Open/Closed: Body widget handles layout, can be extended
/// - Dependency Inversion: Uses callbacks for navigation
class TestSelectionScreen extends StatelessWidget {
  const TestSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(showBackButton: false),
      body: TestSelectionBody(
        onScreeningTestTap: () => _navigateToScreeningTest(context),
        onLevelAssessmentTap: () => _navigateToLevelAssessment(context),
      ),
    );
  }

  void _navigateToScreeningTest(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AutismTestScreen()),
    );
  }

  void _navigateToLevelAssessment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AutismChekerScreen()),
    );
  }
}
