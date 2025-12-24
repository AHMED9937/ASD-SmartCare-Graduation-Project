import 'package:flutter/material.dart';
import 'package:asdsmartcare/core/ui/ui.dart';

class ChatInputDock extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isLoading;

  const ChatInputDock({
    super.key,
    required this.controller,
    required this.onSend,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        MediaQuery.of(context).padding.bottom + AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, -4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: AppTextField(
              controller: controller,
              hint: 'Ask anything...',
              enabled: !isLoading,
              textInputAction: TextInputAction.send,
              onFieldSubmitted: (_) => onSend(),
            ),
          ),
          const AppSpacer.md(),
          _buildSendButton(),
        ],
      ),
    );
  }

  Widget _buildSendButton() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: isLoading
            ? AppColors.primary.withValues(alpha: 0.5)
            : AppColors.primary,
        shape: BoxShape.circle,
        boxShadow: isLoading
            ? []
            : [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: AppIconButton(
        icon: Icons.send_rounded,
        onPressed: isLoading ? null : onSend,
        iconColor: Colors.white,
      ),
    );
  }
}
