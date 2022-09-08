import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
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
      controller: control,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        icon: icon,
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }
}
