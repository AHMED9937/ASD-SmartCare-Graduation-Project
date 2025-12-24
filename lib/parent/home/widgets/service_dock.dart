import 'package:asdsmartcare/app/router/app_router.dart';
import 'package:asdsmartcare/core/ui/buttons/glass_pill.dart';
import 'package:flutter/material.dart';

/// Service item model.
class ServiceItem {
  final IconData icon;
  final String label;
  final String route;

  const ServiceItem(this.icon, this.label, this.route);
}

/// Horizontal scrollable dock of service buttons.
class ServiceDock extends StatelessWidget {
  const ServiceDock({super.key});

  static const List<ServiceItem> _services = [
    ServiceItem(Icons.auto_awesome, 'AI Test', AppRoutes.autismTest),
    ServiceItem(
        Icons.stacked_bar_chart_rounded, 'Progress', AppRoutes.childProgress),
    ServiceItem(Icons.menu_book_rounded, 'Education', AppRoutes.education),
    ServiceItem(Icons.medication_rounded, 'Medicines', AppRoutes.medicines),
    ServiceItem(Icons.volunteer_activism_rounded, 'Charity', AppRoutes.charity),
    ServiceItem(Icons.smart_toy_rounded, 'Chatbot', AppRoutes.chatbot),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(top: 24),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _services.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = _services[index];
          return GlassPill(
            icon: item.icon,
            label: item.label,
            isActive: false,
            onTap: () => Navigator.pushNamed(context, item.route),
          );
        },
      ),
    );
  }
}
