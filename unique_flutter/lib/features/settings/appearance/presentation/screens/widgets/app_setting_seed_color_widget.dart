import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart';

import '../../bloc/appearance_settings_bloc.dart';
import '../../bloc/appearance_settings_state.dart' show AppearanceSettingsState;

//AppearanceSettingsSeedColorWidget

class const AppearanceSettingsSeedColorWidget({
  required final Color flavorDefaultColor,
  super.key,
}) extends StatelessWidget {
  List<Color> get seedColors => [
    flavorDefaultColor, // Design primary purple
    Color(0xFFEF4444), // Red
    Color(0xFFEC4899), // Pink
    Color(0xFF8B5CF6), // Violet
    Color(0xFF6366F1), // Indigo

    Color(0xFF06B6D4), // Cyan
    Color(0xFF14B8A6), // Teal

    Color(0xFF0EA5E9), // Sky
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocSignalSelector<
      AppearanceSettingsBloc,
      AppearanceSettingsState,
      Color
    >(
      selector: (state) => state.seedColor,
      builder: (context, activeColor) {
        final appSettingBloc = context.read<AppearanceSettingsBloc>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Accent Color',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(20),
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: seedColors.map((color) {
                  final isSelected = activeColor.toARGB32() == color.toARGB32();
                  return _SeedColorOption(
                    color: color,
                    isSelected: isSelected,
                    appSettingBloc: appSettingBloc,
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SeedColorOption extends StatelessWidget {
  const _SeedColorOption({
    required this.color,
    required this.isSelected,
    required this.appSettingBloc,
  });

  final Color color;
  final bool isSelected;
  final AppearanceSettingsBloc appSettingBloc;

  void _handleTap() {
    appSettingBloc.add(SetSeedColorEvent(color));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (isSelected)
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2),
              ),
            ),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: isSelected
                ? const Icon(Icons.check, color: Colors.white, size: 22)
                : null,
          ),
        ],
      ),
    );
  }
}
