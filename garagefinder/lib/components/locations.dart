import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:json_annotation/json_annotation.dart';

part 'locations.g.dart';

/// Represents the latitude and longitude of a location.
@JsonSerializable()
class LatLng {
  LatLng({
    required this.lat,
    required this.lng,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngToJson(this);

  final double lat;
  final double lng;
}

/// Represents a parking garage with its details.
@JsonSerializable()
class Garage {
  Garage({
    required this.name,
    required this.lat,
    required this.lng,
    required this.address,
  });

  factory Garage.fromJson(Map<String, dynamic> json) => _$GarageFromJson(json);
  Map<String, dynamic> toJson() => _$GarageToJson(this);

  final String name;
  final double lat;
  final double lng;
  final String address;
}

/// Represents a collection of garages.
@JsonSerializable()
class Locations {
  Locations({
    required this.garages,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<Garage> garages;
}

/// Fetches the parking garage data from a local JSON file.
Future<Locations> getParkingGarages() async {
  try {
    // Load the JSON data from the assets folder
    final jsonString =
        await rootBundle.loadString('assets/parking_garages.json');
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;
    return Locations.fromJson(jsonData);
  } catch (e) {
    if (kDebugMode) {
      print("Error loading parking garages data: $e");
    }
    // Return an empty Locations object as a fallback
    return Locations(garages: []);
  }
}
