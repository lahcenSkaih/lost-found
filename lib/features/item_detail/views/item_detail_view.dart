import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/constants/item_categories.dart';
import '../../../core/widgets/custom_button.dart';
import '../controllers/item_detail_controller.dart';

class ItemDetailView extends GetView<ItemDetailController> {
  const ItemDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final item = controller.item;

    return Scaffold(
      appBar: AppBar(title: Text(item.category.label)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.2,
              child: item.photoUrl.isEmpty
                  ? Container(color: AppColors.border)
                  : CachedNetworkImage(imageUrl: item.photoUrl, fit: BoxFit.cover),
            ),
            if (item.category.isSensitive)
              Container(
                width: double.infinity,
                color: AppColors.accent.withOpacity(0.15),
                padding: const EdgeInsets.all(12),
                child: const Text(
                  'This photo is blurred to protect the owner\'s personal '
                  'information. The full photo is only shown once your claim '
                  'is verified and approved by the finder.',
                  style: AppTextStyles.caption,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.category.label, style: AppTextStyles.heading1),
                  const SizedBox(height: 4),
                  Text('${item.placeDescription}, ${item.city}', style: AppTextStyles.body),
                  const SizedBox(height: 16),
                  if (item.structuredFields.isNotEmpty) ...[
                    Text('Details', style: AppTextStyles.heading2),
                    const SizedBox(height: 8),
                    ...item.structuredFields.entries.map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text('${e.key}: ${e.value}', style: AppTextStyles.body),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (item.description.isNotEmpty) ...[
                    Text('Description', style: AppTextStyles.heading2),
                    const SizedBox(height: 8),
                    Text(item.description, style: AppTextStyles.body),
                    const SizedBox(height: 24),
                  ],
                  CustomButton(label: 'This is mine — claim it', onPressed: controller.goToClaim),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
