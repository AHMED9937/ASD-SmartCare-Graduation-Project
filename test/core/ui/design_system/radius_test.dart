import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:asdsmartcare/core/design_system/tokens/radius.dart';

void main() {
  group('AppRadius', () {
    group('Radius Values', () {
      test('none is 0', () {
        expect(AppRadius.none, 0.0);
      });

      test('xs is 4', () {
        expect(AppRadius.xs, 4.0);
      });

      test('sm is 8', () {
        expect(AppRadius.sm, 8.0);
      });

      test('md is 12', () {
        expect(AppRadius.md, 12.0);
      });

      test('lg is 16', () {
        expect(AppRadius.lg, 16.0);
      });

      test('xl is 24', () {
        expect(AppRadius.xl, 24.0);
      });

      test('full is 9999 for pill shapes', () {
        expect(AppRadius.full, 9999.0);
      });
    });

    group('BorderRadius Objects', () {
      test('noneRadius is zero', () {
        expect(AppRadius.noneRadius, BorderRadius.zero);
      });

      test('smRadius uses sm value', () {
        expect(AppRadius.smRadius, BorderRadius.circular(AppRadius.sm));
      });

      test('mdRadius uses md value', () {
        expect(AppRadius.mdRadius, BorderRadius.circular(AppRadius.md));
      });

      test('lgRadius uses lg value', () {
        expect(AppRadius.lgRadius, BorderRadius.circular(AppRadius.lg));
      });

      test('fullRadius uses full value', () {
        expect(AppRadius.fullRadius, BorderRadius.circular(AppRadius.full));
      });
    });

    group('Semantic BorderRadius', () {
      test('card uses mdRadius', () {
        expect(AppRadius.card, AppRadius.mdRadius);
      });

      test('button uses smRadius', () {
        expect(AppRadius.button, AppRadius.smRadius);
      });

      test('textField uses smRadius', () {
        expect(AppRadius.textField, AppRadius.smRadius);
      });

      test('chip uses fullRadius for pills', () {
        expect(AppRadius.chip, AppRadius.fullRadius);
      });

      test('dialog uses lgRadius', () {
        expect(AppRadius.dialog, AppRadius.lgRadius);
      });

      test('bottomSheet has only top corners rounded', () {
        expect(
            AppRadius.bottomSheet.topLeft, const Radius.circular(AppRadius.xl));
        expect(AppRadius.bottomSheet.topRight,
            const Radius.circular(AppRadius.xl));
        expect(AppRadius.bottomSheet.bottomLeft, Radius.zero);
        expect(AppRadius.bottomSheet.bottomRight, Radius.zero);
      });
    });
  });
}
