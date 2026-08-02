import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/item_categories.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../controllers/post_item_controller.dart';

/// Shows different structured fields depending on the selected category.
/// Keep these fields non-sensitive — enough to help verify ownership,
/// never enough to expose the full document/card number publicly.
class CategoryFieldsForm extends GetView<PostItemController> {
  const CategoryFieldsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final category = controller.category.value;
      if (category == null) return const SizedBox.shrink();

      final fields = _fieldsFor(category);
      if (fields.isEmpty) return const SizedBox.shrink();

      return Column(
        children: fields
            .map(
              (label) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CustomTextField(
                  label: label,
                  controller: TextEditingController(),
                  // In a real build, back this with a controller kept in a
                  // map so text isn't lost on rebuild; simplified for MVP.
                ),
              ),
            )
            .toList(),
      );
    });
  }

  List<String> _fieldsFor(ItemCategory category) {
    switch (category) {
      case ItemCategory.idCard:
        return ['Name initials (e.g. J.D.)', 'Expiry year'];
      case ItemCategory.passport:
        return ['Issuing country', 'Expiry year'];
      case ItemCategory.creditCard:
        return ['Bank name', 'Card network (Visa/Mastercard)'];
      case ItemCategory.document:
        return ['Document type'];
      case ItemCategory.wallet:
        return ['Color', 'Brand (optional)'];
      case ItemCategory.phone:
        return ['Brand and model', 'Color'];
      case ItemCategory.keys:
        return ['Keychain description'];
      case ItemCategory.other:
        return [];
    }
  }
}
