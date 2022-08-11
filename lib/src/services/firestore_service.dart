import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wecode/src/models/weCodeUser_data_model.dart';

class FireStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // add user with initial information to database

  Future<WeCodeUser> addUserWithInitialInformationToDB(
      {required User user,
      required String userName,
      String? phoneNumber}) async {
    WeCodeUser weCodeUser = WeCodeUser(
        name: userName,
        createdAt: DateTime.now(),
        email: user.email!,
        phone: phoneNumber,
        uid: user.uid);

    await _firestore.collection('users').doc(user.uid).set(weCodeUser.toMap());
    return weCodeUser;
  }
}
