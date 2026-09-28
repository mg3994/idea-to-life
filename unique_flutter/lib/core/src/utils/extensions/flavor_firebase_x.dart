import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

import '../../../core.dart' show Flavor, FlavorInterface;

import '../../../../firebase_options_dev.dart' as dev;
import '../../../../firebase_options_prod.dart' as prod;
import '../../../../firebase_options_stg.dart' as stg;

extension FlavorFirebaseOptionsX on FlavorInterface {
  /// Resolves platform-specific [FirebaseOptions] for the current flavor.
  FirebaseOptions get firebaseOptions => switch (this) {
    Flavor.development => dev.DefaultFirebaseOptions.currentPlatform,
    Flavor.staging => stg.DefaultFirebaseOptions.currentPlatform,
    _ => prod.DefaultFirebaseOptions.currentPlatform,
  };
}
