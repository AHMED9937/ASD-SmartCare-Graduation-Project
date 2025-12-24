import 'package:flutter/material.dart';

/// Design system border radius tokens for ASD SmartCare.
///
/// Consistent corner radius scale.
///
/// Usage:
/// ```dart
/// Container(
///   decoration: BoxDecoration(
///     borderRadius: AppRadius.md,
///   ),
/// )
/// ```
abstract final class AppRadius {
  // ─────────────────────────────────────────────────────────────────────────────
  // Radius Values
  // ─────────────────────────────────────────────────────────────────────────────

  /// No radius (sharp corners)
  static const double none = 0.0;

  /// Extra small radius: 4dp
  static const double xs = 4.0;

  /// Small radius: 8dp
  static const double sm = 8.0;

  /// Medium radius: 12dp (default for cards)
  static const double md = 12.0;

  /// Large radius: 16dp
  static const double lg = 16.0;

  /// Extra large radius: 24dp
  static const double xl = 24.0;

  /// Full/pill radius: 9999dp
  static const double full = 9999.0;

  // ─────────────────────────────────────────────────────────────────────────────
  // BorderRadius Objects
  // ─────────────────────────────────────────────────────────────────────────────

  /// No border radius
  static const BorderRadius noneRadius = BorderRadius.zero;

  /// Extra small border radius
  static final BorderRadius xsRadius = BorderRadius.circular(xs);

  /// Small border radius
  static final BorderRadius smRadius = BorderRadius.circular(sm);

  /// Medium border radius (default)
  static final BorderRadius mdRadius = BorderRadius.circular(md);

  /// Large border radius
  static final BorderRadius lgRadius = BorderRadius.circular(lg);

  /// Extra large border radius
  static final BorderRadius xlRadius = BorderRadius.circular(xl);

  /// Full/pill border radius
  static final BorderRadius fullRadius = BorderRadius.circular(full);

  // ─────────────────────────────────────────────────────────────────────────────
  // Semantic BorderRadius
  // ─────────────────────────────────────────────────────────────────────────────

  /// Card border radius
  static final BorderRadius card = mdRadius;

  /// Button border radius
  static final BorderRadius button = smRadius;

  /// Text field border radius
  static final BorderRadius textField = smRadius;

  /// Chip/tag border radius
  static final BorderRadius chip = fullRadius;

  /// Dialog border radius
  static final BorderRadius dialog = lgRadius;

  /// Bottom sheet border radius (top only)
  static const BorderRadius bottomSheet = BorderRadius.only(
    topLeft: Radius.circular(xl),
    topRight: Radius.circular(xl),
  );

  /// Snackbar border radius
  static final BorderRadius snackbar = smRadius;

  /// Avatar border radius
  static final BorderRadius avatar = fullRadius;
}
