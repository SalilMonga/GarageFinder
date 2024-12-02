import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrganizationsPage extends StatefulWidget {
  const OrganizationsPage({super.key});

  @override
  State<OrganizationsPage> createState() => _OrganizationsPageState();
}

class _OrganizationsPageState extends State<OrganizationsPage> {
  int _currentIndex = 0; // Track the currently selected tab

  String _searchQuery = '';
  String _selectedCategory = ''; // Track selected category
  final FocusNode _searchFocusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  // Flutter parses JSON data into dynamic type.
  List<Map<String, dynamic>> _organizations = [];
  Map<String, List<Map<String, dynamic>>> _groupedOrganizations = {};
  List<String> _alphabet = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchOrganizations(); // Fetch organizations on page load
  }

  Future<void> _fetchOrganizations() async {
    try {
      const url = 'http://10.0.2.2:3000/schools';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          _organizations = jsonData.map((data) {
            return {
              'name': data['name'] ?? '',
              'type': data['type'] ?? '',
              'location': data['location'] ?? '',
              'image': data['image'] ?? '',
            };
          }).toList();
          _groupOrganizations();
          _isLoading = false;
        });
      } else {
        // Handle errors (e.g., show error message)
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      // Handle exceptions (e.g., network errors)
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _groupOrganizations() {
    _groupedOrganizations.clear();
    for (var org in _filteredOrganizations) {
      String letter = org['name'][0].toUpperCase();
      if (!_groupedOrganizations.containsKey(letter)) {
        _groupedOrganizations[letter] = [];
      }
      _groupedOrganizations[letter]!.add(org);
    }
    setState(() {
      _alphabet = _groupedOrganizations.keys.toList()..sort();
    });
  }

  List<Map<String, dynamic>> get _filteredOrganizations {
    return _organizations.where((org) {
      final matchesSearch =
          org['name']!.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory =
          _selectedCategory.isEmpty || org['type'] == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchFocusNode
        .dispose(); // Clean up the focus node when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organizations'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Search Bar
                        TextField(
                          controller: searchController,
                          focusNode: _searchFocusNode,
                          decoration: InputDecoration(
                            hintText: 'Search for organizations',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      setState(() {
                                        searchController
                                            .clear(); // Clear the text field
                                        _searchQuery = "";
                                        _selectedCategory = "";
                                        _groupOrganizations(); // Update grouped list
                                      });
                                    },
                                  )
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onTap: () => _searchFocusNode.requestFocus(),
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                              _groupOrganizations(); // Update grouped list
                            });
                          },
                        ),
                        const SizedBox(height: 16),

                        // Featured Organizations
                        const Text(
                          'Featured Organizations',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 150,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              _buildFeaturedCard('Public University',
                                  'Location: Los Angeles', context),
                              _buildFeaturedCard('Private University',
                                  'Location: San Francisco', context),
                              _buildFeaturedCard('Community College',
                                  'Location: San Diego', context),
                            ],
                          ),
                        ),
                        // Categories
                        const SizedBox(height: 16),
                        const Text(
                          'Categories',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildCategoryButton('Public', Icons.school),
                            _buildCategoryButton('Private', Icons.home_work),
                            _buildCategoryButton(
                                'Community', Icons.account_balance),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // All Organizations
                        const Text(
                          'All Organizations',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),

                        // Grouped Organizations by Alphabet
                        const SizedBox(height: 16),
                        ..._alphabet
                            .map((letter) => _buildSection(letter))
                            .toList(),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 30,
                  alignment: Alignment.centerRight,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _alphabet.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _scrollToLetter(_alphabet[index]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Text(
                            _alphabet[index],
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Highlight the active tab
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
            Text(location, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  // Helper Widget for Category Button
  Widget _buildCategoryButton(String label, IconData icon) {
    final isSelected = _selectedCategory == label;
    return ElevatedButton.icon(
      onPressed: () {
        setState(() {
          _selectedCategory = isSelected ? '' : label;
        });
      },
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? Theme.of(context).colorScheme.primary
            : Colors.grey[200], // Dynamic background color
        foregroundColor:
            isSelected ? Colors.white : Colors.black, // Text/icon color
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildSection(String letter) {
    List<Map<String, dynamic>> organizations = _groupedOrganizations[letter]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          letter,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ...organizations
            .map(
                (org) => _buildOrganizationItem(org['name']!, org['location']!))
            .toList(),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildOrganizationItem(String name, String location) {
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

  void _scrollToLetter(String letter) {
    final index = _alphabet.indexOf(letter);
    if (index != -1) {
      _scrollController.animateTo(
        index * 100.0, // Adjust scroll offset based on your item height
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the current index
    });

    // Navigate based on the tapped index
    if (index == 0) {
      // Navigator.pushNamed(context, '/organizations'); // Navigate to Home
    } else if (index == 1) {
      // Navigator.pushNamed(context, '/garage'); // Navigate to Favorites
    } else if (index == 2) {
      Navigator.pushNamed(context, '/settings'); // Navigate to Settings
    }
  }
}
