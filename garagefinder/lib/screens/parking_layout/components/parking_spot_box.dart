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
              ? theme.colorScheme.primary
                  .withOpacity(0.2) // Subtle primary background
              : theme.colorScheme.surface, // Default background
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outline, // Highlight border if selected
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              _getIcon(type),
              style: TextStyle(
                fontSize: 24,
                color: isReserved
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface,
              ),
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

  // Get icon based on parking type
  String _getIcon(String type) {
    const icons = {
      'Handicap': '♿',
      'Motorcycle': '🏍️',
      'Compact': '🚗',
      'Standard': '🅿️',
    };
    return icons[type] ?? '🅿️';
  }
}
