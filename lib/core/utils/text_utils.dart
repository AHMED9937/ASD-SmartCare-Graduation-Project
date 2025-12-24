import 'package:flutter/material.dart';

import 'package:asdsmartcare/core/design_system/tokens/tokens.dart';

/// Legacy text utilities - delegates to design system tokens.
///
/// @deprecated Use [AppTypography] from design_system/tokens directly.
/// This class is kept for backward compatibility during migration.
class TextUtils {
  /// Creates a customizable text widget with optional font size and color.
  ///
  /// @deprecated Use [Text] with [AppTypography.bodyMedium] or similar styles.
  static Widget textDescription(
    String disText, {
    FontWeight? my_FontWeight,
    String myfontFamily = 'Inter',
    double fontSize = 14,
    Color disTextColor = AppColors.onSurface,
    TextAlign? myTextAlign,
  }) {
    return Text(
      disText,
      textAlign: myTextAlign ?? TextAlign.center,
      overflow: TextOverflow.clip,
      style: AppTypography.bodyMedium.copyWith(
        fontFamily: myfontFamily,
        fontSize: fontSize,
        color: disTextColor,
        fontWeight: my_FontWeight ?? FontWeight.w400,
      ),
    );
  }

  /// @deprecated Use [AppTypography.titleMedium] or [AppTypography.titleLarge].
  static TextStyle myTextstyleHeader({
    FontWeight my_fontWeight = FontWeight.w600,
    String myfontFamily = 'Inter',
    double fontSize = 16,
    Color headerTextColor = AppColors.primary,
  }) {
    return AppTypography.titleMedium.copyWith(
      fontFamily: myfontFamily,
      fontSize: fontSize,
      color: headerTextColor,
      fontWeight: my_fontWeight,
    );
  }

  /// @deprecated Use [AppTypography.bodyMedium] or [AppTypography.bodyLarge].
  static TextStyle myDisTextStyle({
    FontWeight my_fontWeight = FontWeight.w400,
    String myfontFamily = 'Inter',
    double fontSize = 16,
    Color disTextColor = AppColors.onSurface,
  }) {
    return AppTypography.bodyMedium.copyWith(
      fontFamily: myfontFamily,
      fontSize: fontSize,
      color: disTextColor,
      fontWeight: my_fontWeight,
    );
  }

  /// Creates a header text widget.
  ///
  /// @deprecated Use [Text] with [AppTypography.titleLarge] or similar styles.
  static Widget textHeader(
    String disText, {
    FontWeight my_fontWeight = FontWeight.w600,
    String myfontFamily = 'Inter',
    double fontSize = 16,
    Color headerTextColor = AppColors.primary,
    TextAlign? myTextAlign,
  }) {
    return Text(
      disText,
      textAlign: myTextAlign ?? TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: AppTypography.titleLarge.copyWith(
        fontFamily: myfontFamily,
        fontSize: fontSize,
        color: headerTextColor,
        fontWeight: my_fontWeight,
      ),
    );
  }
}
