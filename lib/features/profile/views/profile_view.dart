import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/widgets/custom_button.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = controller.user;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 36, child: Text(user?.name.isNotEmpty == true ? user!.name[0] : '?')),
            const SizedBox(height: 16),
            Text(user?.name ?? '', style: AppTextStyles.heading1),
            const SizedBox(height: 4),
            Text(user?.city ?? '', style: AppTextStyles.caption),
            const SizedBox(height: 4),
            Text(user?.phone ?? '', style: AppTextStyles.caption),
            const SizedBox(height: 4),
            Text('Rating: ${user?.rating.toStringAsFixed(1) ?? '0.0'} ★', style: AppTextStyles.body),
            const Spacer(),
            CustomButton(label: 'Log out', onPressed: controller.logout),
          ],
        ),
      ),
    );
  }
}
