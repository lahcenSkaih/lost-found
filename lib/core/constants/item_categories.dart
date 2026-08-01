/// Categories of lost/found items. Kept as an enum so every screen
/// (post item, feed filter, claim verification) stays in sync.
enum ItemCategory {
  idCard,
  passport,
  wallet,
  creditCard,
  document,
  phone,
  keys,
  other,
}

extension ItemCategoryX on ItemCategory {
  String get label {
    switch (this) {
      case ItemCategory.idCard:
        return 'National ID Card';
      case ItemCategory.passport:
        return 'Passport';
      case ItemCategory.wallet:
        return 'Wallet';
      case ItemCategory.creditCard:
        return 'Credit / Debit Card';
      case ItemCategory.document:
        return 'Official Document';
      case ItemCategory.phone:
        return 'Phone';
      case ItemCategory.keys:
        return 'Keys';
      case ItemCategory.other:
        return 'Other';
    }
  }

  /// Sensitive categories get their photo blurred publicly and only
  /// revealed in full once a claim is approved.
  bool get isSensitive {
    switch (this) {
      case ItemCategory.idCard:
      case ItemCategory.passport:
      case ItemCategory.creditCard:
      case ItemCategory.document:
        return true;
      default:
        return false;
    }
  }
}
