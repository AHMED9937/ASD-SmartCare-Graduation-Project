import 'package:flutter/material.dart';
import 'package:asdsmartcare/core/ui/ui.dart';

/// Premium header for the Doctors List.
/// focus on clear typography and elegant spacing.
class DoctorsListHeader extends StatelessWidget {
  const DoctorsListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageHeader(
      title: 'Find Your Specialist',
      subtitle: 'Expert care for your child\'s growth.',
    );
  }
}
