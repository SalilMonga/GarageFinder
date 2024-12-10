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
  Set<String> pinnedOrganizations = {};
  double alphabetTopOffset = 0.0;
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  OrganizationState() {
    print('OrganizationState created: ${DateTime.now()}');
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
    print('Running groupOrganizations at: ${DateTime.now()}');
    groupedOrganizations.clear();
    // sectionKeys.clear();

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
        // sectionKeys.putIfAbsent(
        //     letter, () => GlobalKey(debugLabel: 'SectionKey_$letter'));
        if (!sectionKeys.containsKey(letter)) {
          sectionKeys[letter] = GlobalKey();
        }
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

  void addFavorite(Map<String, dynamic> org) {
    print('Adding to fav: $org');
    if (!favoriteOrganizations.any((fav) => fav['name'] == org['name'])) {
      favoriteOrganizations.add({
        'name': org['name'] ?? '',
        'location': org['location'] ?? '',
        'image': org['image'] ?? '',
      });
      // Automatically pin the first 3 favorites
      if (favoriteOrganizations.length <= 3) {
        pinnedOrganizations.add(org['name'] ?? '');
      }
      print('Favorite orgs: $favoriteOrganizations');
      print('Pinned orgs: $pinnedOrganizations');
      notifyListeners();
    }
  }

  // Remove from Favorites
  void removeFavorite(Map<String, dynamic> org) {
    debugPrint('Removing from favorites: $org');
    favoriteOrganizations.removeWhere((fav) => fav['name'] == org['name']);
    pinnedOrganizations.remove(org['name']);
    notifyListeners();
  }

  void togglePin(String name, BuildContext context) {
    if (pinnedOrganizations.contains(name)) {
      pinnedOrganizations.remove(name);
    } else {
      if (pinnedOrganizations.length < 3) {
        pinnedOrganizations.add(name);
      } else {
        // Show a message when trying to pin more than 3 items
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You can only pin up to 3 organizations.'),
            duration: Duration(seconds: 2),
          ),
        );
        return; // Exit without adding
      }
    }
    notifyListeners();
  }

  List<Map<String, dynamic>> getPinnedFavorites() {
    return favoriteOrganizations
        .where((org) => pinnedOrganizations.contains(org['name']))
        .toList();
  }

  // Sort favorites based on criteria
  List<Map<String, dynamic>> getSortedFavorites(String sortOrder) {
    final sortedFavorites =
        List<Map<String, dynamic>>.from(favoriteOrganizations);

    if (sortOrder == 'Pinned') {
      sortedFavorites.sort((a, b) {
        final aPinned = pinnedOrganizations.contains(a['name']);
        final bPinned = pinnedOrganizations.contains(b['name']);
        if (aPinned && !bPinned) return -1;
        if (!aPinned && bPinned) return 1;
        return 0;
      });
    } else if (sortOrder == 'Name') {
      sortedFavorites
          .sort((a, b) => (a['name'] ?? '').compareTo(b['name'] ?? ''));
    }

    // For 'Recently Added', return in original order
    return sortedFavorites;
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

  void resetState() {
    // Clear all fields to their initial values
    isLoading = true;
    showWelcomeOverlay = true;
    searchQuery = '';
    selectedCategory = '';
    currentIndex = 0;
    organizations.clear();
    favoriteOrganizations.clear();
    groupedOrganizations.clear();
    sectionKeys.clear();
    pinnedOrganizations.clear();
    alphabetTopOffset = 0.0;
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
