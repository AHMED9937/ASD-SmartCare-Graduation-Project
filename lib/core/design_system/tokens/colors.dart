import 'package:flutter/material.dart';

/// Design system color tokens for ASD SmartCare.
///
/// Usage:
/// ```dart
/// Container(color: AppColors.primary)
/// Text(style: TextStyle(color: AppColors.onPrimary))
/// ```
abstract final class AppColors {
  // ─────────────────────────────────────────────────────────────────────────────
  // Brand Colors
  // ─────────────────────────────────────────────────────────────────────────────

  /// Primary brand color - deep blue
  static const Color primary = Color(0xFF133E87);

  /// Primary color variants
  static const Color primaryLight = Color(0xFF3A5F9A);
  static const Color primaryLighter = Color(0xFFCCDFFF);
  static const Color primaryDark = Color(0xFF0D2A5C);

  /// Secondary/accent color - teal
  static const Color secondary = Color(0xFF608BC1);
  static const Color secondaryLight = Color(0xFF8AABD4);
  static const Color secondaryDark = Color(0xFF3D6A9E);

  // ─────────────────────────────────────────────────────────────────────────────
  // Semantic Colors
  // ─────────────────────────────────────────────────────────────────────────────

  /// Success state - green
  static const Color success = Color(0xFF28A745);
  static const Color successLight = Color(0xFFD4EDDA);

  /// Warning state - amber
  static const Color warning = Color(0xFFFFC107);
  static const Color warningLight = Color(0xFFFFF3CD);

  /// Error state - red
  static const Color error = Color(0xFFDC3545);
  static const Color errorLight = Color(0xFFF8D7DA);

  /// Info state - blue
  static const Color info = Color(0xFF17A2B8);
  static const Color infoLight = Color(0xFFD1ECF1);

  // ─────────────────────────────────────────────────────────────────────────────
  // Surface & Background Colors
  // ─────────────────────────────────────────────────────────────────────────────

  /// Main background color - more luminous blue-white
  static const Color background = Color.fromARGB(255, 255, 255, 255);

  /// Surface color (cards, sheets)
  static const Color surface = Color(0xFFFFFFFF);

  /// Elevated surface color
  static const Color surfaceElevated = Color(0xFFFFFFFF);

  /// Scaffold background
  static const Color scaffoldBackground = background;

  // ─────────────────────────────────────────────────────────────────────────────
  // Text & Icon Colors (on surfaces)
  // ─────────────────────────────────────────────────────────────────────────────

  /// Text on primary color
  static const Color onPrimary = Color(0xFFFFFFFF);

  /// Text on secondary color
  static const Color onSecondary = Color(0xFFFFFFFF);

  /// Text on background
  static const Color onBackground = Color(0xFF1A1A1A);

  /// Text on surface
  static const Color onSurface = Color(0xFF1A1A1A);

  /// Text on error
  static const Color onError = Color(0xFFFFFFFF);

  /// Secondary text (muted)
  static const Color textSecondary = Color(0xFF6C757D);

  /// Disabled text
  static const Color textDisabled = Color(0xFFADB5BD);

  /// Hint text
  static const Color textHint = Color(0xFF9E9E9E);

  // ─────────────────────────────────────────────────────────────────────────────
  // Border & Divider Colors
  // ─────────────────────────────────────────────────────────────────────────────

  /// Default border color
  static const Color border = Color(0xFFE0E0E0);

  /// Focused border color
  static const Color borderFocused = primary;

  /// Error border color
  static const Color borderError = error;

  /// Divider color
  static const Color divider = Color(0xFFE0E0E0);

  // ─────────────────────────────────────────────────────────────────────────────
  // Interactive States
  // ─────────────────────────────────────────────────────────────────────────────

  /// Disabled background
  static const Color disabled = Color(0xFFE9ECEF);

  /// Hover overlay
  static const Color hoverOverlay = Color(0x0A000000);

  /// Pressed overlay
  static const Color pressedOverlay = Color(0x1A000000);

  /// Focus overlay
  static const Color focusOverlay = Color(0x1A133E87);

  // ─────────────────────────────────────────────────────────────────────────────
  // Utility
  // ─────────────────────────────────────────────────────────────────────────────

  /// Transparent color
  static const Color transparent = Colors.transparent;

  /// Shadow color
  static const Color shadow = Color(0x1A000000);

  // ─────────────────────────────────────────────────────────────────────────────
  // Gradients
  // ─────────────────────────────────────────────────────────────────────────────

  /// Premium mesh-like gradient used across the app
  static Gradient get premiumGradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          scaffoldBackground,
          secondary.withValues(alpha: 0.05),
          primary.withValues(alpha: 0.03),
          scaffoldBackground,
        ],
        stops: const [0.0, 0.3, 0.7, 1.0],
      );

  /// Primary branding gradient for icons and highlights
  static Gradient get primaryGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [primary, secondary],
      );
}
