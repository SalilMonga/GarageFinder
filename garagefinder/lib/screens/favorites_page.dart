import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteOrganizations;
  final ValueChanged<List<Map<String, String>>> onFavoritesUpdated;

  const FavoritesPage({
    Key? key,
    required this.favoriteOrganizations,
    required this.onFavoritesUpdated,
  }) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late List<Map<String, String>> _favorites;
  String _sortOrder = 'Name'; // Default sort order
  final Set<String> _pinnedOrgs =
      {}; // Keeps track of pinned organization names

  @override
  void initState() {
    super.initState();
    _favorites = List<Map<String, String>>.from(widget.favoriteOrganizations);
    _applySort();
  }

  void _applySort() {
    setState(() {
      if (_sortOrder == 'Pinned') {
        _favorites.sort((a, b) {
          final aPinned = _pinnedOrgs.contains(a['name']);
          final bPinned = _pinnedOrgs.contains(b['name']);
          if (aPinned && !bPinned) return -1;
          if (!aPinned && bPinned) return 1;
          return 0;
        });
      } else if (_sortOrder == 'Name') {
        _favorites.sort((a, b) => (a['name'] ?? '').compareTo(b['name'] ?? ''));
      } else if (_sortOrder == 'Recently Added') {
        // Keeps the original order when sorted by recently added
        _favorites =
            List<Map<String, String>>.from(widget.favoriteOrganizations);
      }
    });
  }

  void _togglePin(Map<String, String> org) {
    setState(() {
      if (_pinnedOrgs.contains(org['name'])) {
        // If already pinned, unpin it
        _pinnedOrgs.remove(org['name']);
      } else {
        // If not pinned, pin it only if less than 3 are pinned
        if (_pinnedOrgs.length < 3) {
          _pinnedOrgs.add(org['name']!);
        } else {
          // Show a message if the user tries to pin more than 3
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('You can only pin up to 3 organizations.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
      _applySort(); // Apply sorting to reflect the changes
    });

    widget.onFavoritesUpdated(_favorites);
  }

  void _unfavorite(Map<String, String> org) {
    setState(() {
      _pinnedOrgs.remove(org['name']); // Remove from pinned if pinned
      _favorites.remove(org); // Remove from the favorites list
      _applySort();
    });

    widget.onFavoritesUpdated(_favorites);
  }

  @override
  Widget build(BuildContext context) {
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
                _sortOrder = value ?? 'Pinned';
                _applySort();
              });
            },
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      body: _favorites.isEmpty
          ? const Center(
              child: Text(
                'No favorite organizations yet.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final org = _favorites[index];
                final isPinned = _pinnedOrgs.contains(org['name']);
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
                        onPressed: () => _togglePin(org),
                      ),
                      IconButton(
                        icon: const Icon(Icons.star, color: Colors.yellow),
                        onPressed: () => _unfavorite(org),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
