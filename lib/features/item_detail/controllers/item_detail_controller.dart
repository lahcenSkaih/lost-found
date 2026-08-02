import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../data/models/item_model.dart';

class ItemDetailController extends GetxController {
  late final ItemModel item;

  @override
  void onInit() {
    super.onInit();
    item = Get.arguments as ItemModel;
  }

  void goToClaim() {
    Get.toNamed(AppRoutes.claim, arguments: item);
  }
}
