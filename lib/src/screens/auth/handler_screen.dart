import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecode/src/common/widgets/loading_indicator.dart';
import 'package:wecode/src/models/weCodeUser_data_model.dart';
import 'package:wecode/src/providers/user_provider.dart';
import 'package:wecode/src/screens/auth/login_screen.dart';
import 'package:wecode/src/screens/jobs_screen/jobs_screen.dart';
import 'package:wecode/src/screens/navigator_screen.dart';
import 'package:wecode/src/services/firestore_service.dart';

class HandlerScreen extends StatefulWidget {
  const HandlerScreen({Key? key}) : super(key: key);

  @override
  State<HandlerScreen> createState() => _HandlerScreenState();
}

class _HandlerScreenState extends State<HandlerScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FireStoreService fireStoreService = FireStoreService();

  WeCodeUser? thWecodeUser;

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth(auth service) =>
    // FirebaseFirestore(database service) =>
    // save it on a global object as provider to use it on all the app sections

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          //TODO:  check if loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          } else if (snapshot.data == null) {
            return LoginScreen();
          } else if (snapshot.hasError) {
            return const Center(child: Text('error'));
          }

          return FutureBuilder<WeCodeUser>(
              future: getUser(snapshot.data!),
              builder: (context, snapshotFromFuture) {
                if (snapshotFromFuture.connectionState ==
                    ConnectionState.waiting) {
                  return const LoadingIndicator();
                } else if (snapshotFromFuture.hasError) {
                  return Center(
                    child: Text(snapshotFromFuture.error.toString()),
                  );
                } else if (snapshotFromFuture.data == null) {
                  //TODO: get the device token

                  //TODO: save the device token to user/device_tokens

                }
                return const NavigatorScreen();
              });
        },
      ),
    );
  }

  Future<WeCodeUser> getUser(User user) async {
    WeCodeUser weCodeUser = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((value) => WeCodeUser.fromSnapShot(value));

    if (weCodeUser != null) {
      String? deviceToken = await FirebaseMessaging.instance.getToken();
      if (deviceToken != null) {
        fireStoreService.addDeviceToken(token: deviceToken, user: weCodeUser);
        debugPrint('token for user: ' + (deviceToken ?? 'null'));
      }
    }

    Provider.of<UserProvider>(context, listen: false).setWeCodeUser(weCodeUser);

    return weCodeUser;
  }
}
