// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appearance_settings_table.dart';

// ignore_for_file: type=lint
mixin _$AppearanceSettingsDaoMixin on DatabaseAccessor<AppDatabase> {
  $AppearanceSettingsTable get appearanceSettings =>
      attachedDatabase.appearanceSettings;
  AppearanceSettingsDaoManager get managers =>
      AppearanceSettingsDaoManager(this);
}

class AppearanceSettingsDaoManager {
  final _$AppearanceSettingsDaoMixin _db;
  AppearanceSettingsDaoManager(this._db);
  $$AppearanceSettingsTableTableManager get appearanceSettings =>
      $$AppearanceSettingsTableTableManager(
        _db.attachedDatabase,
        _db.appearanceSettings,
      );
}
