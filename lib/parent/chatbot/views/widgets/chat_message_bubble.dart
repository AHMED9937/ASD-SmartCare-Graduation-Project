import 'package:flutter/material.dart';
import 'package:asdsmartcare/core/ui/ui.dart';

class ChatMessageBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  final bool isThinking;

  const ChatMessageBubble({
    super.key,
    required this.text,
    required this.isUser,
    this.isThinking = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) _buildBotAvatar(),
          const SizedBox(width: AppSpacing.sm),
          Flexible(child: _buildBubble(context)),
          const SizedBox(width: AppSpacing.md),
        ],
      ),
    );
  }

  Widget _buildBotAvatar() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
          width: 2,
        ),
      ),
      child: Center(
        child: Image.asset(
          'lib/appassets/images/chatBotRobot.png',
          width: 20,
          height: 20,
        ),
      ),
    );
  }

  Widget _buildBubble(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm + 2,
      ),
      color: isUser ? AppColors.primary : Colors.white,
      border: isUser
          ? null
          : Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(AppRadius.lg),
        topRight: const Radius.circular(AppRadius.lg),
        bottomLeft: Radius.circular(isUser ? AppRadius.lg : AppRadius.xs),
        bottomRight: Radius.circular(isUser ? AppRadius.xs : AppRadius.lg),
      ),
      elevation: isUser ? 4 : 2,
      child: isThinking
          ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: BotTypingIndicator(),
            )
          : Text(
              text,
              style: AppTypography.bodyMedium.copyWith(
                color: isUser ? Colors.white : AppColors.primaryDark,
                height: 1.4,
              ),
            ),
    );
  }
}
