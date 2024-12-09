import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OrganizationState extends ChangeNotifier {
  // Fields
  bool isLoading = true;
  bool showWelcomeOverlay = true;
  String searchQuery = '';
  String selectedCategory = '';
  int currentIndex = 0;
  String userName = 'Salil'; // For WelcomePage
  List<Map<String, dynamic>> organizations = [];
  List<Map<String, dynamic>> favoriteOrganizations = [];

  bool get hasFavorites => favoriteOrganizations.isNotEmpty;
  Map<String, List<Map<String, dynamic>>> groupedOrganizations = {};
  Map<String, GlobalKey> sectionKeys = {};
  double alphabetTopOffset = 0.0;
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  OrganizationState() {
    fetchOrganizations();
    // scrollController.addListener(handleScroll);
  }

  // Fetch Organizations
  Future<void> fetchOrganizations() async {
    const String url =
        'http://10.0.2.2:3000/schools'; // Replace with your API endpoint

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        organizations = jsonData.map((data) {
          return {
            'name': data['name'] ?? '',
            'type': data['type'] ?? '',
            'location': data['location'] ?? '',
            'image': data['image'] ?? '',
          };
        }).toList();

        groupOrganizations();
        isLoading = false;
      } else {
        throw Exception('Failed to load organizations from API');
      }
    } catch (e) {
      print('Error fetching organizations: $e');
      isLoading = false; // Handle error by stopping the loader
    } finally {
      debugPrint('Favorite Organizations: $favoriteOrganizations');
      isLoading = false;
      notifyListeners();
    }
  }

  void groupOrganizations() {
    groupedOrganizations.clear();
    sectionKeys.clear();

    // Filter organizations by search query
    final filteredOrganizations = organizations.where((org) {
      final matchesSearch =
          org['name'].toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory =
          selectedCategory.isEmpty || org['type'] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    // Group organizations by their first letter
    for (var org in filteredOrganizations) {
      final String letter = org['name'][0].toUpperCase();
      if (!groupedOrganizations.containsKey(letter)) {
        groupedOrganizations[letter] = [];
        sectionKeys[letter] = GlobalKey();
      }
      groupedOrganizations[letter]!.add(org);
    }

    notifyListeners();
  }

  // Update Search Query
  void updateSearchQuery(String query) {
    searchQuery = query;
    groupOrganizations(); // Re-filter organizations based on the query
    notifyListeners();
  }

  // Hide Welcome Overlay
  void hideWelcomeOverlay() {
    showWelcomeOverlay = false;
    notifyListeners();
  }

  // Update Selected Category
  void updateSelectedCategory(String category) {
    selectedCategory = category;
    groupOrganizations(); // Re-filter organizations based on the category
    notifyListeners();
  }

  // void addToFavorites(Map<String, String> org) {
  //   if (favoriteOrganizations.length >= 3) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('You can only select up to 3 favorite organizations.'),
  //       ),
  //     );
  //     return;
  //   }

  //   setState(() {
  //     favoriteOrganizations.add(org);
  //   });
  // }
  void addFavorite(dynamic org) {
    // Parse the string input if necessary
    Map<String, dynamic> parsedOrg;
    if (org is String) {
      try {
        parsedOrg = json.decode(org);
      } catch (e) {
        print('Error parsing string: $e');
        return;
      }
    } else if (org is Map<String, dynamic>) {
      parsedOrg = org;
    } else {
      throw Exception('Invalid input type for addFavorite');
    }

    // Check if the organization is already in favorites
    debugPrint('Adding to favorites: $parsedOrg');
    if (!favoriteOrganizations.any((fav) => fav['name'] == parsedOrg['name'])) {
      favoriteOrganizations.add({
        'name': parsedOrg['name'] ?? '',
        'location': parsedOrg['location'] ?? '',
        'image': parsedOrg['image'] ?? '',
      });
      notifyListeners();
    }
  }

  // Remove from Favorites
  void removeFavorite(Map<String, dynamic> org) {
    debugPrint('Removing from favorites: $org');
    favoriteOrganizations.removeWhere((fav) => fav['name'] == org['name']);
    notifyListeners();
  }

  void setInitialAlphabetOffset(BuildContext context) {
    final double categoriesOffset = MediaQuery.of(context).size.height * 0.2;

    if (alphabetTopOffset != categoriesOffset) {
      alphabetTopOffset = categoriesOffset;
      debugPrint('Alphabet top offset set to: $alphabetTopOffset');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  void initialize(BuildContext context) {
    setInitialAlphabetOffset(context);
  }

  // Handles scroll behavior for the alphabetical scrollbar
  void handleScroll(BuildContext context) {
    final double offset = scrollController.offset;

    // Calculate the point where the scrollbar should stop moving (middle of the screen)
    final double maxTopOffset = MediaQuery.of(context).size.height * 0.25;

    // Calculate the point where the scrollbar should start moving
    final double startingOffset = MediaQuery.of(context).size.height * 0.35;

    if (offset < startingOffset) {
      alphabetTopOffset = startingOffset;
    } else if (offset > maxTopOffset) {
      alphabetTopOffset = maxTopOffset;
    } else {
      alphabetTopOffset = offset;
    }
    notifyListeners();
  }

  // Scroll to a specific letter section
  void scrollToLetter(String letter) {
    if (sectionKeys.containsKey(letter)) {
      final context = sectionKeys[letter]!.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: 0.0,
        );
      }
    }
  }

  // // Handle Bottom Navigation
  // void onTabTapped(int index, BuildContext context,
  //     List<Map<String, dynamic>> favoriteOrganizations) {
  //   currentIndex = index;
  //   notifyListeners();
  //   if (index == 1) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => FavoritesPage(
  //           favoriteOrganizations: favoriteOrganizations,
  //            onFavoritesUpdated: (updatedFavorites) {
  //               // Sync updates with the global list
  //               setState(() {
  //                 favoriteOrganizations.clear();
  //                 favoriteOrganizations.addAll(updatedFavorites);
  //               });
  //             },
  //         ),
  //       ),
  //     );
  //     // Navigator.pushNamed(context, '/favorites');
  //   } else if (index == 2) {
  //     Navigator.pushNamed(context, '/settings');
  //   }
  // }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
