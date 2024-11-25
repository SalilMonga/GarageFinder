import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../components/locations.dart' as locations;

class MapTestScreen extends StatefulWidget {
  const MapTestScreen({super.key});

  @override
  State<MapTestScreen> createState() => _MapTestScreenState();
}

class _MapTestScreenState extends State<MapTestScreen> {
  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
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
        title: const Text('Map Test Screen'),
        elevation: 2,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(34.241, -118.528), // Centered around CSUN
          zoom: 15,
        ),
        markers: _markers.values.toSet(),
      ),
    );
  }
}
