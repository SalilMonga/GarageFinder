import 'package:flutter/material.dart';

class OrganizationList extends StatelessWidget {
  final Map<String, List<Map<String, dynamic>>> groupedOrganizations;

  const OrganizationList({
    Key? key,
    required this.groupedOrganizations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> alphabet = groupedOrganizations.keys.toList()..sort();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: alphabet
          .map((letter) =>
              _buildSection(context, letter, groupedOrganizations[letter]!))
          .toList(),
    );
  }

  Widget _buildSection(BuildContext context, String letter,
      List<Map<String, dynamic>> organizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          letter,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ...organizations
            .map((org) =>
                _buildOrganizationItem(context, org['name'], org['location']))
            .toList(),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildOrganizationItem(
      BuildContext context, String name, String location) {
    return ListTile(
      leading: const Icon(Icons.school),
      title: Text(name, style: Theme.of(context).textTheme.bodyLarge),
      subtitle: Text(location, style: Theme.of(context).textTheme.bodyMedium),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tapped on $name')),
        );
      },
    );
  }
}
