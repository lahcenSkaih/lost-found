import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/auth_service.dart';
import '../../../data/models/chat_model.dart';
import '../../../data/repositories/chat_repository.dart';

class ChatController extends GetxController {
  final ChatRepository _chatRepo = ChatRepository();
  final AuthService _authService = Get.find();

  final messageController = TextEditingController();
  final messages = <ChatMessage>[].obs;
  final isLoading = false.obs;

  late String chatId;

  @override
  void onInit() {
    super.onInit();
    // Expecting Get.arguments to be the chatId (created earlier when a
    // claim was approved, e.g. via a Cloud Function or claim_repository
    // flow that also calls ChatRepository.createChat).
    chatId = Get.arguments as String? ?? '';
    if (chatId.isNotEmpty) _loadChat();
  }

  Future<void> _loadChat() async {
    isLoading.value = true;
    final chat = await _chatRepo.getChat(chatId);
    messages.value = chat?.messages ?? [];
    isLoading.value = false;
  }

  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final userId = _authService.currentUser.value?.id ?? '';
    final message = ChatMessage(senderId: userId, text: text, sentAt: DateTime.now());
    final updated = [...messages, message];

    messages.value = updated;
    messageController.clear();

    await _chatRepo.sendMessage(chatId, message, updated);
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
