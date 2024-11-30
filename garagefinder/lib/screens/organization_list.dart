import 'package:flutter/material.dart';
import 'package:garagefinder/components/primary_button.dart';

class OrganizationsPage extends StatefulWidget {
  const OrganizationsPage({super.key});

  @override
  State<OrganizationsPage> createState() => _OrganizationsPageState();
}

class _OrganizationsPageState extends State<OrganizationsPage> {
  int _currentIndex = 0; // Track the currently selected tab

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the current index
    });

    // Navigate based on the tapped index
    if (index == 0) {
      // Navigator.pushNamed(context, '/organizations'); // Navigate to Home
    } else if (index == 1) {
      //EXPERIMENTAL!
      // Navigator.pushNamed(context, '/garage'); // Navigate to Favorites
    } else if (index == 2) {
      Navigator.pushNamed(context, '/settings'); // Navigate to Settings
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchFocusNode = FocusNode();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organizations'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              focusNode: searchFocusNode,
              decoration: InputDecoration(
                hintText: 'Search for organizations',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onTap: () => searchFocusNode.requestFocus(),
            ),
            const SizedBox(height: 16),

            // Featured Organizations
            const Text(
              'Featured Organizations',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFeaturedCard(
                      'Public University', 'Location: Los Angeles', context),
                  _buildFeaturedCard(
                      'Private University', 'Location: San Francisco', context),
                  _buildFeaturedCard(
                      'Community College', 'Location: San Diego', context),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // All Organizations
            const Text(
              'All Organizations',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildOrganizationItem(
                'California State University, San Bernardino',
                'San Bernardino',
                context),
            _buildOrganizationItem(
                'California State University, Fresno', 'Fresno', context),
            _buildOrganizationItem('California State University, Long Beach',
                'Long Beach', context),
            _buildOrganizationItem('California State University, Northridge',
                'Favorite Organizations', context),

            const SizedBox(height: 16),

            // Categories
            const Text(
              'Categories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCategoryButton('Public', Icons.school),
                _buildCategoryButton('Private', Icons.home_work),
                _buildCategoryButton('Community', Icons.account_balance),
              ],
            ),
            const SizedBox(height: 16),

            // Buttons
            PrimaryButton(
              text: 'Share',
              isOutlined: true,
              onPressed: () {},
              fullWidth: true,
            ),
            const SizedBox(height: 8),
            PrimaryButton(
              text: 'More',
              isOutlined: true,
              onPressed: () {},
              fullWidth: true,
            ),
            const SizedBox(height: 8),
            PrimaryButton(
              text: 'Favorite',
              onPressed: () {},
              fullWidth: true,
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Highlight the active tab
        //TODO: ontapping the selected screen icon again, just go to the top of the screen.
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  // Helper Widget for Featured Card
  Widget _buildFeaturedCard(
      String title, String location, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/parking');
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Tapped on $title')),
        // );
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const Spacer(),
            Text(location),
          ],
        ),
      ),
    );
  }

  // Helper Widget for Organization Item
  Widget _buildOrganizationItem(
      String name, String location, BuildContext context) {
    return GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tapped on $name')),
          );
        },
        child: ListTile(
          leading: const Icon(Icons.school),
          title: Text(name),
          subtitle: Text(location),
          onTap: () {},
        ));
  }

  // Helper Widget for Category Button
  Widget _buildCategoryButton(String label, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.black,
      ),
    );
  }
}
