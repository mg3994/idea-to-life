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
      ['search'] => _globalSearchConfig(
        query: uri.queryParameters['q'],
      ),
      // Pattern: /search/label/:label
      ['search', 'label', final label] => _globalSearchLabelConfig(
        Uri.decodeComponent(label),
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
      ['blog', final blogId, 'page', final pageId] => _blogPageConfig(
        blogId,
        pageId,
      ),
      //
      ['labels'] => _labelsConfig(),

      // TODO add more
      ['settings'] => _settingsConfig(),
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
        activeBranch: _homeBranch,
        activeBranchStack: [
          const HomeRoot(),
          GlobalSearchRoute(query ?? ''),
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
          StoresRoot(),
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
          StoresRoot(),
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
        activeBranchStack: [StoresRoot(), BlogDetailRoute(blogId)],
      ),
    );
  }

  KaiselConfig<AppRoute> _blogPostConfig(String blogId, String postId) {
    return KaiselConfig(
      mainStack: const [MainShellRoute()],
      nestedState: KaiselShellConfig(
        activeBranch: _storesBranch,
        activeBranchStack: [
          StoresRoot(), BlogDetailRoute(blogId),
          //blogpostsroot ///TODO:
          BlogPostRoute(blogId, postId),
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
          StoresRoot(),
          BlogDetailRoute(blogId),
          BlogPageRoute(blogId, pageId),
        ],
      ),
    );
  }

  KaiselConfig<AppRoute> _labelsConfig() {
    return KaiselConfig(
      mainStack: const [MainShellRoute()],
      nestedState: KaiselShellConfig(
        activeBranch: _labelsBranch,
        activeBranchStack: const [LabelsRoot()],
      ),
    );
  }

  KaiselConfig<AppRoute> _globalSearchLabelConfig(String label) {
    return KaiselConfig(
      mainStack: const [
        MainShellRoute(),
      ], //label bolle to category
      nestedState: KaiselShellConfig(
        activeBranch: _labelsBranch,
        activeBranchStack: [
          const LabelsRoot(),
          GlobalSearchLabelRoute(label),
        ],
      ),
    );
  }

  KaiselConfig<AppRoute> _settingsConfig() {
    return KaiselConfig(
      mainStack: const [MainShellRoute()],
      nestedState: KaiselShellConfig(
        activeBranch: _settingsBranch,
        activeBranchStack: const [SettingsMasterRoute()],
      ),
    );
  }

  KaiselConfig<AppRoute> _generalSettingsConfig() {
    return KaiselConfig(
      mainStack: const [MainShellRoute()],
      nestedState: KaiselShellConfig(
        activeBranch: _settingsBranch,
        activeBranchStack: const [SettingsMasterRoute(), GeneralSettingRoute()],
      ),
    );
  }

  KaiselConfig<AppRoute> _appearanceConfig() {
    return KaiselConfig(
      mainStack: const [MainShellRoute()],
      nestedState: KaiselShellConfig(
        activeBranch: _settingsBranch,
        activeBranchStack: const [
          SettingsMasterRoute(),
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
        activeBranchStack: const [
          SettingsMasterRoute(),
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
        activeBranchStack: const [SettingsMasterRoute(), PrivacySettingRoute()],
      ),
    );
  }

  KaiselConfig<AppRoute>? _supportConfig() {
    return KaiselConfig(
      mainStack: const [MainShellRoute()],
      nestedState: KaiselShellConfig(
        activeBranch: _settingsBranch,
        activeBranchStack: const [SettingsMasterRoute(), SupportRoute()],
      ),
    );
  }

  @override
  Uri encode(KaiselConfig<AppRoute> config) {
    final uri = switch ((config.mainStack.lastOrNull, config.nestedState)) {
      (OnboardingRoute(), _) => Uri(path: '/onboarding'),
      (BlogDetailRoute(:final blogId), _) => Uri(path: '/blog/$blogId'),
      (BlogPostRoute(:final blogId, :final postId), _) => Uri(
        path: '/blog/$blogId/post/$postId',
      ),
      (MainShellRoute(), final KaiselShellConfig shell) =>
        switch (shell.activeBranch) {
          _homeBranch => _encodeHome(shell.activeBranchStack),
          //TODO: 2 more branches to add
          _settingsBranch => _encodeSettings(shell.activeBranchStack),
          _ => Uri(path: '/'),
        },

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
    if (stack.isEmpty) return Uri(path: '/');

    return switch (stack.last) {
      _ => Uri(path: '/'),
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
      SettingsMasterRoute() => Uri(path: '/settings'),
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
