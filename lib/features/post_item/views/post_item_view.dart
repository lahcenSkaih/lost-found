import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/constants/item_categories.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../controllers/post_item_controller.dart';
import 'widgets/category_fields_form.dart';

class PostItemView extends GetView<PostItemController> {
  const PostItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report a found item')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Category', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Obx(() => Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ItemCategory.values
                      .map((c) => ChoiceChip(
                            label: Text(c.label),
                            selected: controller.category.value == c,
                            onSelected: (_) => controller.setCategory(c),
                          ))
                      .toList(),
                )),
            const SizedBox(height: 20),
            Text('Photo', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Obx(() {
              final img = controller.pickedImage.value;
              return GestureDetector(
                onTap: controller.pickImage,
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(12),
                    image: img != null ? DecorationImage(image: FileImage(img), fit: BoxFit.cover) : null,
                  ),
                  child: img == null
                      ? const Center(child: Icon(Icons.add_a_photo_outlined, size: 32))
                      : null,
                ),
              );
            }),
            const SizedBox(height: 20),
            const CategoryFieldsForm(),
            CustomTextField(label: 'Where did you find it?', controller: controller.placeController),
            const SizedBox(height: 12),
            CustomTextField(
              label: 'Additional description',
              controller: controller.descriptionController,
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: controller.useCurrentLocation,
              icon: const Icon(Icons.my_location),
              label: const Text('Use current location'),
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.errorMessage.value == null) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(controller.errorMessage.value!, style: const TextStyle(color: Colors.red)),
              );
            }),
            Obx(() => CustomButton(
                  label: 'Post found item',
                  isLoading: controller.isLoading.value,
                  onPressed: controller.submit,
                )),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
