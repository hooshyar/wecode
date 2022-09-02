import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecode/src/screens/fav_screen/fav_screen.dart';
import 'package:wecode/src/screens/info_screen/info_screen.dart';
import 'package:wecode/src/screens/jobs_screen/jobs_screen.dart';

class CustomeBottomNavigationBar extends StatefulWidget {
  const CustomeBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomeBottomNavigationBar> createState() =>
      _CustomeBottomNavigationBarState();
}

class _CustomeBottomNavigationBarState
    extends State<CustomeBottomNavigationBar> {
  int? _selectedIndex;
  @override
  void initState() {
    _selectedIndex = 1;
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (_selectedIndex) {
      case 0:
        Get.to(() => const FavoritesScreen());
        break;
      case 1:
        Get.to(() => const JobsScreen());
        break;
      case 2:
        Get.to(() => const InfoScreen());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex!,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
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
    );
  }
}
