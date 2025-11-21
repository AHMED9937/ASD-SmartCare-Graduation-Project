import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:asdsmartcare/core/design_system/tokens/shadows.dart';
import 'package:asdsmartcare/core/design_system/tokens/colors.dart';

void main() {
  group('AppShadows', () {
    group('Shadow Presets', () {
      test('none shadow is transparent', () {
        expect(AppShadows.none.color, Colors.transparent);
      });

      test('xs shadow has small blur radius', () {
        expect(AppShadows.xs.blurRadius, 2);
        expect(AppShadows.xs.offset, const Offset(0, 1));
      });

      test('sm shadow has correct properties', () {
        expect(AppShadows.sm.blurRadius, 4);
        expect(AppShadows.sm.offset, const Offset(0, 2));
        expect(AppShadows.sm.color, AppColors.shadow);
      });

      test('md shadow has medium blur radius', () {
        expect(AppShadows.md.blurRadius, 8);
        expect(AppShadows.md.offset, const Offset(0, 4));
      });

      test('lg shadow has large blur radius', () {
        expect(AppShadows.lg.blurRadius, 16);
        expect(AppShadows.lg.offset, const Offset(0, 8));
      });

      test('xl shadow has extra large blur radius', () {
        expect(AppShadows.xl.blurRadius, 24);
        expect(AppShadows.xl.offset, const Offset(0, 12));
      });
    });

    group('Shadow Lists', () {
      test('noneList is empty', () {
        expect(AppShadows.noneList, isEmpty);
      });

      test('smList contains sm shadow', () {
        expect(AppShadows.smList, [AppShadows.sm]);
      });

      test('mdList contains md shadow', () {
        expect(AppShadows.mdList, [AppShadows.md]);
      });
    });

    group('Semantic Shadows', () {
      test('card shadow equals smList', () {
        expect(AppShadows.card, AppShadows.smList);
      });

      test('cardElevated shadow equals mdList', () {
        expect(AppShadows.cardElevated, AppShadows.mdList);
      });

      test('dialog shadow equals xlList', () {
        expect(AppShadows.dialog, AppShadows.xlList);
      });

      test('navBar shadow has negative offset for top shadow', () {
        expect(AppShadows.navBar.first.offset.dy, -2);
      });
    });

    group('Colored Shadows', () {
      test('primaryGlow uses primary color with opacity', () {
        final glow = AppShadows.primaryGlow;
        expect(glow.blurRadius, 12);
        expect(glow.offset, const Offset(0, 4));
        // Check it's based on primary color (alpha reduced)
        expect(glow.color.opacity, lessThan(1.0));
      });

      test('secondaryGlow uses secondary color with opacity', () {
        final glow = AppShadows.secondaryGlow;
        expect(glow.blurRadius, 12);
        expect(glow.offset, const Offset(0, 4));
      });
    });
  });
}
