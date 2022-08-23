import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wecode/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wecode/src/models/vacancy_data_model.dart';
import 'package:wecode/src/providers/user_provider.dart';
import 'package:wecode/src/temp/number_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  final favBox = await Hive.openBox('favBox');
  // favBox.delete('jobId');
  // debugPrint(favBox.get('jobId'));

  // and instance from the local notifications plugin
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //android init
  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          onDidReceiveLocalNotification: (id, title, body, payload) {
    print('on foreground : ' + id.toString());
    print(title);
    print(body);
    print(payload);
  });

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (value) => print('tapped' + value.toString()));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NumberProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider())
      ],
      child: WeCodeApp(),
    ),
  );
}
