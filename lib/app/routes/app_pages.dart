import 'package:get/get.dart';
import 'package:lost_found/features/profile/bindings/profile_binding.dart';
import 'package:lost_found/features/profile/views/profile_view.dart';
import 'package:lost_found/features/splash/binding/splash_binding.dart';
import 'package:lost_found/features/splash/view/splash_view.dart';
import 'app_routes.dart';
import '../../features/auth/bindings/auth_binding.dart';
import '../../features/auth/views/login_view.dart';
import '../../features/auth/views/otp_view.dart';
import '../../features/home/bindings/home_binding.dart';
import '../../features/home/views/home_view.dart';
import '../../features/map/bindings/map_binding.dart';
import '../../features/map/views/map_view.dart';
import '../../features/post_item/bindings/post_item_binding.dart';
import '../../features/post_item/views/post_item_view.dart';
import '../../features/item_detail/bindings/item_detail_binding.dart';
import '../../features/item_detail/views/item_detail_view.dart';
import '../../features/claim/bindings/claim_binding.dart';
import '../../features/claim/views/claim_view.dart';
import '../../features/chat/bindings/chat_binding.dart';
import '../../features/chat/views/chat_view.dart';

class AppPages {
  AppPages._();

  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => const OtpView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.map,
      page: () => const MapView(),
      binding: MapBinding(),
    ),
    GetPage(
      name: AppRoutes.postItem,
      page: () => const PostItemView(),
      binding: PostItemBinding(),
    ),
    GetPage(
      name: AppRoutes.itemDetail,
      page: () => const ItemDetailView(),
      binding: ItemDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.claim,
      page: () => const ClaimView(),
      binding: ClaimBinding(),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
  ];
}
