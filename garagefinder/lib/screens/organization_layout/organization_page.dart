import 'package:flutter/material.dart';
import 'package:garagefinder/screens/organization_layout/components/welcome_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'components/alpha_scroll.dart';
import 'components/category_button_row.dart';
import 'components/featured_organizations.dart';
import 'components/organization_list.dart';
import 'components/search_bar.dart';

class OrganizationsPage extends StatefulWidget {
  const OrganizationsPage({super.key});

  @override
  State<OrganizationsPage> createState() => _OrganizationsPageState();
}

class _OrganizationsPageState extends State<OrganizationsPage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0; // Track the currently selected tab

  String _searchQuery = '';
  String _selectedCategory = ''; // Track selected category
  final FocusNode _searchFocusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  //loading for API call wait
  bool _isLoading = true;
  bool _showWelcomeOverlay = true;
  String _userName = 'Salil';
  //Flutter parses JSON data into dynamic type.
  List<Map<String, dynamic>> _organizations = [];
  final Map<String, List<Map<String, dynamic>>> _groupedOrganizations = {};
  List<String> _alphabet = [];
  double _alphabetTopOffset = 0.0;
  final Map<String, GlobalKey> _sectionKeys = {};

  @override
  void initState() {
    super.initState();
    _fetchOrganizations(); // Fetch organizations on page load
    // Add listener to scrollController
    // Add listener to scrollController
    _scrollController.addListener(_handleScroll);

    // Set the initial position of the scrollbar to be below the "Categories" section
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setInitialAlphabetOffset();
    });

    // _animationController = AnimationController(
    //   vsync: this,
    //   duration:
    //       const Duration(seconds: 2), // Duration for the shrinking animation
    // );

    // // Trigger the shrink animation after a short delay
    // Future.delayed(const Duration(seconds: 1), () {
    //   _animationController.forward().then((_) {
    //     setState(() {
    //       _showWelcomeOverlay = false; // Hide the overlay after the animation
    //     });
    //   });
    // });
  }

  void _setInitialAlphabetOffset() {
    final double categoriesOffset = MediaQuery.of(context).size.height *
        0.3; // Estimate height of Categories
    setState(() {
      _alphabetTopOffset = categoriesOffset;
    });
  }

  void _handleScroll() {
    setState(() {
      // Calculate new position based on the scroll
      final double offset = _scrollController.offset;

      // Calculate the point where the scrollbar should stop moving (middle of the screen)
      final double maxTopOffset =
          MediaQuery.of(context).size.height * 0.25; // 50% from top

      // Calculate the point where the scrollbar should start moving
      final double startingOffset =
          MediaQuery.of(context).size.height * 0.25; // 25% from top

      // Ensure the scrollbar starts under "Categories" and moves until it reaches the middle of the screen
      if (offset < startingOffset) {
        _alphabetTopOffset = startingOffset;
      } else if (offset > maxTopOffset) {
        _alphabetTopOffset = maxTopOffset;
      } else {
        _alphabetTopOffset = offset;
      }
    });
  }

  void _scrollToLetter(String letter) {
    // Make sure the letter is present in sectionKeys
    if (_sectionKeys.containsKey(letter)) {
      final context = _sectionKeys[letter]!.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: 0.0, // Aligns the item close to the top of the screen
        );
      }
    }
  }

  Future<void> _fetchOrganizations() async {
    try {
      // const url = 'http://localhost:3000/schools';
      const url = 'http://10.0.2.2:3000/schools';

      print('Sending GET request to: $url');

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        print('Received data: $jsonData');
        setState(() {
          _organizations = jsonData.map((data) {
            return {
              'name': data['name'] ?? '',
              'type': data['type'] ?? '',
              'location': data['location'] ?? '',
              'image': data['image'] ?? '',
            };
          }).toList();
          _groupOrganizations(); // Load initial page
          _isLoading = false;
        });
      } else {
        // Handle errors (e.g., show error message)
        print('Failed to load organizations');
        setState(() {
          _isLoading = false; // Set loading to false in case of error
        });
      }
    } catch (e) {
      // Handle exceptions (e.g., network errors)
      print('Error fetching organizations: $e');
      setState(() {
        _isLoading = false; // Set loading to false in case of error
      });
    }
  }

  void _groupOrganizations() {
    _groupedOrganizations.clear();
    _sectionKeys.clear();
    List<Map<String, dynamic>> filteredOrganizations = _filteredOrganizations;
    for (var org in filteredOrganizations) {
      String letter = org['name'][0].toUpperCase();
      if (!_groupedOrganizations.containsKey(letter)) {
        _groupedOrganizations[letter] = [];
        _sectionKeys[letter] = GlobalKey();
      }
      _groupedOrganizations[letter]!.add(org);
    }
    setState(() {
      _alphabet = _groupedOrganizations.keys.toList()..sort();
      // for (String letter in _alphabet) {
      //   _sectionKeys[letter] = GlobalKey();
      // }
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
  void dispose() {
    // _animationController.dispose();
    _scrollController.removeListener(_handleScroll);
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
      body: Stack(
        children: [
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search Bar
                      CustomSearchBar(
                        controller: searchController,
                        focusNode: _searchFocusNode,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                            _groupOrganizations();
                          });
                        },
                        onClear: () {
                          setState(() {
                            searchController.clear();
                            _searchQuery = "";
                            _selectedCategory = "";
                            _groupOrganizations();
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
                      const FeaturedOrganizations(),
                      // Categories
                      const SizedBox(height: 16),
                      const Text(
                        'Categories',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      CategoryButtonRow(
                        selectedCategory: _selectedCategory,
                        onCategorySelected: (String category) {
                          setState(() {
                            _selectedCategory = category;
                            _groupOrganizations(); // Update grouped list
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      // All Organizations
                      const Text(
                        'All Organizations',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      // Organization List
                      OrganizationList(
                        groupedOrganizations: _groupedOrganizations,
                        sectionKeys: _sectionKeys,
                      ),
                    ],
                  ),
                ),
          if (_showWelcomeOverlay)
            WelcomePage(
              firstName: _userName, // Pass the user's name
              onAnimationComplete: () {
                setState(() {
                  _showWelcomeOverlay =
                      false; // Remove the overlay after animation
                });
              },
            ),
          Positioned(
            top: _alphabetTopOffset,
            right: -18,
            child: SizedBox(
              width: 30,
              child: AlphabeticalScrollbar(
                alphabet: _alphabet,
                onLetterTap: (String letter) {
                  _scrollToLetter(letter);
                },
              ),
            ),
          ),
        ],
      ),
      // Bottom Navigation Bar
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
}
