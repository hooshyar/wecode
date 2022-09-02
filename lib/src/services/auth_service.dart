import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService {
//TODO: write methods to authenticate user using firebase auth

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential?> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    UserCredential? credential;
    try {
      credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('error', 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('error', 'The account already exists for that email.');
      } else {
        Get.snackbar('error', e.message.toString());
      }
    } catch (e) {
      Get.snackbar('error', e.toString());
    }
    return credential;
  }

  Future<UserCredential?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    UserCredential? credential;

    try {
      credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'Wrong information provided for that user.');
      } else {
        Get.snackbar('Error', e.message.toString());
      }
    }
    return credential;
  }

  forgetPassword({required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email).catchError((err) {
        Get.snackbar('error', '$err');
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar('firebase error ', e.message.toString());
    }
    // await auth.verifyPasswordResetCode(code);
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}
