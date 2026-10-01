// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get languageName => 'English';

  @override
  String get appName => 'BlogStore';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get searchSettings => 'Search settings...';

  @override
  String get noSettingsFound => 'No settings found';

  @override
  String get settingsGeneralTitle => 'General';

  @override
  String get settingsGeneralSubtitle =>
      'Profile, account details and preferences';

  @override
  String get settingsAppearanceTitle => 'Appearance';

  @override
  String get settingsAppearanceSubtitle =>
      'Themes, accent colors, and app language';

  @override
  String get settingsNotificationsTitle => 'Notifications';

  @override
  String get settingsNotificationsSubtitle =>
      'Message alerts, push notifications, and summaries';

  @override
  String get settingsPrivacyTitle => 'Privacy & Security';

  @override
  String get settingsPrivacySubtitle =>
      'Data protection, active sessions, and security';

  @override
  String get themeModeTitle => 'Theme Mode';

  @override
  String get themeModeSubtitle => 'Choose how BlogStore looks to you';

  @override
  String get themeModeSystem => 'System';

  @override
  String get themeModeLight => 'Light';

  @override
  String get themeModeDark => 'Dark';

  @override
  String get seedColorTitle => 'Accent Color';

  @override
  String get seedColorSubtitle => 'Select a dynamic seed color for your theme';

  @override
  String get localeTitle => 'Language';

  @override
  String get localeSubtitle => 'Choose your preferred application language';

  @override
  String get resetToDefault => 'Reset to Defaults';

  @override
  String get syncStatusSynced => 'All changes saved';

  @override
  String get syncStatusPending => 'Saving changes...';

  @override
  String get syncStatusError => 'Sync error';

  @override
  String get syncRetry => 'Retry';
}
