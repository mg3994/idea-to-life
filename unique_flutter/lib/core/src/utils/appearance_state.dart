import 'package:flutter/material.dart' show Color, Locale, ThemeMode;

import '../config/config.dart' show FlavorConfig;

typedef AppearanceSettingsState = ({
  ThemeMode themeMode,
  Locale locale,
  Color seedColor,
  DateTime updatedAt,
});

/// Extension to add copyWith utility to the Record
extension AppearanceSettingsStateX on AppearanceSettingsState {
  static AppearanceSettingsState initial(FlavorConfig flavorConfig) => (
    themeMode: ThemeMode.system,
    locale: flavorConfig.defaultLocale,
    seedColor: flavorConfig.defaultThemeSeedColor,
    updatedAt: DateTime.now().toUtc(),
  );
  AppearanceSettingsState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    Color? seedColor,
    DateTime? updatedAt,
  }) {
    return (
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      seedColor: seedColor ?? this.seedColor,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
