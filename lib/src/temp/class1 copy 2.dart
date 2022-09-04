import 'package:flutter/material.dart';

class ClassOne extends StatelessWidget {
  const ClassOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: const [
          Text('the number'),
        ],
      )),
    );
  }
}
