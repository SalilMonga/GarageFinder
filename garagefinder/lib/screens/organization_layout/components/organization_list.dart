import 'package:flutter/material.dart';

class OrganizationList extends StatelessWidget {
  final Map<String, List<Map<String, dynamic>>> groupedOrganizations;
  final Map<String, GlobalKey> sectionKeys;
  final Function(Map<String, dynamic>) onOrganizationTap; // Callback for tap

  const OrganizationList({
    super.key,
    required this.groupedOrganizations,
    required this.sectionKeys,
    required this.onOrganizationTap,
  });

  @override
  Widget build(BuildContext context) {
    List<String> alphabet = groupedOrganizations.keys.toList()..sort();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: alphabet
          .map((letter) => _buildSection(context, letter, groupedOrganizations[letter]))
          .toList(),
    );
  }

  Widget _buildSection(BuildContext context, String letter, List<Map<String, dynamic>>? organizations) {
    if (organizations == null || organizations.isEmpty) {
      return Container(); // If no organizations for the letter, return an empty container
    }
    final GlobalKey sectionKey = sectionKeys[letter]!;
    return Column(
      key: sectionKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          letter,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ...organizations.map((org) => _buildOrganizationItem(context, org)),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildOrganizationItem(BuildContext context, Map<String, dynamic> organization) {
    return ListTile(
      leading: const Icon(Icons.school),
      title: Text(
        organization['name'] ?? '',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Text(
        organization['location'] ?? '',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      onTap: () => onOrganizationTap(organization), // Call the callback with the selected organization
    );
  }
}
