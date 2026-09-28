// lib/app/firebase/firebase_initializer.dart

import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:unique_flutter/core/constants/firebase_constants.dart';

import '../../core/core.dart'
    show FlavorConfig, FlavorFirebaseOptionsX, currentFBConfig;

abstract interface class FirebaseInitializer {
  Future<FirebaseApp> initialize();
}

final class DefaultFirebaseInitializer implements FirebaseInitializer {
  const DefaultFirebaseInitializer({
    this.flavorConfig,
    this.options,
  });

  /// The active app flavor configuration.
  final FlavorConfig? flavorConfig;

  /// Explicit [FirebaseOptions] override.
  final FirebaseOptions? options;

  @override
  Future<FirebaseApp> initialize() {
    // Falls back to global currentFBConfig if flavorConfig was not explicitly injected
    final effectiveFlavor = flavorConfig ?? currentFBConfig;
    final baseOptions = options ?? effectiveFlavor.flavor.firebaseOptions;
    return Firebase.initializeApp(
      options: _processPlatformOptions(baseOptions),
    );
  }

  /// Ensures web-specific overrides (like [measurementId]) are applied correctly.
  FirebaseOptions _processPlatformOptions(FirebaseOptions options) {
    if (!kIsWeb) return options;

    return FirebaseOptions(
      apiKey: options.apiKey,
      appId: options.appId,
      messagingSenderId: options.messagingSenderId,
      projectId: options.projectId,
      authDomain: options.authDomain,
      databaseURL: options.databaseURL,
      storageBucket: options.storageBucket,
      measurementId: options.measurementId ?? FirebaseConstants.measurementId,
      trackingId: options.trackingId,
      deepLinkURLScheme: options.deepLinkURLScheme,
      androidClientId: options.androidClientId,
      iosClientId: options.iosClientId,
      iosBundleId: options.iosBundleId,
      appGroupId: options.appGroupId,
    );
  }
}
