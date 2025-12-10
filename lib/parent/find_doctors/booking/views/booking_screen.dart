import 'package:asdsmartcare/app/router/app_router.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/find_doctors/browse/models/doctor_model.dart';

import 'package:asdsmartcare/parent/find_doctors/booking/controllers/booking_cubit.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/controllers/booking_state.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/views/widgets/review_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

/// The main entry point for the Doctor Booking flow.
class Reservationscreen extends StatelessWidget {
  final Doctor myDoctor;
  final BookingCubit? cubit;

  const Reservationscreen({super.key, required this.myDoctor, this.cubit});

  @override
  Widget build(BuildContext context) {
    // Body is stateful to manage local UI state (date/time selection)
    final body = BookingBody(doctor: myDoctor);

    return cubit != null
        ? BlocProvider.value(value: cubit!, child: body)
        : BlocProvider(
            create: (_) =>
                BookingCubit()..getDoctorsAppointments(myDoctor.id ?? ''),
            child: body,
          );
  }
}

class BookingBody extends StatefulWidget {
  final Doctor doctor;
  const BookingBody({super.key, required this.doctor});

  @override
  State<BookingBody> createState() => _BookingBodyState();
}

class _BookingBodyState extends State<BookingBody> {
  late DateTime _selectedDate;
  String? _selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDate = DateTime(now.year, now.month, now.day);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookingCubit>();

    return BlocConsumer<BookingCubit, BookingState>(
      listener: _onStateChanged,
      builder: (context, state) {
        // Full-screen State Handling
        if (state is SlotsLoading) {
          return const Scaffold(
            body: LoadingView(message: 'Exploring available appointments...'),
          );
        }

        if (state is SlotsError) {
          return Scaffold(
            appBar: const AppHeader(title: 'Error'),
            body: ErrorView(
              message: state.message,
              onRetry: () =>
                  cubit.getDoctorsAppointments(widget.doctor.id ?? ''),
            ),
          );
        }

        if (state is NoSlotsAvailable) {
          return Scaffold(
            appBar: const AppHeader(title: 'No Availability'),
            body: EmptyView(
              icon: Icons.event_busy_rounded,
              title: 'No Dates Found',
              message: 'This specialist has no available slots at the moment.',
              actionText: 'Refresh',
              onAction: () =>
                  cubit.getDoctorsAppointments(widget.doctor.id ?? ''),
            ),
          );
        }

        final sortedDates = cubit.selectableDates.toList()..sort();
        final effectiveDate = sortedDates.contains(_selectedDate)
            ? _selectedDate
            : (sortedDates.isEmpty ? _selectedDate : sortedDates.first);
        final slotsForDate = cubit.getSlotsForDate(effectiveDate);
        final isBooking = state is BookingInProgress;

        return MeshGradientBackground(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: const AppHeader(title: 'Specialist Detail'),
            bottomNavigationBar: _buildBottomCTA(
              context,
              isBooking,
              effectiveDate,
              cubit,
            ),
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: DoctorProfileHeader(doctor: widget.doctor),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenPaddingH,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppSpacer.md(),
                        DoctorStats(doctor: widget.doctor),
                        const AppSpacer.xl(),
                        const SectionHeader(title: 'Patient Reviews'),
                        const AppSpacer.xs(),
                        ReviewCarousel(doctorId: widget.doctor.id ?? ''),
                        if (widget.doctor.qualifications != null) ...[
                          const AppSpacer.xl(),
                          const SectionHeader(title: 'About Specialist'),
                          const AppSpacer.xs(),
                          AboutSection(content: widget.doctor.qualifications!),
                        ],
                        const AppSpacer.xl(),
                        const SectionHeader(title: 'Schedule Appointment'),
                        const AppSpacer.xs(),
                        BookingCard(
                          sortedDates: sortedDates,
                          effectiveDate: effectiveDate,
                          onDateSelected: (date) => setState(() {
                            _selectedDate = DateTime(
                              date.year,
                              date.month,
                              date.day,
                            );
                            _selectedTimeSlot = null;
                          }),
                          slots: slotsForDate,
                          selectedSlot: _selectedTimeSlot,
                          onSlotSelected: (slot) =>
                              setState(() => _selectedTimeSlot = slot),
                          isBooking: isBooking,
                        ),
                        const AppSpacer.xxl(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomCTA(
    BuildContext context,
    bool isLoading,
    DateTime effectiveDate,
    BookingCubit cubit,
  ) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.md,
        AppSpacing.xl,
        MediaQuery.of(context).padding.bottom + AppSpacing.md,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        boxShadow: [AppShadows.md],
      ),
      child: Semantics(
        label: 'Confirm booking button',
        hint: _selectedTimeSlot == null
            ? 'Please select a time slot'
            : 'Tap to book your appointment for $_selectedTimeSlot',
        child: AppButton(
          label: 'Book Now (${widget.doctor.sessionPrice} EGP)',
          isLoading: isLoading,
          onPressed: _selectedTimeSlot == null
              ? () => _showError(context, 'Please select a time slot.')
              : () => cubit.bookAppointment(
                  doctorId: widget.doctor.id!,
                  date: effectiveDate,
                  timeSlot: _selectedTimeSlot!,
                ),
        ),
      ),
    );
  }

  void _onStateChanged(BuildContext context, BookingState state) {
    if (state is BookingError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.mdRadius),
        ),
      );
    }

    if (state is BookingComplete) {
      Navigator.pushNamed(
        context,
        AppRoutes.bookingPayment,
        arguments: BookingPaymentArgs(
          doctor: widget.doctor,
          session: state.session,
        ),
      );
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.mdRadius),
      ),
    );
  }
}

class DoctorProfileHeader extends StatelessWidget {
  final Doctor doctor;
  const DoctorProfileHeader({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary.withValues(alpha: 0.08),
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        children: [
          const AppSpacer.md(),
          Hero(
            tag: 'doctor_avatar_${doctor.id}',
            child: ProfileAvatar(imageUrl: doctor.image, radius: 64),
          ),
          const AppSpacer.md(),
          Text(
            doctor.parent?.userName ?? 'Specialist',
            style: AppTypography.headlineSmall.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.onBackground,
            ),
          ),
          const AppSpacer.xxs(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: AppRadius.fullRadius,
            ),
            child: Text(
              doctor.speciailization ?? 'Autism Specialist',
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const AppSpacer.md(),
          _RatingRow(doctor: doctor),
        ],
      ),
    );
  }
}

class _RatingRow extends StatelessWidget {
  final Doctor doctor;
  const _RatingRow({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.star_rounded, color: AppColors.warning, size: 20),
        const SizedBox(width: 4),
        Text(
          '${doctor.ratingsAverage ?? 0}.0',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.onBackground,
          ),
        ),
        Text(
          ' (${doctor.ratingQuantity ?? 0} reviews)',
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class DoctorStats extends StatelessWidget {
  final Doctor doctor;
  const DoctorStats({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const StatItem(
              label: 'Experience',
              value: '5+ Yrs',
              icon: Icons.history_edu_rounded,
            ),
            const VerticalDivider(width: 1, indent: 8, endIndent: 8),
            StatItem(
              label: 'Price',
              value: '${doctor.sessionPrice} EGP',
              icon: Icons.payments_outlined,
            ),
            const VerticalDivider(width: 1, indent: 8, endIndent: 8),
            StatItem(
              label: 'Review',
              value: '${doctor.ratingsAverage ?? 0}.0',
              icon: Icons.grade_rounded,
            ),
          ],
        ),
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  final String content;
  const AboutSection({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Text(
        content,
        style: AppTypography.bodyMedium.copyWith(
          color: AppColors.onBackground,
          height: 1.5,
        ),
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final List<DateTime> sortedDates;
  final DateTime effectiveDate;
  final ValueChanged<DateTime> onDateSelected;
  final List<String> slots;
  final String? selectedSlot;
  final ValueChanged<String?> onSlotSelected;
  final bool isBooking;

  const BookingCard({
    super.key,
    required this.sortedDates,
    required this.effectiveDate,
    required this.onDateSelected,
    required this.slots,
    required this.selectedSlot,
    required this.onSlotSelected,
    required this.isBooking,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          const AppSpacer.md(),
          CalendarTimeline(
            initialDate: effectiveDate,
            firstDate: sortedDates.isNotEmpty
                ? sortedDates.first
                : DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365)),
            onDateSelected: onDateSelected,
            monthColor: AppColors.primary,
            dayColor: AppColors.textSecondary,
            dayNameColor: AppColors.onSurface,
            activeDayColor: AppColors.onPrimary,
            activeBackgroundDayColor: AppColors.primary,
            dotColor: AppColors.primary,
            locale: 'en',
            selectableDayPredicate: (date) {
              final d = DateTime(date.year, date.month, date.day);
              return sortedDates.contains(d);
            },
            height: 110,
          ),
          const AppDivider(),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: TimeSlotGrid(
              slots: slots,
              selectedSlot: selectedSlot,
              onSlotSelected: onSlotSelected,
              enabled: !isBooking,
            ),
          ),
        ],
      ),
    );
  }
}
