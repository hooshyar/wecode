import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wecode/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wecode/src/models/vacancy_data_model.dart';
import 'package:wecode/src/providers/user_provider.dart';
import 'package:wecode/src/services/push_notifications_service.dart';
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
      AndroidInitializationSettings("mipmap/ic_launcher");

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
  final String? fcmToken = await FirebaseMessaging.instance.getToken();
  print("FCM" + ':' + (fcmToken ?? 'no token'));

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('Handling a background message ${message.messageId}');
  }

  FirebaseMessaging.onBackgroundMessage(
      (message) => _firebaseMessagingBackgroundHandler(message));

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.notification}');
    if (message.notification != null) {
      // flutterLocalNotificationsPlugin.show(
      //     message.hashCode,
      //     message.notification!.title,
      //     message.notification!.body,
      //     NotificationDetails(
      //       android: AndroidNotificationDetails(
      //         PushNotifService.androidChannel.id,
      //         PushNotifService.androidChannel.name,
      //         channelDescription: PushNotifService.androidChannel.description,
      //         // icon: android.smallIcon,
      //         // other properties...
      //       ),
      //     ));

      Get.snackbar(message.notification!.title!, message.notification!.body!);
    } else {
      Get.snackbar('null', 'notification is null');
    }

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

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
