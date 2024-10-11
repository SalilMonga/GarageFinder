import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Garage Finder Homepage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: OrganizationSelector(),  // Stateful OrganizationSelector included here
        ),
      ),
    );
  }
}

class OrganizationSelector extends StatefulWidget {
  const OrganizationSelector({super.key});

  @override
  State<OrganizationSelector> createState() => _OrganizationSelectorState();
}

class _OrganizationSelectorState extends State<OrganizationSelector> {
  final organizations = {
    'Northern California': [
      'CSU Chico',
      'CSU East Bay',
      'Humboldt State',
      'CSU Maritime',
      'CSU Sacramento',
      'San Francisco State',
      'Sonoma State',
    ],
    'Central California': [
      'CSU Fresno',
      'CSU Monterey Bay',
      'Cal Poly San Luis Obispo',
      'CSU Stanislaus',
      'San Jose State',
    ],
    'Southern California': [
      'CSU Bakersfield',
      'CSU Channel Islands',
      'CSU Dominguez Hills',
      'CSU Fullerton',
      'CSU Los Angeles',
      'CSU Long Beach',
      'CSU Northridge',
      'Cal Poly Pomona',
      'CSU San Marcos',
      'CSU San Bernardino',
      'San Diego State',
    ],
  };

  String? _selectedOrganization;

  List<Widget> getOrganizationsWidgets(ShadThemeData theme) {
    final widgets = <Widget>[];
    for (final region in organizations.entries) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 6, 6, 6),
          child: Text(
            region.key,  // Displays the region name
            style: theme.textTheme.muted.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.popoverForeground,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      );
      widgets.addAll(region.value
          .map((organization) => ShadOption(
                value: organization,
                child: Text(organization),
              ))
          .toList());
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 280),
      child: ShadSelect<String>(
        placeholder: const Text('Select an organization'),
        options: getOrganizationsWidgets(theme),
        onChanged: (String? value) {
          setState(() {
            _selectedOrganization = value;
          });
        },
        selectedOptionBuilder: (context, value) {
          return Text(value ?? 'No organization selected');
        },
      ),
    );
  }
}
