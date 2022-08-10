import 'package:flutter/material.dart';
class CostumeButton extends StatelessWidget {
  const CostumeButton({
    Key? key,
    required this.onPressedd,
    required this.color,
    required this.text,
  }) : super(key: key);

  final Text text;
  final Function onPressedd;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 50,
      child: ElevatedButton(
        onPressed: (){},
        style: ElevatedButton.styleFrom(
          primary: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: text,
      ),
    );
  }
}
