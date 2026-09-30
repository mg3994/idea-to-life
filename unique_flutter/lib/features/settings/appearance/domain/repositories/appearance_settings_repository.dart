// ignore: depend_on_referenced_packages
import 'package:signals_core/signals_core.dart';

import '../../presentation/bloc/appearance_settings_state.dart'
    show AppearanceSettingsState;

abstract interface class const AppearanceSettingsRepository() {
  ReadonlySignal<AppearanceSettingsState> get computedAppearanceSettings;
  ReadonlySignal<String?> get syncError;
  ReadonlySignal<bool> get isPendingSync;

  void clearError();
  Future<void> updateSettings(AppearanceSettingsState newSettings);
  void dispose();
}
