import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wecode/src/common/strings.dart';
import 'package:wecode/src/common/widgets/general_drop_down_widget.dart';
import 'package:wecode/src/common/widgets/loading_indicator.dart';
import 'package:wecode/src/models/vacancy_data_model.dart';
import 'package:wecode/src/models/weCodeUser_data_model.dart';
import 'package:wecode/src/providers/user_provider.dart';
import 'package:wecode/src/screens/Job%20Screen/create_job_screen_view.dart';
import 'package:wecode/src/screens/fav_screen/fav_screen.dart';
import 'package:wecode/src/screens/jobs_screen/bottom_navigation_bar.dart';
import 'package:wecode/src/screens/jobs_screen/button_value_changer.dart';
import 'package:wecode/src/services/auth_service.dart';

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
  String? searchParam;
  List<Vacancy> filteredVacancies = [];
  String? selectedCategory;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Widget build(BuildContext context) {
    final WeCodeUser weCodeUser =
        Provider.of<UserProvider>(context).weCodeUser!;

    return Scaffold(
      floatingActionButton: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green)),
          onPressed: () {
            // Future.delayed(Duration(seconds: 3)).then((value) =>
            // flutterLocalNotificationsPlugin.show(
            //     12,
            //     'hello',
            //     'this is a background notificicaijsdaspfjl c pksdfjlaksdfj',
            //     NotificationDetails());

            // flutterLocalNotificationsPlugin.periodicallyShow(
            //     12,
            //     'hello',
            //     'this is a background notificicaijsdaspfjl c pksdfjlaksdfj',
            //     RepeatInterval.everyMinute,
            //     NotificationDetails());

            Get.to(() {
              return const CreateJobScreen();
            });

            //if you don't want to use the Get package you can navigate like this
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (_) => CreateJobScreen()));
          },
          child: const Text('+ Add a new Vacancy')),
      appBar: AppBar(
        backgroundColor: Colors.green,
        // title: Text('jobs'),
        title: customeText(
            name: 'Jobs',
            fontSize: 20,
            maxLines: 1,
            fontWeight: FontWeight.w800,
            color: Colors.white),
        leading: Text(weCodeUser.email),
        actions: [
          IconButton(
            onPressed: () {
              debugPrint('favorite icon clicked');
              hasNotificationFunction(); // #temporary
              // TODO: open favorite screen

              Get.to(() => const FavoritesScreen());
            },
            icon: const Icon(Icons.favorite_outline, size: 30),
          ),
          // const SizedBox(width: 15),
          notificationIconButton(),
          IconButton(
            onPressed: () async {
              await _authService.logout();
            },
            icon: const Icon(Icons.logout),
            color: Color.lerp(Colors.red, Colors.green, 0.3),
          ),
        ],
      ),
      // sections screen [column].
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('jobs')
            // to search by a query
            // .where('org', isGreaterThan: searchParam)
            .where('category', isEqualTo: selectedCategory)
            // .where('city', isEqualTo: 'Erbil')
            // .where('createdAt', isLessThan: DateTime.now().toIso8601String())
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: SelectableText(snapshot.error.toString()),
            );
          }

          List<Vacancy> _vacancies = snapshot.data!.docs
              .map(
                (e) => Vacancy.fromMap(
                  e.data(),
                ),
              )
              .toList();

          return Column(
            children: [
              // sections screen column > (search) container.
              Container(
                height: 160,
                margin: const EdgeInsets.only(
                    left: 10, top: 20, bottom: 10, right: 10),
                // color: Colors.transparent,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        height: 80,
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(color: Colors.green, width: 4),
                          ),
                        ),
                        // color: Colors.green,
                        child: Card(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  child: const Icon(Icons.search),
                                  onTap: () {
                                    //TODO: add results to a variable ,
                                    setState(() {
                                      searchFunction(
                                          vacancies: _vacancies,
                                          orgName: searchController.text);
                                    });

                                    //TODO: set the list to the variable
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Form(
                                  child: TextFormField(
                                    controller: searchController,
                                    style: const TextStyle(fontSize: 20),
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Search...'),
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
                                  icon: InkWell(
                                    child: const Icon(Icons.close),
                                    onTap: () {
                                      searchController.clear();

                                      setState(() {
                                        filteredVacancies = [];
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    Expanded(
                      child: Container(
                        height: 80,
                        child: GeneralDropDownButton(
                          itemsList: RequiredStrings.jobCategories,
                          selectedItem: selectedCategory,
                          valueChanged: (value) {
                            setState(() {
                              if (value == 'All') {
                                selectedCategory = null;
                              } else {
                                selectedCategory = value;
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.green,
                height: 0,
              ),
              // sections screen column > (body) .
              Expanded(
                  child: snapshot.data == null || snapshot.data!.docs.isEmpty
                      ? Container(
                          child: const Center(
                            child: Text('empty'),
                          ),
                        )
                      : ListView.separated(
                          itemCount: (filteredVacancies.length == 0
                                  ? _vacancies
                                  : filteredVacancies)
                              .length,
                          separatorBuilder: (context, index) => const Divider(
                            indent: 90,
                            endIndent: 20,
                            thickness: 1,
                          ),
                          itemBuilder: (context, index) {
                            // debugPrint(
                            //     '1. from itembuilder ValueChanger.hasNotificationIcon= ${ValueChanger.hasNotification}');
                            return jobVacanciesContainer(
                                vacancy: (filteredVacancies.length == 0
                                    ? _vacancies
                                    : filteredVacancies)[index]);
                          },
                        ))
            ],
          );
        },
      ),
      bottomNavigationBar: const CustomeBottomNavigationBar(),
    );
    //to test provider
    // body: Column(
    //   children: [Expanded(child: ClassOne())],
    // ),
  }

  void searchFunction({required List<Vacancy> vacancies, String? orgName}) {
    // vacan... filter

    if (orgName == null) {
      setState(() {
        filteredVacancies = vacancies;
      });
    }

    filteredVacancies = [];
    setState(() {
      filteredVacancies.addAll(vacancies
          .where(
              (vacancy) => vacancy.org.toUpperCase() == orgName?.toUpperCase())
          .toList());
    });
  }

// ##widget custome card Text() widget
  Widget customeText(
      {required String name,
      required double fontSize,
      FontWeight? fontWeight,
      double? letterSpacing,
      int? maxLines,
      Color? color}) {
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              color: color),
          maxLines: maxLines,
        ),
        const SizedBox(
          height: 7,
        )
      ],
    );
  }

// ##widget this widget is returned by itemBuilder inside listview.seperated
  Widget jobVacanciesContainer({required Vacancy vacancy}) {
    IconData favIcon = Icons.favorite_outline;
    IconData favIconFill = Icons.favorite;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 120,
      // color: Colors.grey,
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Center(
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      final box = Hive.box('favBox');
                      box.put(
                          vacancy.createdAt.toIso8601String(), vacancy.toMap());

                      final dataFromBox =
                          box.get(vacancy.createdAt.toIso8601String());
                      Vacancy _vacancyFromBox = Vacancy.fromMap(dataFromBox);

                      debugPrint(_vacancyFromBox.toString());

                      // ButtonValueChanger.favRecord =
                      //     !ButtonValueChanger.favRecord;
                      // debugPrint(
                      //     'favIcon in record: $theRecord clicked, favIconBool= $favIconBool');
                    });
                  },
                  icon: Icon(favIconFill)),
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
                      name: vacancy.org,
                      fontSize: 017,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.4,
                      maxLines: 1),
                  customeText(
                      name: vacancy.user.name,
                      fontSize: 017,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                      maxLines: 1),
                  customeText(
                      name: '${vacancy.title} • ${vacancy.type}',
                      fontSize: 014,
                      letterSpacing: 0.4,
                      maxLines: 2),
                  customeText(
                    name: vacancy.city,
                    fontSize: 14,
                    maxLines: 1,
                  ),
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
