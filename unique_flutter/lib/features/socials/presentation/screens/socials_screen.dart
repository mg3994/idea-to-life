import 'package:flutter/material.dart';

class SocialsScreen extends StatefulWidget {
  const SocialsScreen({super.key});

  @override
  State<SocialsScreen> createState() => _SocialsScreenState();
}

class _SocialsScreenState extends State<SocialsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  static const _dummySocials = [
    (name: 'Twitter / X', handle: '@unique_app', icon: Icons.alternate_email),
    (name: 'GitHub', handle: 'github.com/unique', icon: Icons.code),
    (name: 'Discord', handle: 'discord.gg/unique', icon: Icons.forum_outlined),
    (name: 'LinkedIn', handle: 'linkedin.com/company/unique', icon: Icons.work_history_outlined),
    (name: 'YouTube', handle: 'youtube.com/@unique', icon: Icons.video_library_outlined),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final filteredSocials = _dummySocials.where((social) {
      return social.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          social.handle.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Social Links')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SearchBar(
                controller: _searchController,
                hintText: 'Search socials...',
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
              child: filteredSocials.isEmpty
                  ? Center(
                      child: Text(
                        'No social links found',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredSocials.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final item = filteredSocials[index];
                        return Card(
                          elevation: 0,
                          color: theme.colorScheme.surfaceContainerLow,
                          child: ListTile(
                            leading: Icon(item.icon, color: theme.colorScheme.primary),
                            title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(item.handle),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Opening ${item.name}...')),
                              );
                            },
                          ),
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
