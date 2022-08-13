// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  //* put first value of the item list in dropdownValue.
  String dropdownValue = 'One';
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
              onPressed: () {},
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
            CustomTextFieldForm(),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 0, 15),
              child: Text(
                "Surename",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 21),
              ),
            ),
            CustomTextFieldForm(),
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
                items: <String>['One', 'Two', 'Free', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
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
            CustomTextFieldForm(),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 0, 15),
              child: Text(
                "Linkedin",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 21),
              ),
            ),
            CustomTextFieldForm(),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 0, 15),
              child: Text(
                "whatsapp",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 21),
              ),
            ),
            CustomTextFieldForm(),
            SizedBox(
              height: 40,
            ),
            Container(
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
            Container(
              margin: EdgeInsets.fromLTRB(115, 25, 0, 75),
              width: 165,
              height: 50,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Delete your account',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
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