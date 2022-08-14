import 'package:flutter/material.dart';

class NumberProvider extends ChangeNotifier {
  int theNumber = 322;

  changeTheNumber(int number) {
    theNumber = number;
    notifyListeners();
  }
}
