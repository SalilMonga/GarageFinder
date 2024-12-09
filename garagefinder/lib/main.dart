import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:garagefinder/components/theme_notifier.dart';
import 'package:garagefinder/screens/homepage.dart';
import 'package:garagefinder/screens/organization_layout/components/organization_state.dart';
import 'package:garagefinder/screens/parking_layout/garage_layout_page.dart';
import 'package:garagefinder/screens/login_page.dart';
import 'package:garagefinder/screens/parking_map.dart';
import 'package:garagefinder/screens/signup_page.dart';
import 'package:garagefinder/screens/settings_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter is ready
  await Firebase.initializeApp();
  print('Firebase initialized successfully'); // Initialize Firebase
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(
            create: (_) =>
                OrganizationState()), // Add OrganizationState provider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      //adds an ease animation during theme change
      return AnimatedBuilder(
          animation: themeNotifier,
          builder: (context, _) {
            return MaterialApp(
              title: 'Garage Finder App',
              // initialRoute: '/login', // The first screen to load
              initialRoute: '/', // Set current test screen and uncomment
              theme: themeNotifier.lightTheme, // Light Theme
              darkTheme: themeNotifier.darkTheme, // Dark Theme
              themeMode: themeNotifier.themeMode, // Current Theme Mode
              routes: {
                '/': (context) => const HomePage(),
                '/login': (context) => const LoginPage(),
                '/signup': (context) => const SignUpPage(),
                // '/organizations': (context) => const OrganizationsPage(),
                '/settings': (context) => const SettingsPage(),
                '/garage': (context) => const GarageLayoutPage(),
                '/parking': (context) => const ParkingMap(),
                // '/welcome': (context) => const WelcomePage(firstName: "Salil"),
                // Add other screens here as needed
              },
            );
          });
    });
  }
}
