import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart' deferred as app_localizations_en;

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// Native display name of the language
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageName;

  /// The name of the application
  ///
  /// In en, this message translates to:
  /// **'BlogStore'**
  String get appName;

  /// Title for the home screen
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// Title for the stores screen
  ///
  /// In en, this message translates to:
  /// **'Stores'**
  String get storesTitle;

  /// Title for the labels screen
  ///
  /// In en, this message translates to:
  /// **'Labels'**
  String get labelsTitle;

  /// Main title for the settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Placeholder hint text for settings search bar
  ///
  /// In en, this message translates to:
  /// **'Search settings...'**
  String get searchSettings;

  /// Message displayed when search yields no setting categories
  ///
  /// In en, this message translates to:
  /// **'No settings found'**
  String get noSettingsFound;

  /// Title for general settings category
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get settingsGeneralTitle;

  /// Subtitle description for general settings category
  ///
  /// In en, this message translates to:
  /// **'Profile, account details and preferences'**
  String get settingsGeneralSubtitle;

  /// Title for appearance settings category
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearanceTitle;

  /// Subtitle description for appearance settings category
  ///
  /// In en, this message translates to:
  /// **'Themes, accent colors, and app language'**
  String get settingsAppearanceSubtitle;

  /// Title for notifications settings category
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotificationsTitle;

  /// Subtitle description for notifications settings category
  ///
  /// In en, this message translates to:
  /// **'Message alerts, push notifications, and summaries'**
  String get settingsNotificationsSubtitle;

  /// Title for privacy and security settings category
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get settingsPrivacyTitle;

  /// Subtitle description for privacy and security settings category
  ///
  /// In en, this message translates to:
  /// **'Data protection, active sessions, and security'**
  String get settingsPrivacySubtitle;

  /// Title for support settings category
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get settingsSupportTitle;

  /// Subtitle description for support settings category
  ///
  /// In en, this message translates to:
  /// **'Help, feedback, and contact information'**
  String get settingsSupportSubtitle;

  /// Title for the theme mode setting section
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeModeTitle;

  /// Subtitle description for the theme mode section
  ///
  /// In en, this message translates to:
  /// **'Choose how BlogStore looks to you'**
  String get themeModeSubtitle;

  /// Label for system default theme mode
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeModeSystem;

  /// Label for light theme mode
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeModeLight;

  /// Label for dark theme mode
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeModeDark;

  /// Title for accent seed color setting section
  ///
  /// In en, this message translates to:
  /// **'Accent Color'**
  String get seedColorTitle;

  /// Subtitle description for accent seed color setting
  ///
  /// In en, this message translates to:
  /// **'Select a dynamic seed color for your theme'**
  String get seedColorSubtitle;

  /// Title for language locale setting section
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get localeTitle;

  /// Subtitle description for language locale setting
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred application language'**
  String get localeSubtitle;

  /// Button label to reset appearance settings to default values
  ///
  /// In en, this message translates to:
  /// **'Reset to Defaults'**
  String get resetToDefault;

  /// Status text shown when appearance settings are in sync
  ///
  /// In en, this message translates to:
  /// **'All changes saved'**
  String get syncStatusSynced;

  /// Status text shown when appearance settings are syncing
  ///
  /// In en, this message translates to:
  /// **'Saving changes...'**
  String get syncStatusPending;

  /// Status text shown when an error occurs during sync
  ///
  /// In en, this message translates to:
  /// **'Sync error'**
  String get syncStatusError;

  /// Action button to retry sync
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get syncRetry;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return lookupAppLocalizations(locale);
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

Future<AppLocalizations> lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return app_localizations_en.loadLibrary().then(
        (dynamic _) => app_localizations_en.AppLocalizationsEn(),
      );
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
