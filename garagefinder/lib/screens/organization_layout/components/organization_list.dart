import 'package:flutter/material.dart';

class OrganizationList extends StatefulWidget {
  final Map<String, List<Map<String, dynamic>>> groupedOrganizations;
  final Map<String, GlobalKey> sectionKeys;
  final Function(List<String>)
      onFavoritesUpdated; // Callback to update favorites

  const OrganizationList({
    super.key,
    required this.groupedOrganizations,
    required this.sectionKeys,
    required this.onFavoritesUpdated,
  });

  @override
  State<OrganizationList> createState() => _OrganizationListState();
}

class _OrganizationListState extends State<OrganizationList> {
  final Set<String> _favoriteOrganizations =
      {}; // Stores favorite organizations by name

  void _updateFavorites() {
    widget.onFavoritesUpdated(_favoriteOrganizations.toList());
  }

  @override
  Widget build(BuildContext context) {
    List<String> alphabet = widget.groupedOrganizations.keys.toList()..sort();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: alphabet
          .map((letter) => _buildSection(
                context,
                letter,
                widget.groupedOrganizations[letter],
              ))
          .toList(),
    );
  }

  Widget _buildSection(BuildContext context, String letter,
      List<Map<String, dynamic>>? organizations) {
    if (organizations == null || organizations.isEmpty) {
      return Container(); // If no organizations for the letter, return an empty container
    }
    final GlobalKey sectionKey = widget.sectionKeys[letter]!;
    return Column(
      key: sectionKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          letter,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ...organizations.map((org) {
          final name = org['name'] ?? '';
          final location = org['location'] ?? '';
          return _buildOrganizationItem(context, name, location);
        }).toList(),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildOrganizationItem(
      BuildContext context, String name, String location) {
    final isFavorite = _favoriteOrganizations.contains(name);

    return ListTile(
      leading: const Icon(Icons.school),
      title: Text(
        name,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Text(
        location,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.star,
          color: isFavorite
              ? Colors.yellow
              : Colors.grey, // Star color based on favorite status
        ),
        onPressed: () {
          setState(() {
            if (isFavorite) {
              _favoriteOrganizations.remove(name); // Remove from favorites
            } else {
              _favoriteOrganizations.add(name); // Add to favorites
            }
            _updateFavorites(); // Notify parent about updated favorites
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(isFavorite
                  ? '$name removed from favorites'
                  : '$name added to favorites'),
            ),
          );
        },
      ),
    );
  }
}
