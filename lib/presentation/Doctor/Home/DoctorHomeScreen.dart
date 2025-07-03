import 'package:asdsmartcare/presentation/Doctor/Home/RigesteredChild/screen/RegesterChilds.dart';
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
    return SizedBox(
      height: 150,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 28, color: const Color(0xFF133E87)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Welcome, Dr. Doctor',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF133E87),
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF133E87)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.folder_open, color: Color(0xFF133E87)),
                  SizedBox(width: 4),
                  Text(
                    'Quick Access',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF133E87),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    _buildCard(
                      context: context,
                      icon: Icons.notifications_outlined,
                      title: 'All upcoming sessions',
                      subtitle:
                          'Lorem ipsum dolor sit amet consectetur adipiscing',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SessionsScreen(status: "coming",),
                        ),
                      ),
                    ),
                    _buildCard(
                      context: context,
                      icon: Icons.check_circle_outline,
                      title: 'All sessions done',
                      subtitle:
                          'Lorem ipsum dolor sit amet consectetur adipiscing',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) =>   SessionsScreen(status: "done",)),
                      ),
                    ),
                    _buildCard(
                      context: context,
                      icon: Icons.group_outlined,
                      title: 'All registered children',
                      subtitle:
                          'Lorem ipsum dolor sit amet consectetur adipiscing',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const RegisteredChildrenScreen()),
                      ),
                    ),
                    _buildCard(
                      context: context,
                      icon: Icons.rate_review_outlined,
                      title: 'My Feedbacks',
                      subtitle:
                          'Lorem ipsum dolor sit amet consectetur adipiscing',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const Placeholder()),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
