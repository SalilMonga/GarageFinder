import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart'; // Assuming this package exists
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp.cupertino(
      cupertinoThemeBuilder: (context, theme) {
        return theme.copyWith(applyThemeToAll: true);
      },
      materialThemeBuilder: (context, theme) {
        return theme.copyWith(
          appBarTheme: const AppBarTheme(toolbarHeight: 52),
        );
      },
      home: LoginScreen(),
    );
  }
}

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
          child: OrganizationSelector(),
        ),
      ),
    );
  }
}

  class OrganizationSelector extends StatelessWidget {
  OrganizationSelector({super.key});

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
          .map((organization) => ShadOption(value: organization, child: Text(organization))));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context); // Ensure you fetch theme appropriately

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 280),
      child: ShadSelect<String>(
        placeholder: const Text('Select an organization'),
        options: getOrganizationsWidgets(theme),
        selectedOptionBuilder: (context, value) {
          return Text(value!);
        },
      ),
    );
  }
}
