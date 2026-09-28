import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/material.dart' show Color, Locale, ThemeMode;
import 'package:path_provider/path_provider.dart';

import '../../config/config.dart' show currentFBConfig;
import '../../config/flavor_config.dart' show FlavorConfig;
import 'tables/tables.dart';
export 'tables/tables.dart'
    show
        AppearanceSettingsDao,
        AppearanceSettingsDaoManager,
        NotificationMsgDao,
        NotificationMsgDaoManager;

part 'app_database.g.dart';

@DriftDatabase(
  tables: [NotificationMessages, TasksTable, AppearanceSettings],
  daos: [NotificationMsgDao, AppearanceSettingsDao],
)
class AppDatabase({
  final FlavorConfig flavorConfig = currentFBConfig,
  QueryExecutor? executor,
}) extends _$AppDatabase {
  this : super(executor ?? _openConnection());
  // AppDatabase([QueryExecutor? executor]) : super( executor ?? _openConnection());
  @override
  int get schemaVersion => 1;
}

QueryExecutor _openConnection() {
  return driftDatabase(
    name: 'blogstore',
    native: const DriftNativeOptions(
      databaseDirectory: getApplicationSupportDirectory,
    ),
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.js'),
    ),
  );
}
