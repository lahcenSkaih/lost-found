
import '../../core/constants/item_categories.dart';

enum ItemStatus { found, claimed, returned }

class ItemModel {
  final String id;
  final ItemCategory category;
  final ItemStatus status;

  final String city;
  final double latitude;
  final double longitude;
  final String placeDescription;

  /// Publicly visible photo. For sensitive categories this MUST be a
  /// blurred/redacted version — never the raw upload.
  final String photoUrl;

  /// Full-resolution, unblurred photo. Only readable by users whose
  /// claim on this item has been approved (enforce via Storage rules).
  final String? photoUrlFull;

  /// Free-form category-specific details, e.g. for idCard:
  /// { "idType": "National ID", "nameInitials": "J.D.", "expiry": "2027" }
  final Map<String, dynamic> structuredFields;

  final String description;
  final String postedBy;
  final DateTime createdAt;

  ItemModel({
    required this.id,
    required this.category,
    required this.status,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.placeDescription,
    required this.photoUrl,
    this.photoUrlFull,
    required this.structuredFields,
    required this.description,
    required this.postedBy,
    required this.createdAt,
  });

  factory ItemModel.fromMap(String id, Map<String, dynamic> map) {
    return ItemModel(
      id: id,
      category: ItemCategory.values.firstWhere(
        (c) => c.name == map['category'],
        orElse: () => ItemCategory.other,
      ),
      status: ItemStatus.values.firstWhere(
        (s) => s.name == map['status'],
        orElse: () => ItemStatus.found,
      ),
      city: map['city'] ?? '',
      latitude: (map['latitude'] ?? 0).toDouble(),
      longitude: (map['longitude'] ?? 0).toDouble(),
      placeDescription: map['placeDescription'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      photoUrlFull: map['photoUrlFull'],
      structuredFields: Map<String, dynamic>.from(map['structuredFields'] ?? {}),
      description: map['description'] ?? '',
      postedBy: map['postedBy'] ?? '',
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category.name,
      'status': status.name,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'placeDescription': placeDescription,
      'photoUrl': photoUrl,
      'photoUrlFull': photoUrlFull,
      'structuredFields': structuredFields,
      'description': description,
      'postedBy': postedBy,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
