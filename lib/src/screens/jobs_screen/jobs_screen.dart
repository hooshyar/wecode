import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wecode/src/models/weCodeUser_data_model.dart';
import 'package:wecode/src/providers/user_provider.dart';
import 'package:wecode/src/screens/Job%20Screen/create_job_screen_view.dart';
import 'package:wecode/src/screens/jobs_screen/button_value_changer.dart';
import 'package:wecode/src/services/auth_service.dart';
import 'package:wecode/src/temp/class1.dart';

///
///  # temporary codes
///  ## widgets
///  ### methods
///

class JobsScreen extends StatefulWidget {
  const JobsScreen({Key? key}) : super(key: key);

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  final TextEditingController searchController = TextEditingController();
  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final WeCodeUser weCodeUser =
        Provider.of<UserProvider>(context).weCodeUser!;

    return Scaffold(
      floatingActionButton: ElevatedButton(
          onPressed: () {
            Get.to(() => CreateJobScreen());

            //if you don't want to use the Get package you can navigate like this
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (_) => CreateJobScreen()));
          },
          child: Text('Add a new Vacancy')),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('jobs'),
        leading: Text(weCodeUser.email),
        actions: [
          IconButton(
              onPressed: () async {
                await _authService.logout();
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      // sections screen [column].
      body: Column(
        children: [
          // sections screen column > (header) container.

          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            color: Colors.yellow,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Job\nFinder',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        debugPrint('favorite icon clicked');
                        hasNotificationFunction(); // #temporary
                        // TODO: open favorite screen
                      },
                      icon: const Icon(Icons.favorite, size: 30),
                    ),
                    // const SizedBox(width: 15),
                    notificationIconButton()
                  ],
                )
              ],
            ),
          ),
          // sections screen column > (search) container.
          Container(
            height: 80,
            margin: const EdgeInsets.only(left: 60, top: 20, bottom: 20),
            // color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: const Border(
                  left: BorderSide(color: Colors.yellow, width: 4),
                ),
              ),
              // color: Colors.green,
              child: Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Icon(Icons.search),
                  ),
                  Expanded(
                    flex: 5,
                    child: Form(
                      child: TextFormField(
                        controller: searchController,
                        style: const TextStyle(fontSize: 20),
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Search...'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {
                        debugPrint(
                            'searchController= ${searchController.text}'); // #temporary
                        // to clear the text input form
                        searchController.clear();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  )
                ],
              ),
            ),
          ),
          // sections screen column > (body) .
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (context, index) => const Divider(
                indent: 90,
                endIndent: 20,
                thickness: 1,
              ),
              itemBuilder: (context, index) {
                // debugPrint(
                //     '1. from itembuilder ValueChanger.hasNotificationIcon= ${ValueChanger.hasNotification}');
                return jobVacanciesContainer(
                  theRecord: {index + 1}.toString(),
                  companyName: 'The Company',
                  companyJobPosition: 'Junior developer',
                  companyJobType: 'Full Time',
                  companyJobSalary: 92000,
                  favIconBool: !ButtonValueChanger.favRecord,
                );
              },
            ),
          )
        ],
      ),

      //to test provider
      // body: Column(
      //   children: [Expanded(child: ClassOne())],
      // ),
    );
  }

// ##widget custome card Text() widget
  Widget customeText(
      {required String name,
      required double fontSize,
      FontWeight? fontWeight,
      double? letterSpacing}) {
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing),
        ),
        const SizedBox(
          height: 7,
        )
      ],
    );
  }

// ##widget this widget is returned by itemBuilder inside listview.seperated
  Widget jobVacanciesContainer({
    required String theRecord,
    required String companyName,
    required String companyJobPosition,
    required String companyJobType,
    required int companyJobSalary,
    required bool favIconBool,
  }) {
    IconData favIcon = Icons.favorite_outline;
    IconData favIconFill = Icons.favorite;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 100,
      // color: Colors.grey,
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Center(
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      ButtonValueChanger.favRecord =
                          !ButtonValueChanger.favRecord;
                      debugPrint(
                          'favIcon in record: $theRecord clicked, favIconBool= $favIconBool');
                    });
                  },
                  icon: Icon(favIconBool ? favIconFill : favIcon)),
            ),
          ),
          // SizedBox(width: 20,),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customeText(
                      name: companyName,
                      fontSize: 017,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.4),
                  customeText(
                      name: '$companyJobPosition • $companyJobType',
                      fontSize: 014,
                      letterSpacing: 0.4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      customeText(
                        name: '\$$companyJobSalary ',
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                      customeText(name: 'Year', fontSize: 14)
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

// ##widget this widget handle the notificationIconButton state if it has notification or not.
  Widget notificationIconButton() {
    IconData notificationIcon = Icons.notifications_outlined; // off
    IconData hasNotificationIcon = Icons.notifications_active; // on

    return IconButton(
      onPressed: () {
        if (ButtonValueChanger.hasNotification) {
          setState(() {
            ButtonValueChanger.hasNotification = false;
          });
        }
        debugPrint('notifications icon clicked');
        debugPrint(
            'ValueChanger.hasNotification= ${ButtonValueChanger.hasNotification.toString()}');
        // TODO: open notification list here
      },
      icon: Icon(
          ButtonValueChanger.hasNotification
              ? hasNotificationIcon
              : notificationIcon,
          size: 30),
    );
  }

// ###method this hasNotificationFunction function is used to change notification icon status, while invoking it.
  void hasNotificationFunction() {
    setState(() {
      ButtonValueChanger.hasNotification = true;
    });
    debugPrint(
        'hasNotificationFunction() executed •• ValueChanger.hasNotification= ${ButtonValueChanger.hasNotification.toString()}');
  }
}
