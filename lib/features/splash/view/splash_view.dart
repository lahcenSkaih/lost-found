import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:lost_found/features/splash/controller/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
