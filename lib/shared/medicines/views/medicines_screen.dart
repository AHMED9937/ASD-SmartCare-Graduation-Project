import 'package:asdsmartcare/shared/medicines/controllers/medicines_cubit.dart';
import 'package:asdsmartcare/shared/medicines/views/widgets/medicines_body.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Redesigned Medicines screen following SOLID principles.
///
/// Uses a thin screen pattern that provides the Cubit and delegates
/// layout to [MedicinesBody].
class Availablemedicinescreen extends StatelessWidget {
  final AvailableMedicineCubit? cubit;

  const Availablemedicinescreen({super.key, this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          cubit ?? (AvailableMedicineCubit()..getAvailableMedicine()),
      child: const Scaffold(
        appBar: AppHeader(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageHeader(
              title: 'Pharmacy & Medicine',
              subtitle: 'Browse and order essential medicines for your child.',
            ),
            Expanded(child: MedicinesBody()),
          ],
        ),
      ),
    );
  }
}
