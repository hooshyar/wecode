import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wecode/src/screens/auth/loginScreen.dart';

class ScreenHandler extends StatefulWidget {
  const ScreenHandler({Key? key}) : super(key: key);

  @override
  State<ScreenHandler> createState() => _ScreenHandlerState();
}

class _ScreenHandlerState extends State<ScreenHandler> {
  @override
  Widget build(BuildContext context) {
    //TODO: if user is logged in and created the profile retrun the screen with bottom navigation
    return Scaffold(
      body: LoginScreen(),
    );
  }
}
