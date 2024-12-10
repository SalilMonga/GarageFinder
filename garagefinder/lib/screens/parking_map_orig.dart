// import 'package:flutter/material.dart';
// import 'package:garagefinder/components/theme_notifier.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../components/primary_button.dart';
// import '../components/locations.dart' as locations;

// class ParkingMap extends StatefulWidget {
//   final String? schoolName;
//   final String? schoolId;

//   const ParkingMap({super.key, this.schoolName, this.schoolId});

//   @override
//   _ParkingMapState createState() => _ParkingMapState();
// }

// class _ParkingMapState extends State<ParkingMap> {
//   final Map<String, Marker> _markers = {};

//   Future<void> _onMapCreated(GoogleMapController controller) async {
//     try {
//       final parkingGarages = await locations.getParkingGarages();
//       setState(() {
//         _markers.clear();
//         for (final garage in parkingGarages.garages) {
//           final marker = Marker(
//             markerId: MarkerId(garage.name),
//             position: LatLng(garage.lat, garage.lng),
//             infoWindow: InfoWindow(
//               title: garage.name,
//               snippet: garage.address,
//             ),
//           );
//           _markers[garage.name] = marker;
//         }
//       });
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error loading parking garages: $e')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('CSUN Parking Map'),
//         elevation: 1,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildHeaderSection(),
//             _buildMapSection(),
//             _buildButtonsSection(),
//             _buildParkingStructuresSection(),
//             _buildAdditionalInfoSection(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: 0, // Highlight "Home" or update based on your app logic
//         onTap: (index) {
//           if (index == 1) {
//             // Navigator.pushNamed(context, '/favorites');
//           } else if (index == 2) {
//             Navigator.pushNamed(context, '/settings');
//           }
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.star),
//             label: 'Favorites',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeaderSection() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: [
//           const CircleAvatar(
//             radius: 24,
//             backgroundColor: ThemeNotifier.lightUnselectedItemColor,
//             child:
//                 Icon(Icons.directions_car, color: ThemeNotifier.darkTextColor),
//           ),
//           const SizedBox(width: 16),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'CSUN Parking',
//                 style: Theme.of(context).textTheme.bodyLarge,
//               ),
//               Text(
//                 'Parking Structures Map',
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMapSection() {
//     return Container(
//       margin: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: SizedBox(
//         height: 200,
//         child: GoogleMap(
//           initialCameraPosition: const CameraPosition(
//             target: LatLng(34.241, -118.528), // Centered around CSUN
//             zoom: 15,
//           ),
//           onMapCreated: _onMapCreated,
//           markers: _markers.values.toSet(),
//         ),
//       ),
//     );
//   }

//   Widget _buildButtonsSection() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Column(
//         children: [
//           const SizedBox(height: 8),
//           PrimaryButton(
//             text: 'Navigate to CSUN',
//             onPressed: () => Navigator.pushNamed(context, '/garage'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildParkingStructuresSection() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Parking Structures',
//             style: Theme.of(context).textTheme.bodyLarge,
//           ),
//           const SizedBox(height: 16),
//           Row(
//             children: [
//               _buildParkingCard('Open', 'Parking Structure A', '500'),
//               const SizedBox(width: 16),
//               _buildParkingCard('Full', 'Parking Structure B', '300'),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildParkingCard(String status, String name, String capacity) {
//     return Expanded(
//       child: Card(
//         color: Theme.of(context).cardTheme.color, // Use theme card color
//         shadowColor:
//             Theme.of(context).cardTheme.shadowColor, // Use theme shadow color
//         elevation: 4, // Increased elevation for a more prominent shadow
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//           side: BorderSide(
//             color: Colors.grey.shade300, // Subtle border for better contrast
//             width: 1,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: 100,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade200, // Light gray for contrast
//                   borderRadius: BorderRadius.circular(12), // Rounded corners
//                 ),
//                 child: const Center(
//                   child: Text(
//                     'Image of parking structure',
//                     style: TextStyle(color: Colors.black54),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 name,
//                 style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//               ),
//               Text(
//                 'Capacity: $capacity',
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//               Text(
//                 status,
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   color: status == 'Open' ? Colors.green : Colors.red,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAdditionalInfoSection() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Additional Info',
//             style: Theme.of(context).textTheme.bodyLarge,
//           ),
//           const SizedBox(height: 8),
//           Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   children: [
//                     Text(
//                       'Parking Rates',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                     const Text(
//                       'Rates are based on location',
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ),
//               const Expanded(
//                 child: Column(
//                   children: [
//                     Text(
//                       'Check CSUN website',
//                       style: TextStyle(fontSize: 14),
//                     ),
//                     Icon(Icons.info, color: Colors.blue),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
