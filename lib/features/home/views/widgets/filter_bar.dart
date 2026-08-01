import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/constants/item_categories.dart';
import '../../controllers/home_controller.dart';

class FilterBar extends GetView<HomeController> {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selected = controller.selectedCategory.value;
      return SizedBox(
        height: 40,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            _chip(
              context,
              label: 'All',
              isSelected: selected == null,
              onTap: () => controller.setCategory(null),
            ),
            ...ItemCategory.values.map(
              (c) => _chip(
                context,
                label: c.label,
                isSelected: selected == c,
                onTap: () => controller.setCategory(c),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _chip(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onTap(),
        selectedColor: AppColors.primary,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : AppColors.textPrimary,
        ),
      ),
    );
  }
}
