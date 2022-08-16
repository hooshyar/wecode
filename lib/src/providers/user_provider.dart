import 'package:flutter/material.dart';
import 'package:wecode/src/models/weCodeUser_data_model.dart';

class UserProvider extends ChangeNotifier {
  WeCodeUser? weCodeUser;

  setWeCodeUser(WeCodeUser user) {
    weCodeUser = user;
    debugPrint('from provider : ' + weCodeUser.toString());
    notifyListeners();
  }
}
