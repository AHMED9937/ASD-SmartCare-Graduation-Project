import 'package:asdsmartcare/app/router/app_router.dart';
import 'package:asdsmartcare/core/design_system/tokens/colors.dart';
import 'package:asdsmartcare/core/ui/buttons/app_button.dart';
import 'package:asdsmartcare/core/ui/buttons/glass_pill.dart';
import 'package:asdsmartcare/parent/progress/controllers/child_progress_cubit.dart';
import 'package:asdsmartcare/parent/progress/controllers/child_progress_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Hero card showing next session or CTA to book.
class HeroActionCard extends StatelessWidget {
  const HeroActionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: BlocBuilder<ChildProgressCubit, ChildProgressState>(
        builder: (context, state) {
          final cubit = context.read<ChildProgressCubit>();
          final sessions = cubit.sessions;

          if (sessions.isNotEmpty) {
            return _buildNextSessionCard(context, sessions.first);
          }

          return _buildBookingCta(context);
        },
      ),
    );
  }

  Widget _buildNextSessionCard(BuildContext context, dynamic nextSession) {
    final doctorName = nextSession.doctorId?.parent?.userName ?? 'Dr. Unknown';
    final date = nextSession.sessionDate ?? 'Upcoming';

    return GlassPill(
      icon: Icons.calendar_today_rounded,
      label: 'Next Session: $date with $doctorName',
      isActive: true,
      onTap: () => Navigator.pushNamed(context, AppRoutes.childProgress),
    );
  }

  Widget _buildBookingCta(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Start your journey',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Book a Consultation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                AppButton(
                  label: 'Find Doctor',
                  size: AppButtonSize.small,
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.findDoctors),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.medical_services_outlined,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
