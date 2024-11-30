import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../components/locations.dart' as locations;

class ParkingMap extends StatefulWidget {
  const ParkingMap({super.key});

  @override
  _ParkingMapState createState() => _ParkingMapState();
}

class _ParkingMapState extends State<ParkingMap> {
  // GoogleMapController? _mapController;
  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    // setState(() {
    //   _mapController = controller;
    // });

    try {
      final parkingGarages = await locations.getParkingGarages();
      setState(() {
        _markers.clear();
        for (final garage in parkingGarages.garages) {
          final marker = Marker(
            markerId: MarkerId(garage.name),
            position: LatLng(garage.lat, garage.lng),
            infoWindow: InfoWindow(
              title: garage.name,
              snippet: garage.address,
            ),
          );
          _markers[garage.name] = marker;
        }
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading parking garages: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSUN Parking Map'),
        // backgroundColor: Colors.white,
        // foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(),
            _buildMapSection(),
            _buildButtonsSection(),
            _buildParkingStructuresSection(),
            _buildAdditionalInfoSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.grey,
            child: Icon(Icons.directions_car, color: Colors.white),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CSUN Parking',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Parking Structures Map',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: SizedBox(
        height: 200,
        child: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(34.241, -118.528), // Centered around CSUN
            zoom: 15,
          ),
          onMapCreated: _onMapCreated,
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }

  Widget _buildButtonsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          // ElevatedButton(
          //   onPressed: () {},
          //   child: const Text('Filter Map'),
          // ),
          // const SizedBox(height: 8),
          // ElevatedButton(
          //   onPressed: () {},
          //   child: const Text('Share Map'),
          // ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => {Navigator.pushNamed(context, '/garage')},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            child: const Text(
              'Navigate to CSUN',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParkingStructuresSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Parking Structures',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildParkingCard('Open', 'Parking Structure A', '500'),
              const SizedBox(width: 16),
              _buildParkingCard('Full', 'Parking Structure B', '300'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildParkingCard(String status, String name, String capacity) {
    return Expanded(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                color: Colors.grey.shade200,
                child: const Center(
                  child: Text(
                    'Image of parking structure',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Capacity: $capacity',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Text(
                status,
                style: TextStyle(
                  fontSize: 14,
                  color: status == 'Open' ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdditionalInfoSection() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Additional Info',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Parking Rates',
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      'Rates are based on location',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Check CSUN website',
                      style: TextStyle(fontSize: 14),
                    ),
                    Icon(Icons.info, color: Colors.blue),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
