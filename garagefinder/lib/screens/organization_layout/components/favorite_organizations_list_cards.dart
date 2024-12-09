import 'package:flutter/material.dart';

class FavoriteOrganizations extends StatelessWidget {
  final List<Map<String, String>> favoriteOrganizations;
  final Function(Map<String, String>) onRemoveFavorite;

  const FavoriteOrganizations({
    super.key,
    required this.favoriteOrganizations,
    required this.onRemoveFavorite,
  });

  @override
  Widget build(BuildContext context) {
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
                        child: Image.network(
                          org['image'] ?? 'https://via.placeholder.com/150',
                          height: 80,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                            Icons.broken_image,
                            size: 80,
                            color: Colors.grey,
                          ),
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
                // Remove Button
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => onRemoveFavorite(org),
                    child: const CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 14,
                      child: Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
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
