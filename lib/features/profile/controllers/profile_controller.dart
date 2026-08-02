import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/services/auth_service.dart';
import '../../../data/models/user_model.dart';

class ProfileController extends GetxController {
  final AuthService _authService = Get.find();

  UserModel? get user => _authService.currentUser.value;

  void logout() async {
    await _authService.signOut();
    Get.offAllNamed(AppRoutes.login);
  }
}
