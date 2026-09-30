import 'dart:async' show unawaited;

import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/foundation.dart' show PlatformDispatcher;
import 'package:flutter/material.dart' show Material;
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' show Intl;
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart' show FlutterAuthSessionManager, FlutterAuthSessionManagerExtension;

import '../core/core.dart'
    show
        AppDatabase,
        BootstrapErrorReporter,
        firebaseMessagingBackgroundHandler,
        BuildContextLocalizationExtensions, FlavorConfig, Client, FlutterConnectivityMonitor, FlutterAuthSessionManager;
import '../features/settings/appearance/presentation/bloc/appearance_settings_bloc.dart'
    show AppearanceSettingsBloc;
import '../features/settings/settings.dart' show AppearanceSettingsLocalDatasource, AppearanceSettingsRepositoryImpl;
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
    final router = _appRouter;
    if (router != null) {
      return AppDependenciesProvider(
        appDependencies: _appDependencies,
        child: MultiBlocSignalProvider(
          providers: [
            BlocSignalProvider<AppearanceSettingsBloc>.value(
              value: _appearanceSettingsBloc,
            ),
          ],
          child: router.buildApp(context),
        ),
      );
    }
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Material(
        color: Color(0xFF121212),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16),
              Text(
                // _loadingMessage, // if date time says it is night then dark logo else light
                "Initializing unique ...",
                // context.l10n.app_initializing,
                style: TextStyle(color: Color(0xFFE0E0E0), fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
