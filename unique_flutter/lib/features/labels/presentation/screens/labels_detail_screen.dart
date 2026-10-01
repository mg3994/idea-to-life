import 'package:flutter/material.dart';

import '../../../../core/core.dart' show BuildContextLocalizationExtensions;
import '../../../../navigation/router.dart' show LabelDetailRoute;

class LabelDetailScreen extends StatelessWidget {
  const LabelDetailScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Label: $id'),
        backgroundColor: theme.colorScheme.surface,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.label,
              size: 72,
              color: theme.colorScheme.primary.withOpacity(0.4),
            ),
            const SizedBox(height: 24),
            Text(
              id,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Label detail — coming soon',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
