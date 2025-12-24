import 'package:asdsmartcare/app/router/app_router.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/models/booking_response.dart';
import 'package:asdsmartcare/parent/find_doctors/browse/models/doctor_model.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';

class Confirmreservationscreen extends StatelessWidget {
  final Doctor DoctorData;
  final BookSession sessionD;

  const Confirmreservationscreen({
    super.key,
    required this.DoctorData,
    required this.sessionD,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 200,
        flexibleSpace: _Header(doctor: DoctorData),
      ),
      body: MeshGradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              children: [
                const AppSpacer.xl(),

                // Success message
                const Icon(
                  Icons.check_circle_rounded,
                  size: 64,
                  color: AppColors.success,
                ),
                const AppSpacer.md(),
                Text(
                  'Booking Confirmed!',
                  style: AppTypography.headlineMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),

                const AppSpacer.xl(),

                // Booking details card
                AppCard(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    children: [
                      BookingDetailRow(
                        icon: Icons.attach_money_rounded,
                        label: 'Session Price',
                        value: '${DoctorData.sessionPrice ?? 0} EGP',
                        valueColor: AppColors.success,
                      ),
                      const AppDivider(),
                      BookingDetailRow(
                        icon: Icons.calendar_today_rounded,
                        label: 'Date',
                        value: sessionD.data?.date ?? 'N/A',
                      ),
                      const AppDivider(),
                      BookingDetailRow(
                        icon: Icons.access_time_rounded,
                        label: 'Time',
                        value: sessionD.data?.time ?? 'N/A',
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Done button
                AppButton(
                  label: 'Done',
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.parentHome,
                      (Route<dynamic> route) => false,
                    );
                  },
                ),

                const AppSpacer.md(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final Doctor doctor;

  const _Header({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(100),
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + AppSpacing.md,
            left: AppSpacing.xl,
            right: AppSpacing.xl,
          ),
          child: DoctorInfoCard(
            name: doctor.parent?.userName ?? 'Doctor',
            specialty: doctor.speciailization,
            imageUrl: doctor.image,
            rating: (doctor.ratingsAverage ?? 0).toDouble(),
          ),
        ),
      ),
    );
  }
}
