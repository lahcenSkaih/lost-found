
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

/// Handles uploading item photos. Sensitive categories should be blurred
/// on-device (see core/utils/image_blur_helper.dart) BEFORE calling
/// uploadPublicPhoto, and the untouched original should go to
/// uploadPrivatePhoto, which only claim-approved users can read
/// (enforce this with Storage security rules, not just app logic).
class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final _uuid = const Uuid();

  Future<String> uploadPublicPhoto(File file, {required String itemId}) async {
    final ref = _storage.ref('item_images/public/$itemId/${_uuid.v4()}.jpg');
    final task = await ref.putFile(file);
    return task.ref.getDownloadURL();
  }

  Future<String> uploadPrivatePhoto(File file, {required String itemId}) async {
    final ref = _storage.ref('item_images/private/$itemId/${_uuid.v4()}.jpg');
    final task = await ref.putFile(file);
    return task.ref.getDownloadURL();
  }
}
