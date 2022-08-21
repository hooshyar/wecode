import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wecode/src/models/vacancy_data_model.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
      )),
    );
  }
}
