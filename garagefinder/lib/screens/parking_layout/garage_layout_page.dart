import 'package:flutter/material.dart';
import 'components/parking_header.dart';
import 'components/parking_spot_list.dart';
import 'components/parking_buttons.dart';
import 'components/parking_filter_modal.dart';

class GarageLayoutPage extends StatefulWidget {
  const GarageLayoutPage({super.key});

  @override
  _GarageLayoutPageState createState() => _GarageLayoutPageState();
}

class _GarageLayoutPageState extends State<GarageLayoutPage> {
  String? selectedSpot; // To track selected spot
  String? reservedSpot; // To track reserved spot
  String? selectedParkingType; // To track selected parking type for filter
  int? selectedFloor; // To track selected floor for filter

  final List<Map<String, dynamic>> parkingSpots = List.generate(12, (index) {
    const types = ['Handicap', 'Motorcycle', 'Compact', 'Standard'];
    return {
      'spot': 'Parking Spot ${index + 1}',
      'type': types[index % 4],
      'floor': (index ~/ 4) + 1,
    };
  });

  List<Map<String, dynamic>> get filteredParkingSpots {
    return parkingSpots.where((spot) {
      final matchesType =
          selectedParkingType == null || spot['type'] == selectedParkingType;
      final matchesFloor =
          selectedFloor == null || spot['floor'] == selectedFloor;
      return matchesType && matchesFloor;
    }).toList();
  }

  void _onFilterPressed(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => ParkingFilterModal(
        selectedParkingType: selectedParkingType,
        selectedFloor: selectedFloor,
        onApplyFilter: (type, floor) {
          setState(() {
            selectedParkingType = type;
            selectedFloor = floor;
          });
        },
        onClearFilter: () {
          setState(() {
            selectedParkingType = null;
            selectedFloor = null;
          });
        },
      ),
    );
  }

  void _onReservePressed() {
    if (selectedSpot == null) {
      // If no spot is selected, show an error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a spot first!')),
      );
    } else if (reservedSpot == selectedSpot) {
      // If the selected spot is already reserved, unreserve it
      setState(() {
        reservedSpot = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Reservation for $selectedSpot has been removed!')),
      );
    } else {
      // Reserve the selected spot
      setState(() {
        reservedSpot = selectedSpot;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$selectedSpot has been reserved!')),
      );
    }
  }

  String _getReserveButtonLabel() {
    if (selectedSpot == null) {
      return 'Reserve Spot'; // Default state
    }
    return reservedSpot == selectedSpot ? 'Unreserve Spot' : 'Reserve Spot';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Garage Layout'),
        elevation: 0,
      ),
      body: Column(
        children: [
          const ParkingHeader(), // Display header
          Expanded(
            child: ParkingSpotList(
              spots: filteredParkingSpots,
              selectedSpot: selectedSpot,
              reservedSpot: reservedSpot,
              onSpotSelected: (spot) {
                // Update selected spot
                setState(() {
                  selectedSpot = spot;
                });
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding around buttons
        child: ParkingButtons(
          onFilterPressed: () => _onFilterPressed(context),
          onReservePressed: _onReservePressed,
          reserveButtonLabel: _getReserveButtonLabel(),
        ),
      ),
    );
  }
}
