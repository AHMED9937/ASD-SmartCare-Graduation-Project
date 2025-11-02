import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/chatbot/controllers/chatbot_cubit.dart';
import 'package:asdsmartcare/parent/chatbot/controllers/chatbot_state.dart';
import 'package:asdsmartcare/parent/chatbot/views/widgets/chat_input_dock.dart';
import 'package:asdsmartcare/parent/chatbot/views/widgets/chat_message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBotBody extends StatefulWidget {
  const ChatBotBody({super.key});

  @override
  State<ChatBotBody> createState() => _ChatBotBodyState();
}

class _ChatBotBodyState extends State<ChatBotBody> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBotCubit, ChatBotState>(
      listener: (context, state) {
        if (state is ChatBotSuccess || state is ChatBotLoading) {
          // Delayed scroll to allow list to update
          Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
        }
      },
      builder: (context, state) {
        final cubit = ChatBotCubit.get(context);
        final messages = cubit.messages;
        final isLoading = state is ChatBotLoading;

        return Column(
          children: [
            // Message Feed
            Expanded(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  color: AppColors.background,
                  child: ResponsivePadding(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      itemCount: messages.length + (isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < messages.length) {
                          final msg = messages[index];
                          return ChatMessageBubble(
                            text: msg['message'],
                            isUser: msg['isUser'],
                          );
                        }

                        // Bot thinking indicator
                        return const ChatMessageBubble(
                          text: '',
                          isUser: false,
                          isThinking: true,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),

            // Input Dock
            ChatInputDock(
              controller: cubit.questionController,
              onSend: () {
                final text = cubit.questionController.text.trim();
                if (text.isNotEmpty && !isLoading) {
                  // Manually add user message before cubit logic if needed,
                  // but following original logic it adds in listener or before call.
                  // Original: _sendMessage added it to list.
                  cubit.messages.add({
                    'message': text,
                    'isUser': true,
                  });
                  cubit.sendMessage();
                  cubit.questionController.clear();
                  _scrollToBottom();
                }
              },
              isLoading: isLoading,
            ),
          ],
        );
      },
    );
  }
}
