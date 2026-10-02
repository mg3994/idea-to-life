part of 'router.dart';

/// ===========================================================================
/// Application route contracts & interfaces
/// ===========================================================================

/// Interface for routes requiring authentication.
abstract interface class RequiresAuth {}

/// Interface for routes supporting query parameters / search queries.
abstract interface class QueryRoute {
  String? get query;
}

/// Interface for routes associated with a specific blog / store ID.
abstract interface class BlogScopedRoute {
  String get blogId;
}

/// Base class for all application routes.
sealed class AppRoute extends KaiselRoute {
  const AppRoute();
}

final class ConsentModalRoute extends AppRoute
    implements KaiselModalRoute<bool?> {
  const ConsentModalRoute();
}

final class AuthenticationModalRoute extends AppRoute
    implements KaiselModalRoute<bool?> {
  const AuthenticationModalRoute();
}

final class LocationModalRoute<T> extends AppRoute
    implements KaiselModalRoute<T?> {
  const LocationModalRoute();
}

final class PrivacyPolicyRoute extends AppRoute implements KaiselModalRoute {
  const PrivacyPolicyRoute();
}

final class TermsAndConditionsRoute extends AppRoute implements KaiselModalRoute {
  const TermsAndConditionsRoute();
}

final class AboutRoute extends AppRoute implements KaiselModalRoute {
  const AboutRoute();
}

final class SocialsRoute extends AppRoute implements KaiselModalRoute {
  const SocialsRoute();
}

final class OnboardingRoute extends AppRoute {
  const OnboardingRoute();
}

/// ===========================================================================
/// Main shell route host
/// ===========================================================================

final class MainShellRoute extends AppRoute {
  const MainShellRoute();
}

/// ===========================================================================
/// Home branch
/// ===========================================================================

sealed class HomeRoute extends MainShellRoute {
  const HomeRoute();
}

/// Root of the Home navigation stack.
final class HomeRoot extends HomeRoute {
  const HomeRoot();
}

/// ===========================================================================
/// Stores / Blog Branch Routes
/// ===========================================================================

sealed class StoresRoute extends MainShellRoute {
  const StoresRoute();
}

/// Global search route pushed from Stores.
final class StoresRoot extends StoresRoute implements QueryRoute {
  const StoresRoot([this.query]);

  @override
  final String? query;

  @override
  List<Object?> get props => [query];

  @override
  String get restorationId => query != null ? 'search-$query' : 'search';
}

final class BlogDetailRoute extends StoresRoute implements BlogScopedRoute {
  const BlogDetailRoute(this.blogId);

  @override
  final String blogId;

  @override
  List<Object?> get props => [blogId];

  @override
  String get restorationId => 'blog-$blogId';
}

final class BlogPostRoute extends StoresRoute implements BlogScopedRoute {
  const BlogPostRoute(this.blogId, this.postId);

  @override
  final String blogId;
  final String postId;

  @override
  List<Object?> get props => [blogId, postId];

  @override
  String get restorationId => 'blog-$blogId-post-$postId';
}

final class BlogPageRoute extends StoresRoute implements BlogScopedRoute {
  const BlogPageRoute(this.blogId, this.pageId);

  @override
  final String blogId;
  final String pageId;

  @override
  List<Object?> get props => [blogId, pageId];

  @override
  String get restorationId => 'blog-$blogId-p-$pageId';
}

final class BlogSearchRoute extends StoresRoute
    implements BlogScopedRoute, QueryRoute {
  const BlogSearchRoute(this.blogId, [this.query]);

  @override
  final String blogId;

  @override
  final String? query;

  @override
  List<Object?> get props => [blogId, query];

  @override
  String get restorationId =>
      query != null ? 'blog-$blogId-search-$query' : 'blog-$blogId-search';
}

final class BlogSearchLabelRoute extends StoresRoute implements BlogScopedRoute {
  const BlogSearchLabelRoute(this.blogId, [this.label]);

  @override
  final String blogId;
  final String? label;

  @override
  List<Object?> get props => [blogId, label];

  @override
  String get restorationId =>
      label != null ? 'blog-$blogId-label-$label' : 'blog-$blogId-label';
}

/// ===========================================================================
/// Labels / Category Branch Routes
/// ===========================================================================

sealed class LabelsRoute extends MainShellRoute {
  const LabelsRoute();
}

final class LabelsRoot extends LabelsRoute {
  const LabelsRoot([this.label]);

  final String? label;

  @override
  List<Object?> get props => [label];

  @override
  String get restorationId => label != null ? 'label-$label' : 'all-labels';
}

/// ===========================================================================
/// Settings branch
/// ===========================================================================

sealed class SettingsRoute extends MainShellRoute {
  const SettingsRoute();
}

/// Root/master of the Settings navigation stack.
final class SettingsRoot extends SettingsRoute implements QueryRoute {
  const SettingsRoot([this.query]);

  @override
  final String? query;

  @override
  List<Object?> get props => [query];

  @override
  String get restorationId => query != null ? 'settings-$query' : 'settings';
}

final class GeneralSettingRoute extends SettingsRoute {
  const GeneralSettingRoute();
}

final class AppearanceSettingRoute extends SettingsRoute {
  const AppearanceSettingRoute();
}

final class NotificationsSettingRoute extends SettingsRoute {
  const NotificationsSettingRoute();
}

final class PrivacySettingRoute extends SettingsRoute {
  const PrivacySettingRoute();
}

final class SupportRoute extends SettingsRoute {
  const SupportRoute();
}
