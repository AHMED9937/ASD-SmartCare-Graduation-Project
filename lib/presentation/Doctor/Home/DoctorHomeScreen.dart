import 'package:asdsmartcare/presentation/Doctor/Home/RigesteredChild/screen/RegesterChilds.dart';
import 'package:asdsmartcare/presentation/Doctor/Home/appointments/Screen/appointment.dart';
import 'package:flutter/material.dart';
import 'package:asdsmartcare/presentation/Doctor/Home/DoctorSessions/Screen/SessionsScreen.dart';

class QuickAccessPage extends StatelessWidget {
  /// Builds a tappable card with icon, title, and subtitle.
  Widget _buildCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        splashColor: Colors.blue.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF133E87), Color(0xFF4A90E2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Icon(icon, size: 32, color: Colors.white),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF133E87),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 13,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'icon': Icons.notifications_outlined,
        'title': 'Upcoming Sessions',
        'subtitle': 'See sessions scheduled soon',
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SessionsScreen(status: 'coming'),
              ),
            ),
      },
      {
        'icon': Icons.check_circle_outline,
        'title': 'Completed Sessions',
        'subtitle': 'Review past sessions',
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SessionsScreen(status: 'done'),
              ),
            ),
      },
      {
        'icon': Icons.group_outlined,
        'title': 'Create Session',
'subtitle': 'Once a child books an appointment, create a session to add notes, feedback, and monitor their progress.',
 'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const RegisteredChildrenScreen(),
              ),
            ),
      },
      {
        'icon': Icons.calendar_today,
        'title': 'All Appointments',
        'subtitle': 'View and manage appointments',
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AppointmentListScreen(),
              ),
            ),
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
                forceMaterialTransparency: true,

        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Welcome, Doctor',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF133E87),
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF133E87)),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return _buildCard(
                    context: context,
                    icon: item['icon'] as IconData,
                    title: item['title'] as String,
                    subtitle: item['subtitle'] as String,
                    onTap: item['onTap'] as VoidCallback,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
