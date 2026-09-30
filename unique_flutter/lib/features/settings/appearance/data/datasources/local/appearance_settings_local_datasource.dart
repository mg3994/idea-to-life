import '../../../../../../app/di/app_dependencies.dart' show AppDependencies;
import '../../../../../../core/core.dart'
    show
        AppDatabase,
        AppearanceSettingsState,
        AppearanceSettingsDataX,
        AppearanceSettingsStateX,
        AppearanceSettingsStateToCompanion;

/// Local datasource for [AppearanceSettingsData] backed by Drift.
class AppearanceSettingsLocalDatasource {
  /// Creates an [AppearanceSettingsLocalDatasource].
  const new({required this._db, required this._appDependencies});

  final AppDatabase _db;
  final AppDependencies _appDependencies;

  /// Emits a new [AppearanceSettingsState] whenever the stored row changes.
  Stream<AppearanceSettingsState> get watchSettings {
    return _db.appearanceSettingsDao.watchSettings().map(
      (data) =>
          data?.toState() ??
          AppearanceSettingsStateX.initial(_appDependencies.flavorConfig),
    );
  }

  // ── One-shot reads ────────────────────────────────────────────────────────

  /// Fetches the current settings once, returning defaults if no row exists.
  Future<AppearanceSettingsState> getSettings() async {
    final data = await _db.appearanceSettingsDao.getSettings();
    return data?.toState() ??
        AppearanceSettingsStateX.initial(_appDependencies.flavorConfig);
  }

  // ── Writes ────────────────────────────────────────────────────────────────

  /// Upserts the singleton settings row (id = 1).
  Future<void> updateSettings(AppearanceSettingsState settings) {
    return _db.appearanceSettingsDao.upsertSettings(settings.toCompanion());
  }

  /// Resets the singleton row to the database column defaults.
  Future<void> resetSettings() {
    return _db.appearanceSettingsDao.resetSettings();
  }
}
