import 'package:flutter/material.dart';
import 'package:kaisel/kaisel.dart';
import 'package:unique_flutter/features/settings/appearance/presentation/screens/appearance_settings_screen.dart';

import '../../core/core.dart'
    show DeviceScreenExtension, BuildContextLocalizationExtensions;
import '../../navigation/router.dart'
    show
        AppSettingRoute,
        AppearanceSettingRoute,
        DraftDetailRoute,
        DraftsMasterRoute,
        DraftsRoute,
        GeneralSettingRoute,
        HomeMasterRoute,
        HomeRoute,
        MainShellRoute,
        NotificationsSettingRoute,
        PrivacySettingRoute,
        ProductDetailRoute,
        SettingsMasterRoute,
        SettingsRoute,
        StoreDetailRoute,
        StoreMasterRoute,
        StoreRoute;
import '../features.dart'
    show
        HomeMasterScreen,
        ProductDetailScreen,
        StoreMasterScreen,
        StoreDetailScreen,
        DraftsMasterScreen,
        DraftDetailScreen,
        SettingsMasterScreen,
        AppSettingScreen;

class AppNavItem {
  const AppNavItem({
    required this.label,
    required this.unselectedIcon,
    required this.selectedIcon,
  });

  final String Function(BuildContext) label;
  final IconData unselectedIcon;
  final IconData selectedIcon;
}

class LazyShell extends StatelessWidget {
  const LazyShell({super.key});

  List<AppNavItem> get _navItems => [
    AppNavItem(
      label: (context) => 'Home',
      unselectedIcon: Icons.home_outlined,
      selectedIcon: Icons.home,
    ),
    AppNavItem(
      label: (context) => 'Stores',
      unselectedIcon: Icons.storefront_outlined,
      selectedIcon: Icons.storefront,
    ),
    AppNavItem(
      label: (context) => 'Drafts',
      unselectedIcon: Icons.edit_note_outlined,
      selectedIcon: Icons.edit_note,
    ),
    AppNavItem(
      label: (context) => 'Settings',
      unselectedIcon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
    ),
  ];

  KaiselPageResult _buildContentRoute<T extends MainShellRoute>(
    BuildContext context,
    T route,
    KaiselStackContext<T> ctx,
  ) {
    final mq = MediaQuery.of(context);
    final fold = mq.horizontalFold ?? mq.verticalFold;
    final isWide = fold != null || mq.size.width >= 700;

    return switch (route) {
      final HomeRoute homeRoute => _buildHomeBranch(
        context,
        homeRoute,
        ctx as KaiselStackContext<HomeRoute>,
        isWide,
      ),
      final StoreRoute storeRoute => _buildStoreBranch(
        context,
        storeRoute,
        ctx as KaiselStackContext<StoreRoute>,
        isWide,
      ),
      final DraftsRoute draftsRoute => _buildDraftsBranch(
        context,
        draftsRoute,
        ctx as KaiselStackContext<DraftsRoute>,
        isWide,
      ),
      final SettingsRoute settingsRoute => _buildSettingsBranch(
        context,
        settingsRoute,
        ctx as KaiselStackContext<SettingsRoute>,
        isWide,
      ),
      _ => throw UnimplementedError('Unhandled route: ${route.runtimeType}'),
    };
  }

  // ===========================================================================
  // 1. Home Branch (Two-Pane & Single-Pane)
  // ===========================================================================
  KaiselPageResult _buildHomeBranch(
    BuildContext context,
    HomeRoute route,
    KaiselStackContext<HomeRoute> ctx,
    bool isWide,
    double? masterFraction,
  ) {
    if (isWide) {
      final effectiveRoute = route; // TODO: Add default wide route if needed

      final twoPaneWidget = KaiselMasterDetailScaffold(
        master: HomeMasterScreen(
          selectedRoute: effectiveRoute,
          onSelectRoute: (tileContext, targetRoute) {
            if (effectiveRoute.runtimeType == targetRoute.runtimeType) return;
            tileContext.pushOrReplaceTop(targetRoute);
          },
        ),
        detail: switch (effectiveRoute) {
          ProductDetailRoute(:final id) => ProductDetailScreen(id: id),
          _ => const Center(child: Text('Select an item')),
        },
        masterFraction: context.mq.masterFraction ?? 0.33,
      );

      return (ctx.previous is HomeMasterRoute)
          ? KaiselAbsorbingPage(widget: twoPaneWidget)
          : KaiselStandalonePage(twoPaneWidget);
    }

    return KaiselStandalonePage(
      switch (route) {
        ProductDetailRoute(:final id) => ProductDetailScreen(id: id),
        _ => HomeMasterScreen(
          selectedRoute: route,
          onSelectRoute: (tileContext, targetRoute) {
            tileContext.pushOrReplaceTop(targetRoute);
          },
        ),
      },
    );
  }

  // ===========================================================================
  // 2. Store Branch (Two-Pane & Single-Pane)
  // ===========================================================================
  KaiselPageResult _buildStoreBranch(
    BuildContext context,
    StoreRoute route,
    KaiselStackContext<StoreRoute> ctx,
    bool isWide,
  ) {
    if (isWide) {
      final effectiveRoute = route; // TODO: Add default wide route if needed

      final twoPaneWidget = KaiselMasterDetailScaffold(
        master: StoreMasterScreen(
          selectedRoute: effectiveRoute,
          onSelectRoute: (tileContext, targetRoute) {
            if (effectiveRoute.runtimeType == targetRoute.runtimeType) return;
            tileContext.pushOrReplaceTop(targetRoute);
          },
        ),
        detail: switch (effectiveRoute) {
          StoreDetailRoute(:final id) => StoreDetailScreen(id: id),
          _ => const Center(child: Text('Select a store item')),
        },
        masterFraction: context.mq.masterFraction ?? 0.33,
      );

      return (ctx.previous is StoreMasterRoute)
          ? KaiselAbsorbingPage(widget: twoPaneWidget)
          : KaiselStandalonePage(twoPaneWidget);
    }

    return KaiselStandalonePage(
      switch (route) {
        StoreDetailRoute(:final id) => StoreDetailScreen(id: id),
        _ => StoreMasterScreen(
          selectedRoute: route,
          onSelectRoute: (tileContext, targetRoute) {
            tileContext.pushOrReplaceTop(targetRoute);
          },
        ),
      },
    );
  }

  // ===========================================================================
  // 3. Drafts Branch (Two-Pane & Single-Pane)
  // ===========================================================================
  KaiselPageResult _buildDraftsBranch(
    BuildContext context,
    DraftsRoute route,
    KaiselStackContext<DraftsRoute> ctx,
    bool isWide,
  ) {
    if (isWide) {
      final effectiveRoute = route; // TODO: Add default wide route if needed

      final twoPaneWidget = KaiselMasterDetailScaffold(
        master: DraftsMasterScreen(
          selectedRoute: effectiveRoute,
          onSelectRoute: (tileContext, targetRoute) {
            if (effectiveRoute.runtimeType == targetRoute.runtimeType) return;
            tileContext.pushOrReplaceTop(targetRoute);
          },
        ),
        detail: switch (effectiveRoute) {
          DraftDetailRoute(:final id) => DraftDetailScreen(id: id),
          _ => const Center(child: Text('Select a draft')),
        },
        masterFraction: context.mq.masterFraction ?? 0.33,
      );

      return (ctx.previous is DraftsMasterRoute)
          ? KaiselAbsorbingPage(widget: twoPaneWidget)
          : KaiselStandalonePage(twoPaneWidget);
    }

    return KaiselStandalonePage(
      switch (route) {
        DraftDetailRoute(:final id) => DraftDetailScreen(id: id),
        _ => DraftsMasterScreen(
          selectedRoute: route,
          onSelectRoute: (tileContext, targetRoute) {
            tileContext.pushOrReplaceTop(targetRoute);
          },
        ),
      },
    );
  }

  // ===========================================================================
  // 4. Settings Branch (Two-Pane & Single-Pane)
  // ===========================================================================
  KaiselPageResult _buildSettingsBranch(
    BuildContext context,
    SettingsRoute route,
    KaiselStackContext<SettingsRoute> ctx,
    bool isWide,
  ) {
    if (isWide) {
      final effectiveRoute = switch (route) {
        SettingsMasterRoute() => const AppearanceSettingRoute(),
        _ => route,
      };

      final twoPaneWidget = KaiselMasterDetailScaffold(
        master: SettingsMasterScreen(
          selectedRoute: effectiveRoute,
          onSelectRoute: (tileContext, targetRoute) {
            if (effectiveRoute.runtimeType == targetRoute.runtimeType) return;
            tileContext.pushOrReplaceTop(targetRoute);
          },
        ),
        detail: switch (effectiveRoute) {
          AppearanceSettingRoute() => const AppearanceSettingsScreen(),
          GeneralSettingRoute() => const Placeholder(),
          NotificationsSettingRoute() => const Placeholder(),
          PrivacySettingRoute() => const Placeholder(),
          _ => const AppearanceSettingsScreen(),
        },
        masterFraction: context.mq.masterFraction ?? 0.33,
      );

      return (ctx.previous is SettingsMasterRoute)
          ? KaiselAbsorbingPage(widget: twoPaneWidget)
          : KaiselStandalonePage(twoPaneWidget);
    }

    return KaiselStandalonePage(
      switch (route) {
        AppearanceSettingRoute() => const AppearanceSettingsScreen(),
        GeneralSettingRoute() => const Placeholder(),
        NotificationsSettingRoute() => const Placeholder(),
        PrivacySettingRoute() => const Placeholder(),
        _ => SettingsMasterScreen(
          selectedRoute: route,
          onSelectRoute: (tileContext, targetRoute) {
            tileContext.pushOrReplaceTop(targetRoute);
          },
        ),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final fold = mq.horizontalFold ?? mq.verticalFold;
    final isWide = fold != null || mq.size.width >= 700;

    return KaiselBranchedShell.specs(
      branches: [
        KaiselBranchSpec<HomeRoute>.adaptive(
          initial: const HomeMasterRoute(),
          builder: _buildContentRoute,
        ),
        KaiselBranchSpec<StoreRoute>.adaptive(
          initial: const StoreMasterRoute(),
          builder: _buildContentRoute,
        ),
        KaiselBranchSpec<DraftsRoute>.adaptive(
          initial: const DraftsMasterRoute(),
          builder: _buildContentRoute,
        ),
        KaiselBranchSpec<SettingsRoute>.adaptive(
          initial: const SettingsMasterRoute(),
          builder: _buildContentRoute,
        ),
      ],
      chromeBuilder: (context, active, content, switchBranch) => isWide
          ? Scaffold(
              body: Row(
                children: [
                  NavigationRail(
                    selectedIndex: active,
                    onDestinationSelected: switchBranch,
                    labelType: NavigationRailLabelType.all,
                    backgroundColor: context.theme.colorScheme.surfaceContainer,
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 24),
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor:
                            context.theme.colorScheme.primaryContainer,
                        child: Icon(
                          Icons.settings,
                          color: context.theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    destinations: _navItems.map((item) {
                      return NavigationRailDestination(
                        icon: Icon(item.unselectedIcon),
                        selectedIcon: Icon(item.selectedIcon),
                        label: Text(item.label(context)),
                      );
                    }).toList(),
                  ),
                  const VerticalDivider(width: 1, thickness: 1),
                  Expanded(child: content),
                ],
              ),
            )
          : Scaffold(
              body: content,
              bottomNavigationBar: NavigationBar(
                selectedIndex: active,
                onDestinationSelected: switchBranch,
                destinations: _navItems.map((item) {
                  return NavigationDestination(
                    icon: Icon(item.unselectedIcon),
                    selectedIcon: Icon(item.selectedIcon),
                    label: item.label(context),
                  );
                }).toList(),
              ),
            ),
    );
  }
}
