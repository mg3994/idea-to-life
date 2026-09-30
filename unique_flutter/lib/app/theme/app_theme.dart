import 'package:flutter/material.dart'
    show
        RoundedRectangleBorder,
        ThemeData,
        Color,
        Colors,
        ColorScheme,
        EdgeInsets,
        BorderRadius,
        CardThemeData,
        Brightness;

abstract final class AppTheme {
  static ThemeData light({Color seed = Colors.indigo}) {
    final base = ThemeData.light(useMaterial3: true);
    final scheme = ColorScheme.fromSeed(seedColor: seed);

    return base.copyWith(
      colorScheme: scheme,

      cardTheme: CardThemeData(
        color: scheme.surface,
        surfaceTintColor: scheme.surfaceTint,
        shadowColor: Colors.black.withAlpha(100),
        elevation: 1,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      textTheme: base.textTheme.apply(
        bodyColor: scheme.onSurface,
        displayColor: scheme.onSurface,
        decorationColor: scheme.onSurface,
      ),
      primaryTextTheme: base.primaryTextTheme.apply(
        bodyColor: scheme.onPrimary,
        displayColor: scheme.onPrimary,
      ),
    );
  }

  static ThemeData dark({Color seed = Colors.indigo}) {
    final base = ThemeData.dark(useMaterial3: true);
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.dark,
    );

    return base.copyWith(
      colorScheme: scheme,

      cardTheme: CardThemeData(
        color: scheme.surface,
        surfaceTintColor: scheme.surfaceTint,
        shadowColor: Colors.black.withAlpha(100),
        elevation: 2,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      textTheme: base.textTheme.apply(
        bodyColor: scheme.onSurface,
        displayColor: scheme.onSurface,
        decorationColor: scheme.onSurface,
      ),
      primaryTextTheme: base.primaryTextTheme.apply(
        bodyColor: scheme.onPrimary,
        displayColor: scheme.onPrimary,
      ),
    );
  }
}
