import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garagefinder/screens/organization_layout/components/organization_state.dart';
import 'package:garagefinder/screens/organization_layout/organization_page.dart';
import 'package:garagefinder/screens/favorites_page.dart';
import 'package:garagefinder/screens/settings_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _initializePages();
  }

  void _initializePages() {
    _pages = [
      OrganizationsPage(key: GlobalKey()), // New key for OrganizationsPage
      FavoritesPage(key: GlobalKey()), // New key for FavoritesPage
      SettingsPage(key: GlobalKey()), // New key for SettingsPage
    ];
  }

  void _logout() {
    FirebaseAuth.instance.signOut();

    // Reset the app state and reinitialize pages
    context.read<OrganizationState>().resetState();
    setState(() {
      _initializePages(); // Rebuild the pages with fresh keys
      _currentIndex = 0; // Reset to the first tab
    });

    // Navigate to the login page
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Organizations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
