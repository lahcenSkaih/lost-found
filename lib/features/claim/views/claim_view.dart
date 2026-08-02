import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../controllers/claim_controller.dart';

class ClaimView extends GetView<ClaimController> {
  const ClaimView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify ownership')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Answer a couple of questions so the finder can confirm '
              'this item is really yours before sharing contact details.',
              style: AppTextStyles.body,
            ),
            const SizedBox(height: 20),
            ...controller.questions.map(
              (q) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CustomTextField(
                  label: q,
                  controller: controller.answerControllers[q]!,
                  maxLines: 2,
                ),
              ),
            ),
            Obx(() {
              if (controller.errorMessage.value == null) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(controller.errorMessage.value!, style: const TextStyle(color: Colors.red)),
              );
            }),
            Obx(() => CustomButton(
                  label: 'Submit claim',
                  isLoading: controller.isLoading.value,
                  onPressed: controller.submitClaim,
                )),
          ],
        ),
      ),
    );
  }
}
