import 'package:flutter/material.dart';
import 'parking_spot_box.dart';

class ParkingSpotList extends StatelessWidget {
  final List<Map<String, dynamic>> spots;
  final String? selectedSpot;
  final String? reservedSpot;
  final void Function(String spot) onSpotSelected;

  const ParkingSpotList({
    super.key,
    required this.spots,
    required this.selectedSpot,
    required this.reservedSpot,
    required this.onSpotSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: spots.length,
      itemBuilder: (context, index) {
        final spot = spots[index];
        return ParkingSpotBox(
          title: spot['spot'],
          type: spot['type'],
          floor: spot['floor'],
          isSelected: selectedSpot == spot['spot'],
          isReserved: reservedSpot == spot['spot'],
          onTap: () => onSpotSelected(spot['spot']),
        );
      },
    );
  }
}
