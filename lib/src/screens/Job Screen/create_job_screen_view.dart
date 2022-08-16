import 'package:flutter/material.dart';

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

  List<String> typeList = ['Full Time', 'Part Time', 'Remote', 'Intern'];

  List<String> categoryList = ['one', 'Two', 'Three', 'Four', 'Five'];

  String? selectedtypeOfJob = 'Full Time';
  String? selectdCity = 'Erbil';
  String? selectedCatigory = 'one';

  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
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
                  dropDownButton(
                      selectedItem: selectedtypeOfJob, itemsList: typeList),

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
                      textController: descriptionTextEditingController,
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
                  dropDownButton(
                      selectedItem: selectdCity, itemsList: citysList),

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
                  dropDownButton(
                      selectedItem: selectedCatigory, itemsList: categoryList),
                  spaceBetweenHeaderAndInput(),

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

  // Style of text inside Drop Down Button
  TextStyle dropDownItemStyle() {
    return TextStyle(
      fontSize: 15,
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
  Widget dropDownButton(
      {required String? selectedItem, required List<String> itemsList}) {
    return SizedBox(
      width: 350,
      child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
              focusedBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 1,
                  ))),
          value: selectedItem,
          items: itemsList
              .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: dropDownItemStyle(),
                  )))
              .toList(),
          onChanged: (item) => setState(() {
                selectedItem = item;
              })),
    );
  }

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
