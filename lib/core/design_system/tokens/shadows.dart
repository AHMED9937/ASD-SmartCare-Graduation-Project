import 'package:flutter/material.dart';

import 'colors.dart';

/// Design system shadow tokens for ASD SmartCare.
///
/// Consistent elevation shadows for depth and hierarchy.
///
/// Usage:
/// ```dart
/// Container(
///   decoration: BoxDecoration(
///     boxShadow: [AppShadows.md],
///   ),
/// )
/// ```
abstract final class AppShadows {
  // ─────────────────────────────────────────────────────────────────────────────
  // Shadow Presets
  // ─────────────────────────────────────────────────────────────────────────────

  /// No shadow
  static const BoxShadow none = BoxShadow(color: Colors.transparent);

  /// Extra small shadow - subtle depth
  static const BoxShadow xs = BoxShadow(
    color: AppColors.shadow,
    blurRadius: 2,
    offset: Offset(0, 1),
  );

  /// Small shadow - cards, buttons
  static const BoxShadow sm = BoxShadow(
    color: AppColors.shadow,
    blurRadius: 4,
    offset: Offset(0, 2),
  );

  /// Medium shadow - elevated cards, dropdowns
  static const BoxShadow md = BoxShadow(
    color: AppColors.shadow,
    blurRadius: 8,
    offset: Offset(0, 4),
  );

  /// Large shadow - modals, popovers
  static const BoxShadow lg = BoxShadow(
    color: AppColors.shadow,
    blurRadius: 16,
    offset: Offset(0, 8),
  );

  /// Extra large shadow - dialogs, overlays
  static const BoxShadow xl = BoxShadow(
    color: AppColors.shadow,
    blurRadius: 24,
    offset: Offset(0, 12),
  );

  // ─────────────────────────────────────────────────────────────────────────────
  // Shadow Lists (for BoxDecoration)
  // ─────────────────────────────────────────────────────────────────────────────

  /// No shadow list
  static const List<BoxShadow> noneList = [];

  /// Extra small shadow list
  static const List<BoxShadow> xsList = [xs];

  /// Small shadow list
  static const List<BoxShadow> smList = [sm];

  /// Medium shadow list
  static const List<BoxShadow> mdList = [md];

  /// Large shadow list
  static const List<BoxShadow> lgList = [lg];

  /// Extra large shadow list
  static const List<BoxShadow> xlList = [xl];

  // ─────────────────────────────────────────────────────────────────────────────
  // Semantic Shadows
  // ─────────────────────────────────────────────────────────────────────────────

  /// Card shadow
  static const List<BoxShadow> card = smList;

  /// Elevated card shadow
  static const List<BoxShadow> cardElevated = mdList;

  /// Button shadow (for elevated buttons)
  static const List<BoxShadow> button = xsList;

  /// Floating action button shadow
  static const List<BoxShadow> fab = mdList;

  /// Bottom sheet shadow
  static const List<BoxShadow> bottomSheet = lgList;

  /// Dialog shadow
  static const List<BoxShadow> dialog = xlList;

  /// Dropdown/menu shadow
  static const List<BoxShadow> dropdown = mdList;

  /// Navigation bar shadow
  static const List<BoxShadow> navBar = [
    BoxShadow(
      color: AppColors.shadow,
      blurRadius: 8,
      offset: Offset(0, -2),
    ),
  ];

  // ─────────────────────────────────────────────────────────────────────────────
  // Primary Colored Shadows (for branded elements)
  // ─────────────────────────────────────────────────────────────────────────────

  /// Primary color glow - for CTA buttons, highlights
  static BoxShadow get primaryGlow => BoxShadow(
        color: AppColors.primary.withValues(alpha: 0.3),
        blurRadius: 12,
        offset: const Offset(0, 4),
      );

  /// Secondary color glow
  static BoxShadow get secondaryGlow => BoxShadow(
        color: AppColors.secondary.withValues(alpha: 0.3),
        blurRadius: 12,
        offset: const Offset(0, 4),
      );
}
