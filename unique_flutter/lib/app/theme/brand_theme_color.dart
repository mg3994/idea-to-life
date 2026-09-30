import 'package:flutter/material.dart'
    show
        Brightness,
        BuildContext,
        Color,
        ColorScheme,
        Theme,
        ThemeData,
        ThemeExtension,
        immutable;

/// A [ThemeExtension] that defines brand-specific colors for the application.
@immutable
final class BrandThemeColor extends ThemeExtension<BrandThemeColor> {
  const BrandThemeColor({
    required this.brand,
    required this.onBrand,
    required this.brandSecondary,
    required this.onBrandSecondary,
    required this.brandContainer,
    required this.onBrandContainer,
    required this.brandMuted,
  });

  /// The primary brand color.
  final Color brand;

  /// The color used for content on top of [brand].
  final Color onBrand;

  /// A secondary accent brand color.
  final Color brandSecondary;

  /// The color used for content on top of [brandSecondary].
  final Color onBrandSecondary;

  /// A container / tonal surface color for brand elements.
  final Color brandContainer;

  /// The color used for content on top of [brandContainer].
  final Color onBrandContainer;

  /// A subtle or muted variation of the brand color.
  final Color brandMuted;

  /// Creates a [BrandThemeColor] by deriving harmonious values from a [seed] color.
  factory BrandThemeColor.fromSeed({
    required Color seed,
    Brightness brightness = Brightness.light,
  }) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
    );
    final isDark = brightness == Brightness.dark;

    return BrandThemeColor(
      brand: scheme.primary,
      onBrand: scheme.onPrimary,
      brandSecondary: scheme.secondary,
      onBrandSecondary: scheme.onSecondary,
      brandContainer: scheme.primaryContainer,
      onBrandContainer: scheme.onPrimaryContainer,
      brandMuted: isDark
          ? scheme.surfaceContainerHighest
          : scheme.surfaceContainerLow,
    );
  }

  /// Default light brand theme color.
  static const BrandThemeColor light = BrandThemeColor(
    brand: Color(0xFF6750A4),
    onBrand: Color(0xFFFFFFFF),
    brandSecondary: Color(0xFF625B71),
    onBrandSecondary: Color(0xFFFFFFFF),
    brandContainer: Color(0xFFEADDFF),
    onBrandContainer: Color(0xFF21005D),
    brandMuted: Color(0xFFF7F2FA),
  );

  /// Default dark brand theme color.
  static const BrandThemeColor dark = BrandThemeColor(
    brand: Color(0xFFD0BCFF),
    onBrand: Color(0xFF381E72),
    brandSecondary: Color(0xFFCCC2DC),
    onBrandSecondary: Color(0xFF332D41),
    brandContainer: Color(0xFF4F378B),
    onBrandContainer: Color(0xFFEADDFF),
    brandMuted: Color(0xFF2B2930),
  );

  @override
  BrandThemeColor copyWith({
    Color? brand,
    Color? onBrand,
    Color? brandSecondary,
    Color? onBrandSecondary,
    Color? brandContainer,
    Color? onBrandContainer,
    Color? brandMuted,
  }) {
    return BrandThemeColor(
      brand: brand ?? this.brand,
      onBrand: onBrand ?? this.onBrand,
      brandSecondary: brandSecondary ?? this.brandSecondary,
      onBrandSecondary: onBrandSecondary ?? this.onBrandSecondary,
      brandContainer: brandContainer ?? this.brandContainer,
      onBrandContainer: onBrandContainer ?? this.onBrandContainer,
      brandMuted: brandMuted ?? this.brandMuted,
    );
  }

  @override
  BrandThemeColor lerp(
    covariant ThemeExtension<BrandThemeColor>? other,
    double t,
  ) {
    if (other is! BrandThemeColor) {
      return this;
    }
    return BrandThemeColor(
      brand: Color.lerp(brand, other.brand, t) ?? brand,
      onBrand: Color.lerp(onBrand, other.onBrand, t) ?? onBrand,
      brandSecondary:
          Color.lerp(brandSecondary, other.brandSecondary, t) ?? brandSecondary,
      onBrandSecondary:
          Color.lerp(onBrandSecondary, other.onBrandSecondary, t) ??
          onBrandSecondary,
      brandContainer:
          Color.lerp(brandContainer, other.brandContainer, t) ?? brandContainer,
      onBrandContainer:
          Color.lerp(onBrandContainer, other.onBrandContainer, t) ??
          onBrandContainer,
      brandMuted: Color.lerp(brandMuted, other.brandMuted, t) ?? brandMuted,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BrandThemeColor &&
        other.brand == brand &&
        other.onBrand == onBrand &&
        other.brandSecondary == brandSecondary &&
        other.onBrandSecondary == onBrandSecondary &&
        other.brandContainer == brandContainer &&
        other.onBrandContainer == onBrandContainer &&
        other.brandMuted == brandMuted;
  }

  @override
  int get hashCode => Object.hash(
    brand,
    onBrand,
    brandSecondary,
    onBrandSecondary,
    brandContainer,
    onBrandContainer,
    brandMuted,
  );
}

/// Convenience extensions to easily access [BrandThemeColor] from [BuildContext].
extension BrandThemeColorContextX on BuildContext {
  /// Resolves the current [BrandThemeColor] from the widget tree.
  BrandThemeColor get brandThemeColor =>
      Theme.of(this).extension<BrandThemeColor>() ?? BrandThemeColor.light;

  /// Shorthand alias for [brandThemeColor].
  BrandThemeColor get brandColor => brandThemeColor;
}

/// Convenience extensions to easily access [BrandThemeColor] from [ThemeData].
extension BrandThemeColorThemeDataX on ThemeData {
  /// Resolves [BrandThemeColor] from this [ThemeData].
  BrandThemeColor get brandThemeColor =>
      extension<BrandThemeColor>() ?? BrandThemeColor.light;

  /// Shorthand alias for [brandThemeColor].
  BrandThemeColor get brandColor => brandThemeColor;
}
