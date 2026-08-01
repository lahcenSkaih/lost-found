
enum ClaimStatus { pending, approved, rejected }

class ClaimModel {
  final String id;
  final String itemId;
  final String claimantId;

  /// Answers to the verification questions set for this item's category
  /// (e.g. "What's the expiry date on the ID?", "What color is the wallet
  /// inside?"). Only the finder sees these before approving.
  final Map<String, String> answers;

  final ClaimStatus status;
  final DateTime createdAt;

  ClaimModel({
    required this.id,
    required this.itemId,
    required this.claimantId,
    required this.answers,
    required this.status,
    required this.createdAt,
  });

  factory ClaimModel.fromMap(String id, Map<String, dynamic> map) {
    return ClaimModel(
      id: id,
      itemId: map['itemId'] ?? '',
      claimantId: map['claimantId'] ?? '',
      answers: Map<String, String>.from(map['answers'] ?? {}),
      status: ClaimStatus.values.firstWhere(
        (s) => s.name == map['status'],
        orElse: () => ClaimStatus.pending,
      ),
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'claimantId': claimantId,
      'answers': answers,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
