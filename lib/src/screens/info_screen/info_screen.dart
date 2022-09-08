import 'package:flutter/material.dart';
import 'package:wecode/src/screens/jobs_screen/bottom_navigation_bar.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info'),
      ),
      body: Container(
        color: Colors.grey,
        child: const Center(child: Text('Info')),
      ),
      bottomNavigationBar: const CustomeBottomNavigationBar(),
    );
  }
}
