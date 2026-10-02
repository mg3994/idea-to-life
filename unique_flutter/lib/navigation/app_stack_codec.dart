part of 'router.dart';

final class const AppStackCodec({
  required final bool isOnboardingFirstRoute,
  required final AppearanceSettingsBloc appearanceSettingsBloc,
  required final AppDependencies appDependencies,
}) implements KaiselConfigCodec<AppRoute> {
  static const _homeBranch = 0;
  static const _storesBranch = 1;
  static const _labelsBranch = 2;
  static const _settingsBranch = 3;

  @override
  KaiselConfig<AppRoute>? decode(Uri uri) {
    debugPrint('🔥 DECODE URI = $uri');

    _applyGlobalLanguage(uri);

    final segments = uri.pathSegments
        .where((segment) => segment.isNotEmpty)
        .toList(growable: false);

    return switch (segments) {
      //search/label/:name
      // TODO: fix it
      [] => _rootConfig(),
      ['onboarding'] => _onboardingConfig(),
      // --- Global Search & Labels ---
      // Pattern: /search?q=query
      //search in stores (global)
      ['search'] => _globalSearchConfig(
        query: uri.queryParameters['q'],
      ),

      // .. TODO:
      // Pattern: /blog/:blogId/search?q=query
      ['blog', final blogId, 'search'] => _blogSearchConfig(
        blogId,
        query: uri.queryParameters['q'],
      ),

      // --- Blogger Search & Labels (Blog-Scoped) ---
      // Pattern: /blog/:blogId/search/label/:label
      ['blog', final blogId, 'search', 'label', final label] =>
        _blogSearchLabelConfig(blogId, Uri.decodeComponent(label)),

      ['blog', final blogId] => _blogDetailConfig(blogId),
      ['blog', final blogId, 'post', final postId] => _blogPostConfig(
        blogId,
        postId,
      ),
      ['blog', final blogId, 'p', final pageId] => _blogPageConfig(
        blogId,
        pageId,
      ),
      //
      // Pattern: /search/label/:label
      //search in labels (global)
      ['search', 'labels'] => _labelsConfig(""),
      ['search', 'label', final label] => _labelsConfig(
        Uri.decodeComponent(label),
      ),

      // TODO add more
      ['settings'] => _settingsConfig(
        query: uri.queryParameters['q'],
      ),
      ['settings', 'general'] => _generalSettingsConfig(),
      ['settings', 'appearance'] => _appearanceConfig(),
      ['settings', 'notifications'] => _notificationsConfig(),
      ['settings', 'privacy'] => _privacyConfig(),
      ['settings', 'support'] => _supportConfig(),
      _ => null,
    };
  }

  KaiselConfig<AppRoute> _rootConfig() {
    final hasCompletedOnboarding = isOnboardingFirstRoute;

    debugPrint(
      '🔥 ROOT CONFIG → '
      '${hasCompletedOnboarding ? 'Home' : 'Onboarding'}',
    );

    return hasCompletedOnboarding ? _homeConfig() : _onboardingConfig();
  }

  KaiselConfig<AppRoute> _onboardingConfig() {
    return KaiselConfig(mainStack: const [OnboardingRoute()]);
  }

  KaiselConfig<AppRoute> _homeConfig() {
    return KaiselConfig(
      mainStack: const [MainShellRoute()],
      nestedState: KaiselShellConfig(
        activeBranch: _homeBranch,
        activeBranchStack: const [HomeRoot()],
      ),
    );
  }

  KaiselConfig<AppRoute> _globalSearchConfig({String? query}) {
    return KaiselConfig(
      mainStack: const [
        MainShellRoute(),
      ],
      nestedState: KaiselShellConfig(
        activeBranch: _storesBranch,
        activeBranchStack: [
          StoresRoot(query ?? ''),
        ],
      ),
    );
  }

  KaiselConfig<AppRoute> _blogSearchConfig(String blogId, {String? query}) {
    return KaiselConfig(
      mainStack: const [
        MainShellRoute(),
      ],
      nestedState: KaiselShellConfig(
        activeBranch: _storesBranch,
        activeBranchStack: [
          StoresRoot(blogId), //search with blogId
          BlogDetailRoute(blogId),
          BlogSearchRoute(blogId, query ?? ''),
        ],
      ),
    );
  }

  KaiselConfig<AppRoute> _blogSearchLabelConfig(String blogId, String? label) {
    return KaiselConfig(
      mainStack: const [
        MainShellRoute(),
      ],
      nestedState: KaiselShellConfig(
        activeBranch: _storesBranch,
        activeBranchStack: [
          StoresRoot(blogId), //search with Blog ID
          BlogDetailRoute(blogId),
          BlogSearchLabelRoute(blogId, label ?? ""),
        ],
      ),
    );
  }

  KaiselConfig<AppRoute> _blogDetailConfig(String blogId) {
    return KaiselConfig(
      mainStack: const [MainShellRoute()],
      nestedState: KaiselShellConfig(
        activeBranch: _storesBranch,
        activeBranchStack: [
          StoresRoot(
            blogId, //search with blog ID
          ),
          BlogDetailRoute(blogId),
        ],
      ),
    );
  }

  KaiselConfig<AppRoute> _blogPostConfig(String blogId, String postId) {
    return KaiselConfig(
      mainStack: const [MainShellRoute()],
      nestedState: KaiselShellConfig(
        activeBranch: _storesBranch,
        activeBranchStack: [
          StoresRoot(blogId), // search with blog ID
          BlogDetailRoute(blogId), // detail of blog with blog ID
          //blogpostsroot ///TODO:
          BlogPostRoute(blogId, postId), // post of blog with blog ID
        ],
      ),
    );
  }

  KaiselConfig<AppRoute> _blogPageConfig(String blogId, String pageId) {
    return KaiselConfig(
      mainStack: const [MainShellRoute()],
      nestedState: KaiselShellConfig(
        activeBranch: _storesBranch,
        activeBranchStack: [
          StoresRoot(blogId), // search with blog ID
          BlogDetailRoute(blogId),
          BlogPageRoute(blogId, pageId),
        ],
      ),
    );
  }

  KaiselConfig<AppRoute> _labelsConfig(String? label) {
    return KaiselConfig(
      mainStack: const [
        MainShellRoute(),
      ], //label bolle to category
      nestedState: KaiselShellConfig(
        activeBranch: _labelsBranch,
        activeBranchStack: [
          LabelsRoot(label),
        ],
      ),
    );
  }

  KaiselConfig<AppRoute> _settingsConfig({String? query}) {
    return KaiselConfig(
      mainStack: const [MainShellRoute()],
      nestedState: KaiselShellConfig(
        activeBranch: _settingsBranch,
        activeBranchStack: [SettingsRoot(query)],
      ),
    );
  }

  KaiselConfig<AppRoute> _generalSettingsConfig() {
    return KaiselConfig(
      mainStack: const [MainShellRoute()],
      nestedState: KaiselShellConfig(
        activeBranch: _settingsBranch,
        activeBranchStack: [
          SettingsRoot(""), //TODO: do something for better
          GeneralSettingRoute(),
        ],
      ),
    );
  }

  KaiselConfig<AppRoute> _appearanceConfig() {
    return KaiselConfig(
      mainStack: const [MainShellRoute()],
      nestedState: KaiselShellConfig(
        activeBranch: _settingsBranch,
        activeBranchStack: [
          SettingsRoot(""), //TODO: do something for better
          AppearanceSettingRoute(),
        ],
      ),
    );
  }

  KaiselConfig<AppRoute> _notificationsConfig() {
    return KaiselConfig(
      mainStack: const [MainShellRoute()],
      nestedState: KaiselShellConfig(
        activeBranch: _settingsBranch,
        activeBranchStack: [
          SettingsRoot(""), //TODO: do something for better
          NotificationsSettingRoute(),
        ],
      ),
    );
  }

  KaiselConfig<AppRoute> _privacyConfig() {
    return KaiselConfig(
      mainStack: const [MainShellRoute()],
      nestedState: KaiselShellConfig(
        activeBranch: _settingsBranch,
        activeBranchStack: [
          SettingsRoot(""), //TODO: do something for better
          PrivacySettingRoute(),
        ],
      ),
    );
  }

  KaiselConfig<AppRoute>? _supportConfig() {
    return KaiselConfig(
      mainStack: const [MainShellRoute()],
      nestedState: KaiselShellConfig(
        activeBranch: _settingsBranch,
        activeBranchStack: [
          SettingsRoot(""), //TODO: do something for better
          SupportRoute(),
        ],
      ),
    );
  }

  @override
  Uri encode(KaiselConfig<AppRoute> config) {
    final uri = switch ((config.mainStack.lastOrNull, config.nestedState)) {
      (OnboardingRoute(), _) => Uri(path: '/onboarding'),

      (MainShellRoute(), final KaiselShellConfig shell) =>
        switch (shell.activeBranch) {
          _homeBranch => _encodeHome(shell.activeBranchStack),
          _storesBranch => _encodeStores(shell.activeBranchStack),
          _labelsBranch => _encodeLabels(shell.activeBranchStack),
          _settingsBranch => _encodeSettings(shell.activeBranchStack),
          // home
          _ => Uri(path: '/'),
        },
      // home
      _ => Uri(path: '/'),
    };

    debugPrint(
      '🔥 ENCODE '
      '${config.mainStack.map((route) => route.routeName).toList()} '
      '→ $uri',
    );

    return uri;
  }

  Uri _encodeHome(List<KaiselRoute> stack) {
    // home
    if (stack.isEmpty) return Uri(path: '/');

    return switch (stack.last) {
      // home
      _ => Uri(path: '/'),
    };
  }

  Uri _encodeStores(List<KaiselRoute> stack) {
    if (stack.isEmpty) return Uri(path: '/search');

    return switch (stack.last) {
      StoresRoot(:final query) => Uri(
        path: '/search',
        queryParameters: query != null ? {'q': query.toString()} : null,
      ),
      BlogDetailRoute(:final blogId) => Uri(path: '/blog/$blogId'),
      // stores store detail => posts => [blog post]
      BlogPostRoute(:final blogId, :final postId) => Uri(
        path: '/blog/$blogId/post/$postId',
      ),
      // stores store details => pages => [blog page]
      BlogPageRoute(:final blogId, :final pageId) => Uri(
        path: '/blog/$blogId/p/$pageId',
      ),

      BlogSearchRoute(:final blogId, :final query) => Uri(
        path: '/blog/$blogId/search',
        queryParameters: query != null ? {'q': query.toString()} : null,
      ),

      BlogSearchLabelRoute(:final blogId, :final label) => Uri(
        path: '/blog/$blogId/label',
        queryParameters: label != null ? {'label': label} : null,
      ),

      _ => Uri(path: '/search'),
    };
  }

  Uri _encodeLabels(List<KaiselRoute> stack) {
    if (stack.isEmpty) return Uri(path: '/label');
    return switch (stack.last) {
      LabelsRoot(:final label) => Uri(
        path: '/label',
        pathSegments: label != null ? ['label', label] : null,
      ),
      _ => Uri(path: '/label'),
    };
  }

  /// Match on [stack.last] instead of rigid 2-element list patterns.
  Uri _encodeSettings(List<KaiselRoute> stack) {
    if (stack.isEmpty) return Uri(path: '/settings');

    return switch (stack.last) {
      AppearanceSettingRoute() => Uri(path: '/settings/appearance'),
      GeneralSettingRoute() => Uri(path: '/settings/general'),
      NotificationsSettingRoute() => Uri(path: '/settings/notifications'),
      PrivacySettingRoute() => Uri(path: '/settings/privacy'),
      SupportRoute() => Uri(path: '/settings/support'),
      SettingsRoot(:final query) => Uri(
        path: '/settings',
        queryParameters: query != null ? {'q': query} : null,
      ),
      _ => Uri(path: '/settings'),
    };
  }

  // there should be no use of logic here this is just a configuration file find a better place
  void _applyGlobalLanguage(Uri uri) {
    final globalLanguage = uri.queryParameters['gl'];

    if (globalLanguage == null || globalLanguage.isEmpty) {
      return;
    }

    final languageCode = globalLanguage.split('_').first.toLowerCase();

    final supported = AppLocalizations.supportedLocales.any(
      (locale) => locale.languageCode.toLowerCase() == languageCode,
    );

    if (!supported) {
      return;
    }

    return WidgetsBinding.instance.addPostFrameCallback((_) {
      appearanceSettingsBloc.add(
        SetLocaleEvent(
          Locale.fromSubtags(languageCode: languageCode),
        ),
      );
    });
  }
}
