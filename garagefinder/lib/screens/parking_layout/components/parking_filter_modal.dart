import 'package:flutter/material.dart';
import 'package:garagefinder/components/primary_button.dart';

class ParkingFilterModal extends StatelessWidget {
  final String? selectedParkingType;
  final int? selectedFloor;
  final void Function(String? type, int? floor) onApplyFilter;
  final VoidCallback onClearFilter;

  const ParkingFilterModal({
    super.key,
    this.selectedParkingType,
    this.selectedFloor,
    required this.onApplyFilter,
    required this.onClearFilter,
  });

  // Helper Function to Show Floor Selection Modal
  void _showFloorSelection(BuildContext context, StateSetter setState,
      int? currentFloor, void Function(int?) onFloorSelected) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            3,
            (index) => ListTile(
              title: Text('Floor ${index + 1}'),
              selected: currentFloor == (index + 1),
              onTap: () {
                onFloorSelected(index + 1);
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  // Helper Function to Show Parking Type Selection Modal
  void _showParkingTypeSelection(BuildContext context, StateSetter setState,
      String? currentType, void Function(String?) onTypeSelected) {
    final types = ['Handicap', 'Motorcycle', 'Compact', 'Standard'];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: types.map((type) {
            return ListTile(
              title: Text(type),
              selected: currentType == type,
              onTap: () {
                onTypeSelected(type);
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String? tempSelectedParkingType = selectedParkingType;
    int? tempSelectedFloor = selectedFloor;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Filters',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Floor Selection
              ListTile(
                title: const Text('Floor'),
                subtitle: Text(
                  tempSelectedFloor == null
                      ? 'All'
                      : 'Floor $tempSelectedFloor',
                ),
                onTap: () => _showFloorSelection(
                    context, setState, tempSelectedFloor, (floor) {
                  setState(() => tempSelectedFloor = floor);
                }),
              ),

              // Parking Type Selection
              ListTile(
                title: const Text('Parking Type'),
                subtitle: Text(
                  tempSelectedParkingType ?? 'All',
                ),
                onTap: () => _showParkingTypeSelection(
                    context, setState, tempSelectedParkingType, (type) {
                  setState(() => tempSelectedParkingType = type);
                }),
              ),

              const SizedBox(height: 16),

              // Apply and Clear Buttons
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      text: 'Apply',
                      onPressed: () {
                        onApplyFilter(
                            tempSelectedParkingType, tempSelectedFloor);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: PrimaryButton(
                      text: 'Clear',
                      isOutlined: true,
                      onPressed: () {
                        onClearFilter();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
