// typedef ErrorReporter = void Function(Object error, StackTrace stackTrace);

// final class BootstrapErrorReporter {
//   ErrorReporter? _reporter;

//   final List<_PendingError> _pending = [];

//   bool _closed = false;

//   void report(Object error, StackTrace stackTrace) {
//     if (_closed) return;

//     final reporter = _reporter;

//     if (reporter == null) {
//       _pending.add(_PendingError(error: error, stackTrace: stackTrace));
//       return;
//     }

//     reporter(error, stackTrace);
//   }

//   void attach(ErrorReporter reporter) {
//     if (_closed) {
//       throw StateError('Error reporter is closed.');
//     }

//     if (_reporter != null) {
//       throw StateError('Error reporter is already attached.');
//     }

//     _reporter = reporter;

//     final pending = List<_PendingError>.of(_pending);
//     _pending.clear();

//     for (final error in pending) {
//       reporter(error.error, error.stackTrace);
//     }
//   }

//   void close() {
//     _closed = true;
//     _reporter = null;
//     _pending.clear();
//   }
// }

// final class const _PendingError({
//   required final Object error,
//   required final StackTrace stackTrace,
// });

///////////////
typedef ErrorReporter = void Function(Object error, StackTrace stackTrace);

abstract class BootstrapErrorReporter {
  const BootstrapErrorReporter();

  /// Const no-op instance (safe for default parameters)
  const factory BootstrapErrorReporter.noop() = _NoOpBootstrapErrorReporter;

  /// Factory for the standard mutable reporter
  factory BootstrapErrorReporter.active() = _ActiveBootstrapErrorReporter;

  void report(Object error, StackTrace stackTrace);
  void attach(ErrorReporter reporter);
  void close();
}

class const _NoOpBootstrapErrorReporter() extends BootstrapErrorReporter {
  @override
  void report(Object error, StackTrace stackTrace) {}

  @override
  void attach(ErrorReporter reporter) {}

  @override
  void close() {}
}

class _ActiveBootstrapErrorReporter extends BootstrapErrorReporter {
  ErrorReporter? _reporter;
  bool _closed = false;
  final List<_PendingError> _pending = [];

  _ActiveBootstrapErrorReporter();

  @override
  void report(Object error, StackTrace stackTrace) {
    if (_closed) return;

    final reporter = _reporter;

    if (reporter == null) {
      _pending.add(_PendingError(error: error, stackTrace: stackTrace));
      return;
    }

    reporter(error, stackTrace);
  }

  @override
  void attach(ErrorReporter reporter) {
    if (_closed) {
      throw StateError('Error reporter is closed.');
    }

    if (_reporter != null) {
      throw StateError('Error reporter is already attached.');
    }

    _reporter = reporter;

    final pending = List<_PendingError>.of(_pending);
    _pending.clear();

    for (final error in pending) {
      reporter(error.error, error.stackTrace);
    }
  }

  @override
  void close() {
    _closed = true;
    _reporter = null;
    _pending.clear();
  }
}

final class _PendingError {
  final Object error;
  final StackTrace stackTrace;

  const _PendingError({
    required this.error,
    required this.stackTrace,
  });
}
