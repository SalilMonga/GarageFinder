import 'package:flutter/material.dart';

class ParkingHeader extends StatelessWidget {
  final String imagePath;

  const ParkingHeader({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover, // Ensures the image fills the header area
        ),
      ),
    );
  }
}
