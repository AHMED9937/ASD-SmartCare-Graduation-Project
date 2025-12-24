import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';
import 'package:asdsmartcare/shared/donations/models/charity_model.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/controllers/booking_cubit.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/controllers/booking_state.dart';
import 'package:asdsmartcare/shared/donations/views/widgets/charity_info_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Redesigned Charity Profile screen following the SOLID thin-screen pattern.
class CharityInfo extends StatelessWidget {
  final Charity charityData;
  const CharityInfo({super.key, required this.charityData});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingCubit(),
      child: BlocConsumer<BookingCubit, BookingState>(
        listener: _handleBookingState,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: CharityInfoBody(charityData: charityData),
          );
        },
      ),
    );
  }

  void _handleBookingState(BuildContext context, BookingState state) {
    if (state is GenrateSPSSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.success,
          content: Text(
            '🎉 Donation successful!\nThank you for your generosity.',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 6),
        ),
      );
    }
    if (state is GenrateCSCOsuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.success,
          content: Text(
            '🎉 Donation Confirmed!\nThank you for your generosity. Please visit the charity office to complete your cash payment.',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 6),
        ),
      );
    }
  }
}
