import 'package:flutter_test/flutter_test.dart';
import 'package:asdsmartcare/core/design_system/tokens/spacing.dart';

void main() {
  group('AppSpacing', () {
    group('Base Scale', () {
      test('base unit is 4dp', () {
        expect(AppSpacing.base, 4.0);
      });

      test('xxs is half of base', () {
        expect(AppSpacing.xxs, 2.0);
      });

      test('xs equals base', () {
        expect(AppSpacing.xs, AppSpacing.base);
      });

      test('sm is 2x base', () {
        expect(AppSpacing.sm, 8.0);
      });

      test('md is 3x base', () {
        expect(AppSpacing.md, 12.0);
      });

      test('lg is 4.5x base', () {
        expect(AppSpacing.lg, 18.0);
      });

      test('xl is 6x base', () {
        expect(AppSpacing.xl, 24.0);
      });

      test('xxl is 9x base', () {
        expect(AppSpacing.xxl, 36.0);
      });

      test('xxxl is 12x base', () {
        expect(AppSpacing.xxxl, 48.0);
      });
    });

    group('Semantic Spacing', () {
      test('screenPaddingH equals md', () {
        expect(AppSpacing.screenPaddingH, AppSpacing.md);
      });

      test('cardPadding equals md', () {
        expect(AppSpacing.cardPadding, AppSpacing.md);
      });

      test('listItemSpacing equals sm', () {
        expect(AppSpacing.listItemSpacing, AppSpacing.sm);
      });

      test('formFieldSpacing equals md', () {
        expect(AppSpacing.formFieldSpacing, AppSpacing.md);
      });
    });

    group('Component Sizes', () {
      test('minTouchTarget is 48dp for accessibility', () {
        expect(AppSpacing.minTouchTarget, 48.0);
      });

      test('buttonHeight is 48dp', () {
        expect(AppSpacing.buttonHeight, 48.0);
      });

      test('buttonHeightSmall is 36dp', () {
        expect(AppSpacing.buttonHeightSmall, 36.0);
      });

      test('iconSm is 16dp', () {
        expect(AppSpacing.iconSm, 16.0);
      });

      test('iconMd is 24dp', () {
        expect(AppSpacing.iconMd, 24.0);
      });

      test('iconLg is 32dp', () {
        expect(AppSpacing.iconLg, 32.0);
      });

      test('avatarSm is 32dp', () {
        expect(AppSpacing.avatarSm, 32.0);
      });

      test('avatarMd is 48dp', () {
        expect(AppSpacing.avatarMd, 48.0);
      });

      test('avatarLg is 64dp', () {
        expect(AppSpacing.avatarLg, 64.0);
      });
    });
  });
}
