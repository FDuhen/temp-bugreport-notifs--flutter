import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

// Listening incoming notification when the app is inactive or killed (background)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  debugPrint("Handling a background message: ${message.messageId}");
}

class NotificationManager extends ChangeNotifier {
  final _messaging = FirebaseMessaging.instance;

  AuthorizationStatus? _currentAuthorization;
  AuthorizationStatus? get currentAuthorization => _currentAuthorization;

  String? _token;
  String? get deviceToken => _token;

  Future<void> askNotifificationPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      announcement: true,
      criticalAlert: true,
      sound: true,
    );

    // Listening incoming notification when the app is active (foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message foreground!');
      debugPrint('Message data: ${message.data}');

      if (message.notification != null) {
        debugPrint('Message also contained a notification: ${message.notification}');
      }
    });

    final token = await _messaging.getToken();

    debugPrint('User granted permission: ${settings.authorizationStatus}');
    _currentAuthorization = settings.authorizationStatus;
    // The token can be used in Firebase panel to test the notification for this device
    debugPrint('token: $token');
    _token = token;
    notifyListeners();
  }
}
