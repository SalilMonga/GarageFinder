import 'package:flutter/material.dart';
import 'package:garagefinder/screens/organization_layout/components/organization_state.dart';
import 'package:garagefinder/screens/organization_layout/components/welcome_page.dart';
import 'package:provider/provider.dart';
import 'components/search_bar.dart';
import 'components/organization_list.dart';
import 'components/favorite_organizations_list_cards.dart';
import 'components/category_button_row.dart';
import 'components/alpha_scroll.dart';

class OrganizationsPage extends StatefulWidget {
  const OrganizationsPage({super.key});

  @override
  State<OrganizationsPage> createState() => _OrganizationsPageState();
}

class _OrganizationsPageState extends State<OrganizationsPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<OrganizationState>();
      state.initialize(context); // Initialize the state
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<OrganizationState>();
    state.initialize(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organizations'),
      ),
      body: Stack(
        children: [
          state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  controller: state.scrollController,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search Bar
                      CustomSearchBar(
                        controller: state.searchController,
                        focusNode: state.searchFocusNode,
                        onChanged: (value) => state.updateSearchQuery(value),
                        onClear: () {
                          state.searchController.clear();
                          state.updateSearchQuery('');
                        },
                      ),
                      const SizedBox(height: 16),

                      // Favorite Organizations
                      const Text(
                        'Favorite Organizations',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      FavoriteOrganizations(
                        favoriteOrganizations: state.favoriteOrganizations
                            .map((org) => org.map(
                                  (key, value) => MapEntry(
                                    key,
                                    value.toString(),
                                  ),
                                ))
                            .toList(),
                        onRemoveFavorite: state.removeFavorite,
                      ),

                      const SizedBox(height: 16),

                      // Categories
                      const Text(
                        'Categories',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      CategoryButtonRow(
                        selectedCategory: state.selectedCategory,
                        onCategorySelected: state.updateSelectedCategory,
                      ),

                      const SizedBox(height: 16),

                      // All Organizations
                      const Text(
                        'All Organizations',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      OrganizationList(
                        groupedOrganizations: state.groupedOrganizations,
                        sectionKeys: state.sectionKeys,
                        onFavoritesUpdated: (favorites) {
                          state.favoriteOrganizations =
                              favorites.cast<Map<String, dynamic>>();
                          state.notifyListeners();
                        },
                      ),
                    ],
                  ),
                ),
          Positioned(
            top: state.alphabetTopOffset,
            right: -18,
            child: SizedBox(
              width: 30,
              child: AlphabeticalScrollbar(
                alphabet: state.groupedOrganizations.keys.toList()..sort(),
                onLetterTap: (String letter) {
                  state.scrollToLetter(letter);
                },
              ),
            ),
          ),
          if (state.showWelcomeOverlay)
            WelcomePage(
              firstName: state.userName,
              onAnimationComplete: () {
                state.hideWelcomeOverlay();
              },
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: state.currentIndex,
        onTap: (index) => state.onTabTapped(index, context),
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
