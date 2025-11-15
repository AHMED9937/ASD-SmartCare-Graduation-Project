import 'package:asdsmartcare/shared/donations/controllers/charity_cubit.dart';
import 'package:asdsmartcare/shared/donations/views/widgets/charity_medicine_body.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Redesigned Charity support screen following the SOLID thin-screen pattern.
class CharityMedicine extends StatelessWidget {
  final AvailableCharityCubit? cubit;

  const CharityMedicine({super.key, this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          (cubit ?? AvailableCharityCubit())..getAvailableCharity(),
      child: const Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageHeader(
              title: 'Charity Support',
              subtitle: 'Find organizations that can help',
            ),
            Expanded(
              child: CharityMedicineBody(),
            ),
          ],
        ),
      ),
    );
  }
}
