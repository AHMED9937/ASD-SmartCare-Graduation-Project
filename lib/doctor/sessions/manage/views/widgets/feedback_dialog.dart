import 'package:flutter/material.dart';
import 'package:asdsmartcare/core/ui/ui.dart';

class FeedbackDialog extends StatefulWidget {
  final String? initialText;
  final String title;
  final String actionLabel;

  const FeedbackDialog({
    super.key,
    this.initialText,
    required this.title,
    required this.actionLabel,
  });

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  late final TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: AppRadius.lgRadius),
      backgroundColor: AppColors.surface,
      title: Text(
        widget.title,
        style: AppTypography.titleLarge.copyWith(fontWeight: FontWeight.bold),
      ),
      content: Form(
        key: _formKey,
        child: AppTextField(
          controller: _controller,
          hint: 'Enter your feedback here...',
          maxLines: 5,
          minLines: 3,
          autofocus: true,
          validator: (value) => value == null || value.trim().isEmpty
              ? 'Feedback cannot be empty'
              : null,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: AppTypography.labelLarge
                .copyWith(color: AppColors.textSecondary),
          ),
        ),
        AppButton(
          label: widget.actionLabel,
          size: AppButtonSize.small,
          expanded: false,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(context, _controller.text.trim());
            }
          },
        ),
      ],
    );
  }
}
