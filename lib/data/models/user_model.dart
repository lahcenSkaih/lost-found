
class UserModel {
  final String id;
  final String name;
  final String phone;
  final String city;
  final double rating;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.city,
    required this.rating,
    required this.createdAt,
  });

  factory UserModel.fromMap(String id, Map<String, dynamic> map) {
    return UserModel(
      id: id,
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      city: map['city'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'city': city,
      'rating': rating,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
