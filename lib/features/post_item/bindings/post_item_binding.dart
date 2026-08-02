import 'package:get/get.dart';
import '../controllers/post_item_controller.dart';

class PostItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostItemController());
  }
}
