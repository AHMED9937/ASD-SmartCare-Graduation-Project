import 'package:asdsmartcare/presentation/DoctorLayout/Clinic/Screen/clinicScreen.dart';
import 'package:asdsmartcare/presentation/DoctorLayout/DoctorProfile/Screen/doctorProfile.dart';
import 'package:asdsmartcare/presentation/DoctorLayout/Home/DoctorHomeScreen.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
import 'package:asdsmartcare/presentation/CharityAndDonations/Screen/CharityMedicine.dart';
import 'package:flutter/material.dart';

class Doctornavgationscreen extends StatefulWidget {
  const Doctornavgationscreen({Key? key}) : super(key: key);

  @override
  _DoctornavgationscreenState createState() => _DoctornavgationscreenState();
}

class _DoctornavgationscreenState extends State<Doctornavgationscreen> {
  int _currentIndex = 0;

  // List of widget pages corresponding to each bottom nav item
  final List<Widget> _pages = [
    QuickAccessPage(),
    const ClinicDoctorScreen(),
    CharityMedicine(),
    const DoctorProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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