/// Design system spacing tokens for ASD SmartCare.
///
/// Consistent spacing scale based on 4dp base unit.
///
/// Usage:
/// ```dart
/// Padding(padding: EdgeInsets.all(AppSpacing.md))
/// SizedBox(height: AppSpacing.lg)
/// ```
abstract final class AppSpacing {
  // ─────────────────────────────────────────────────────────────────────────────
  // Base Unit
  // ─────────────────────────────────────────────────────────────────────────────

  /// Base unit for spacing calculations (4dp)
  static const double base = 4.0;

  // ─────────────────────────────────────────────────────────────────────────────
  // Spacing Scale
  // ─────────────────────────────────────────────────────────────────────────────

  /// Extra extra small spacing: 2dp
  static const double xxs = base * 0.5; // 2

  /// Extra small spacing: 4dp
  static const double xs = base; // 4

  /// Small spacing: 8dp
  static const double sm = base * 2; // 8

  /// Medium spacing: 12dp (default)
  static const double md = base * 3; // 12 (was 16)

  /// Large spacing: 18dp
  static const double lg = base * 4.5; // 18 (was 24)

  /// Extra large spacing: 24dp
  static const double xl = base * 6; // 24 (was 32)

  /// Extra extra large spacing: 36dp
  static const double xxl = base * 9; // 36 (was 48)

  /// Extra extra extra large spacing: 48dp
  static const double xxxl = base * 12; // 48 (was 64)

  // ─────────────────────────────────────────────────────────────────────────────
  // Semantic Spacing
  // ─────────────────────────────────────────────────────────────────────────────

  /// Screen edge padding (horizontal)
  static const double screenPaddingH = md; // 16

  /// Screen edge padding (vertical)
  static const double screenPaddingV = md; // 16

  /// Card internal padding
  static const double cardPadding = md; // 16

  /// List item vertical spacing
  static const double listItemSpacing = sm; // 8

  /// Section spacing (between major sections)
  static const double sectionSpacing = xl; // 32

  /// Form field spacing
  static const double formFieldSpacing = md; // 16

  /// Button internal horizontal padding
  static const double buttonPaddingH = md; // 16

  /// Button internal vertical padding
  static const double buttonPaddingV = sm; // 8

  /// Icon text gap
  static const double iconTextGap = sm; // 8

  /// App bar content spacing
  static const double appBarSpacing = md; // 16

  // ─────────────────────────────────────────────────────────────────────────────
  // Component Sizes
  // ─────────────────────────────────────────────────────────────────────────────

  /// Minimum touch target size (accessibility)
  static const double minTouchTarget = 48.0;

  /// Standard button height
  static const double buttonHeight = 48.0;

  /// Small button height
  static const double buttonHeightSmall = 36.0;

  /// Text field height
  static const double textFieldHeight = 48.0;

  /// App bar height
  static const double appBarHeight = 56.0;

  /// Bottom navigation bar height
  static const double bottomNavHeight = 80.0;

  /// Icon size small
  static const double iconSm = 16.0;

  /// Icon size medium
  static const double iconMd = 24.0;

  /// Icon size large
  static const double iconLg = 32.0;

  /// Avatar size small
  static const double avatarSm = 32.0;

  /// Avatar size medium
  static const double avatarMd = 48.0;

  /// Avatar size large
  static const double avatarLg = 64.0;
}
