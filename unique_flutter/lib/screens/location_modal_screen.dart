import 'package:flutter/material.dart';

/// GPS Reverse-Geocoding and Location Picker modal.
class LocationModalScreen extends StatefulWidget {
  const LocationModalScreen({super.key});

  @override
  State<LocationModalScreen> createState() => _LocationModalScreenState();
}

class _LocationModalScreenState extends State<LocationModalScreen> {
  final _searchController = TextEditingController();
  String _currentAddress = '123 Main St, Springfield, USA';
  double _latitude = 37.7749;
  double _longitude = -122.4194;
  bool _isLoadingGps = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _detectGpsLocation() {
    setState(() => _isLoadingGps = true);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isLoadingGps = false;
          _currentAddress = '456 Market St, San Francisco, CA';
          _latitude = 37.7892;
          _longitude = -122.4014;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('GPS Location Updated!')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location & Geolocation'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search address or city...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.my_location),
                    onPressed: _detectGpsLocation,
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              OutlinedButton.icon(
                onPressed: _isLoadingGps ? null : _detectGpsLocation,
                icon: _isLoadingGps
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.gps_fixed),
                label: const Text('Use Current GPS Location'),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: theme.colorScheme.outlineVariant),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.map, size: 56, color: theme.colorScheme.primary),
                          const SizedBox(height: 8),
                          Text(
                            _currentAddress,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Lat: $_latitude, Lng: $_longitude',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.outline,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 16,
                        child: FilledButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop({
                              'address': _currentAddress,
                              'latitude': _latitude,
                              'longitude': _longitude,
                            });
                          },
                          icon: const Icon(Icons.check_circle),
                          label: const Text('Confirm Location'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
