import 'package:flutter/material.dart';

class FavoriteOrganizationCard extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteOrganizations;
  final Function(Map<String, dynamic>) onRemoveFavorite;

  const FavoriteOrganizationCard({
    super.key,
    required this.favoriteOrganizations,
    required this.onRemoveFavorite,
  });

  @override
  Widget build(BuildContext context) {
    print('Favorite Organizations: $favoriteOrganizations');

    return SizedBox(
      height: 150, // Set a fixed height for the card layout
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: favoriteOrganizations.length,
        itemBuilder: (context, index) {
          final org = favoriteOrganizations[index];

          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Stack(
              children: [
                // Organization Card
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Organization Image
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        child: org['image'] != null && org['image'].isNotEmpty
                            ? Image.network(
                                org['image'],
                                height: 80,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  'assets/images/ducati.jpg',
                                  height: 80,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Image.asset(
                                'assets/images/placeholder.jpg',
                                height: 80,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                      ),
                      // Organization Details
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              org['name'] ?? '',
                              style: Theme.of(context).textTheme.bodyLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              org['location'] ?? 'Unknown Location',
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
