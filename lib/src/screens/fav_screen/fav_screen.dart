import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wecode/src/models/vacancy_data_model.dart';
import 'package:wecode/src/screens/jobs_screen/bottom_navigation_bar.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        child: ValueListenableBuilder<Box>(
          valueListenable: Hive.box('favBox').listenable(),
          builder: (context, box, widget) {
            return Center(
              child: ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    Map<dynamic, dynamic> _data = box.getAt(index);
                    Vacancy _vacancy =
                        Vacancy.fromMap(_data.cast<String, dynamic>());

                    return ListTile(
                      title: Text(_vacancy.org),
                    );
                  }),
            );
          },
        ),
      ),
      bottomNavigationBar: const CustomeBottomNavigationBar(),
    );
  }
}
