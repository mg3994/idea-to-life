import 'dart:ui' show DisplayFeature, DisplayFeatureType, DisplayFeatureState;

import 'package:flutter/material.dart' show BorderRadius, MediaQueryData, Rect;

extension DeviceScreenExtension on MediaQueryData {
  // ==========================================
  // 1. CORNER RADII
  // ==========================================

  /// Returns the hardware corner radii of the display.
  BorderRadius? get cornerRadii => displayCornerRadii;

  /// Does the screen have physical rounded corners?
  bool get hasRoundedCorners =>
      displayCornerRadii != null && displayCornerRadii != BorderRadius.zero;

  // ==========================================
  // 2. CUTOUTS
  // ==========================================

  /// Returns all cutouts obstructing the screen.
  List<DisplayFeature> get cutouts => displayFeatures
      .where((f) => f.type == DisplayFeatureType.cutout)
      .toList();

  /// Does the device have any screen cutouts?
  bool get hasCutouts => cutouts.isNotEmpty;

  // ==========================================
  // 3. FOLDS & HINGES (Hardware detection)
  // ==========================================

  /// Internal DRY helper: Returns all hardware hinges and folds.
  List<DisplayFeature> get _foldsAndHinges => displayFeatures
      .where(
        (f) =>
            f.type == DisplayFeatureType.fold ||
            f.type == DisplayFeatureType.hinge,
      )
      .toList();

  /// Does the device have a flexible fold or physical hinge mechanism?
  bool get isFoldableScreen => _foldsAndHinges.isNotEmpty;

  /// Does a hinge or fold bisect the screen into two distinctly usable areas?
  bool get isDualScreenDevice => verticalFold != null || horizontalFold != null;

  /// Gets the vertical fold (splits screen Left/Right).
  DisplayFeature? get verticalFold {
    for (final f in _foldsAndHinges) {
      final spansVertically = f.bounds.height >= size.height * 0.9;
      final splitsLeftRight = f.bounds.left > 0;
      final isVertical = f.bounds.height > f.bounds.width;

      if (spansVertically && splitsLeftRight && isVertical) return f;
    }
    return null;
  }

  /// Gets the horizontal fold (splits screen Top/Bottom).
  DisplayFeature? get horizontalFold {
    for (final f in _foldsAndHinges) {
      final spansHorizontally = f.bounds.width >= size.width * 0.9;
      final splitsTopBottom = f.bounds.top > 0;
      final isHorizontal = f.bounds.width > f.bounds.height;

      if (spansHorizontally && splitsTopBottom && isHorizontal) return f;
    }
    return null;
  }

  // ==========================================
  // 4. POSTURE / STATE (Flex Mode detection)
  // ==========================================

  /// Returns true if the device is actively bent in an intermediate "L" shape
  /// (also known as Flex Mode, Tabletop Mode, or Laptop Mode).
  bool get isHalfOpened => _foldsAndHinges.any(
    (f) => f.state == DisplayFeatureState.postureHalfOpened,
  );

  /// Returns true ONLY if this is a foldable device AND it is completely opened flat.
  /// (Returns false for standard non-foldable slab phones).
  bool get isFoldableFlat =>
      isFoldableScreen &&
      _foldsAndHinges.every((f) => f.state == DisplayFeatureState.postureFlat);
}
