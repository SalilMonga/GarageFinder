import 'package:flutter/material.dart';
import 'package:garagefinder/screens/organization_layout/components/organization_state.dart';
import 'package:provider/provider.dart';

class OrganizationList extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteOrganizations;
  final Map<String, List<Map<String, dynamic>>> groupedOrganizations;
  final Map<String, GlobalKey> sectionKeys;
  final Function(List<Map<String, dynamic>>)
      onFavoritesUpdated; // Callback to update favorites

  const OrganizationList({
    super.key,
    required this.favoriteOrganizations,
    required this.groupedOrganizations,
    required this.sectionKeys,
    required this.onFavoritesUpdated,
  });

  // @override
  // State<OrganizationList> createState() => _OrganizationListState();
  @override
  State<OrganizationList> createState() {
    print('OrganizationList created: ${DateTime.now()}');
    return _OrganizationListState();
  }
}

class _OrganizationListState extends State<OrganizationList> {
  void _updateFavorites() {
    widget.onFavoritesUpdated(
      widget.favoriteOrganizations.toList(), // Pass list of maps
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> alphabet = widget.groupedOrganizations.keys.toList()..sort();
    final sectionKeys =
        Provider.of<OrganizationState>(context, listen: false).sectionKeys;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: alphabet
          .map((letter) => _buildSection(
                context,
                letter,
                widget.groupedOrganizations[letter],
                sectionKeys,
              ))
          .toList(),
    );
  }

  Widget _buildSection(
      BuildContext context,
      String letter,
      List<Map<String, dynamic>>? organizations,
      Map<String, GlobalKey> sectionKeys) {
    if (organizations == null || organizations.isEmpty) {
      return Container(); // If no organizations for the letter, return an empty container
    }
    // if (!sectionKeys.containsKey(letter)) {
    //   sectionKeys[letter] = GlobalKey(debugLabel: 'SectionKey_$letter');
    // }

    final GlobalKey sectionKey = sectionKeys[letter]!;
    print(
        'Assigning sectionKey for letter: $letter -> $widget.sectionKeysOrgList');
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
        }),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildOrganizationItem(
      BuildContext context, String name, String location) {
    final org = {'name': name, 'location': location};
    final isFavorite =
        widget.favoriteOrganizations.any((fav) => fav['name'] == name);

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
              widget.favoriteOrganizations.removeWhere(
                  (fav) => fav['name'] == name); // Remove the full org map
            } else {
              widget.favoriteOrganizations.add(org); // Add the full org map
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
