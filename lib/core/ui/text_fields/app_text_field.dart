import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';

/// Reusable text field component following design system tokens.
///
/// Usage:
/// ```dart
/// AppTextField(
///   label: 'Email',
///   hint: 'Enter your email',
///   controller: _emailController,
///   validator: (value) => value?.isEmpty == true ? 'Required' : null,
/// )
/// ```
class AppTextField extends StatelessWidget {
  /// Text editing controller
  final TextEditingController? controller;

  /// Field label (displayed above input)
  final String? label;

  /// Hint text (displayed inside input when empty)
  final String? hint;

  /// Validation function
  final String? Function(String?)? validator;

  /// Callback when field is saved
  final FormFieldSetter<String>? onSaved;

  /// Callback when text changes
  final ValueChanged<String>? onChanged;

  /// Callback when editing is complete
  final VoidCallback? onEditingComplete;

  /// Callback when field is submitted
  final ValueChanged<String>? onFieldSubmitted;

  /// Whether field is obscured (for passwords)
  final bool obscureText;

  /// Whether field is enabled
  final bool enabled;

  /// Whether field is read-only
  final bool readOnly;

  /// Keyboard type
  final TextInputType? keyboardType;

  /// Text input action
  final TextInputAction? textInputAction;

  /// Input formatters
  final List<TextInputFormatter>? inputFormatters;

  /// Maximum lines
  final int? maxLines;

  /// Minimum lines
  final int? minLines;

  /// Maximum length
  final int? maxLength;

  /// Prefix icon
  final IconData? prefixIcon;

  /// Suffix icon
  final IconData? suffixIcon;

  /// Suffix icon callback
  final VoidCallback? onSuffixIconPressed;

  /// Focus node
  final FocusNode? focusNode;

  /// Whether to autofocus
  final bool autofocus;

  /// Auto-validate mode
  final AutovalidateMode? autovalidateMode;

  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.focusNode,
    this.autovalidateMode,
    this.onSaved,
  });

  /// Create an email text field
  const AppTextField.email({
    super.key,
    this.controller,
    this.label = 'Email',
    this.hint = 'Enter your email',
    this.validator,
    this.onSaved,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.focusNode,
    this.autovalidateMode,
  })  : obscureText = false,
        keyboardType = TextInputType.emailAddress,
        textInputAction = TextInputAction.next,
        inputFormatters = null,
        maxLines = 1,
        minLines = null,
        maxLength = null,
        prefixIcon = Icons.email_outlined,
        suffixIcon = null,
        onSuffixIconPressed = null;

  /// Create a password text field
  factory AppTextField.password({
    Key? key,
    TextEditingController? controller,
    String label = 'Password',
    String hint = 'Enter your password',
    String? Function(String?)? validator,
    FormFieldSetter<String>? onSaved,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onFieldSubmitted,
    bool enabled = true,
    bool autofocus = false,
    FocusNode? focusNode,
    AutovalidateMode? autovalidateMode,
  }) {
    return _PasswordTextField(
      key: key,
      controller: controller,
      label: label,
      hint: hint,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled,
      autofocus: autofocus,
      focusNode: focusNode,
      autovalidateMode: autovalidateMode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
        TextFormField(
          controller: controller,
          validator: validator,
          onSaved: onSaved,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          obscureText: obscureText,
          enabled: enabled,
          readOnly: readOnly,
          autofocus: autofocus,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          focusNode: focusNode,
          autovalidateMode: autovalidateMode,
          style: AppTypography.bodyMedium,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, size: AppSpacing.iconMd)
                : null,
            suffixIcon: suffixIcon != null
                ? IconButton(
                    icon: Icon(suffixIcon, size: AppSpacing.iconMd),
                    onPressed: onSuffixIconPressed,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

/// Password text field with visibility toggle
class _PasswordTextField extends AppTextField {
  const _PasswordTextField({
    super.key,
    super.controller,
    super.label,
    super.hint,
    super.validator,
    super.onSaved,
    super.onChanged,
    super.onEditingComplete,
    super.onFieldSubmitted,
    super.enabled,
    super.autofocus,
    super.focusNode,
    super.autovalidateMode,
  }) : super(
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          prefixIcon: Icons.lock_outline,
        );

  @override
  Widget build(BuildContext context) {
    return _PasswordTextFieldStateful(
      controller: controller,
      label: label,
      hint: hint,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled,
      autofocus: autofocus,
      focusNode: focusNode,
      autovalidateMode: autovalidateMode,
    );
  }
}

class _PasswordTextFieldStateful extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? Function(String?)? validator;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final bool enabled;
  final bool autofocus;
  final FocusNode? focusNode;
  final AutovalidateMode? autovalidateMode;

  const _PasswordTextFieldStateful({
    this.controller,
    this.label,
    this.hint,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
    this.autovalidateMode,
  });

  @override
  State<_PasswordTextFieldStateful> createState() =>
      _PasswordTextFieldStatefulState();
}

class _PasswordTextFieldStatefulState
    extends State<_PasswordTextFieldStateful> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          onSaved: widget.onSaved,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: widget.onFieldSubmitted,
          obscureText: _obscureText,
          enabled: widget.enabled,
          autofocus: widget.autofocus,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          focusNode: widget.focusNode,
          autovalidateMode: widget.autovalidateMode,
          style: AppTypography.bodyMedium,
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: const Icon(Icons.lock_outline, size: AppSpacing.iconMd),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                size: AppSpacing.iconMd,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
