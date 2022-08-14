import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:wecode/src/temp/class3.dart';
import 'package:wecode/src/temp/number_provider.dart';

class ClassTwo extends StatelessWidget {
  const ClassTwo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Expanded(child: ClassThree()),
          Expanded(
              child: Text(context.watch<NumberProvider>().theNumber.toString()))
        ],
      )),
    );
  }
}
