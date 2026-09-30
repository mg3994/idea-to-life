part of 'appearance_settings_bloc.dart';

sealed class const AppearanceSettingsEvent();

final class const GetAppearanceSettingsEvent() extends AppearanceSettingsEvent;

final class const SetThemeModeEvent(final ThemeMode themeMode)
    extends AppearanceSettingsEvent;

final class const SetLocaleEvent(final Locale locale)
    extends AppearanceSettingsEvent;

final class const SetSeedColorEvent(final Color seedColor)
    extends AppearanceSettingsEvent;

final class const ResetAppearanceSettingsEvent()
    extends AppearanceSettingsEvent;
