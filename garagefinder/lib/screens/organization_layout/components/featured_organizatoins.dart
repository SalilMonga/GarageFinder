import 'package:flutter/material.dart';

class FeaturedOrganizations extends StatelessWidget {
  const FeaturedOrganizations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildFeaturedCard(
              context, 'Public University', 'Location: Los Angeles'),
          _buildFeaturedCard(
              context, 'Private University', 'Location: San Francisco'),
          _buildFeaturedCard(
              context, 'Community College', 'Location: San Diego'),
        ],
      ),
    );
  }

  Widget _buildFeaturedCard(
      BuildContext context, String title, String location) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/parking');
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
}
