import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wecode/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
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
      AndroidInitializationSettings("mipmap/ic_launcher");

  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          onDidReceiveLocalNotification: (id, title, body, payload) {
    debugPrint('on foreground : $id');
    debugPrint(title);
    debugPrint(body);
    debugPrint(payload);
  });

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (value) => debugPrint('tapped$value'));
  final String? fcmToken = await FirebaseMessaging.instance.getToken();
  debugPrint("FCM" ':' + (fcmToken ?? 'no token'));

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    debugPrint('Handling a background message ${message.messageId}');
  }

  FirebaseMessaging.onBackgroundMessage(
      (message) => _firebaseMessagingBackgroundHandler(message));

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('Got a message whilst in the foreground!');
    debugPrint('Message data: ${message.notification}');
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
      debugPrint('Message also contained a notification: ${message.notification}');
    }
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NumberProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider())
      ],
      child: const WeCodeApp(),
    ),
  );
}
