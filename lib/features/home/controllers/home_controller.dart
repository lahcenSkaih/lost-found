import 'package:get/get.dart';
import '../../../core/constants/item_categories.dart';
import '../../../core/services/auth_service.dart';
import '../../../data/models/item_model.dart';
import '../../../data/repositories/item_repository.dart';

class HomeController extends GetxController {
  final ItemRepository _itemRepo = ItemRepository();
  final AuthService _authService = Get.find();

  final items = <ItemModel>[].obs;
  final isLoading = false.obs;
  final Rxn<ItemCategory> selectedCategory = Rxn<ItemCategory>();

  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }

  Future<void> fetchItems() async {
    isLoading.value = true;
    final city = _authService.currentUser.value?.city ?? '';
    items.value = await _itemRepo.getItemsByCityAndCategory(
      city: city,
      category: selectedCategory.value,
    );
    isLoading.value = false;
  }

  void setCategory(ItemCategory? category) {
    selectedCategory.value = category;
    fetchItems();
  }
}
