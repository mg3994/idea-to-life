import 'package:flutter/material.dart';
import '../../../../../core/schema_ld/schema_ld.dart';

/// UI component for rendering Schema.org `@type: "Service"`.
class ServiceCatalogView extends StatelessWidget {
  final ServiceLd service;
  final VoidCallback? onBookAppointment;

  const ServiceCatalogView({
    super.key,
    required this.service,
    this.onBookAppointment,
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
                  avatar: const Icon(Icons.design_services, size: 16),
                  label: Text(service.serviceType ?? 'Service Catalog'),
                  backgroundColor: theme.colorScheme.secondaryContainer,
                ),
                const Spacer(),
                if (service.providerName != null)
                  Chip(
                    avatar: const Icon(Icons.verified, size: 16),
                    label: Text(service.providerName!),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            Text(
              service.name,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            if (service.description != null) ...[
              Text(
                service.description!,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
            ],

            Row(
              children: [
                if (service.price > 0)
                  Text(
                    'Starting at ${service.priceCurrency} \$${service.price.toStringAsFixed(2)}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                if (service.areaServed != null) ...[
                  const Spacer(),
                  Icon(Icons.location_on_outlined, size: 16, color: theme.colorScheme.outline),
                  const SizedBox(width: 4),
                  Text(
                    service.areaServed!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),

            if (service.offerPackages.isNotEmpty) ...[
              Text(
                'Available Packages:',
                style: theme.textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              ...service.offerPackages.map((pkg) => ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.check_circle_outline,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                    title: Text(pkg),
                  )),
              const SizedBox(height: 16),
            ],

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  onBookAppointment?.call();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Booking Appointment for ${service.name}'),
                    ),
                  );
                },
                icon: const Icon(Icons.calendar_month),
                label: const Text('Book Appointment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
