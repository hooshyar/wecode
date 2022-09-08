import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wecode/src/screens/fav_screen/fav_screen.dart';
import 'package:wecode/src/screens/info_screen/info_screen.dart';
import 'package:wecode/src/screens/jobs_screen/jobs_screen.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key});

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int _selectedIndex = 1;

  Widget? _selectedScreen = JobsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex!,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.green,
        selectedLabelStyle: TextStyle(letterSpacing: 1.5),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favs'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Jobs'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
        ],
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (_selectedIndex) {
      case 0:
        setState(() {
          _selectedScreen = FavoritesScreen();
        });
        break;
      case 1:
        setState(() {
          _selectedScreen = JobsScreen();
        });
        break;
      case 2:
        setState(() {
          _selectedScreen = InfoScreen();
        });
        break;
    }
  }
}
