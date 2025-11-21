import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:asdsmartcare/core/design_system/tokens/colors.dart';

void main() {
  group('AppColors', () {
    group('Brand Colors', () {
      test('primary color is correct hex value', () {
        expect(AppColors.primary, const Color(0xFF133E87));
      });

      test('primaryLight color is correct hex value', () {
        expect(AppColors.primaryLight, const Color(0xFF3A5F9A));
      });

      test('primaryLighter color is correct hex value', () {
        expect(AppColors.primaryLighter, const Color(0xFFCCDFFF));
      });

      test('primaryDark color is correct hex value', () {
        expect(AppColors.primaryDark, const Color(0xFF0D2A5C));
      });

      test('secondary color is correct hex value', () {
        expect(AppColors.secondary, const Color(0xFF608BC1));
      });
    });

    group('Semantic Colors', () {
      test('success color is green', () {
        expect(AppColors.success, const Color(0xFF28A745));
      });

      test('warning color is amber', () {
        expect(AppColors.warning, const Color(0xFFFFC107));
      });

      test('error color is red', () {
        expect(AppColors.error, const Color(0xFFDC3545));
      });

      test('info color is blue', () {
        expect(AppColors.info, const Color(0xFF17A2B8));
      });
    });

    group('Surface Colors', () {
      test('background is white', () {
        expect(AppColors.background, const Color(0xFFFFFFFF));
      });

      test('surface is pure white', () {
        expect(AppColors.surface, const Color(0xFFFFFFFF));
      });

      test('scaffoldBackground equals background', () {
        expect(AppColors.scaffoldBackground, AppColors.background);
      });
    });

    group('Text Colors', () {
      test('onPrimary is white for contrast on primary', () {
        expect(AppColors.onPrimary, const Color(0xFFFFFFFF));
      });

      test('onSurface is dark for readability on light surfaces', () {
        expect(AppColors.onSurface, const Color(0xFF1A1A1A));
      });

      test('textSecondary is muted gray', () {
        expect(AppColors.textSecondary, const Color(0xFF6C757D));
      });
    });

    group('Gradients', () {
      test('premiumGradient returns a LinearGradient', () {
        final gradient = AppColors.premiumGradient;
        expect(gradient, isA<LinearGradient>());
      });

      test('primaryGradient contains primary and secondary colors', () {
        final gradient = AppColors.primaryGradient as LinearGradient;
        expect(gradient.colors, contains(AppColors.primary));
        expect(gradient.colors, contains(AppColors.secondary));
      });
    });
  });
}
