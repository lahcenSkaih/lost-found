import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/widgets/item_card.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../controllers/home_controller.dart';
import 'widgets/filter_bar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby found items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.map_outlined),
            onPressed: () => Get.toNamed(AppRoutes.map),
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => Get.toNamed(AppRoutes.profile),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: controller.fetchItems,
        child: Column(
          children: [
            const SizedBox(height: 8),
            const FilterBar(),
            const SizedBox(height: 8),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) return const LoadingIndicator();
                if (controller.items.isEmpty) {
                  return const Center(
                    child: Text('No items reported nearby yet.'),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = controller.items[index];
                    return ItemCard(
                      item: item,
                      onTap: () =>
                          Get.toNamed(AppRoutes.itemDetail, arguments: item),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(AppRoutes.postItem),
        icon: const Icon(Icons.add_a_photo_outlined),
        label: const Text('Report found item'),
      ),
    );
  }
}
