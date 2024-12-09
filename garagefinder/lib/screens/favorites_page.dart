import 'package:flutter/material.dart';
import 'package:garagefinder/screens/organization_layout/components/organization_state.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String _sortOrder = 'Name'; // Default sort order

  @override
  Widget build(BuildContext context) {
    final organizationState = Provider.of<OrganizationState>(context);
    final favorites = organizationState.getSortedFavorites(_sortOrder);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Organizations'),
        actions: [
          DropdownButton<String>(
            value: _sortOrder,
            items: const [
              DropdownMenuItem(
                value: 'Pinned',
                child: Text('Pinned on Top'),
              ),
              DropdownMenuItem(
                value: 'Name',
                child: Text('Alphabetical'),
              ),
              DropdownMenuItem(
                value: 'Recently Added',
                child: Text('Recently Added'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _sortOrder = value ?? 'Name';
              });
            },
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text(
                'No favorite organizations yet.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final org = favorites[index];
                final isPinned =
                    organizationState.pinnedOrganizations.contains(org['name']);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      org['image'] ?? 'https://via.placeholder.com/150',
                    ),
                  ),
                  title: Text(
                    org['name'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    org['location'] ?? 'Unknown Location',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.push_pin,
                          color: isPinned ? Colors.blue : Colors.grey,
                        ),
                        onPressed: () {
                          organizationState.togglePin(org['name'] ?? '');
                          setState(() {}); // Update the UI
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.star, color: Colors.yellow),
                        onPressed: () {
                          organizationState.removeFavorite(org);
                          setState(() {}); // Update the UI
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
