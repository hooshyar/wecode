import 'package:flutter/material.dart';
import 'package:wecode/src/temp/class2.dart';

class ClassOne extends StatelessWidget {
  const ClassOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: ClassTwo()),
    );
  }
}
