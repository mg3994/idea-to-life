import 'package:flutter/material.dart';
import '../../../../../core/schema_ld/schema_ld.dart';

/// UI component for rendering Schema.org `@type: "Event"`.
class EventCardView extends StatelessWidget {
  final EventLd event;
  final VoidCallback? onRegister;

  const EventCardView({
    super.key,
    required this.event,
    this.onRegister,
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
                  avatar: const Icon(Icons.event, size: 16),
                  label: const Text('Event'),
                  backgroundColor: theme.colorScheme.tertiaryContainer,
                ),
                const Spacer(),
                if (event.startDate != null)
                  Text(
                    event.startDate!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.tertiary,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            Text(
              event.name,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            if (event.description != null) ...[
              Text(event.description!, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 12),
            ],

            if (event.locationName != null) ...[
              Row(
                children: [
                  Icon(Icons.place, color: theme.colorScheme.primary, size: 20),
                  const SizedBox(width: 8),
                  Text(event.locationName!, style: theme.textTheme.bodyMedium),
                ],
              ),
              const SizedBox(height: 12),
            ],

            Row(
              children: [
                if (event.price > 0)
                  Text(
                    '${event.priceCurrency} \$${event.price.toStringAsFixed(2)}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  )
                else
                  Text(
                    'Free Admission',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                const Spacer(),
                FilledButton.icon(
                  onPressed: () {
                    onRegister?.call();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Registered for ${event.name}')),
                    );
                  },
                  icon: const Icon(Icons.confirmation_number),
                  label: const Text('Get Tickets'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
