import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/services/auth_service.dart';

class OtpController extends GetxController {
  final AuthService _authService = Get.find();

  final otpController = TextEditingController();
  final isLoading = false.obs;
  final errorMessage = RxnString();

  late String name;
  late String city;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    name = args['name'] ?? '';
    city = args['city'] ?? '';
  }

  void verifyOtp() async {
    if (otpController.text.trim().length != 6) {
      errorMessage.value = 'Enter the 6-digit code';
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    try {
      await _authService.verifyOtp(
        smsCode: otpController.text.trim(),
        name: name,
        city: city,
      );
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}
