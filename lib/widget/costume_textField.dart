import 'package:flutter/material.dart';

class CostumeTextField extends StatelessWidget {
  const CostumeTextField({
    Key? key,
    required this.hint,
    required this.icon,
    required this.control,
  }) : super(key: key);

  final String hint;
  final Icon icon;
  final TextEditingController control;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller : control,
      decoration: InputDecoration(
        icon: icon,
        hintText: hint,
        hintStyle: TextStyle(fontSize: 18 , fontWeight: FontWeight.w400),
      ),
    );
  }
}
