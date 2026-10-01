import 'package:flutter/material.dart';

import '../../../../core/core.dart' show BuildContextLocalizationExtensions;
import '../../../../navigation/router.dart' show HomeRoute, HomeRoot;

class HomeMasterScreen extends StatelessWidget {
  const HomeMasterScreen({
    super.key,
    this.selectedRoute,
    this.onSelectRoute,
  });

  final HomeRoute? selectedRoute;
  final void Function(BuildContext context, HomeRoute route)? onSelectRoute;

  static const _dummyProducts = [
    (id: 'prod-1', name: 'Product Alpha', icon: Icons.inventory_2_outlined),
    (id: 'prod-2', name: 'Product Beta', icon: Icons.category_outlined),
    (id: 'prod-3', name: 'Product Gamma', icon: Icons.star_outline),
    (id: 'prod-4', name: 'Product Delta', icon: Icons.local_offer_outlined),
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
                'Home',
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
                itemCount: _dummyProducts.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final product = _dummyProducts[index];
                  final route = HomeRoot();
                  final isSelected = selectedRoute is HomeRoot;

                  return _HomeTile(
                    icon: product.icon,
                    name: product.name,
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

class _HomeTile extends StatelessWidget {
  const _HomeTile({
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
