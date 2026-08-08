import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lost_found/core/services/auth_service.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint("SplashController initialized");
      checkUserState();
    });
  }

  checkUserState() async {
    final AuthService authService = Get.find<AuthService>();
    await authService.checkUserLoginStatus();

    // Check if the user is logged in or not
    // Navigate to the appropriate screen based on the user's state
  }
}
