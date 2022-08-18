import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wecode/src/common/strings.dart';
import 'package:wecode/src/common/widgets/general_drop_down_widget.dart';
import 'package:wecode/src/models/vacancy_data_model.dart';
import 'package:wecode/src/models/weCodeUser_data_model.dart';
import 'package:wecode/src/providers/user_provider.dart';
import 'package:wecode/src/services/firestore_service.dart';

class CreateJobScreen extends StatefulWidget {
  CreateJobScreen({Key? key}) : super(key: key);

  @override
  State<CreateJobScreen> createState() => deferent();
}

class deferent extends State<CreateJobScreen> {
  List<String> citysList = [
    'Erbil',
    'Duhok',
    'Slemmany',
    'Karkuk',
    'Zakho',
    'Halabja'
  ];

  FireStoreService _fireStoreService = FireStoreService();

  List<String> typeList = ['Full Time', 'Part Time', 'Remote', 'Intern'];

  String? selectedtypeOfJob;
  String? selectedCity = 'Erbil';
  String? selectedCategory = RequiredStrings.jobCategories.first;

  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  TextEditingController organizationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          foregroundColor: Colors.red,
          title: Text(
            'JOB INFO',
            style: headerTextStyle(),
          ),
          actions: [
            IconButton(
              color: Colors.red,
              onPressed: () {},
              icon: Icon(Icons.save),
            )
          ]),
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // to fix asset image error
              // Container(
              //   margin: EdgeInsets.only(top: 40, bottom: 20),
              //   child: Image.asset('assets/images/job.png'),
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //* Type of the Job
                  //header.
                  headerInformationOfInputs(name: 'Type'),
                  // space between header and Input.
                  spaceBetweenHeaderAndInput(),
                  // DropDown Button for Type of Jobs.
                  GeneralDropDownButton(
                      selectedItem: selectedtypeOfJob,
                      itemsList: typeList,
                      valueChanged: (job) => selectedtypeOfJob = job),

                  ///
                  ///
                  ///

                  //* Title of the Job
                  // space between header and Input.
                  spaceBetweenHeaderAndInput(),
                  // TextField for title of the job
                  textField(
                      name: 'Title',
                      textController: titleTextEditingController),

                  ///
                  ///
                  ///

                  //* Description of Job
                  // space between header and input widget
                  spaceBetweenHeaderAndInput(),
                  // DropDown Button for city
                  textField(
                      textController: descriptionTextEditingController,
                      name: 'Description'),

                  ///
                  ///
                  ///

                  //* Organization
                  // space between header and input widget
                  spaceBetweenHeaderAndInput(),
                  // DropDown Button for city
                  textField(
                      textController: organizationController,
                      name: 'Organization'),

                  ///
                  ///
                  ///

                  //* City
                  // Space between 2 input Widget
                  spaceBetweenHeaderAndInput(),
                  // header
                  headerInformationOfInputs(name: 'City'),
                  // space between header and input widget
                  spaceBetweenHeaderAndInput(),
                  // DropDown Button for city
                  GeneralDropDownButton(
                      selectedItem: selectedCity,
                      itemsList: citysList,
                      valueChanged: (city) => setState(() {
                            selectedCity = city;
                          })),

                  ///
                  ///
                  ///

                  //* Category
                  // Space between 2 input Widget
                  spaceBetweenHeaderAndInput(),
                  // header
                  headerInformationOfInputs(name: 'Category'),
                  // space between header and input widget
                  spaceBetweenHeaderAndInput(),
                  // DropDown Button for city
                  GeneralDropDownButton(
                      selectedItem: selectedCategory,
                      itemsList: RequiredStrings.jobCategories,
                      valueChanged: (value) => selectedCategory = value),
                  spaceBetweenHeaderAndInput(),

                  ElevatedButton.icon(
                      onPressed: () {
                        WeCodeUser? weCodeUser =
                            context.read<UserProvider>().weCodeUser;
                        if (weCodeUser != null) {
                          Vacancy _vacancy = Vacancy(
                              type: selectedtypeOfJob ?? typeList.first,
                              title: titleTextEditingController.text,
                              description:
                                  descriptionTextEditingController.text,
                              org: organizationController.text,
                              city: selectedCity ??
                                  citysList.firstWhere(
                                      (element) => element == 'Erbil'),
                              category: selectedCategory ??
                                  RequiredStrings.jobCategories.first,
                              createdAt: DateTime.now(),
                              expDate: DateTime.now().add(Duration(days: 15)),
                              user: weCodeUser);

                          Get.defaultDialog(
                            title: 'values',
                            content: Container(
                              height: 500,
                              child: Column(
                                children: [
                                  Expanded(child: Text(_vacancy.toString())),
                                  ElevatedButton(
                                      onPressed: () async {
                                        //TODO: _loading

                                        await _fireStoreService
                                            .addNewVacancy(_vacancy)
                                            .then((value) {
                                          debugPrint(" ref id  :  " + value.id);
                                          Navigator.of(context).pop();
                                        });
                                      },
                                      child: Text('Are you sure? '))
                                ],
                              ),
                            ),
                          );
                        } else {
                          Get.snackbar('Error',
                              'You don\'t have the privileges to do that ');
                        }
                      },
                      icon: Icon(Icons.add),
                      label: Text('Add a New Vacancy')),

                  ///
                  ///
                  ///
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // this is the style of header text
  // Have Font Weight Bold and font Size 24
  TextStyle headerTextStyle() {
    return TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
  }

  // Information Header Text Style [ City , Category , ... etc]
  // Font Weight is BOLD.
  TextStyle informationHeaderOfInputsTextStyle() {
    return TextStyle(
      fontWeight: FontWeight.bold,
    );
  }

  // Drop Down Button form field
  // required 2 parameter ( selectedItem and List of Items)
  // List of items is the items that will show when drop down is pressed
  // Sized Box used to resize the Drop Down button : Size ( 350 )
  // the size will be different for other platforms
  // the drop down button controller will return String
  // using ( drop DownItemStyle() ) is a method that user define is this file
  // Widget dropDownButton(
  //     {required String? selectedItem,
  //     required List<String> itemsList,
  //     required valueChanged}) {
  //   final ValueChanged<String> valueChanged;
  //   return SizedBox(
  //     width: 350,
  //     child: DropdownButtonFormField<String>(
  //         decoration: InputDecoration(
  //             focusedBorder:
  //                 OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
  //             enabledBorder: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(5),
  //                 borderSide: BorderSide(
  //                   color: Colors.red,
  //                   width: 1,
  //                 ))),
  //         value: selectedItem,
  //         items: itemsList
  //             .map((item) => DropdownMenuItem(
  //                 value: item,
  //                 child: Text(
  //                   item,
  //                   style: dropDownItemStyle(),
  //                 )))
  //             .toList(),
  //         onChanged: (item) {
  //           // setState(() {

  //           //     selec = item;
  //           //   });
  //           valueChanged(item!);
  //         }),
  //   );

  // }

  // this is the header of the text field and drop down button.
  Widget headerInformationOfInputs({required String name}) {
    return Container(
      margin: EdgeInsets.only(right: 290, left: 24),
      child: Text(
        name,
        style: informationHeaderOfInputsTextStyle(),
      ),
    );
  }

  // space between the header and input widget
  Widget spaceBetweenHeaderAndInput() {
    return SizedBox(
      height: 15,
    );
  }

  // space between 2 input widget
  Widget spaceBetweenTwoInput() {
    return SizedBox(
      height: 40,
    );
  }

  // text field
  Widget textField(
      {required TextEditingController textController, required String name}) {
    return Container(
      width: 340,
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.red),
            label: Text(name),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.red))),
      ),
    );
  }
}
