import 'package:flutter/material.dart';

class GarageLayoutPage extends StatefulWidget {
  const GarageLayoutPage({Key? key}) : super(key: key);

  @override
  State<GarageLayoutPage> createState() => _GarageLayoutPageState();
}

class _GarageLayoutPageState extends State<GarageLayoutPage> {
  String? selectedSpot;
  String? reservedSpot;
  String? selectedParkingType;
  int? selectedFloor;

  final List<Map<String, dynamic>> parkingSpots = List.generate(12, (index) {
    const types = ['Handicap', 'Motorcycle', 'Compact', 'Standard'];
    return {
      'spot': 'Parking Spot ${index + 1}',
      'type': types[index % 4],
      'floor': (index ~/ 4) + 1,
    };
  });

  List<Map<String, dynamic>> get filteredSpots {
    return parkingSpots.where((spot) {
      final matchesType =
          selectedParkingType == null || spot['type'] == selectedParkingType;
      final matchesFloor =
          selectedFloor == null || spot['floor'] == selectedFloor;
      return matchesType && matchesFloor;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Garage Layout',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => {Navigator.pushNamed(context, '/organizations')},
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade200,
            ),
            child: const Center(
              child: Text(
                "Image Placeholder\n(Replace with your asset directory)",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSpots.length,
              itemBuilder: (context, index) {
                final spot = filteredSpots[index];
                return _buildParkingSpotBox(
                  spot['spot'],
                  spot['type'],
                  spot['floor'],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => _showFilterPopup(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black),
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Filter',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedSpot == null) {
                    _showError(context, 'Please select a spot first!');
                  } else {
                    if (reservedSpot == selectedSpot) {
                      _unreserveSpot();
                    } else if (reservedSpot != null) {
                      _showConfirmationPopup(context, selectedSpot!);
                    } else {
                      _reserveSpot(selectedSpot!);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black),
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  reservedSpot == selectedSpot
                      ? 'Unreserve Spot'
                      : 'Reserve Spot',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParkingSpotBox(String title, String type, int floor) {
    final icons = {
      'Handicap': '♿',
      'Motorcycle': '🏍️',
      'Compact': '🚗',
      'Standard': '🅿️',
    };

    final isSelected = selectedSpot == title;
    final isReserved = reservedSpot == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSpot = selectedSpot == title ? null : title;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isReserved ? Colors.green.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.black12,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              icons[type]!,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isReserved ? Colors.green : Colors.black,
              ),
            ),
            const Spacer(),
            Text(
              isReserved ? 'Selected' : 'Floor $floor',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isReserved ? Colors.green : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterPopup(BuildContext context) {
    String? tempSelectedParkingType = selectedParkingType;
    int? tempSelectedFloor = selectedFloor;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Filters',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('Floor'),
                    subtitle: Text(
                      tempSelectedFloor == null
                          ? 'All'
                          : 'Floor $tempSelectedFloor',
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              3,
                              (index) => ListTile(
                                title: Text('Floor ${index + 1}'),
                                onTap: () {
                                  setState(() {
                                    tempSelectedFloor = index + 1;
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Parking Type'),
                    subtitle: Text(
                      tempSelectedParkingType ?? 'All',
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: const Text('♿ Handicap'),
                                onTap: () {
                                  setState(() {
                                    tempSelectedParkingType = 'Handicap';
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('🏍️ Motorcycle'),
                                onTap: () {
                                  setState(() {
                                    tempSelectedParkingType = 'Motorcycle';
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('🚗 Compact'),
                                onTap: () {
                                  setState(() {
                                    tempSelectedParkingType = 'Compact';
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('🅿️ Standard'),
                                onTap: () {
                                  setState(() {
                                    tempSelectedParkingType = 'Standard';
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedParkingType = tempSelectedParkingType;
                              selectedFloor = tempSelectedFloor;
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Colors.black),
                          ),
                          child: const Text(
                            'Apply',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              selectedParkingType = null;
                              selectedFloor = null;
                            });
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Clear',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((_) =>
        setState(() {})); // Trigger a refresh when filter dialog is closed.
  }

  void _reserveSpot(String spot) {
    setState(() {
      reservedSpot = spot;
    });
  }

  void _unreserveSpot() {
    setState(() {
      reservedSpot = null;
    });
  }

  void _showConfirmationPopup(BuildContext context, String spot) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Reservation'),
          content: Text('Do you want to reserve $spot?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _reserveSpot(spot);
                Navigator.pop(context);
              },
              child: const Text('Reserve'),
            ),
          ],
        );
      },
    );
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
