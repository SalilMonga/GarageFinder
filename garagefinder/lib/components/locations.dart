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
    this.capacity, // Optional capacity field
  });

  factory Garage.fromJson(Map<String, dynamic> json) => _$GarageFromJson(json);
  Map<String, dynamic> toJson() => _$GarageToJson(this);

  final String name;
  final double lat;
  final double lng;
  final String address;
  final int? capacity; // Capacity is optional
}

/// Represents a school with its details and associated garages.
@JsonSerializable()
class School {
  School({
    required this.id,
    required this.name,
    required this.type,
    required this.location,
    required this.image,
    required this.lat,
    required this.long,
    required this.garages,
  });

  factory School.fromJson(Map<String, dynamic> json) => _$SchoolFromJson(json);
  Map<String, dynamic> toJson() => _$SchoolToJson(this);

  final int id;
  final String name;
  final String type;
  final String location;
  final String image;
  final double lat;
  final double long;
  final List<Garage> garages;
}

/// Represents a collection of schools with garages.
@JsonSerializable()
class Locations {
  Locations({
    required this.schools,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<School> schools;
}

/// Fetches the schools and their garages data from a local JSON file.
Future<Locations> getParkingGarages() async {
  try {
    // Load the JSON data from the assets folder
    final jsonString =
        await rootBundle.loadString('assets/schools_with_garages.json');
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;
    return Locations.fromJson(jsonData);
  } catch (e) {
    if (kDebugMode) {
      print("Error loading parking garages data: $e");
    }
    // Return an empty Locations object as a fallback
    return Locations(schools: []);
  }
}
