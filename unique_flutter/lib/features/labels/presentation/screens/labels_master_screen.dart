import 'package:flutter/material.dart';

import '../../../../core/core.dart' show BuildContextLocalizationExtensions;
import '../../../../navigation/router.dart'
    show LabelDetailRoute, LabelsMasterRoute, LabelsRoot, LabelsRoute;

class LabelsMasterScreen extends StatefulWidget {
  const LabelsMasterScreen({
    super.key,
    this.selectedRoute,
    this.onSelectRoute,
  });

  final LabelsRoute? selectedRoute;
  final void Function(BuildContext context, LabelsRoute route)? onSelectRoute;

  @override
  State<LabelsMasterScreen> createState() => _LabelsMasterScreenState();
}

class _LabelsMasterScreenState extends State<LabelsMasterScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Placeholder label IDs — replace with real data later.
  static const _dummyLabels = [
    (id: 'work', name: 'Work', icon: Icons.work_outline),
    (id: 'personal', name: 'Personal', icon: Icons.person_outline),
    (id: 'shopping', name: 'Shopping', icon: Icons.shopping_bag_outlined),
    (id: 'finance', name: 'Finance', icon: Icons.account_balance_outlined),
    (id: 'travel', name: 'Travel', icon: Icons.flight_outlined),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final filteredLabels = _dummyLabels.where((label) {
      return label.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SearchBar(
                controller: _searchController,
                hintText: 'Search labels...',
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
              child: filteredLabels.isEmpty
                  ? Center(
                      child: Text(
                        'No labels found',
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
                      itemCount: filteredLabels.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final label = filteredLabels[index];
                        final route = LabelsRoot("");
                        final isSelected = widget.selectedRoute is LabelsRoot;

                        return _LabelTile(
                          icon: label.icon,
                          name: label.name,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
