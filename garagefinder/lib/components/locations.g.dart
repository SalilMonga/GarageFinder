// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatLng _$LatLngFromJson(Map<String, dynamic> json) => LatLng(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$LatLngToJson(LatLng instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Garage _$GarageFromJson(Map<String, dynamic> json) => Garage(
      name: json['name'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      address: json['address'] as String,
      capacity: (json['capacity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GarageToJson(Garage instance) => <String, dynamic>{
      'name': instance.name,
      'lat': instance.lat,
      'lng': instance.lng,
      'address': instance.address,
      'capacity': instance.capacity,
    };

School _$SchoolFromJson(Map<String, dynamic> json) => School(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      type: json['type'] as String,
      location: json['location'] as String,
      image: json['image'] as String,
      lat: (json['lat'] as num).toDouble(),
      long: (json['long'] as num).toDouble(),
      garages: (json['garages'] as List<dynamic>)
          .map((e) => Garage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SchoolToJson(School instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'location': instance.location,
      'image': instance.image,
      'lat': instance.lat,
      'long': instance.long,
      'garages': instance.garages,
    };

Locations _$LocationsFromJson(Map<String, dynamic> json) => Locations(
      schools: (json['schools'] as List<dynamic>)
          .map((e) => School.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocationsToJson(Locations instance) => <String, dynamic>{
      'schools': instance.schools,
    };
