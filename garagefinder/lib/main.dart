import 'package:flutter/material.dart';
import 'package:garagefinder/components/theme_notifier.dart';
import 'package:garagefinder/screens/garage_layout.dart';
import 'package:garagefinder/screens/login_page.dart';
import 'package:garagefinder/screens/signup_page.dart';
import 'package:garagefinder/screens/organization_list.dart';
import 'package:garagefinder/screens/settings_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      title: 'Garage Finder App',
      // initialRoute: '/login', // The first screen to load
      initialRoute: '/organizations', // Set current test screen and uncomment
      theme: themeNotifier.lightTheme, // Light Theme
      darkTheme: themeNotifier.darkTheme, // Dark Theme
      themeMode: themeNotifier.themeMode, // Current Theme Mode
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/organizations': (context) => const OrganizationsPage(),
        '/settings': (context) => const SettingsPage(),
        '/garage': (context) => const GarageLayoutPage(),
        // Add other screens here as needed
      },
    );
  }
}
