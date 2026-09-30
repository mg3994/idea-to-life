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
        NotificationMsgDaoManager,
        AppPreferencesDao,
        AppPreferencesDaoManager;

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    NotificationMessages,
    TasksTable,
    AppearanceSettings,
    AppPreferences,
  ],
  daos: [NotificationMsgDao, AppearanceSettingsDao, AppPreferencesDao],
)
class AppDatabase({
  final FlavorConfig flavorConfig = currentFBConfig,
  QueryExecutor? executor,
}) extends _$AppDatabase {
  this : super(executor ?? _openConnection(flavorConfig: flavorConfig));
  // AppDatabase([QueryExecutor? executor]) : super( executor ?? _openConnection());
  @override
  int get schemaVersion => 1;
  // @override
  // MigrationStrategy get migration {
  //   return MigrationStrategy(
  //     onCreate: (Migrator m) async {
  //       await m.createAll();
  //     },
  //     // will we needed in future if we realese app in play store?
  //     onUpgrade: (Migrator m, int from, int to) async {
  //   /// Run migration steps without foreign keys and re-enable them later
  // /// (https://drift.simonbinder.eu/docs/advanced-features/migrations/#tips)
  // await customStatement('PRAGMA foreign_keys = OFF');

  //       // Handle migrations incrementally based on the user's current version
  //       if (from < 2) {
  //         // Add the new column introduced in version 2
  //         // await m.addColumn(todos, todos.dueDate);
  //       }

  //       // Future migration example:
  //       // if (from < 3) {
  //       //   await m.createTable(newTable);
  //       // }
  //     },
  //     beforeOpen: (details) async {
  //  /// Enable foreign_keys
  //       await customStatement('PRAGMA foreign_keys = ON');
  //       // Optional: Execute PRAGMAs or initial data seeds after upgrade completes
  //       if (details.hadUpgrade) {
  //         // Runs only if a migration was performed
  //       }
  //     },
  //   );
  // }
}

QueryExecutor _openConnection({FlavorConfig? flavorConfig}) {
  return driftDatabase(
    name: '${flavorConfig?.flavor.name}_unique_store',
    native: DriftNativeOptions(
      databaseDirectory: getApplicationSupportDirectory,
      // Drift's native setup callback for SQLite configuration
      setup: (db) {
        // Automatically shrinks the database file on DELETE/UPDATE
        db.execute('PRAGMA auto_vacuum = FULL;');

        // Optional: Frees up OS memory when SQLite caches grow large
        db.execute('PRAGMA journal_mode = WAL;');
      },
    ),
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.js'),
    ),
  );
}
//What my idea is i want to use extensuin methods for all those opreation on
//tables onUpgrade: and so on to make it small
// extension Migrations on GeneratedDatabase { //better with these
