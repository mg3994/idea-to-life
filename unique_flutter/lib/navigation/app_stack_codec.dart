part of 'router.dart';

final class AppStackCodec implements KaiselConfigCodec<AppRoute> {
  const AppStackCodec({
    required this.isOnboardingFirstRoute,
    required this.appearanceSettingsBloc,
    required this.appDependencies,
  });

  final bool isOnboardingFirstRoute;
  final AppearanceSettingsBloc appearanceSettingsBloc;
  final AppDependencies appDependencies;

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
      [] => _rootConfig(),
      ['onboarding'] => _onboardingConfig(),
      ['search'] => _globalSearchConfig(
        query: uri.queryParameters['q'],
      ),
      ['blog', final blogId, 'search'] => _blogSearchConfig(
        blogId,
        query: uri.queryParameters['q'],
      ),
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
      ['search', 'labels'] => _labelsConfig(""),
      ['search', 'label', final label] => _labelsConfig(
        Uri.decodeComponent(label),
      ),
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
    return const KaiselConfig(mainStack: [OnboardingRoute()]);
  }

  KaiselConfig<AppRoute> _homeConfig() {
    return const KaiselConfig(
      mainStack: [MainShellRoute()],
      nestedState: KaiselShellConfig(
        activeBranch: _homeBranch,
        activeBranchStack: [HomeRoot()],
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
          StoresRoot(blogId),
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
          StoresRoot(blogId),
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
          StoresRoot(blogId),
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
          StoresRoot(blogId),
          BlogDetailRoute(blogId),
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
          StoresRoot(blogId),
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
      ],
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
    return const KaiselConfig(
      mainStack: [MainShellRoute()],
      nestedState: KaiselShellConfig(
        activeBranch: _settingsBranch,
        activeBranchStack: [
          SettingsRoot(""),
          GeneralSettingRoute(),
        ],
      ),
    );
  }

  KaiselConfig<AppRoute> _appearanceConfig() {
    return const KaiselConfig(
      mainStack: [MainShellRoute()],
      nestedState: KaiselShellConfig(
        activeBranch: _settingsBranch,
        activeBranchStack: [
          SettingsRoot(""),
          AppearanceSettingRoute(),
        ],
      ),
    );
  }

  KaiselConfig<AppRoute> _notificationsConfig() {
    return const KaiselConfig(
      mainStack: [MainShellRoute()],
      nestedState: KaiselShellConfig(
        activeBranch: _settingsBranch,
        activeBranchStack: [
          SettingsRoot(""),
          NotificationsSettingRoute(),
        ],
      ),
    );
  }

  KaiselConfig<AppRoute> _privacyConfig() {
    return const KaiselConfig(
      mainStack: [MainShellRoute()],
      nestedState: KaiselShellConfig(
        activeBranch: _settingsBranch,
        activeBranchStack: [
          SettingsRoot(""),
          PrivacySettingRoute(),
        ],
      ),
    );
  }

  KaiselConfig<AppRoute> _supportConfig() {
    return const KaiselConfig(
      mainStack: [MainShellRoute()],
      nestedState: KaiselShellConfig(
        activeBranch: _settingsBranch,
        activeBranchStack: [
          SettingsRoot(""),
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

  Uri _encodeStores(List<KaiselRoute> stack) {
    if (stack.isEmpty) return Uri(path: '/search');

    final last = stack.last;
    if (last is StoresRoot) {
      return Uri(
        path: '/search',
        queryParameters: last.query != null ? {'q': last.query!} : null,
      );
    }
    if (last is BlogDetailRoute) {
      return Uri(path: '/blog/${last.blogId}');
    }
    if (last is BlogPostRoute) {
      return Uri(path: '/blog/${last.blogId}/post/${last.postId}');
    }
    if (last is BlogPageRoute) {
      return Uri(path: '/blog/${last.blogId}/p/${last.pageId}');
    }
    if (last is BlogSearchRoute) {
      return Uri(
        path: '/blog/${last.blogId}/search',
        queryParameters: last.query != null ? {'q': last.query!} : null,
      );
    }
    if (last is BlogSearchLabelRoute) {
      return Uri(
        path: '/blog/${last.blogId}/label',
        queryParameters: last.label != null ? {'label': last.label!} : null,
      );
    }

    return Uri(path: '/search');
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

  Uri _encodeSettings(List<KaiselRoute> stack) {
    if (stack.isEmpty) return Uri(path: '/settings');

    final last = stack.last;
    if (last is AppearanceSettingRoute) {
      return Uri(path: '/settings/appearance');
    }
    if (last is GeneralSettingRoute) {
      return Uri(path: '/settings/general');
    }
    if (last is NotificationsSettingRoute) {
      return Uri(path: '/settings/notifications');
    }
    if (last is PrivacySettingRoute) {
      return Uri(path: '/settings/privacy');
    }
    if (last is SupportRoute) {
      return Uri(path: '/settings/support');
    }
    if (last is SettingsRoot) {
      return Uri(
        path: '/settings',
        queryParameters: last.query != null ? {'q': last.query!} : null,
      );
    }

    return Uri(path: '/settings');
  }

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
