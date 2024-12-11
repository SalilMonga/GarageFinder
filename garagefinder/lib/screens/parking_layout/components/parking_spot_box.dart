import 'package:flutter/material.dart';

class ParkingSpotBox extends StatelessWidget {
  final String title;
  final String type;
  final int floor;
  final bool isSelected;
  final bool isReserved;
  final VoidCallback onTap;

  const ParkingSpotBox({
    super.key,
    required this.title,
    required this.type,
    required this.floor,
    required this.isSelected,
    required this.isReserved,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isReserved
              ? theme.colorScheme.primary.withOpacity(0.15) // Reserved look
              : isSelected
                  ? theme.colorScheme.primary.withOpacity(0.1) // Selected look
                  : theme.brightness == Brightness.dark
                      ? Colors.grey[850] // Dark mode default
                      : Colors.grey[300], // Light mode default
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.5),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            if (!isSelected && !isReserved)
              const BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 6,
              ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              _getIcon(type), // Use the updated _getIcon function
              size: 24,
              color: isReserved
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isReserved
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface,
                ),
              ),
            ),
            Text(
              isReserved ? 'Reserved' : 'Floor $floor',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isReserved
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'Handicap':
        return Icons.accessible; // Wheelchair accessible icon
      case 'Motorcycle':
        return Icons.two_wheeler; // Motorcycle icon
      case 'Compact':
        return Icons.local_parking; // Parking "P" icon
      default:
        return Icons.directions_car; // Default car icon
    }
  }
}
