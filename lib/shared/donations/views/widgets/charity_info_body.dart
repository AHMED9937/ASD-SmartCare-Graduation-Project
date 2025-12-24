import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/controllers/booking_cubit.dart';
import 'package:asdsmartcare/parent/find_doctors/booking/controllers/booking_state.dart';
import 'package:asdsmartcare/shared/donations/models/charity_model.dart';
import 'package:asdsmartcare/shared/donations/views/charity_medicines_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum CharityPaymentMethod { cash, card }

class CharityInfoBody extends StatefulWidget {
  final Charity charityData;

  const CharityInfoBody({super.key, required this.charityData});

  @override
  State<CharityInfoBody> createState() => _CharityInfoBodyState();
}

class _CharityInfoBodyState extends State<CharityInfoBody> {
  CharityPaymentMethod _selectedMethod = CharityPaymentMethod.cash;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            // 1. Immersive Header
            _buildSliverAppBar(),

            // 2. Content Sections
            SliverToBoxAdapter(
              child: _buildContent(context, state),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 240,
      pinned: true,
      backgroundColor: AppColors.primary,
      leading: const _CircularBackButton(),
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'charity_${widget.charityData.id}',
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (widget.charityData.logo != null &&
                  widget.charityData.logo!.isNotEmpty)
                Image.network(widget.charityData.logo!, fit: BoxFit.cover)
              else
                Container(color: AppColors.primary.withValues(alpha: 0.2)),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black45],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, BookingState state) {
    return Container(
      transform: Matrix4.translationValues(0, -24, 0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadius.xl),
          topRight: Radius.circular(AppRadius.xl),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title & Info
            Text(
              widget.charityData.charityName ?? 'Unknown Charity',
              style: AppTypography.displaySmall.copyWith(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            const AppSpacer.sm(),

            _buildInfoRow(Icons.location_on_outlined,
                widget.charityData.charityAddress ?? 'No address'),
            const AppSpacer.xs(),
            _buildInfoRow(Icons.phone_outlined,
                widget.charityData.charityPhone ?? 'No phone'),

            const AppSpacer.xl(),

            // Action Buttons (Contact & Medicines)
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: 'Medicines',
                    icon: Icons.medical_services_outlined,
                    onPressed: () => _navigateToMedicines(context),
                  ),
                ),
                const AppSpacer.md(),
                Expanded(
                  child: AppButton(
                    label: 'Contact',
                    icon: Icons.phone_forwarded_outlined,
                    style: AppButtonStyle.secondary,
                    onPressed: () {
                      // Contact logic
                    },
                  ),
                ),
              ],
            ),

            const AppSpacer.xxl(),
            const AppDivider(),
            const AppSpacer.xl(),

            // Donation Section
            const _SectionTitle(title: 'Make a Donation'),
            const AppSpacer.sm(),
            Text(
              'Your support helps us provide essential medicines to those in need.',
              style: AppTypography.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
            const AppSpacer.lg(),

            _buildPaymentOption(
              icon: Icons.credit_card_outlined,
              label: 'Credit Card / E-wallet',
              value: CharityPaymentMethod.card,
            ),
            const AppSpacer.md(),
            _buildPaymentOption(
              icon: Icons.payments_outlined,
              label: 'Cash at Charity',
              value: CharityPaymentMethod.cash,
            ),

            const AppSpacer.xxl(),

            // Donate Button
            if (state is GenrateSPSLoading)
              const Center(child: LoadingView())
            else
              AppButton(
                label: 'Donate Now',
                onPressed: () => _handleDonation(context),
              ),

            const AppSpacer.xxl(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: AppTypography.bodySmall
                .copyWith(color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentOption({
    required IconData icon,
    required String label,
    required CharityPaymentMethod value,
  }) {
    final isSelected = _selectedMethod == value;
    return AppCard(
      onTap: () => setState(() => _selectedMethod = value),
      color:
          isSelected ? AppColors.primary.withValues(alpha: 0.05) : Colors.white,
      padding: const EdgeInsets.all(AppSpacing.md),
      border: Border.all(
        color: isSelected ? AppColors.primary : AppColors.border,
        width: isSelected ? 2 : 1,
      ),
      child: Row(
        children: [
          Icon(icon,
              color: isSelected ? AppColors.primary : AppColors.textSecondary),
          const AppSpacer.md(),
          Expanded(
            child: Text(
              label,
              style: AppTypography.bodyLarge.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? AppColors.primary : AppColors.onSurface,
              ),
            ),
          ),
          Radio<CharityPaymentMethod>(
            value: value,
            groupValue: _selectedMethod,
            activeColor: AppColors.primary,
            onChanged: (val) => setState(() => _selectedMethod = val!),
          ),
        ],
      ),
    );
  }

  void _navigateToMedicines(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AvaillableCharityMed(
          medicines: widget.charityData.charityMedican ?? [],
        ),
      ),
    );
  }

  void _handleDonation(BuildContext context) {
    // Current hardcoded ID from the original file
    const id = '6877223da9bf499365cfbb28';
    if (_selectedMethod == CharityPaymentMethod.card) {
      context.read<BookingCubit>().generateStripePaymentSheet(id);
    } else {
      context.read<BookingCubit>().cashPayments(id);
    }
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTypography.titleMedium.copyWith(
        color: AppColors.primaryDark,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _CircularBackButton extends StatelessWidget {
  const _CircularBackButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundColor: Colors.white.withValues(alpha: 0.9),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 18, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
