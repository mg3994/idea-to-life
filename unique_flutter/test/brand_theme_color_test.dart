import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unique_flutter/app/theme/app_theme.dart';

void main() {
  group('BrandThemeColor', () {
    test('static light and dark presets have valid colors', () {
      expect(BrandThemeColor.light.brand, isNotNull);
      expect(BrandThemeColor.light.onBrand, isNotNull);
      expect(BrandThemeColor.dark.brand, isNotNull);
      expect(BrandThemeColor.dark.onBrand, isNotNull);
    });

    test('fromSeed produces matching primary and onPrimary colors', () {
      const seed = Colors.deepOrange;
      final lightBrand = BrandThemeColor.fromSeed(
        seed: seed,
        brightness: Brightness.light,
      );
      final darkBrand = BrandThemeColor.fromSeed(
        seed: seed,
        brightness: Brightness.dark,
      );

      final lightScheme = ColorScheme.fromSeed(
        seedColor: seed,
        brightness: Brightness.light,
      );
      final darkScheme = ColorScheme.fromSeed(
        seedColor: seed,
        brightness: Brightness.dark,
      );

      expect(lightBrand.brand, lightScheme.primary);
      expect(lightBrand.onBrand, lightScheme.onPrimary);
      expect(darkBrand.brand, darkScheme.primary);
      expect(darkBrand.onBrand, darkScheme.onPrimary);
    });

    test('copyWith updates specified fields only', () {
      const original = BrandThemeColor.light;
      const customBrand = Color(0xFF123456);
      final updated = original.copyWith(brand: customBrand);

      expect(updated.brand, customBrand);
      expect(updated.onBrand, original.onBrand);
      expect(updated.brandSecondary, original.brandSecondary);
      expect(updated.onBrandSecondary, original.onBrandSecondary);
      expect(updated.brandContainer, original.brandContainer);
      expect(updated.onBrandContainer, original.onBrandContainer);
      expect(updated.brandMuted, original.brandMuted);
    });

    test('lerp interpolates between two instances', () {
      const colorA = Color(0xFF000000);
      const colorB = Color(0xFFFFFFFF);

      const brandA = BrandThemeColor(
        brand: colorA,
        onBrand: colorA,
        brandSecondary: colorA,
        onBrandSecondary: colorA,
        brandContainer: colorA,
        onBrandContainer: colorA,
        brandMuted: colorA,
      );

      const brandB = BrandThemeColor(
        brand: colorB,
        onBrand: colorB,
        brandSecondary: colorB,
        onBrandSecondary: colorB,
        brandContainer: colorB,
        onBrandContainer: colorB,
        brandMuted: colorB,
      );

      final lerped = brandA.lerp(brandB, 0.5);

      expect(lerped.brand, Color.lerp(colorA, colorB, 0.5));
      expect(lerped.onBrand, Color.lerp(colorA, colorB, 0.5));
    });

    test(
      'AppTheme.light and AppTheme.dark provide BrandThemeColor extension',
      () {
        final lightTheme = AppTheme.light(seed: Colors.teal);
        final darkTheme = AppTheme.dark(seed: Colors.teal);

        final lightExt = lightTheme.extension<BrandThemeColor>();
        final darkExt = darkTheme.extension<BrandThemeColor>();

        expect(lightExt, isNotNull);
        expect(darkExt, isNotNull);
        expect(lightTheme.brandThemeColor, lightExt);
        expect(darkTheme.brandThemeColor, darkExt);
        expect(lightTheme.brandColor, lightExt);
        expect(darkTheme.brandColor, darkExt);
      },
    );

    testWidgets('BuildContext extensions resolve BrandThemeColor from tree', (
      tester,
    ) async {
      late BrandThemeColor contextBrand;
      late BrandThemeColor contextAlias;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(seed: Colors.purple),
          home: Builder(
            builder: (context) {
              contextBrand = context.brandThemeColor;
              contextAlias = context.brandColor;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(contextBrand, isNotNull);
      expect(contextAlias, contextBrand);
    });
  });
}
