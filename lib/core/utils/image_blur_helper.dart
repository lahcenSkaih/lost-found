// Placeholder for on-device blurring of sensitive item photos
// (ID cards, passports, credit cards, documents) before they are
// uploaded to the PUBLIC storage path. The unblurred original is
// uploaded separately to a PRIVATE path that is only exposed once a
// claim has been approved (see StorageService + claim_repository).
//
// Suggested implementation: use the `image` package to apply a strong
// Gaussian blur, or pixelate the photo, on a background isolate so the
// UI doesn't freeze on large images.
//
// Example signature to implement:
//
// Future<File> blurImage(File original) async { ... }

class ImageBlurHelper {
  ImageBlurHelper._();

  static Future<void> blurImage() async {
    // TODO: implement using package:image
    throw UnimplementedError(
      'Add package:image and implement Gaussian blur / pixelation here.',
    );
  }
}

