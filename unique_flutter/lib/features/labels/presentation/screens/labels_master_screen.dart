import 'package:flutter/material.dart';

import '../../../../core/core.dart' show BuildContextLocalizationExtensions;
import '../../../../navigation/router.dart'
    show LabelDetailRoute, LabelsMasterRoute, LabelsRoot, LabelsRoute;

class LabelsMasterScreen extends StatelessWidget {
  const LabelsMasterScreen({
    super.key,
    this.selectedRoute,
    this.onSelectRoute,
  });

  final LabelsRoute? selectedRoute;
  final void Function(BuildContext context, LabelsRoute route)? onSelectRoute;

  // Placeholder label IDs — replace with real data later.
  static const _dummyLabels = [
    (id: 'work', name: 'Work', icon: Icons.work_outline),
    (id: 'personal', name: 'Personal', icon: Icons.person_outline),
    (id: 'shopping', name: 'Shopping', icon: Icons.shopping_bag_outlined),
    (id: 'finance', name: 'Finance', icon: Icons.account_balance_outlined),
    (id: 'travel', name: 'Travel', icon: Icons.flight_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Labels',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: _dummyLabels.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final label = _dummyLabels[index];
                  final route = LabelsRoot();
                  final isSelected = selectedRoute is LabelsRoot;

                  return _LabelTile(
                    icon: label.icon,
                    name: label.name,
                    isSelected: isSelected,
                    onTap: (tileContext) {
                      if (isSelected) return;
                      onSelectRoute?.call(tileContext, route);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add label
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add label — coming soon')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _LabelTile extends StatelessWidget {
  const _LabelTile({
    required this.icon,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String name;
  final bool isSelected;
  final void Function(BuildContext context) onTap;

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
          name,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        onTap: () => onTap(context),
      ),
    );
  }
}
