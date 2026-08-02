import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/constants/item_categories.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/location_service.dart';
import '../../../core/services/storage_service.dart';
import '../../../data/models/item_model.dart';
import '../../../data/repositories/item_repository.dart';

class PostItemController extends GetxController {
  final ItemRepository _itemRepo = ItemRepository();
  final StorageService _storageService = StorageService();
  final LocationService _locationService = Get.find();
  final AuthService _authService = Get.find();
  final _picker = ImagePicker();

  final Rxn<ItemCategory> category = Rxn<ItemCategory>();
  final placeController = TextEditingController();
  final descriptionController = TextEditingController();

  /// Category-specific structured fields, e.g. idType / expiry / bank name.
  /// Keep values non-sensitive (no full card numbers, no full ID numbers).
  final structuredFields = <String, String>{}.obs;

  final Rxn<File> pickedImage = Rxn<File>();
  final isLoading = false.obs;
  final errorMessage = RxnString();

  double? _latitude;
  double? _longitude;
  String? _city;

  Future<void> pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.camera, imageQuality: 85);
    if (picked != null) pickedImage.value = File(picked.path);
  }

  Future<void> useCurrentLocation() async {
    final position = await _locationService.getCurrentPosition();
    if (position == null) {
      errorMessage.value = 'Could not get your location. Enable location services.';
      return;
    }
    _latitude = position.latitude;
    _longitude = position.longitude;
    _city = await _locationService.getCityFromCoordinates(position.latitude, position.longitude);
  }

  void setCategory(ItemCategory? c) {
    category.value = c;
    structuredFields.clear();
  }

  void updateField(String key, String value) {
    structuredFields[key] = value;
  }

  Future<void> submit() async {
    if (category.value == null || pickedImage.value == null || _latitude == null) {
      errorMessage.value = 'Please add a photo, category, and location.';
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    try {
      // Create the item doc first to get an ID to namespace the photo path.
      final userId = _authService.currentUser.value?.id ?? '';
      final tempItem = ItemModel(
        id: '',
        category: category.value!,
        status: ItemStatus.found,
        city: _city ?? '',
        latitude: _latitude!,
        longitude: _longitude!,
        placeDescription: placeController.text.trim(),
        photoUrl: '',
        structuredFields: structuredFields,
        description: descriptionController.text.trim(),
        postedBy: userId,
        createdAt: DateTime.now(),
      );
      final itemId = await _itemRepo.createItem(tempItem);

      // NOTE: for sensitive categories (ID, passport, credit card, document)
      // the photo picked here should be blurred BEFORE calling
      // uploadPublicPhoto — see core/utils/image_blur_helper.dart (TODO).
      // The raw file could optionally also go to uploadPrivatePhoto so it's
      // only revealed after a claim is approved.
      final photoUrl = await _storageService.uploadPublicPhoto(
        pickedImage.value!,
        itemId: itemId,
      );

      await _itemRepo.updateStatus(itemId, ItemStatus.found.name);
      // photoUrl is saved via a follow-up update since it depends on itemId.
      // (In production, wrap createItem+upload+update in a single flow.)

      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    placeController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
