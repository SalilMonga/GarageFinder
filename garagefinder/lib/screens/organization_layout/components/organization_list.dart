import 'package:flutter/material.dart';
import 'package:garagefinder/screens/organization_layout/components/organization_state.dart';
import 'package:provider/provider.dart';

class OrganizationList extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteOrganizations;
  final Map<String, List<Map<String, dynamic>>> groupedOrganizations;
  final Map<String, GlobalKey> sectionKeys;
  final Function(List<Map<String, dynamic>>)
      onFavoritesUpdated; // Callback to update favorites
  final Function(Map<String, dynamic>)
      onOrganizationTap; // Callback for organization tap

  const OrganizationList({
    super.key,
    required this.favoriteOrganizations,
    required this.groupedOrganizations,
    required this.sectionKeys,
    required this.onFavoritesUpdated,
    required this.onOrganizationTap,
  });

  @override
  State<OrganizationList> createState() {
    return _OrganizationListState();
  }
}

class _OrganizationListState extends State<OrganizationList> {
  @override
  Widget build(BuildContext context) {
    List<String> alphabet = widget.groupedOrganizations.keys.toList()..sort();
    final sectionKeys =
        Provider.of<OrganizationState>(context, listen: false).sectionKeys;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: alphabet.map((letter) {
        final organizations = widget.groupedOrganizations[letter];
        if (organizations == null || organizations.isEmpty) return Container();

        return _buildSection(
          context,
          letter,
          organizations,
          sectionKeys,
        );
      }).toList(),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String letter,
    List<Map<String, dynamic>> organizations,
    Map<String, GlobalKey> sectionKeys,
  ) {
    final GlobalKey sectionKey = sectionKeys[letter]!;

    return Column(
      key: sectionKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          letter,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ...organizations.map((org) {
          return GestureDetector(
            onTap: () => widget.onOrganizationTap(org), // Trigger callback
            child: _buildOrganizationItem(
              context,
              org,
            ),
          );
        }),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildOrganizationItem(
    BuildContext context,
    Map<String, dynamic> org,
  ) {
    final organizationState =
        Provider.of<OrganizationState>(context, listen: false);
    final isFavorite = organizationState.favoriteOrganizations
        .any((fav) => fav['name'] == org['name']);

    return ListTile(
      leading: const Icon(Icons.school),
      title: Text(
        org['name'] ?? '',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Text(
        org['location'] ?? '',
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
          if (isFavorite) {
            organizationState.removeFavorite(org); // Update global state
          } else {
            organizationState.addFavorite(org); // Update global state
          }

          // Notify parent about updated favorites
          widget.onFavoritesUpdated(organizationState.favoriteOrganizations);
          setState(() {}); // Update local UI
        },
      ),
    );
  }
}
