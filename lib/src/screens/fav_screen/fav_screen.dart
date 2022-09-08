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
        centerTitle: true,
        title: const Text('Favorites', style: TextStyle(color: Colors.white)),
        actions: const <Widget>[
          Icon(Icons.favorite),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
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

                    return MyExpansionTile(
                        org: _vacancy.org,
                        userName: _vacancy.user.name,
                        title: _vacancy.title,
                        type: _vacancy.type,
                        city: _vacancy.city);
                  }),
            );
          },
        ),
      ),
    );
  }
}

class MyExpansionTile extends StatefulWidget {
  const MyExpansionTile(
      {super.key,
      required this.org,
      required this.userName,
      required this.title,
      required this.type,
      required this.city});
  final String org;
  final String userName;
  final String title;
  final String type;
  final String city;

  @override
  State<MyExpansionTile> createState() => _MyExpansionTileState();
}

class _MyExpansionTileState extends State<MyExpansionTile> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.org),
      trailing: Icon(
        _customTileExpanded
            ? Icons.arrow_drop_down_circle
            : Icons.arrow_drop_down,
      ),
      childrenPadding: const EdgeInsets.only(left: 40),
      expandedAlignment: Alignment.centerLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        customeText(
            name: widget.userName,
            fontSize: 018,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.4,
            maxLines: 1),
        customeText(
            name: '${widget.title} • ${widget.type}',
            fontSize: 015,
            letterSpacing: 0.4,
            maxLines: 2),
        customeText(
          name: widget.city,
          fontSize: 15,
          maxLines: 1,
        ),
        const SizedBox(
          height: 15,
        )
      ],
      onExpansionChanged: (bool expanded) {
        setState(() => _customTileExpanded = expanded);
      },
    );
  }

  Widget customeText({
    required String name,
    required double fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    int? maxLines,
  }) {
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              color: Colors.black87),
          maxLines: maxLines,
        ),
        const SizedBox(
          height: 7,
        )
      ],
    );
  }
}
