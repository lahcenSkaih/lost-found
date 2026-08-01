
import '../../core/constants/app_constants.dart';
import '../../core/services/firestore_service.dart';
import '../models/chat_model.dart';

class ChatRepository {
  final FirestoreService _fs = FirestoreService();

  Future<String> createChat(ChatModel chat) async {
    final ref = await _fs.add(AppConstants.chatsCollection, chat.toMap());
    return ref.id;
  }

  Future<ChatModel?> getChat(String chatId) async {
    final doc = await _fs.getById(AppConstants.chatsCollection, chatId);
    if (!doc.exists) return null;
    return ChatModel.fromMap(doc.id, doc.data()!);
  }

  Future<void> sendMessage(String chatId, ChatMessage message, List<ChatMessage> updatedList) {
    return _fs.update(AppConstants.chatsCollection, chatId, {
      'messages': updatedList.map((m) => m.toMap()).toList(),
    });
  }
}
