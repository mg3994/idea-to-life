import 'package:flutter/material.dart';

import '../../../../core/core.dart' show BuildContextLocalizationExtensions;
import '../../../../navigation/router.dart' show StoresRoot, StoresRoute;

class StoreMasterScreen extends StatelessWidget {
  const StoreMasterScreen({
    super.key,
    this.selectedRoute,
    this.onSelectRoute,
  });

  final StoresRoute? selectedRoute;
  final void Function(BuildContext context, StoresRoute route)? onSelectRoute;

  static const _dummyStores = [
    (
      id: 'store-1',
      name: 'Electronics Hub',
      icon: Icons.electrical_services_outlined,
    ),
    (id: 'store-2', name: 'Fashion World', icon: Icons.checkroom_outlined),
    (
      id: 'store-3',
      name: 'Fresh Grocery',
      icon: Icons.local_grocery_store_outlined,
    ),
    (id: 'store-4', name: 'Book Nook', icon: Icons.menu_book_outlined),
    (id: 'store-5', name: 'Sports Zone', icon: Icons.sports_outlined),
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
                'Stores',
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
                itemCount: _dummyStores.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final store = _dummyStores[index];
                  final route = StoresRoot("");
                  final isSelected = selectedRoute is StoresRoot;

                  return _StoreTile(
                    icon: store.icon,
                    name: store.name,
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
    );
  }
}

class _StoreTile extends StatelessWidget {
  const _StoreTile({
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
