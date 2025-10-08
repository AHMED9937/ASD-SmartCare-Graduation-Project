import 'package:flutter/material.dart';

import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';

/// Reusable search field component following design system tokens.
///
/// Usage:
/// ```dart
/// AppSearchField(
///   hint: 'Search doctors...',
///   onChanged: (value) => cubit.search(value),
/// )
/// ```
class AppSearchField extends StatefulWidget {
  /// Hint text
  final String hint;

  /// Callback when text changes
  final ValueChanged<String>? onChanged;

  /// Callback when search is submitted
  final ValueChanged<String>? onSubmitted;

  /// Callback when clear button is pressed
  final VoidCallback? onClear;

  /// Text editing controller
  final TextEditingController? controller;

  /// Focus node
  final FocusNode? focusNode;

  /// Whether search is enabled
  final bool enabled;

  /// Debounce duration for onChanged callback
  final Duration debounceDuration;

  const AppSearchField({
    super.key,
    this.hint = 'Search...',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.controller,
    this.focusNode,
    this.enabled = true,
    this.debounceDuration = const Duration(milliseconds: 300),
  });

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  late final TextEditingController _controller;
  bool _showClear = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);
    _showClear = _controller.text.isNotEmpty;
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller.removeListener(_onTextChanged);
    }
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _controller.text.isNotEmpty;
    if (_showClear != hasText) {
      setState(() {
        _showClear = hasText;
      });
    }
    widget.onChanged?.call(_controller.text);
  }

  void _onClear() {
    _controller.clear();
    widget.onClear?.call();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      textInputAction: TextInputAction.search,
      onSubmitted: widget.onSubmitted,
      style: AppTypography.bodyMedium,
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: const Icon(
          Icons.search,
          size: AppSpacing.iconMd,
          color: AppColors.textSecondary,
        ),
        suffixIcon: _showClear
            ? IconButton(
                icon: const Icon(
                  Icons.clear,
                  size: AppSpacing.iconMd,
                  color: AppColors.textSecondary,
                ),
                onPressed: _onClear,
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: AppRadius.fullRadius,
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.fullRadius,
          borderSide: BorderSide(
            color: AppColors.primary.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.fullRadius,
          borderSide: BorderSide(
            color: AppColors.primary.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        filled: false,
      ),
    );
  }
}
