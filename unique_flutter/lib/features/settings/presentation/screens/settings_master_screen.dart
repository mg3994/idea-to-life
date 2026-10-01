import 'package:flutter/material.dart';

import '../../../../core/core.dart' show BuildContextLocalizationExtensions;
import '../../../../navigation/router.dart'
    show
        AppearanceSettingRoute,
        GeneralSettingRoute,
        NotificationsSettingRoute,
        PrivacySettingRoute,
        SettingsRoute,
        SupportRoute;

class const SettingsCategoryItemData({
  required final SettingsRoute route,
  required final String Function(BuildContext context) titleBuilder,
  required final String Function(BuildContext context) subtitleBuilder,
  required final IconData icon,
});

final List<SettingsCategoryItemData> kSettingsCategoryItems = [
  SettingsCategoryItemData(
    route: const GeneralSettingRoute(),
    titleBuilder: (context) => context.l10n.settingsGeneralTitle,
    subtitleBuilder: (context) => context.l10n.settingsGeneralSubtitle,
    icon: Icons.person_outline,
  ),
  SettingsCategoryItemData(
    route: const AppearanceSettingRoute(),
    titleBuilder: (context) => context.l10n.settingsAppearanceTitle,
    subtitleBuilder: (context) => context.l10n.settingsAppearanceSubtitle,
    icon: Icons.palette_outlined,
  ),
  SettingsCategoryItemData(
    route: const NotificationsSettingRoute(),
    titleBuilder: (context) => context.l10n.settingsNotificationsTitle,
    subtitleBuilder: (context) => context.l10n.settingsNotificationsSubtitle,
    icon: Icons.notifications_none,
  ),
  SettingsCategoryItemData(
    route: const PrivacySettingRoute(),
    titleBuilder: (context) => context.l10n.settingsPrivacyTitle,
    subtitleBuilder: (context) => context.l10n.settingsPrivacySubtitle,
    icon: Icons.lock_outline,
  ),
  // SettingsCategoryItemData(
  //   route: const SupportRoute(),
  //   titleBuilder: (context) => context.l10n.settingsSupportTitle,
  //   subtitleBuilder: (context) => context.l10n.settingsSupportSubtitle,
  //   icon: Icons.support,
  // ),
];

class const SettingsMasterScreen({
  super.key,
  final SettingsRoute? selectedRoute,
  final void Function(BuildContext context, SettingsRoute route)? onSelectRoute,
}) extends StatefulWidget {
  @override
  State<SettingsMasterScreen> createState() => _SettingsMasterScreenState();
}

class _SettingsMasterScreenState extends State<SettingsMasterScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.trim().toLowerCase();
    });
  }

  void _clearSearch() {
    _searchController.clear();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  List<SettingsCategoryItemData> _getFilteredItems(BuildContext context) {
    if (_searchQuery.isEmpty) return kSettingsCategoryItems;
    return kSettingsCategoryItems.where((item) {
      final title = item.titleBuilder(context).toLowerCase();
      final subtitle = item.subtitleBuilder(context).toLowerCase();
      return title.contains(_searchQuery) || subtitle.contains(_searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    // final m10n = context.m10n;
    // final c10n = context.c10n;
    final theme = context.theme;
    // final mq = context.mq;
    // final sm = context.sm;
    final filtered = _getFilteredItems(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                l10n.settingsTitle,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: l10n.searchSettings,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: _clearSearch,
                        )
                      : null,
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainerHigh,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Text(
                        l10n.noSettingsFound,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: filtered.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final item = filtered[index];
                        final isSelected =
                            widget.selectedRoute?.runtimeType ==
                            item.route.runtimeType;

                        return _SettingsCategoryTile(
                          icon: item.icon,
                          title: item.titleBuilder(context),
                          subtitle: item.subtitleBuilder(context),
                          isSelected: isSelected,
                          onTap: (tileContext) {
                            // ✅ Fix: Guard against duplicate clicks
                            if (isSelected) return;
                            widget.onSelectRoute?.call(tileContext, item.route);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class const _SettingsCategoryTile({
  required final IconData icon,
  required final String title,
  required final String subtitle,
  required final bool isSelected,
  required final void Function(BuildContext context) onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;

    final backgroundColor = isSelected
        ? colorScheme.secondaryContainer
        : Colors.transparent;
    final iconColor = isSelected
        ? colorScheme.primary
        : colorScheme.onSurfaceVariant;
    final textColor = isSelected
        ? colorScheme.onSecondaryContainer
        : colorScheme.onSurface;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Icon(icon, color: iconColor),
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        onTap: () => onTap(context),
      ),
    );
  }
}
