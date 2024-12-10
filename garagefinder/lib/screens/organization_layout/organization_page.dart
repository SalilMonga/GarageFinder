import 'package:flutter/material.dart';
// import 'package:garagefinder/screens/favorites_page.dart';
import 'package:garagefinder/screens/organization_layout/components/organization_state.dart';
import 'package:garagefinder/screens/organization_layout/components/welcome_page.dart';
import 'package:provider/provider.dart';
import 'components/search_bar.dart';
import 'components/organization_list.dart';
import 'components/favorite_org_cards.dart';
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

  // int currentIndex = 0; // Track the current index of the bottom nav
  // // List<Map<String, String>> favoriteOrganizations = []; // Global favorites list
  // // Handle Bottom Navigation
  // void onTabTapped(int index, BuildContext context,
  //     List<Map<String, dynamic>> favoriteOrganizations) {
  //   currentIndex = index;
  //   // notifyListeners();
  //   if (index == 1) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const FavoritesPage(

  //             ),
  //       ),
  //     );
  //     // Navigator.pushNamed(context, '/favorites');
  //   } else if (index == 2) {
  //     // Navigator.pushNamed(context, '/settings');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<OrganizationState>();
    final pinnedFavorites = state.getPinnedFavorites();
    // debugPrint(
    //     'Favorite Organizations in build: ${state.favoriteOrganizations}');

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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (pinnedFavorites.isEmpty)
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.favorite_border_rounded,
                                    size: 48,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'No Favorite Organizations',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          // we spread out the array as we need mutliple children and we want them to render individually
                          else ...[
                            const SizedBox(
                                height: 16), // Add spacing before the card
                            FavoriteOrganizationCard(
                              favoriteOrganizations: pinnedFavorites,
                              onRemoveFavorite: state.removeFavorite,
                            ),
                          ],
                        ],
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
                      if (!state.showWelcomeOverlay)
                        OrganizationList(
                          groupedOrganizations: state.groupedOrganizations,
                          sectionKeys: state.sectionKeys,
                          favoriteOrganizations: state.favoriteOrganizations,
                          onFavoritesUpdated: (favorites) {
                            state.favoriteOrganizations =
                                favorites.cast<Map<String, dynamic>>();
                            // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                            state.notifyListeners();
                          },
                          onOrganizationTap: (org) {
                            Navigator.pushNamed(
                              context,
                              '/parking',
                              arguments: {
                                'schoolName': org['name'],
                                'schoolId': org[
                                    'id'], // Ensure 'id' is part of the org data
                              },
                            );
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
    );
  }
}
