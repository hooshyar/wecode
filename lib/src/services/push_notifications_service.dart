import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotifService {
  static const AndroidNotificationChannel androidChannel =
      AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
    playSound: true,
  );
}
