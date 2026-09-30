import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart' show Color, Locale, ThemeMode;

import '../../domain/repositories/appearance_settings_repository.dart'
    show AppearanceSettingsRepository;
import 'appearance_settings_state.dart'
    show AppearanceSettingsState, AppearanceSettingsStateX;

part 'appearance_settings_event.dart';

class AppearanceSettingsBloc({
  required final AppearanceSettingsRepository repository,
}) extends BlocSignal<AppearanceSettingsEvent, AppearanceSettingsState> {
  this
    : super(
        initialState: (
          themeMode: repository.computedAppearanceSettings.value.themeMode,
          locale: repository.computedAppearanceSettings.value.locale,
          seedColor: repository.computedAppearanceSettings.value.seedColor,
          updatedAt: repository.computedAppearanceSettings.value.updatedAt,
        ),
        equals: (previous, current) =>
            previous.themeMode == current.themeMode &&
            previous.locale == current.locale &&
            previous.seedColor == current.seedColor,
      ) {
    on<SetThemeModeEvent>((event, emit) async {
      final newState = stateValue.copyWith(
        themeMode: event.themeMode,
        updatedAt: DateTime.now().toUtc(),
      );
      emit(newState);
      await repository.updateSettings(newState);
    });

    on<SetLocaleEvent>((event, emit) async {
      final newState = stateValue.copyWith(
        locale: event.locale,
        updatedAt: DateTime.now().toUtc(),
      );
      emit(newState);
      await repository.updateSettings(newState);
    });

    on<SetSeedColorEvent>((event, emit) async {
      final newState = stateValue.copyWith(
        seedColor: event.seedColor,
        updatedAt: DateTime.now().toUtc(),
      );
      emit(newState);
      await repository.updateSettings(newState);
    });

    on<ResetAppearanceSettingsEvent>((event, emit) async {
      final newState = (
        themeMode: ThemeMode.system,
        locale: const Locale('en'),
        seedColor: const Color(0xFFFF9800),
        updatedAt: DateTime.now().toUtc(),
      );
      emit(newState);
      await repository.updateSettings(newState);
    });

    on<GetAppearanceSettingsEvent>((event, emit) {
      emit(repository.computedAppearanceSettings.value);
    });

    createEffect(() {
      final latest = repository.computedAppearanceSettings.value;
      if (stateValue != latest) {
        emit(latest);
      }
    });
  }
}
