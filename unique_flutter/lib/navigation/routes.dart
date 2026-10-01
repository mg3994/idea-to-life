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

final class const LocationModalRoute<T>()
    extends AppRoute
    implements KaiselModalRoute<T?>;

final class const OnboardingRoute() extends AppRoute;

final class const PrivacyPolicyRoute() extends AppRoute;

final class const TermsAndConditionsRoute() extends AppRoute;

final class const AboutRoute() extends AppRoute;

final class const SocialsRoute() extends AppRoute;

final class const SupportRoute() extends AppRoute;

/// ===========================================================================
/// Main shell
///
/// ├── HomeRoute
/// │   └── HomeRoot
/// │       └──
/// │   ...
/// └── SettingsRoute
///     └── SettingsMasterRoute
///         └── AppearanceSettingRoute
/// ===========================================================================
/// soe extra pages like PrivacyPoicy, TermsAndConditions and About, Socials , Contact and so on

// sealed

final class const MainShellRoute() extends AppRoute; // this is our ShellHost

/// ===========================================================================
/// Home branch
/// ===========================================================================

sealed class const HomeRoute() extends MainShellRoute;

/// Root of the Home navigation stack.
final class const HomeRoot() extends HomeRoute;

/// Detail pushed from [HomeRoot].

/// Global search route pushed from Home.
final class const GlobalSearchRoute(final String query) extends HomeRoute {
  @override
  List<Object?> get props => [query];
  @override
  String get restorationId => 'search-$query';
}

// ===========================================================================
// Stores / Blog Branch Routes
// ===========================================================================

sealed class const StoresRoute() extends MainShellRoute;

/// Root of the Stores navigation stack.
final class const StoresRoot() extends StoresRoute;

final class const BlogDetailRoute(final String blogId) extends StoresRoute {
  @override
  List<Object?> get props => [blogId];
  @override
  String get restorationId => 'blog-$blogId';
}

final class const BlogPostRoute(final String blogId, final String postId)
    extends StoresRoute {
  @override
  List<Object?> get props => [blogId, postId];
  @override
  String get restorationId => 'blog-$blogId-post-$postId';
}

final class const BlogPageRoute(final String blogId, final String pageId)
    extends StoresRoute {
  @override
  List<Object?> get props => [blogId, pageId];
  @override
  String get restorationId => 'blog-$blogId-page-$pageId';
}

final class const BlogSearchRoute(final String blogId, final String query)
    extends StoresRoute {
  @override
  List<Object?> get props => [blogId, query];
  @override
  String get restorationId => 'blog-$blogId-search-$query';
}

final class const BlogSearchLabelRoute(final String blogId, final String label)
    extends StoresRoute {
  @override
  List<Object?> get props => [blogId, label];
  @override
  String get restorationId => 'blog-$blogId-label-$label';
}
// ===========================================================================
// Labels / Category Branch Routes
// ===========================================================================

sealed class const LabelsRoute() extends MainShellRoute;

/// Root of the Labels navigation stack.
final class const LabelsRoot() extends LabelsRoute;

final class const GlobalSearchLabelRoute(final String label)
    extends LabelsRoute {
  @override
  List<Object?> get props => [label];
  @override
  String get restorationId => 'label-$label';
}

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
