import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart'
    show
        BorderRadius,
        BouncingScrollPhysics,
        Brightness,
        BuildContext,
        CardThemeData,
        ClampingScrollPhysics,
        Color,
        ColorScheme,
        Colors,
        EdgeInsets,
        MaterialScrollBehavior,
        RoundedRectangleBorder,
        ScrollBehavior,
        ScrollPhysics,
        ThemeData,
        ThemeExtension;

import 'brand_theme_color.dart' show BrandThemeColor;

export 'brand_theme_color.dart';

final class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
  };

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    if (kIsWeb) {
      return const ClampingScrollPhysics();
    }
    return const BouncingScrollPhysics();
  }
}

abstract final class AppTheme {
  static const ScrollBehavior scrollBehavior = AppScrollBehavior();

  static ThemeData light({
    Color seed = Colors.indigo,
    BrandThemeColor? brandThemeColor,
  }) {
    final base = ThemeData.light(useMaterial3: true);
    final scheme = ColorScheme.fromSeed(seedColor: seed);
    final brand =
        brandThemeColor ??
        BrandThemeColor.fromSeed(
          seed: seed,
          brightness: Brightness.light,
        );

    return base.copyWith(
      colorScheme: scheme,
      extensions: <ThemeExtension<dynamic>>[brand],

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

  static ThemeData dark({
    Color seed = Colors.indigo,
    BrandThemeColor? brandThemeColor,
  }) {
    final base = ThemeData.dark(useMaterial3: true);
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.dark,
    );
    final brand =
        brandThemeColor ??
        BrandThemeColor.fromSeed(
          seed: seed,
          brightness: Brightness.dark,
        );

    return base.copyWith(
      colorScheme: scheme,
      extensions: <ThemeExtension<dynamic>>[brand],

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

/// Adaptive [ScrollPhysics] that automatically uses [ClampingScrollPhysics]
/// on web and [BouncingScrollPhysics] on other platforms.
// class AppScrollPhysics extends ScrollPhysics {
//   const AppScrollPhysics({super.parent});

//   @override
//   AppScrollPhysics applyTo(ScrollPhysics? ancestor) {
//     return AppScrollPhysics(parent: buildParent(ancestor));
//   }

//   ScrollPhysics get _delegate => kIsWeb
//       ? ClampingScrollPhysics(parent: parent)
//       : BouncingScrollPhysics(parent: parent);

//   @override
//   double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
//     return _delegate.applyPhysicsToUserOffset(position, offset);
//   }

//   @override
//   double applyBoundaryConditions(ScrollMetrics position, double value) {
//     return _delegate.applyBoundaryConditions(position, value);
//   }

//   @override
//   Simulation? createBallisticSimulation(
//     ScrollMetrics position,
//     double velocity,
//   ) {
//     return _delegate.createBallisticSimulation(position, velocity);
//   }

//   @override
//   bool shouldAcceptUserOffset(ScrollMetrics position) {
//     return _delegate.shouldAcceptUserOffset(position);
//   }
// }
