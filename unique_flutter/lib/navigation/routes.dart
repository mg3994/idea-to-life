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

final class const BlogRoute(final String blogId) extends AppRoute {
  @override
  List<Object?> get props => [blogId];
  @override
  String get restorationId => 'blog-$blogId';
}

final class const PostRoute(final String blogId, final String postId)
    extends AppRoute {
  @override
  List<Object?> get props => [blogId, postId];
  @override
  String get restorationId => 'post-$blogId-$postId';
}
// sealed

final class const MainShellRoute() extends AppRoute; // this is our ShellHost

/// ===========================================================================
/// Home branch
/// ===========================================================================

sealed class const HomeRoute() extends MainShellRoute;

/// Root of the Home navigation stack.
final class const HomeRoot() extends HomeRoute;

/// Detail pushed from [HomeRoot].

// .....more here

/// ===========================================================================
/// Settings branch
/// ===========================================================================

sealed class const SettingsRoute() extends MainShellRoute;

/// Root/master of the Settings navigation stack.
final class const SettingsMasterRoute() extends SettingsRoute;

final class const GeneralSettingRoute() extends SettingsRoute;

/// Detail pushed from [SettingsMasterRoute].
final class const AppearanceSettingRoute() extends SettingsRoute;

final class const NotificationsSettingRoute() extends SettingsRoute;

final class const PrivacySettingRoute() extends SettingsRoute;

//
sealed class const StoresRoute() extends MainShellRoute;
// what if products are also there in this as well the same that is home route

// product categories route
