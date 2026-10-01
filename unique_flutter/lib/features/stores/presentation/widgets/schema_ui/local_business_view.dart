import 'package:flutter/material.dart';
import '../../../../../core/schema_ld/schema_ld.dart';

/// UI component for rendering Schema.org `@type: "LocalBusiness"`.
class LocalBusinessView extends StatelessWidget {
  final LocalBusinessLd business;
  final VoidCallback? onDirectionsTap;
  final VoidCallback? onCallTap;

  const LocalBusinessView({
    super.key,
    required this.business,
    this.onDirectionsTap,
    this.onCallTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Chip(
                  avatar: const Icon(Icons.store, size: 16),
                  label: const Text('Local Business'),
                  backgroundColor: theme.colorScheme.primaryContainer,
                ),
                const Spacer(),
                if (business.priceRange != null)
                  Text(
                    business.priceRange!,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            Text(
              business.name,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            if (business.description != null) ...[
              Text(
                business.description!,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
            ],

            if (business.image != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  business.image!,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 120,
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: const Center(
                      child: Icon(Icons.business, size: 48),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            if (business.address != null) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on, color: theme.colorScheme.primary, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      business.address!,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],

            if (business.telephone != null) ...[
              Row(
                children: [
                  Icon(Icons.phone, color: theme.colorScheme.primary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    business.telephone!,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],

            if (business.openingHours != null) ...[
              Row(
                children: [
                  Icon(Icons.access_time, color: theme.colorScheme.secondary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Hours: ${business.openingHours}',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],

            if (business.latitude != null && business.longitude != null) ...[
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.map, size: 36, color: theme.colorScheme.primary),
                        const SizedBox(height: 4),
                        Text(
                          'GPS Coordinates: ${business.latitude}, ${business.longitude}',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            Row(
              children: [
                if (business.telephone != null)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        onCallTap?.call();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Calling ${business.telephone}'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.call),
                      label: const Text('Call Now'),
                    ),
                  ),
                if (business.telephone != null) const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      onDirectionsTap?.call();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Opening directions for ${business.name}'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.directions),
                    label: const Text('Directions'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
