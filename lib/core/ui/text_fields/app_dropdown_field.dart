import 'package:flutter/material.dart';

import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';

/// Dropdown field component following design system tokens.
///
/// Usage:
/// ```dart
/// AppDropdownField<String>(
///   label: 'Gender',
///   hint: 'Select gender',
///   value: selectedGender,
///   items: ['Male', 'Female', 'Other'],
///   onChanged: (value) => setState(() => selectedGender = value),
/// )
/// ```
class AppDropdownField<T> extends StatelessWidget {
  /// Currently selected value
  final T? value;

  /// List of dropdown items
  final List<T> items;

  /// Callback when value changes
  final ValueChanged<T?>? onChanged;

  /// Field label (displayed above dropdown)
  final String? label;

  /// Hint text (displayed when no value selected)
  final String? hint;

  /// Validation function
  final String? Function(T?)? validator;

  /// Whether field is enabled
  final bool enabled;

  /// Prefix icon
  final IconData? prefixIcon;

  /// Function to convert item to display string
  final String Function(T)? itemLabel;

  /// Auto-validate mode
  final AutovalidateMode? autovalidateMode;

  const AppDropdownField({
    super.key,
    this.value,
    required this.items,
    this.onChanged,
    this.label,
    this.hint,
    this.validator,
    this.enabled = true,
    this.prefixIcon,
    this.itemLabel,
    this.autovalidateMode,
  });

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
        DropdownButtonFormField<T>(
          // ignore: deprecated_member_use
          value: value,
          items: items.map((item) {
            final displayText = itemLabel != null
                ? itemLabel!(item)
                : item.toString();
            return DropdownMenuItem<T>(
              value: item,
              child: Text(displayText, style: AppTypography.bodyMedium),
            );
          }).toList(),
          onChanged: enabled ? onChanged : null,
          validator: validator,
          autovalidateMode: autovalidateMode,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, size: AppSpacing.iconMd)
                : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            border: OutlineInputBorder(
              borderRadius: AppRadius.xlRadius,
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.xlRadius,
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.xlRadius,
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: AppRadius.xlRadius,
              borderSide: const BorderSide(color: AppColors.error),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.xlRadius,
              borderSide: BorderSide(
                color: AppColors.border.withValues(alpha: 0.5),
              ),
            ),
          ),
          style: AppTypography.bodyMedium,
          dropdownColor: AppColors.surface,
          borderRadius: AppRadius.mdRadius,
          isExpanded: true,
        ),
      ],
    );
  }
}
