import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecode/src/temp/number_provider.dart';

class ClassThree extends StatelessWidget {
  ClassThree({
    Key? key,
  }) : super(key: key);

  final TextEditingController _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final int number = context.watch<NumberProvider>().theNumber;

    return Scaffold(
      body: Center(
          child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('consumer'),
            Consumer<NumberProvider>(
                builder: (BuildContext context, value, __) =>
                    Text('${value.theNumber}')),
            const Divider(),
            TextField(
              controller: _numberController,
            ),
            ElevatedButton(
                onPressed: () {
                  context
                      .read<NumberProvider>()
                      .changeTheNumber(int.parse(_numberController.text));
                },
                child: const Text('update number'))
          ],
        ),
      )),
    );
  }
}
