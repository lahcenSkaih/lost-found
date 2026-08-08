import 'package:get/get.dart';
import 'package:lost_found/features/splash/controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
      Get.put(SplashController());
    // Get.put<SplashController>(() => SplashController());
  }
}
