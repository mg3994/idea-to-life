part of 'bootstrap.dart';  
  
augment final class _BootStrapState {  
  // augment void initState();

  late final AppDependencies _appDependencies;
  late final AppDatabase _db;
  late final AppearanceSettingsBloc _appearanceSettingsBloc;
  late final AppRouter _appRouter;
  late final   Client _client;
  


  Future<void> _initAsync() async {
    _appDependencies = widget._appDependencies ?? const AppDependencies();
   _db = AppDatabase(flavorConfig: _appDependencies.flavorConfig);
   // TODO: Conectivity and Internet Access Stream
   final localDatasource = AppearanceSettingsLocalDatasource(
        db: _db,
        appDependencies: _appDependencies,
      );
      final repository = AppearanceSettingsRepositoryImpl(
        appDependencies: _appDependencies,
        cloudStream: const Stream.empty(),
        localStream: localDatasource.watchSettings,
        isConnectedStream: Stream.value(false),
        updateRemoteSettings: (_) async {},
        updateLocalSettings: localDatasource.updateSettings,
      );
_appearanceSettingsBloc = widget._appearanceSettingsBloc ?? AppearanceSettingsBloc(repository: repository);
    final firebaseInitializer = _appDependencies.firebaseInitializer;
    final crashReporter = _appDependencies.crashReporter;
    final notificationGateway = _appDependencies.notificationGateway;

    try {
      await firebaseInitializer.initialize();
      widget.errors.attach((error, stackTrace) {
      unawaited(crashReporter.recordError(error, stackTrace, fatal: true)); //un
      });
      
        unawaited(notificationGateway.registerBackgroundHandler(
          firebaseMessagingBackgroundHandler,
        )); //un

      // Startup cleanup on active database connection
      await _db.notificationMsgDao.deleteExpiredMessages();
      final locale = PlatformDispatcher.instance.locale;

      Intl.defaultLocale = 
      // TODO: from DB
      Locale(
        locale.languageCode,
        locale.countryCode,
      ).toString();
// Find from DB is onboarding done
_client = Client(_appDependencies.flavorConfig.baseUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();
   unawaited(_client.auth.initialize());
      final appRouter = AppRouter(isOnboardingFirstRoute: ,
       appearanceSettingsBloc: _appearanceSettingsBloc, 
       appDependencies: _appDependencies, 
       db: _db,
       client: _client
      );

      if (!mounted) return;
      setState(() {
        _appRouter = appRouter;
      });

      await notificationGateway.requestPermission();
    } catch (error, stackTrace) {
     unawaited(crashReporter.recordError(error, stackTrace, fatal: true)); //un
    } finally {
      _allowFirstFrame();
    }
  }

  void _allowFirstFrame() {
    if (!widget.binding.sendFramesToEngine) {
      widget.binding.allowFirstFrame();
    }
  }
}