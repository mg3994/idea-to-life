import 'package:bloc_signals_flutter/bloc_signals_flutter.dart'
    show BlocSignalBuilder;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'
    show BuildContext, Widget, MaterialApp, MediaQuery;
import 'package:flutter/widgets.dart' show Locale;

import 'package:kaisel/kaisel.dart';

import '../app/di/app_dependencies.dart' show AppDependencies;
import '../app/theme/app_theme.dart' show AppTheme;
import '../core/core.dart'
    show
        AppDatabase,
        AppearanceSettingsState,
        BuildContextLocalizationExtensions,
        BuildMode,
        DeviceScreenExtension,
        Client;
import '../features/features.dart';
import '../features/settings/appearance/presentation/bloc/appearance_settings_bloc.dart'
    show AppearanceSettingsBloc, SetLocaleEvent;
import '../l10n/l10n.dart' show AppLocalizations;

part 'routes.dart';
part 'app_stack_codec.dart';

final class const AppRouter({
  final KaiselRouterConfig<AppRoute>? _routerConfig,
  required final bool isOnboardingFirstRoute,
  required final AppearanceSettingsBloc appearanceSettingsBloc,
  required final AppDependencies appDependencies,
  required final AppDatabase db,
  required final Client client,
}) {
  KaiselRouterConfig<AppRoute> get routerConfig =>
      _routerConfig ?? _createRouterConfig();

  KaiselRouterConfig<AppRoute> _createRouterConfig() {
    final initialRoute = isOnboardingFirstRoute
        ? const MainShellRoute()
        : const OnboardingRoute();

    return KaiselRouterConfig<AppRoute>.adaptive(
      initial: initialRoute, // ✅ Dynamically resolves to OnboardingRoute
      codec: AppStackCodec(
        isOnboardingFirstRoute: isOnboardingFirstRoute,
        appearanceSettingsBloc: appearanceSettingsBloc,
        appDependencies: appDependencies,
      ),
      // guards: [consentGuard],
      observers: () => [appDependencies.analyticsGateway.observer()],
      onScreenChanged: (route) {
        debugPrint('🔥 ROUTE = ${route.routeName}');
        appDependencies.analyticsGateway.logScreenView(
          screenName: route.routeName,
        );
      },
      // pageWrapper: _pageWrapper,
      // modalBuilder: _modalBuilder,
      builder: _buildRoute,
    );
  }

  static KaiselPageResult _buildRoute(
    BuildContext context,
    AppRoute route,
    KaiselStackContext<AppRoute> stack,
  ) {
    final mediaQuery = context.mq;
    // SCENARIO 1: "Flex Mode" (Top/Bottom Split)
    // e.g., Galaxy Z Flip resting halfway open on a table.
    // final flipHalfOpened =
    //     mediaQuery.isHalfOpened && mediaQuery.horizontalFold != null;
    // SCENARIO 2: "Book Mode" (Left/Right Split, Partially Folded)
    // e.g., Galaxy Z Fold held like a slightly bent book.
    // final verticalFoldOpened =
    //     mediaQuery.isHalfOpened && mediaQuery.verticalFold != null;
    // SCENARIO 3: Flat Foldable / Dual Screen (Fully Open)
    // e.g., Galaxy Z Fold or Surface Duo opened completely flat (Tablet Mode).
    // final flatFoldableOpened =
    //     mediaQuery.isFoldableFlat && mediaQuery.verticalFold != null;
    final fold = mediaQuery.horizontalFold ?? mediaQuery.verticalFold;
    final isWide = fold != null || mediaQuery.size.width >= 700;

    // if (flipHalfOpened) {
    //   return KaiselPageResult(
    //     // Example: Put the main route content on top, and auxiliary controls on bottom
    //     child: FlexModeLayout(
    //       topHalf: _getRouteWidget(route),
    //       bottomHalf: _getAuxiliaryWidget(route),
    //       foldBounds: mediaQuery.horizontalFold!.bounds,
    //     ),
    //   );
    // }

    // // SCENARIO 2: "Book Mode" (Left/Right Split, Partially Folded)
    // // e.g., Galaxy Z Fold held like a slightly bent book.
    // if (mediaQuery.isHalfOpened && mediaQuery.verticalFold != null) {
    //   return KaiselPageResult(
    //     // Example: Render two pages side-by-side, avoiding the hinge
    //     child: BookModeLayout(
    //       leftSide: _getRouteWidget(route),
    //       rightSide: _getSecondaryRouteWidget(stack),
    //       foldBounds: mediaQuery.verticalFold!.bounds,
    //     ),
    //   );
    // }

    // // SCENARIO 3: Flat Foldable / Dual Screen (Fully Open)
    // // e.g., Galaxy Z Fold or Surface Duo opened completely flat (Tablet Mode).
    // if (mediaQuery.isFoldableFlat && mediaQuery.verticalFold != null) {
    //   return KaiselPageResult(
    //     // Ideal for Master-Detail navigation (e.g., List on Left, Detail on Right)
    //     child: MasterDetailLayout(
    //       masterRoute: _getRouteWidget(route),
    //       detailRoute: stack.hasPrevious
    //           ? _getRouteWidget(stack.previous!)
    //           : null,
    //     ),
    //   );
    // }

    // // SCENARIO 4: Standard Screen (Slab Phone or single screen active)
    // // Fallback for 95% of devices.
    // return KaiselPageResult(
    //   // We let SafeArea handle the cutouts and corner radii internally on the standard page.
    //   child: StandardRouteWrapper(
    //     hasCutouts: mediaQuery.hasCutouts,
    //     child: _getRouteWidget(route),
    //   ),
    // );
    return switch (route) {
      OnboardingRoute() => KaiselPageResult(),
      MainShellRoute() => KaiselStandalonePage(LazyShell()),
      // TODO: Handle this case.
      ConsentModalRoute() => throw UnimplementedError(),
      // TODO: Handle this case.
      AuthenticationModalRoute() => throw UnimplementedError(),
    };
  }

  /// Builds the top-level application widget with navigation.
  Widget buildApp(BuildContext context) {
    //client.auth.authInfoListenable
    // buider is required unless i have used `context.value`
    return BlocSignalBuilder<AppearanceSettingsBloc, AppearanceSettingsState>(
      bloc: appearanceSettingsBloc,
      builder: (context, state) {
        // do your all repo case stffs here
        return MaterialApp.router(
          routerConfig: routerConfig,
          onGenerateTitle: (context) => context.l10n.appName,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates, // avoid using this as it is not yet fixed for gen-l10nfor intl utils so prefer old approch

          debugShowCheckedModeBanner: switch ((
            context.appDependencies.flavorConfig.buildMode,
            context.appDependencies.flavorConfig.flavor,
          )) {
            // kept fot future
            (BuildMode.debug, _) => true,
            (BuildMode.profile, _) => true,

            _ => false, // Handles release and satisfies the interface check
          },
          themeMode: state.themeMode,
          locale: state.locale,
          theme: AppTheme.light(seed: state.seedColor),
          darkTheme: AppTheme.dark(seed: state.seedColor),
          scrollBehavior: AppTheme.scrollBehavior,
        );
      },
    );
  }
}
