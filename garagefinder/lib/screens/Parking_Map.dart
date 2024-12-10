// ignore: file_names
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../components/theme_notifier.dart';
import '../components/primary_button.dart';
import 'organization_layout/components/organization_state.dart';

class ParkingMap extends StatefulWidget {
  final String? schoolName;
  final String? schoolId;

  const ParkingMap({super.key, this.schoolName, this.schoolId});

  @override
  _ParkingMapState createState() => _ParkingMapState();
}

class _ParkingMapState extends State<ParkingMap> {
  final Map<String, Marker> _markers = {};
  late GoogleMapController _mapController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final organizationState =
          Provider.of<OrganizationState>(context, listen: false);
      await organizationState.fetchOrganizations(); // Ensure data is fetched
    });
  }

  Future<void> _initializeMap() async {
    final organizationState =
        Provider.of<OrganizationState>(context, listen: false);
    final List<Map<String, dynamic>> organizations =
        organizationState.organizations;
    print('Organizations in initilizeMap: $organizations');
    if (organizations.isNotEmpty) {
      _loadMarkers(organizations);
      _centerMapOnSchool(organizations);
    } else {
      _showErrorState('No data available from the backend.');
    }
  }

  void _loadMarkers(List<Map<String, dynamic>> organizations) {
    setState(() {
      _markers.clear();
      for (final org in organizations) {
        final garages = org['garages'] ?? [];
        if (garages.isEmpty) continue;

        for (final garage in garages) {
          final lat = (garage['lat'] as num).toDouble(); // Cast to double
          final long = (garage['long'] as num).toDouble(); // Cast to double

          final marker = Marker(
            markerId: MarkerId('${org['name']}_${garage['name']}'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(
              title: garage['name'],
              snippet:
                  '${garage['address']} - Capacity: ${garage['capacity'] ?? 'Unknown'}',
            ),
          );
          _markers[garage['name']] = marker;
        }
      }
    });
  }

  void _centerMapOnSchool(List<Map<String, dynamic>> organizations) {
    final schoolIdentifier = widget.schoolName ?? widget.schoolId;
    if (schoolIdentifier == null) {
      _showErrorState('School identifier is missing.');
      return;
    }

    final school = organizations.firstWhere(
      (org) =>
          org['name'] == schoolIdentifier ||
          org['id'].toString() == schoolIdentifier,
      orElse: () => {},
    );

    if (_mapController == null) {
      print('MapController is not initialized yet.');
      return; // Skip until the controller is ready
    }

    if (school.isNotEmpty && school['lat'] != null && school['long'] != null) {
      final lat = (school['lat'] as num).toDouble(); // Cast to double
      final long = (school['long'] as num).toDouble(); // Cast to double

      _mapController.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(lat, long),
        ),
      );
    } else {
      _showErrorState('School not found or incomplete data.');
    }
  }

  void _showErrorState(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking Map'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(),
            _buildMapSection(),
            _buildButtonsSection(),
            _buildAdditionalInfoSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: ThemeNotifier.lightUnselectedItemColor,
            child:
                Icon(Icons.directions_car, color: ThemeNotifier.darkTextColor),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.schoolName ?? 'Parking Map',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'View Parking Locations',
                style: Theme.of(context).textTheme.bodyMedium,
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
            target: LatLng(34.241, -118.528), // Default fallback position
            zoom: 15,
          ),
          onMapCreated: (controller) {
            _mapController = controller; // Initialize the controller
            _initializeMap(); // Re-run map initialization after the controller is ready
          },
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
          const SizedBox(height: 8),
          PrimaryButton(
            text: 'Navigate to Garage Layout',
            onPressed: () => Navigator.pushNamed(
              context,
              '/garage',
              arguments: {
                'schoolName': widget.schoolName,
                'schoolId': widget.schoolId,
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfoSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Additional Info',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Parking Rates',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const Text(
                      'Rates are based on location',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: Column(
                  children: [
                    Text(
                      'Check School Website',
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
