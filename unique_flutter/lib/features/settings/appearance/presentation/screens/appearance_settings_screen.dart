import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart';

import '../../../../../core/core.dart' show BuildContextLocalizationExtensions;
import '../bloc/appearance_settings_bloc.dart'
    show AppearanceSettingsBloc, ResetAppearanceSettingsEvent;

import 'widgets/widgets.dart'
    show
        AppearanceSettingsLocaleWidget,
        AppearanceSettingsThemeModeWidget,
        AppearanceSettingsSeedColorWidget;

class const AppearanceSettingsScreen({
  final Color? flavorDefaultColor,
  final AppearanceSettingsBloc? appearanceSettingsBloc,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final flavorDefaultColor =
        this.flavorDefaultColor ??
        context.appDependencies.flavorConfig.defaultThemeSeedColor;
    final appearanceSettingsBloc =
        this.appearanceSettingsBloc ?? context.read<AppearanceSettingsBloc>();
    final l10n = context.l10n;
    final theme = context.theme;
    final mq = context.mq;
    final pageScope = context.pageScope;
    final isCompact = mq.size.width < 700;
    final isOnlyPage = pageScope?.isBottom ?? false;
    // On wide screens, master & detail are visible side-by-side: disable the back button
    final showBackButton = isCompact && !isOnlyPage;

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        title: Text(l10n.settingsAppearanceTitle),
        automaticallyImplyLeading: showBackButton,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        key: const PageStorageKey('appearance_settings_scroll'),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isCompact) ...[
                Text(
                  l10n.settingsAppearanceTitle,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 32),
              ],
              const AppearanceSettingsThemeModeWidget(),
              const SizedBox(height: 32),
              AppearanceSettingsSeedColorWidget(
                flavorDefaultColor: flavorDefaultColor,
              ),
              const SizedBox(height: 32),
              const AppearanceSettingsLocaleWidget(),
              const SizedBox(height: 40),
              FilledButton.tonalIcon(
                onPressed: () {
                  appearanceSettingsBloc.add(
                    const ResetAppearanceSettingsEvent(),
                  );
                },
                icon: const Icon(Icons.restore),
                label: Text(l10n.resetToDefault),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
