import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify your number')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter the 6-digit code we sent you',
              style: AppTextStyles.heading2,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: 'Verification code',
              controller: controller.otpController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.errorMessage.value == null)
                return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  controller.errorMessage.value!,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }),
            Obx(
              () => CustomButton(
                label: 'Verify & continue',
                isLoading: controller.isLoading.value,
                onPressed: () {
                  debugPrint('OTP entered: ${controller.otpController.text}');
                  debugPrint("Error message: ${controller.errorMessage.value}");
                  controller.verifyOtp();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
