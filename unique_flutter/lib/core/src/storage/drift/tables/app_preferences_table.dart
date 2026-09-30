import 'package:drift/drift.dart';

import '../app_database.dart';
part 'app_preferences_table.g.dart';

@DataClassName('AppPreference')
class AppPreferences extends Table {
  // Single-row table constraint (ID is always 1)
  IntColumn get id => integer().withDefault(const Constant(1))();

  // Onboarding & App State
  BoolColumn get isOnboardingDone =>
      boolean().withDefault(const Constant(false))();

  // Privacy & Consent Flags
  BoolColumn get hasGivenConsent =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get analyticsStorageConsentGranted =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get adStorageConsentGranted =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get adUserDataConsentGranted =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get adPersonalizationSignalsConsentGranted =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get functionalityStorageConsentGranted =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get personalizationStorageConsentGranted =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get securityStorageConsentGranted =>
      boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftAccessor(tables: [AppPreferences])
class AppPreferencesDao extends DatabaseAccessor<AppDatabase>
    with _$AppPreferencesDaoMixin {
  AppPreferencesDao(super.db);

  /// Fetch single app settings row, creating default row if empty
  Future<AppPreference> getPreferences() async {
    final prefs = await select(appPreferences).getSingleOrNull();
    if (prefs != null) return prefs;

    await into(appPreferences).insert(
      const AppPreferencesCompanion(),
      mode: InsertMode.insertOrIgnore,
    );
    return select(appPreferences).getSingle();
  }

  /// Reactive stream for real-time app preference changes
  Stream<AppPreference> watchPreferences() {
    return select(appPreferences).watchSingle();
  }

  Future<void> updatePreferences(AppPreferencesCompanion entry) async {
    await update(appPreferences).replace(entry);
  }
}
