import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestPermission();

      // RemoteMessage initialMsg =
      //     await FirebaseMessaging.instance.getInitialMessage();

      // FirebaseMessaging.onMessage.any(
      //   (element) {
      //     print(element);
      //     return true;
      //   },
      // );

      // print("INITIAL MSG " + initialMsg.toString());

      FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
        print(
            "NOOOOOOOTIIIIIII FIIIIIIII : : : : " + message.notification.body);
      });
      _initialized = true;
    }
  }
}
