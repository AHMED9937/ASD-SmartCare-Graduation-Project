import 'package:asdsmartcare/core/ui/ui.dart';
import 'package:asdsmartcare/parent/chatbot/controllers/chatbot_cubit.dart';
import 'package:asdsmartcare/parent/chatbot/controllers/chatbot_state.dart';
import 'package:asdsmartcare/parent/chatbot/views/widgets/chat_bot_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Redesigned ChatBot screen following the SOLID thin-screen pattern.
class ChatBotscreen extends StatefulWidget {
  final ChatBotCubit? cubit; // Optional for testing injection

  const ChatBotscreen({super.key, this.cubit});

  @override
  State<ChatBotscreen> createState() => _ChatBotscreenState();
}

class _ChatBotscreenState extends State<ChatBotscreen> {
  late final ChatBotCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = widget.cubit ?? ChatBotCubit();
  }

  @override
  void dispose() {
    // Only close if we created it
    if (widget.cubit == null) {
      _cubit.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: AppHeader(
          title: 'AI Companion',
          actions: [
            _buildCompanionAvatar(),
          ],
        ),
        body: MeshGradientBackground(
          child: BlocListener<ChatBotCubit, ChatBotState>(
            listener: (context, state) {
              if (state is ChatBotSuccess) {
                _cubit.messages.add({
                  'message': _cubit.chatRes.response,
                  'isUser': false,
                });
              }
              if (state is ChatBotError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: AppColors.error,
                    content: Text('Failed to connect. Please try again.'),
                  ),
                );
              }
            },
            child: const ChatBotBody(),
          ),
        ),
      ),
    );
  }

  Widget _buildCompanionAvatar() {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.md),
      child: Hero(
        tag: 'chatbot_avatar',
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            'lib/appassets/images/chatBotRobot.png',
            width: 32,
            height: 32,
          ),
        ),
      ),
    );
  }
}
