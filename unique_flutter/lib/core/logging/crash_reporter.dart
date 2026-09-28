import 'dart:async' show unawaited;

import 'package:firebase_crashlytics/firebase_crashlytics.dart'
    show FirebaseCrashlytics;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart' show FlutterErrorDetails;

/// Reporter for recording unhandled crashes and errors.
abstract interface class CrashReporter {
  /// Records an unhandled error and stack trace.
  Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    dynamic reason,
    Iterable<Object> information = const [],
    bool? printDetails,
    bool fatal = false,
  });

  /// Records a Flutter error. pass fatal as true when error is critical.
  /// If the app is running in debug mode, the error will be printed to the console.
  /// If the app is running in release mode, the error will be sent to Firebase Crashlytics.
  Future<void> recordFlutterError(
    FlutterErrorDetails flutterErrorDetails, {
    bool fatal = false,
  });
}

/// Default implementation of [CrashReporter].
final class const DefaultCrashReporter({
  /// Firebase Crashlytics instance.
  ///
  /// If `null`, errors will not be reported to Firebase Crashlytics.
  final FirebaseCrashlytics? _crashlytics,
}) implements CrashReporter {
  FirebaseCrashlytics? get _instance =>
      kIsWeb ? null : _crashlytics ?? FirebaseCrashlytics.instance;

  /// Creates a default crash reporter.

  @override
  Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    dynamic reason,
    Iterable<Object> information = const [],
    bool? printDetails,
    bool fatal = false,
  }) async {
    return unawaited(
      _instance?.recordError(
        exception,
        stack,
        reason: reason,
        information: information,
        printDetails: printDetails,
        fatal: fatal,
      ),
    );
  }

  @override
  Future<void> recordFlutterError(
    FlutterErrorDetails flutterErrorDetails, {
    bool fatal = false,
  }) async {
    return unawaited(
      _instance?.recordFlutterError(flutterErrorDetails, fatal: fatal),
    );
  }
}
