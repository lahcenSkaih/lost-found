import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final myId = Get.find<AuthService>().currentUser.value?.id;

    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) return const LoadingIndicator();
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final m = controller.messages[index];
                  final isMine = m.senderId == myId;
                  return Align(
                    alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: isMine ? AppColors.primary : AppColors.surface,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        m.text,
                        style: TextStyle(color: isMine ? Colors.white : AppColors.textPrimary),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.messageController,
                      decoration: const InputDecoration(hintText: 'Type a message...'),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: AppColors.primary),
                    onPressed: controller.sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
