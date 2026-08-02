import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/services/auth_service.dart';
import '../../../data/models/claim_model.dart';
import '../../../data/models/item_model.dart';
import '../../../data/repositories/claim_repository.dart';

/// Verification questions shown to the claimant. In a fuller build these
/// would be generated dynamically from the finder's structuredFields
/// (e.g. "What's the expiry year on the ID?") instead of being generic.
class ClaimController extends GetxController {
  final ClaimRepository _claimRepo = ClaimRepository();
  final AuthService _authService = Get.find();

  late final ItemModel item;
  final answerControllers = <String, TextEditingController>{};
  final isLoading = false.obs;
  final errorMessage = RxnString();

  final List<String> questions = [
    'Describe a unique detail about this item only the owner would know',
    'When and roughly where did you lose it?',
  ];

  @override
  void onInit() {
    super.onInit();
    item = Get.arguments as ItemModel;
    for (final q in questions) {
      answerControllers[q] = TextEditingController();
    }
  }

  Future<void> submitClaim() async {
    final userId = _authService.currentUser.value?.id ?? '';
    if (userId.isEmpty) {
      errorMessage.value = 'You must be logged in to claim an item.';
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    try {
      final claim = ClaimModel(
        id: '',
        itemId: item.id,
        claimantId: userId,
        answers: {
          for (final entry in answerControllers.entries) entry.key: entry.value.text.trim(),
        },
        status: ClaimStatus.pending,
        createdAt: DateTime.now(),
      );
      await _claimRepo.submitClaim(claim);

      Get.snackbar(
        'Claim submitted',
        'The finder will review your answers and get back to you.',
      );
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    for (final c in answerControllers.values) {
      c.dispose();
    }
    super.onClose();
  }
}
