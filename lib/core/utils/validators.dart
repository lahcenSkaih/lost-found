class Validators {
  Validators._();

  static String? required(String? value, {String field = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$field is required';
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Phone number is required';
    final cleaned = value.replaceAll(RegExp(r'\s|-'), '');
    if (!RegExp(r'^\+?[0-9]{8,15}$').hasMatch(cleaned)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? otp(String? value) {
    if (value == null || value.trim().length != 6) {
      return 'Enter the 6-digit code';
    }
    return null;
  }
}
