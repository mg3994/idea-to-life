import 'dart:async' show unawaited;

import 'package:flutter/foundation.dart' show PlatformDispatcher;
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' show Intl;

import '../core/core.dart'
    show
        AppDatabase,
        BootstrapErrorReporter,
        firebaseMessagingBackgroundHandler;
import 'di/app_dependencies.dart' show AppDependencies;
part 'bootstrap_state_init.dart';

final class const BootStrap({
  required final WidgetsBinding binding,
  required final BootstrapErrorReporter errors,
  final AppDependencies? _appDependencies,
  super.key,
}) extends StatefulWidget {
  @override
  State<BootStrap> createState() => _BootStrapState();
}

final class _BootStrapState extends State<BootStrap> {
  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  @override
  void dispose() {
    //at last close the error reporter
    widget.errors.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = _appRouter;

    return const Placeholder();
  }
}

//
