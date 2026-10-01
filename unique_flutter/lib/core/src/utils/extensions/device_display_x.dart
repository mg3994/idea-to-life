// import 'dart:ui' show DisplayFeature, DisplayFeatureType, DisplayFeatureState;

// import 'package:flutter/material.dart' show BorderRadius, MediaQueryData, Rect;

// extension DeviceScreenExtension on MediaQueryData {
//   // ==========================================
//   // 1. CORNER RADII
//   // ==========================================

//   /// Returns the hardware corner radii of the display.
//   BorderRadius? get cornerRadii => displayCornerRadii;

//   /// Does the screen have physical rounded corners?
//   bool get hasRoundedCorners =>
//       displayCornerRadii != null && displayCornerRadii != BorderRadius.zero;

//   // ==========================================
//   // 2. CUTOUTS
//   // ==========================================

//   /// Returns all cutouts obstructing the screen.
//   List<DisplayFeature> get cutouts => displayFeatures
//       .where((f) => f.type == DisplayFeatureType.cutout)
//       .toList();

//   /// Does the device have any screen cutouts?
//   bool get hasCutouts => cutouts.isNotEmpty;

//   // ==========================================
//   // 3. FOLDS & HINGES (Hardware detection)
//   // ==========================================

//   /// Internal DRY helper: Returns all hardware hinges and folds.
//   List<DisplayFeature> get _foldsAndHinges => displayFeatures
//       .where(
//         (f) =>
//             f.type == DisplayFeatureType.fold ||
//             f.type == DisplayFeatureType.hinge,
//       )
//       .toList();

//   /// Does the device have a flexible fold or physical hinge mechanism?
//   bool get isFoldableScreen => _foldsAndHinges.isNotEmpty;

//   /// Does a hinge or fold bisect the screen into two distinctly usable areas?
//   bool get isDualScreenDevice => verticalFold != null || horizontalFold != null;

//   /// Gets the vertical fold (splits screen Left/Right).
//   DisplayFeature? get verticalFold {
//     for (final f in _foldsAndHinges) {
//       final spansVertically = f.bounds.height >= size.height * 0.9;
//       final splitsLeftRight = f.bounds.left > 0;
//       final isVertical = f.bounds.height > f.bounds.width;

//       if (spansVertically && splitsLeftRight && isVertical) return f;
//     }
//     return null;
//   }

//   /// Gets the horizontal fold (splits screen Top/Bottom).
//   DisplayFeature? get horizontalFold {
//     for (final f in _foldsAndHinges) {
//       final spansHorizontally = f.bounds.width >= size.width * 0.9;
//       final splitsTopBottom = f.bounds.top > 0;
//       final isHorizontal = f.bounds.width > f.bounds.height;

//       if (spansHorizontally && splitsTopBottom && isHorizontal) return f;
//     }
//     return null;
//   }

//   // ==========================================
//   // 4. POSTURE / STATE (Flex Mode detection)
//   // ==========================================

//   /// Returns true if the device is actively bent in an intermediate "L" shape
//   /// (also known as Flex Mode, Tabletop Mode, or Laptop Mode).
//   bool get isHalfOpened => _foldsAndHinges.any(
//     (f) => f.state == DisplayFeatureState.postureHalfOpened,
//   );

//   /// Returns true ONLY if this is a foldable device AND it is completely opened flat.
//   /// (Returns false for standard non-foldable slab phones).
//   bool get isFoldableFlat =>
//       isFoldableScreen &&
//       _foldsAndHinges.every((f) => f.state == DisplayFeatureState.postureFlat);
// }

//////////////
import 'dart:ui' show DisplayFeature, DisplayFeatureState, DisplayFeatureType;

import 'package:flutter/material.dart' show BorderRadius, MediaQueryData, Rect;

extension DeviceScreenExtension on MediaQueryData {
  // ===========================================================================
  // 1. CORNER RADII
  // ===========================================================================

  BorderRadius? get cornerRadii => displayCornerRadii;

  bool get hasRoundedCorners =>
      displayCornerRadii != null && displayCornerRadii != BorderRadius.zero;

  // ===========================================================================
  // 2. CUTOUTS
  // ===========================================================================

  List<DisplayFeature> get cutouts => displayFeatures
      .where((feature) => feature.type == DisplayFeatureType.cutout)
      .toList();

  bool get hasCutouts => cutouts.isNotEmpty;

  List<Rect> get cutoutBounds =>
      cutouts.map((feature) => feature.bounds).toList();

  // ===========================================================================
  // 3. FOLDS & HINGES
  // ===========================================================================

  List<DisplayFeature> get _foldsAndHinges => displayFeatures
      .where(
        (feature) =>
            feature.type == DisplayFeatureType.fold ||
            feature.type == DisplayFeatureType.hinge,
      )
      .toList();

  bool get isFoldableScreen => _foldsAndHinges.isNotEmpty;

  // ---------------------------------------------------------------------------
  // Vertical folds / hinges
  // ---------------------------------------------------------------------------

  List<DisplayFeature> get verticalFolds {
    final features = _foldsAndHinges
        .where(
          (feature) => feature.bounds.height > feature.bounds.width,
        )
        .toList();

    features.sort(
      (a, b) => a.bounds.left.compareTo(b.bounds.left),
    );

    return features;
  }

  // ---------------------------------------------------------------------------
  // Horizontal folds / hinges
  // ---------------------------------------------------------------------------

  List<DisplayFeature> get horizontalFolds {
    final features = _foldsAndHinges
        .where(
          (feature) => feature.bounds.width > feature.bounds.height,
        )
        .toList();

    features.sort(
      (a, b) => a.bounds.top.compareTo(b.bounds.top),
    );

    return features;
  }

  // ---------------------------------------------------------------------------
  // First fold / hinge
  // ---------------------------------------------------------------------------

  DisplayFeature? get verticalFold =>
      verticalFolds.isEmpty ? null : verticalFolds.first;

  DisplayFeature? get horizontalFold =>
      horizontalFolds.isEmpty ? null : horizontalFolds.first;

  bool get isDualScreenDevice =>
      verticalFolds.isNotEmpty || horizontalFolds.isNotEmpty;

  // ===========================================================================
  // 4. MASTER FRACTIONS
  // ===========================================================================

  /// Fraction of the complete screen width before the first vertical
  /// fold/hinge.
  ///
  /// Example:
  ///   screen width = 1800
  ///   hinge.left   = 880
  ///   result       = 880 / 1800 = 0.489
  double? get verticalMasterFraction {
    final fold = verticalFold;

    if (fold == null) return null;

    return (fold.bounds.left / size.width).clamp(0.0, 1.0);
  }

  /// Fraction of the complete screen height before the first horizontal
  /// fold/hinge.
  ///
  /// Example:
  ///   screen height = 2400
  ///   hinge.top     = 1180
  ///   result        = 1180 / 2400 = 0.492
  double? get horizontalMasterFraction {
    final fold = horizontalFold;

    if (fold == null) return null;

    return (fold.bounds.top / size.height).clamp(0.0, 1.0);
  }

  /// Master fraction using whichever orientation has a first fold/hinge.
  ///
  /// Prefer the axis-specific getters when the layout direction is known.
  double? get masterFraction =>
      verticalMasterFraction ?? horizontalMasterFraction;

  // ===========================================================================
  // 5. ALL FOLD FRACTIONS
  // ===========================================================================

  /// Position of every vertical fold/hinge as a fraction of the complete
  /// screen width.
  List<double> get verticalFoldFractions => [
    for (final fold in verticalFolds)
      (fold.bounds.left / size.width).clamp(0.0, 1.0),
  ];

  /// Position of every horizontal fold/hinge as a fraction of the complete
  /// screen height.
  List<double> get horizontalFoldFractions => [
    for (final fold in horizontalFolds)
      (fold.bounds.top / size.height).clamp(0.0, 1.0),
  ];

  // ===========================================================================
  // 6. POSTURE / STATE
  // ===========================================================================

  bool get isHalfOpened => _foldsAndHinges.any(
    (feature) => feature.state == DisplayFeatureState.postureHalfOpened,
  );

  bool get isFoldableFlat =>
      isFoldableScreen &&
      _foldsAndHinges.every(
        (feature) => feature.state == DisplayFeatureState.postureFlat,
      );
}
