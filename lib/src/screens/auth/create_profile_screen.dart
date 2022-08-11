import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wecode/src/common/widgets/loading_indicator.dart';
import 'package:wecode/src/models/weCodeUser_data_model.dart';
import 'package:wecode/widget/costume_textField.dart';

class CreateProfileScreen extends StatelessWidget {
  CreateProfileScreen({Key? key, required this.wecodeUser}) : super(key: key);
  final WeCodeUser wecodeUser;

  final TextEditingController _gitHubController = TextEditingController();
  final TextEditingController _linkedInController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _surNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(wecodeUser.email),
        ),
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(wecodeUser.uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingIndicator();
              } else if (snapshot.hasError) {
                Text('Error');
              } else if (snapshot.data == null) {
                return Text('null');
              }

              WeCodeUser theWeCodeUser =
                  WeCodeUser.fromSnapShot(snapshot.data as DocumentSnapshot);

              theWeCodeUser.reference!.delete();

              // FirebaseFirestore.instance
              //     .collection('users')
              //     .doc(wecodeUser.uid)
              //     .delete();

              debugPrint(theWeCodeUser.reference.toString());

              return Container(
                child: Form(
                    child: Column(
                  children: [
                    //TODO: image picker, firebase storage
                    Text('choose your profile image'),
                    Container(height: 100, width: 100, child: Placeholder()),

                    CostumeTextField(
                      hint: 'github',
                      icon: Icon(FontAwesomeIcons.github),
                      control: _gitHubController,
                    ),
                    CostumeTextField(
                      hint: 'linkedin',
                      icon: Icon(FontAwesomeIcons.linkedin),
                      control: _linkedInController,
                    ),
                    CostumeTextField(
                      hint: 'website',
                      icon: Icon(FontAwesomeIcons.networkWired),
                      control: _websiteController,
                    ),
                    CostumeTextField(
                      hint: 'surName',
                      icon: Icon(FontAwesomeIcons.person),
                      control: _surNameController,
                    ),
                  ],
                )),
              );
            }));
  }
}
