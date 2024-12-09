import 'package:flutter/material.dart';
import 'package:garagefinder/components/theme_notifier.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // int _currentIndex = 2; // Track the currently selected tab

  // void _onTabTapped(int index) {
  //   setState(() {
  //     _currentIndex = index; // Update the current index
  //   });

  //   // Navigate based on the tapped index
  //   if (index == 0) {
  //     Navigator.pushNamed(context, '/organizations'); // Navigate to Home
  //   } else if (index == 1) {
  //     // Navigator.pushNamed(context, '/favorites'); // Navigate to Favorites
  //   } else if (index == 2) {
  //     // Navigator.pushNamed(context, '/settings'); // Navigate to Settings
  //   }
  // }

  void _showThemeSelectionModal(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    final currentMode = themeNotifier.themeMode;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('System Default'),
                leading: Radio<ThemeMode>(
                  value: ThemeMode.system,
                  groupValue: currentMode,
                  onChanged: null,
                ),
                onTap: () {
                  themeNotifier.setThemeMode(ThemeMode.system);
                  Navigator.pop(context); // Close the modal
                },
              ),
              ListTile(
                title: const Text('Always Light'),
                leading: Radio<ThemeMode>(
                  value: ThemeMode.light,
                  groupValue: currentMode,
                  onChanged: null,
                ),
                onTap: () {
                  themeNotifier.setThemeMode(ThemeMode.light);
                  Navigator.pop(context); // Close the modal
                },
              ),
              ListTile(
                title: const Text('Always Dark'),
                leading: Radio<ThemeMode>(
                  value: ThemeMode.dark,
                  groupValue: currentMode,
                  onChanged: null,
                ),
                onTap: () {
                  themeNotifier.setThemeMode(ThemeMode.dark);
                  Navigator.pop(context); // Close the modal
                },
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Profile Section
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: const Text('John Doe'),
            subtitle: const Text('johndoe@example.com'),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Handle edit profile
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Edit profile tapped!')),
                );
              },
            ),
          ),
          const Divider(),

          // Theme Settings Section
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Theme Settings'),
            subtitle: const Text('System Default, Light, Dark'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              _showThemeSelectionModal(
                  context); // Open modal for theme selection
            },
          ),
          const Divider(),

          // Account Settings
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Account Settings'),
            onTap: () {
              // Navigate to account settings page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Account settings tapped!')),
              );
            },
          ),
          const Divider(),

          // Notifications
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notification Settings'),
            onTap: () {
              // Navigate to notification settings page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notification settings tapped!')),
              );
            },
          ),
          const Divider(),

          // Help and Support
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help & Support'),
            onTap: () {
              // Navigate to help and support page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Help & Support tapped!')),
              );
            },
          ),
          const Divider(),

          // Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              // Handle logout
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   // currentIndex: 2, // Index for the Settings Page
      //   // onTap: (index) {
      //   //   if (index == 0) {
      //   //     Navigator.pushNamed(context, '/organizations'); // Navigate to Home
      //   //   } else if (index == 1) {
      //   //     // Navigator.pushNamed(context, '/favorites'); // Navigate to Favorites
      //   //   } else if (index == 2) {
      //   //     // Stay on Settings Page
      //   //   }
      //   // },
      //   currentIndex: _currentIndex, // Highlight the active tab
      //   //TODO: ontapping the selected screen icon again, just go to the top of the screen.
      //   onTap: _onTabTapped,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.star),
      //       label: 'Favorites',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: 'Settings',
      //     ),
      //   ],
      // ),
    );
  }
}
