import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
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
  final List<Garage> garages; // Nested list of garages
}

/// Represents a collection of schools.
@JsonSerializable()
class Schools {
  Schools({
    required this.schools,
  });

  factory Schools.fromJson(Map<String, dynamic> json) =>
      _$SchoolsFromJson(json);
  Map<String, dynamic> toJson() => _$SchoolsToJson(this);

  final List<School> schools; // List of School objects
}

/// Fetches the schools and parking garage data from a local JSON file.
Future<Schools> getSchools() async {
  try {
    // Load the JSON data from the specified file path
    final jsonString =
        await rootBundle.loadString('assets/schools.json');
    final jsonData = json.decode(jsonString) as List<dynamic>;
    final schools = jsonData.map((e) => School.fromJson(e)).toList();

    return Schools(schools: schools);
  } catch (e) {
    if (kDebugMode) {
      print("Error loading schools data: $e");
    }
    // Return an empty Schools object as a fallback
    return Schools(schools: []);
  }
}
