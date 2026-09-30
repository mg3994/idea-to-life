import 'package:flutter/material.dart';
import 'package:kaisel/kaisel.dart';

import '../../core/core.dart'
    show DeviceScreenExtension, BuildContextLocalizationExtensions;
import '../../navigation/router.dart'
    show
        SettingsRoute,
        SettingsMasterRoute,
        AppearanceSettingRoute,
        MainShellRoute,
        GeneralSettingRoute,
        NotificationsSettingRoute,
        PrivacySettingRoute;
import '../features.dart' show AppearanceSettingsScreen, SettingsMasterScreen;

class const AppNavItem({
  required final String Function(BuildContext) label,
  required final IconData unselectedIcon,
  required final IconData selectedIcon,
});

class const LazyShell({super.key}) extends StatelessWidget {
  // Single source of truth for all navigation destinations
  List<AppNavItem> get _navItems => [
    AppNavItem(
      //TODO: Change these as per context
      label: (context) => 'Home',
      unselectedIcon: Icons.home_outlined,
      selectedIcon: Icons.home,
    ),
    AppNavItem(
      label: (context) => 'Store',
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
    final mq = context.mq;
    final fold = mq.horizontalFold ?? mq.verticalFold;
    final isWide = fold != null || mq.size.width >= 700;
    // Default to AppSettingRoute when nothing specific is selected (i.e. at SettingsMasterRoute)
    if (isWide) {
      // agar screen size baddi ho tab default route
      final effectiveRoutes = switch (route) {
        SettingsRoute() when route is SettingsMasterRoute =>
          const AppearanceSettingRoute(),
        _ => route,
      };
    }
    return KaiselStandalonePage(switch (route) {
      // TODO: Handle this case.
      SettingsRoute() => switch <SettingsRoute>(route) {
        GeneralSettingRoute() => GeneralSettingScreen(),
        AppearanceSettingRoute() => AppearanceSettingsScreen(),
        NotificationsSettingRoute() => NotificationsSettingScreen(),
        PrivacySettingRoute() => PrivacySettingScreen(),
        _ => SettingsMasterScreen(),
      },
      // TODO: Handle this case.
      MainShellRoute() => throw UnimplementedError(),
    });
  }

  @override
  Widget build(BuildContext context) {
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
    return KaiselBranchedShell.specs(
      branches: [
        KaiselBranchSpec<SettingsRoute>.adaptive(
          initial: const SettingsMasterRoute(),
          builder: _buildContentRoute,
        ),
        KaiselBranchSpec<SettingsRoute>.adaptive(
          initial: const SettingsMasterRoute(),
          builder: _buildContentRoute,
        ),
        KaiselBranchSpec<SettingsRoute>.adaptive(
          initial: const SettingsMasterRoute(),
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
                    // Top header icon
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
