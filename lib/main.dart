import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'app/app.dart';
import 'core/services/auth_service.dart';
import 'core/services/location_service.dart';
import 'core/services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: run `flutterfire configure` and replace this with
  // Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
  await Firebase.initializeApp();

  // Global, app-wide services (available anywhere via Get.find())
  Get.put(AuthService(), permanent: true);
  Get.put(LocationService(), permanent: true);
  Get.put(NotificationService(), permanent: true);

  runApp(const LostFoundApp());
}
