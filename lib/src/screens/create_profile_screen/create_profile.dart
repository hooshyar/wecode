// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecode/src/models/weCodeUser_data_model.dart';
import 'package:wecode/src/screens/jobs_screen/jobs_screen.dart';
import 'package:wecode/widget/create_profile_textfield.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen(
      {Key? key, required this.weCodeUser, required this.isUpdate})
      : super(key: key);

  final WeCodeUser weCodeUser;
  final bool isUpdate;

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surNameController = TextEditingController();
  TextEditingController githubController = TextEditingController();
  TextEditingController linkedInController = TextEditingController();
  TextEditingController whatsAppController = TextEditingController();

  //* put first value of the item list in dropdownValue.
  String dropdownValue = 'Full Stack Flutter Developer';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile info',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 30,
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Container(
            width: 75,
            margin: EdgeInsets.fromLTRB(0, 5, 20, 0),
            child: ElevatedButton(
              onPressed: () async {
                WeCodeUser newWecodeUser = WeCodeUser(
                  name: nameController.text.isEmpty
                      ? widget.weCodeUser.name
                      : nameController.text,
                  createdAt: DateTime.now(),
                  uid: widget.weCodeUser.uid,
                  email: widget.weCodeUser.email,
                  github: githubController.text,
                  linkedin: linkedInController.text,
                  phone: whatsAppController.text.isEmpty ||
                          whatsAppController.text.length < 8
                      ? widget.weCodeUser.phone
                      : whatsAppController.text,
                  skills: [dropdownValue],
                );

                //TODO: update the current user with the new data
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.weCodeUser.uid)
                    .update(
                      newWecodeUser.toMap(),
                    )
                    .then((value) => Get.to(JobsScreen()));
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(50, 0),
                  primary: Color.fromARGB(255, 70, 155, 74),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50), // <-- Radius
                  ),
                  elevation: 0),
              child: Text(
                "Save",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.weCodeUser.email),
            Text(widget.weCodeUser.uid),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      maxRadius: 52,
                      backgroundColor: Colors.grey[500],
                      //* backgroundImage: , set User image here.
                    ),
                  ],
                ),
                SizedBox(width: 15),
                Column(
                  children: [
                    Text(
                      "Update your Picture",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Upload a photo under 2 MB",
                      style: TextStyle(
                          letterSpacing: 0.5,
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.upload),
                          label: Text(
                            'Upload',
                            style: TextStyle(fontSize: 12),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 77, 165, 146)),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: Text(
                            'Delete Current Picture',
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 13,
                                fontWeight: FontWeight.w800),
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 0, 15),
              child: Text(
                "Name",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 21),
              ),
            ),
            CustomTextFieldForm(
              controller: nameController,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 0, 15),
              child: Text(
                "Surename",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 21),
              ),
            ),
            CustomTextFieldForm(
              controller: surNameController,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 0, 10),
              child: Text(
                "Skils",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 21),
              ),
            ),
            Container(
              width: 365,
              padding: const EdgeInsets.fromLTRB(25, 25, 0, 15),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  fillColor: Color(0xffF6FAFB),
                  filled: true,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                iconSize: 27,
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>[
                  'Full Stack Flutter Developer',
                  'Front end Web Developer',
                  'Data Engineer',
                  'Ui/Ux designer'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 0, 15),
              child: Text(
                "github",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 21),
              ),
            ),
            CustomTextFieldForm(
              controller: githubController,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 0, 15),
              child: Text(
                "Linkedin",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 21),
              ),
            ),
            CustomTextFieldForm(
              controller: linkedInController,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 0, 15),
              child: Text(
                "whatsapp",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 21),
              ),
            ),
            CustomTextFieldForm(
              controller: whatsAppController,
            ),
            SizedBox(
              height: 40,
            ),
            widget.isUpdate != true
                ? Container()
                : Container(
                    margin: EdgeInsets.only(left: 30),
                    width: 325,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Change your password',
                        style: TextStyle(),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 18, 18, 18)),
                    ),
                  ),
            widget.isUpdate != true
                ? Container()
                : Container(
                    margin: EdgeInsets.fromLTRB(115, 25, 0, 75),
                    width: 165,
                    height: 50,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Delete your account',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Color.fromARGB(255, 245, 244, 244),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
