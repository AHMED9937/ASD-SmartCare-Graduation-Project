import 'package:asdsmartcare/presentation/Doctor/Clinic/Screen/clinicScreen.dart';
import 'package:asdsmartcare/presentation/Doctor/Home/DoctorHomeScreen.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/FixedWidgets.dart';
import 'package:asdsmartcare/presentation/Fixed_Widgets/TextUtils.dart';
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
     Expanded(child: QuickAccessPage()),
    const SearchScreen(),
    const ClinicDoctorScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  String _getTitle() {
    switch (_currentIndex) {
      case 0:
        return 'Home';
      case 1:
        return 'Search';
      case 2:
        return 'Add';
      case 3:
        return 'Favorites';
      case 4:
        return 'Profile';
      default:
        return '';
    }
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Search Screen Placeholder',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Add Screen Placeholder',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Favorites Screen Placeholder',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Profile Screen Placeholder',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
