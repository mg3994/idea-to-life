import 'package:flutter/material.dart';

import '../../../../core/core.dart' show BuildContextLocalizationExtensions;
import '../../../../navigation/router.dart' show StoresRoot, StoresRoute;

class StoreMasterScreen extends StatefulWidget {
  const StoreMasterScreen({
    super.key,
    this.selectedRoute,
    this.onSelectRoute,
  });

  final StoresRoute? selectedRoute;
  final void Function(BuildContext context, StoresRoute route)? onSelectRoute;

  @override
  State<StoreMasterScreen> createState() => _StoreMasterScreenState();
}

class _StoreMasterScreenState extends State<StoreMasterScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final filteredStores = _dummyStores.where((store) {
      return store.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SearchBar(
                controller: _searchController,
                hintText: 'Search stores...',
                leading: const Icon(Icons.search),
                trailing: _searchQuery.isNotEmpty
                    ? [
                        IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _searchQuery = '';
                            });
                          },
                        ),
                      ]
                    : null,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            Expanded(
              child: filteredStores.isEmpty
                  ? Center(
                      child: Text(
                        'No stores found',
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
                      itemCount: filteredStores.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final store = filteredStores[index];
                        final route = StoresRoot("");
                        final isSelected = widget.selectedRoute is StoresRoot;

                        return _StoreTile(
                          icon: store.icon,
                          name: store.name,
                          isSelected: isSelected,
                          onTap: (tileContext) {
                            if (isSelected) return;
                            widget.onSelectRoute?.call(tileContext, route);
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
