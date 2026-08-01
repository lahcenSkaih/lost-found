import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lost_found/core/constants/item_categories.dart';
import '../../../core/services/auth_service.dart';
import '../../../data/models/item_model.dart';
import '../../../data/repositories/item_repository.dart';

// Named MapPageController (not MapController) to avoid clashing with
// google_maps_flutter's own MapController-like classes.
class MapPageController extends GetxController {
  final ItemRepository _itemRepo = ItemRepository();
  final AuthService _authService = Get.find();

  final items = <ItemModel>[].obs;
  final markers = <Marker>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }

  Future<void> fetchItems() async {
    final city = _authService.currentUser.value?.city ?? '';
    items.value = await _itemRepo.getItemsByCityAndCategory(city: city);
    markers.value = items.value
        .map(
          (item) => Marker(
            markerId: MarkerId(item.id),
            position: LatLng(item.latitude, item.longitude),
            infoWindow: InfoWindow(
              title: item.category.label,
              snippet: item.placeDescription,
            ),
          ),
        )
        .toSet();
  }
}
