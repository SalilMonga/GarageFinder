import 'package:flutter/material.dart';

class ParkingHeader extends StatelessWidget {
  const ParkingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16.0),
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isDarkMode ? Colors.grey[850] : Colors.grey[200],
      ),
      child: const Center(
        child: Text(
          "Image Placeholder\n(Replace with your asset directory)",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
