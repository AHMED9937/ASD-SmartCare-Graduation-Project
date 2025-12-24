import 'package:asdsmartcare/doctor/clinic/views/clinic_screen.dart';
import 'package:asdsmartcare/doctor/account/views/profile_screen.dart';
import 'package:asdsmartcare/doctor/home/views/doctor_home_screen.dart';
import 'package:asdsmartcare/shared/donations/views/charities_screen.dart';
import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:flutter/material.dart';

class Doctornavgationscreen extends StatefulWidget {
  const Doctornavgationscreen({super.key});

  @override
  _DoctornavgationscreenState createState() => _DoctornavgationscreenState();
}

class _DoctornavgationscreenState extends State<Doctornavgationscreen> {
  int _currentIndex = 0;

  // List of widget pages corresponding to each bottom nav item
  final List<Widget> _pages = [
    const DoctorHomeScreen(),
    const ClinicDoctorScreen(),
    const CharityMedicine(),
    const DoctorProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex != 3
          ? const AppHeader(
              showBackButton: false,
              automaticallyImplyLeading: false,
            )
          : null,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined),
            activeIcon: Icon(Icons.medical_services),
            label: 'Clinic',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Charity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            activeIcon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
