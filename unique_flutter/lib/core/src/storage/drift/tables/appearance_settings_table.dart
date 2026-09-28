
import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show Color, Locale, ThemeMode;

import '../../../config/config.dart' show FlavorConfig;
import '../app_database.dart';

part 'appearance_settings_table.g.dart';

/// Type converter for Flutter [Color] stored as a 32-bit ARGB integer.
class ColorConverter extends TypeConverter<Color, int> {
  /// Creates a [ColorConverter].
  const ColorConverter();

  @override
  Color fromSql(int fromDb) => Color(fromDb);

  @override
  int toSql(Color value) => value.toARGB32();
}

/// Type converter for Flutter [Locale] stored as a language tag string.
class LocaleConverter extends TypeConverter<Locale, String> {
  /// Creates a [LocaleConverter].
  const LocaleConverter();

  @override
  Locale fromSql(String fromDb) {
    final parts = fromDb.replaceAll('-', '_').split('_');
    if (parts.length > 1) {
      return Locale(parts[0], parts[1]);
    }
    return Locale(parts[0]);
  }

  @override
  String toSql(Locale value) {
    final country = value.countryCode;
    if (country != null && country.isNotEmpty) {
      return '${value.languageCode}_$country';
    }
    return value.languageCode;
  }
}

/// Database table representing appearance settings in Drift.
/// Database table representing appearance settings in Drift.
@DataClassName('AppearanceSettingsData')
class AppearanceSettings extends Table {
  /// Primary key identifying the settings profile.
  IntColumn get id => integer()();

  /// User's theme mode preference.
  TextColumn get themeMode => textEnum<ThemeMode>()();

  /// Selected application locale.
  TextColumn get locale => text().map(const LocaleConverter())();

  /// Primary seed color used for dynamic Material 3 color scheming.
  IntColumn get seedColor => integer().map(const ColorConverter())();

  /// Timestamp when the settings were last updated.
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Data Access Object for querying and modifying [AppearanceSettings].
@DriftAccessor(tables: [AppearanceSettings])
class AppearanceSettingsDao extends DatabaseAccessor<AppDatabase>
    with _$AppearanceSettingsDaoMixin {
  /// Standard single-parameter constructor required by Drift
  new(super.attachedDatabase);

  /// Access flavorConfig directly from AppDatabase instance via `db`
  FlavorConfig get _flavorConfig => db.flavorConfig;

  /// Generate default insert companion dynamically using active flavor
  AppearanceSettingsCompanion get defaultCompanion =>
      AppearanceSettingsCompanion.insert(
        id: const Value(1),
        themeMode: _flavorConfig.defaultThemeMode,
        locale: _flavorConfig.defaultLocale,
        seedColor: _flavorConfig.defaultThemeSeedColor,
        updatedAt: DateTime.now().toUtc(),
      );

  /// Watches appearance settings for given [id].
  Stream<AppearanceSettingsData?> watchSettings({int id = 1}) {
    return (select(
      appearanceSettings,
    )..where((t) => t.id.equals(id))).watchSingleOrNull();
  }

  /// Fetches appearance settings for given [id].
  Future<AppearanceSettingsData?> getSettings({int id = 1}) {
    return (select(
      appearanceSettings,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /// Inserts or updates appearance settings.
  Future<void> upsertSettings(AppearanceSettingsCompanion companion) {
    return into(appearanceSettings).insertOnConflictUpdate(companion);
  }

  /// Resets settings back to active flavor defaults.
  Future<void> resetSettings({int id = 1}) {
    return into(appearanceSettings)
        .insertOnConflictUpdate(defaultCompanion.copyWith(id: Value(id)));
  }
}
