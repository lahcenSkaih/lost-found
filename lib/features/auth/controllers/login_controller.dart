import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/services/auth_service.dart';

class LoginController extends GetxController {
  final AuthService _authService = Get.find();

  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final cityController = TextEditingController();

  final isLoading = false.obs;
  final errorMessage = RxnString();

  void sendOtp() async {
    if (phoneController.text.trim().isEmpty ||
        nameController.text.trim().isEmpty) {
      errorMessage.value = 'Please fill in your name and phone number';
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    await _authService.sendOtp(
      phoneNumber: phoneController.text.trim(),
      onCodeSent: (verificationId) {
        isLoading.value = false;
        Get.toNamed(
          AppRoutes.otp,
          arguments: {
            'name': nameController.text.trim(),
            'city': cityController.text.trim(),
          },
        );
      },
      onError: (error) {
        isLoading.value = false;
        // errorMessage.value = error;
        debugPrint('Error sending OTP: $error');
        errorMessage.value =
            "Something broken on the server, please try again later.";
      },
    );
  }

  @override
  void onClose() {
    phoneController.dispose();
    nameController.dispose();
    cityController.dispose();
    super.onClose();
  }
}
