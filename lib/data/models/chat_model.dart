class ChatMessage {
  final String senderId;
  final String text;
  final DateTime sentAt;

  ChatMessage({
    required this.senderId,
    required this.text,
    required this.sentAt,
  });

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      senderId: map['senderId'] ?? '',
      text: map['text'] ?? '',
      sentAt: DateTime.tryParse(map['sentAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': text,
      'sentAt': sentAt.toIso8601String(),
    };
  }
}

class ChatModel {
  final String id;
  final String itemId;
  final List<String> participantIds;
  final List<ChatMessage> messages;

  ChatModel({
    required this.id,
    required this.itemId,
    required this.participantIds,
    required this.messages,
  });

  factory ChatModel.fromMap(String id, Map<String, dynamic> map) {
    return ChatModel(
      id: id,
      itemId: map['itemId'] ?? '',
      participantIds: List<String>.from(map['participantIds'] ?? []),
      messages: (map['messages'] as List<dynamic>? ?? [])
          .map((m) => ChatMessage.fromMap(Map<String, dynamic>.from(m)))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'participantIds': participantIds,
      'messages': messages.map((m) => m.toMap()).toList(),
    };
  }
}
