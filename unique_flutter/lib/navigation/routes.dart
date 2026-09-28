part of 'router.dart';

/// ===========================================================================
/// Application routes
/// ===========================================================================
/// Marker for routes that require authentication.
sealed class const RequiresAuth();

/// Marker for routes that require authentication.

sealed class const AppRoute() extends KaiselRoute;

final class const ConsentModalRoute()
    extends AppRoute
    implements KaiselModalRoute<bool?>;

final class const AuthenticationModalRoute()
    extends AppRoute
    implements KaiselModalRoute<bool?>;

final class const OnboardingRoute() extends AppRoute;

/// ===========================================================================
/// Main shell
///
/// ├── HomeRoute
/// │   └── HomeRoot
/// │       └── ProductDetailRoute
/// │   ...
/// └── SettingsRoute
///     └── SettingsMasterRoute
///         └── AppSettingRoute
/// ===========================================================================

// sealed

final class const MainShellRoute() extends AppRoute; // this is our ShellHost

/// ===========================================================================
/// Home branch
/// ===========================================================================

sealed class const HomeRoute() extends MainShellRoute;

/// Root of the Home navigation stack.
final class const HomeRoot() extends HomeRoute;

/// Detail pushed from [HomeRoot].
final class const ProductDetailRoute(final String id) extends HomeRoute {
  @override
  List<Object?> get props => [id];
  @override
  String get restorationId => 'product-$id';
}

/// ===========================================================================
/// Settings branch
/// ===========================================================================

sealed class const SettingsRoute() extends MainShellRoute;

/// Root/master of the Settings navigation stack.
final class const SettingsMasterRoute() extends SettingsRoute;

final class const GeneralSettingRoute() extends SettingsRoute;

/// Detail pushed from [SettingsMasterRoute].
final class const AppSettingRoute() extends SettingsRoute;

final class const NotificationsSettingRoute() extends SettingsRoute;

final class const PrivacySettingRoute() extends SettingsRoute;
