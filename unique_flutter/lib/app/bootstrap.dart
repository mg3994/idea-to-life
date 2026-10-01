import 'dart:async' show unawaited;

import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
// import 'package:flutter/foundation.dart' show PlatformDispatcher;
import 'package:flutter/material.dart' show Material, Icons, CircularProgressIndicator, Colors;
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' show Intl;
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart'
    show FlutterAuthSessionManager, FlutterAuthSessionManagerExtension;

import '../core/core.dart'
    show
        AppDatabase,
        BootstrapErrorReporter,
        firebaseMessagingBackgroundHandler,
        Client,
        FlutterConnectivityMonitor,
        AppPreferencesDao,
        ConnectivityMonitorStreamX,
        AppBlocObserver;
import '../features/settings/appearance/presentation/bloc/appearance_settings_bloc.dart'
    show AppearanceSettingsBloc;
import '../features/settings/settings.dart'
    show AppearanceSettingsLocalDatasource, AppearanceSettingsRepositoryImpl;
import '../navigation/router.dart';

import 'di/app_dependencies.dart' show AppDependencies;
import 'di/app_dependencies_provider.dart' show AppDependenciesProvider;
part 'bootstrap_state_init.dart';

final class const BootStrap({
  required final WidgetsBinding binding,
  required final BootstrapErrorReporter errors,
  final AppDependencies? _appDependencies,
  final AppearanceSettingsBloc? _appearanceSettingsBloc,
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
    if (_appRouter != null) {
      return AppDependenciesProvider(
        appDependencies: _appDependencies,
        child: MultiBlocSignalProvider(
          providers: [
            BlocSignalProvider<AppearanceSettingsBloc>.value(
              value: _appearanceSettingsBloc,
            ),
          ],
          child: _appRouter!.buildApp(context),
        ),
      );
    }
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Material(
        color: const Color(0xFF121212),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              // ADD THIS CHECK:
              if (_initializationError != null) ...[
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "Error:\n$_initializationError",
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ] else ...[
                const CircularProgressIndicator(), // Helpful to see it's trying
                const SizedBox(height: 16),
                const Text(
                  "Initializing unique ...",
                  style: TextStyle(color: Color(0xFFE0E0E0), fontSize: 14),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
