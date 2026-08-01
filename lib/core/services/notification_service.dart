import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

/// Wraps FCM. Cloud Functions (server-side) should do the actual
/// "match a new found item to nearby lost reports" logic and send the
/// push; this service just registers the device and handles foreground
/// messages.
class NotificationService extends GetxService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    await _messaging.requestPermission();
    final token = await _messaging.getToken();
    // TODO: save `token` on the user's Firestore doc so Cloud Functions
    // can target this device.
    debugTokenLog(token);

    FirebaseMessaging.onMessage.listen((message) {
      // TODO: show an in-app banner / update a badge count.
    });
  }

  void debugTokenLog(String? token) {
    // ignore: avoid_print
    print('FCM token: $token');
  }
}
