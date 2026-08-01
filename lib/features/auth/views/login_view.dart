import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.search_rounded, size: 56),
              const SizedBox(height: 16),
              Text('Welcome to Lost & Found', style: AppTextStyles.heading1),
              const SizedBox(height: 4),
              Text(
                'Help reunite people with what they lost.',
                style: AppTextStyles.caption,
              ),
              const SizedBox(height: 32),
              CustomTextField(label: 'Full name', controller: controller.nameController),
              const SizedBox(height: 16),
              CustomTextField(label: 'City', controller: controller.cityController),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Phone number (e.g. +212600000000)',
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),
              Obx(() {
                if (controller.errorMessage.value == null) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    controller.errorMessage.value!,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }),
              Obx(() => CustomButton(
                    label: 'Send verification code',
                    isLoading: controller.isLoading.value,
                    onPressed: controller.sendOtp,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
