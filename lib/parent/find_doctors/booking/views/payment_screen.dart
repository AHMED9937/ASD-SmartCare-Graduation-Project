import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/controllers/booking_cubit.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/controllers/booking_state.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/models/booking_response.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/views/confirm_booking_screen.dart';
import 'package:asdsmartcare/parent/find_doctors/browse/models/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum PaymentMethod { cash, card }

class PaymentType extends StatefulWidget {
  final Doctor doctor;
  final BookSession sessionData;

  const PaymentType({
    super.key,
    required this.doctor,
    required this.sessionData,
  });

  @override
  State<PaymentType> createState() => _PaymentTypeState();
}

class _PaymentTypeState extends State<PaymentType> {
  PaymentMethod? _selectedMethod = PaymentMethod.cash;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingCubit(),
      child: BlocConsumer<BookingCubit, BookingState>(
        listener: _onStateChanged,
        builder: (context, state) {
          final isLoading =
              state is PaymentLoading || state is CancelInProgress;

          return MeshGradientBackground(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppHeader(
                title: 'Check Out',
                leading: AppBackButton(
                  onPressed: () {
                    final sessionId = widget.sessionData.data?.sId ?? '';
                    BookingCubit.get(context).CancelBooking(sessionId);
                  },
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionHeader(title: 'Booking Summary'),
                          const AppSpacer.sm(),
                          _BookingSummaryCard(
                            doctor: widget.doctor,
                            session: widget.sessionData,
                          ),
                          const AppSpacer.xl(),
                          const SectionHeader(title: 'Payment Method'),
                          const AppSpacer.sm(),
                          _PremiumPaymentTile(
                            title: 'Cash at Clinic',
                            subtitle: 'Pay after your appointment session',
                            icon: Icons.account_balance_wallet_rounded,
                            value: PaymentMethod.cash,
                            groupValue: _selectedMethod,
                            onChanged: (val) =>
                                setState(() => _selectedMethod = val),
                          ),
                          const AppSpacer.md(),
                          _PremiumPaymentTile(
                            title: 'Online Payment',
                            subtitle: 'Secure payment via Credit Card/Wallet',
                            icon: Icons.credit_card_rounded,
                            value: PaymentMethod.card,
                            groupValue: _selectedMethod,
                            onChanged: (val) =>
                                setState(() => _selectedMethod = val),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildPaymentFooter(context, isLoading),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPaymentFooter(BuildContext context, bool isLoading) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.md,
        AppSpacing.xl,
        MediaQuery.of(context).padding.bottom + AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Amount',
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    '${widget.doctor.sessionPrice} EGP',
                    style: AppTypography.headlineSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 180,
                child: AppButton(
                  label: 'Proceed',
                  isLoading: isLoading,
                  onPressed: _selectedMethod == null
                      ? null
                      : () => _processPayment(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onStateChanged(BuildContext context, BookingState state) {
    if (state is CancelComplete) {
      Navigator.pop(context);
    }

    if (state is PaymentComplete) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => Confirmreservationscreen(
            DoctorData: widget.doctor,
            sessionD: widget.sessionData,
          ),
        ),
        (route) => false,
      );
    }

    if (state is PaymentError) {
      _showError(context, state.message);
    }

    if (state is CancelError) {
      _showError(context, state.message);
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _processPayment(BuildContext context) {
    if (_selectedMethod == PaymentMethod.card) {
      final appointmentId = widget.sessionData.data?.sId ?? '';
      BookingCubit.get(context).generateStripePaymentSheet(appointmentId);
    } else {
      final doctorId =
          widget.sessionData.data?.doctorId ?? widget.doctor.id ?? '';
      final appointmentId = widget.sessionData.data?.sId ?? '';
      BookingCubit.get(
        context,
      ).processCashPayment(doctorId: doctorId, appointmentId: appointmentId);
    }
  }
}

class _BookingSummaryCard extends StatelessWidget {
  final Doctor doctor;
  final BookSession session;

  const _BookingSummaryCard({required this.doctor, required this.session});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.lgRadius,
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ProfileAvatar(imageUrl: doctor.image, radius: 28),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.parent?.userName ?? 'Doctor',
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      doctor.speciailization ?? 'Specialist',
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const AppDivider(height: AppSpacing.xl),
          _SummaryRow(
            icon: Icons.calendar_today_rounded,
            label: 'Date',
            value: session.data?.date ?? 'To be scheduled',
          ),
          const SizedBox(height: AppSpacing.sm),
          _SummaryRow(
            icon: Icons.access_time_rounded,
            label: 'Time Slot',
            value: session.data?.time ?? 'To be scheduled',
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _SummaryRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        Text(
          label,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.onBackground,
          ),
        ),
      ],
    );
  }
}

class _PremiumPaymentTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final PaymentMethod value;
  final PaymentMethod? groupValue;
  final ValueChanged<PaymentMethod?> onChanged;

  const _PremiumPaymentTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.08)
              : AppColors.surface,
          borderRadius: AppRadius.mdRadius,
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.primary.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.onPrimary : AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? AppColors.primaryDark
                          : AppColors.onBackground,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.primary,
                size: 24,
              )
            else
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    width: 2,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
