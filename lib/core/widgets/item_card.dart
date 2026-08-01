
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/constants/item_categories.dart';
import '../../core/utils/date_formatter.dart';
import '../../data/models/item_model.dart';

/// A single found-item card shown in the home feed.
class ItemCard extends StatelessWidget {
  final ItemModel item;
  final VoidCallback onTap;

  const ItemCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 96,
              height: 96,
              child: item.photoUrl.isEmpty
                  ? Container(
                      color: AppColors.border,
                      child: const Icon(Icons.image_not_supported_outlined),
                    )
                  : CachedNetworkImage(
                      imageUrl: item.photoUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(color: AppColors.border),
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.category.label, style: AppTextStyles.heading2),
                    const SizedBox(height: 4),
                    Text(
                      '${item.placeDescription}, ${item.city}',
                      style: AppTextStyles.caption,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      DateFormatter.relative(item.createdAt),
                      style: AppTextStyles.caption.copyWith(color: AppColors.primary),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
