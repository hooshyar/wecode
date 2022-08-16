import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wecode/src/common/widgets/loading_indicator.dart';
import 'package:wecode/src/models/weCodeUser_data_model.dart';
import 'package:wecode/src/providers/user_provider.dart';
import 'package:wecode/src/screens/Job%20Screen/create_job_screen_view.dart';
import 'package:wecode/src/screens/auth/login_screen.dart';
import 'package:wecode/src/screens/create_profile_screen/create_profile.dart';
import 'package:wecode/src/screens/jobs_screen/jobs_screen.dart';

class HandlerScreen extends StatefulWidget {
  HandlerScreen({Key? key}) : super(key: key);

  @override
  State<HandlerScreen> createState() => _HandlerScreenState();
}

class _HandlerScreenState extends State<HandlerScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

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
            return LoadingIndicator();
          } else if (snapshot.data == null) {
            return LoginScreen();
          } else if (snapshot.hasError) {
            return Center(child: Text('error'));
          }

          return FutureBuilder<WeCodeUser>(
              future: getUser(snapshot.data!),
              builder: (context, snapshotFromFuture) {
                if (snapshotFromFuture.connectionState ==
                    ConnectionState.waiting) {
                  return LoadingIndicator();
                } else if (snapshotFromFuture.hasError) {
                  return Center(
                    child: Text(snapshotFromFuture.error.toString()),
                  );
                } else if (snapshotFromFuture.data == null) {
                  //TODO: go to create Profile

                  // Get.to(()=> CreateProfileScreen(weCodeUser: weCodeUser, isUpdate: isUpdate))
                }
                return JobsScreen();
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

    Provider.of<UserProvider>(context, listen: false).setWeCodeUser(weCodeUser);

    return weCodeUser;
  }
}
