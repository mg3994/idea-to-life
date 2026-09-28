typedef ErrorReporter = void Function(Object error, StackTrace stackTrace);

final class BootstrapErrorReporter {
  ErrorReporter? _reporter;

  final List<_PendingError> _pending = [];

  bool _closed = false;

  void report(Object error, StackTrace stackTrace) {
    if (_closed) return;

    final reporter = _reporter;

    if (reporter == null) {
      _pending.add(_PendingError(error: error, stackTrace: stackTrace));
      return;
    }

    reporter(error, stackTrace);
  }

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

  void close() {
    _closed = true;
    _reporter = null;
    _pending.clear();
  }
}

final class const _PendingError({
  required final Object error,
  required final StackTrace stackTrace,
});
