import 'package:asdsmartcare/app/router/app_router.dart';
import 'package:asdsmartcare/core/design_system/tokens/colors.dart';
import 'package:asdsmartcare/core/design_system/tokens/radius.dart';
import 'package:asdsmartcare/core/design_system/tokens/spacing.dart';
import 'package:asdsmartcare/core/design_system/tokens/typography.dart';
import 'package:flutter/material.dart';

class OrbitServiceItem {
  final IconData icon;
  final String label;
  final String route;
  final Color color;

  const OrbitServiceItem(this.icon, this.label, this.route, this.color);
}

class ServiceOrbit extends StatelessWidget {
  const ServiceOrbit({super.key});

  static const List<OrbitServiceItem> _services = [
    OrbitServiceItem(
      Icons.auto_awesome,
      'AI Test',
      AppRoutes.autismTest,
      Color(0xFFE3F2FD),
    ),
    OrbitServiceItem(
      Icons.stacked_bar_chart_rounded,
      'Progress',
      AppRoutes.childProgress,
      Color(0xFFF1F8E9),
    ),
    OrbitServiceItem(
      Icons.menu_book_rounded,
      'Education',
      AppRoutes.education,
      Color(0xFFFFF3E0),
    ),
    OrbitServiceItem(
      Icons.medication_rounded,
      'Medicines',
      AppRoutes.medicines,
      Color(0xFFFCE4EC),
    ),
    OrbitServiceItem(
      Icons.volunteer_activism_rounded,
      'Charity',
      AppRoutes.charity,
      Color(0xFFF3E5F5),
    ),
    OrbitServiceItem(
      Icons.smart_toy_rounded,
      'Chatbot',
      AppRoutes.chatbot,
      Color(0xFFE0F2F1),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _services.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
        itemBuilder: (context, index) {
          final item = _services[index];
          return _ServiceOrbitItem(item: item);
        },
      ),
    );
  }
}

class _ServiceOrbitItem extends StatelessWidget {
  final OrbitServiceItem item;

  const _ServiceOrbitItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Service: ${item.label}',
      button: true,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, item.route),
        child: Column(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppRadius.lgRadius,
                boxShadow: [
                  BoxShadow(
                    color: item.color.withValues(alpha: 0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
                border: Border.all(
                  color: item.color.withValues(alpha: 0.5),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: item.color.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item.icon,
                    color: AppColors.primaryDark,
                    size: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              item.label,
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
