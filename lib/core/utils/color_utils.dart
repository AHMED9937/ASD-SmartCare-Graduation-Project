import 'package:flutter/material.dart';

import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';

/// Legacy color utilities - delegates to design system tokens.
///
/// @deprecated Use [AppColors] from design_system/tokens directly.
/// This class is kept for backward compatibility during migration.
class colorUtils {
  /// @deprecated Use [AppColors.primary] instead.
  static const List<Color> colors = [
    AppColors.primary,
  ];

  /// @deprecated Use [AppColors.primary] instead.
  static Color get primaryBlue => AppColors.primary;

  /// @deprecated Use [AppColors.secondary] instead.
  static Color get secondaryBlue => AppColors.secondary;

  /// @deprecated Use [AppColors.error] instead.
  static Color get errorRed => AppColors.error;

  /// @deprecated Use [AppColors.success] instead.
  static Color get successGreen => AppColors.success;
}
