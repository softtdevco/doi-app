import 'dart:convert';

import 'package:doi_mobile/core/utils/enums.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationService {
  Future<LocationPermissionStatus> checkPermission();
  Future<LocationPermissionStatus> requestPermission();
  Future<AppPosition> getCurrentPosition();

  Future<bool> openSettings();
}

class AppPosition extends Position {
  final String address;
  final String city;
  final String state;
  final String country;
  final String zipcode;
  const AppPosition({
    required super.longitude,
    required super.latitude,
    required super.timestamp,
    required super.accuracy,
    required super.altitude,
    required super.heading,
    required super.speed,
    required super.speedAccuracy,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.zipcode,
    required super.altitudeAccuracy,
    required super.headingAccuracy,
  });

  AppPosition copyWith({
    String? address,
    String? city,
    String? state,
    String? country,
    String? zipcode,
    double? longitude,
    double? latitude,
    DateTime? timestamp,
    double? accuracy,
    double? altitude,
    double? heading,
    double? speed,
    double? speedAccuracy,
  }) {
    return AppPosition(
        address: address ?? this.address,
        city: city ?? this.city,
        state: state ?? this.state,
        country: country ?? this.country,
        zipcode: zipcode ?? this.zipcode,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        accuracy: accuracy ?? this.accuracy,
        timestamp: timestamp ?? this.timestamp,
        altitude: altitude ?? this.altitude,
        heading: heading ?? this.heading,
        speed: speed ?? this.speed,
        speedAccuracy: speedAccuracy ?? this.speedAccuracy,
        altitudeAccuracy: altitudeAccuracy,
        headingAccuracy: headingAccuracy);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'zipcode': zipcode,
    };
  }

  factory AppPosition.fromMap(Map<String, dynamic> map) {
    return AppPosition(
      address: map['address'] ?? "",
      city: map['city'] ?? "",
      state: map['state'] ?? "",
      country: map['country'] ?? "",
      zipcode: map['zipcode'] ?? "",
      accuracy: map['accuracy'] ?? 0,
      longitude: map['longitude'] ?? 0,
      latitude: map['latitude'] ?? 0,
      timestamp: map['timestamp'] == null
          ? DateTime.now()
          : DateTime.fromMillisecondsSinceEpoch(
              map['timestamp'].toInt(),
              isUtc: true,
            ),
      altitude: map['altitude'] ?? 0,
      heading: map['heading'] ?? 0,
      speed: map['speed'] ?? 0,
      speedAccuracy: map['speed_accuracy'] ?? 0,
      altitudeAccuracy: map['altitude_accuracy'] ?? 0,
      headingAccuracy: map['heading_accuracy'] ?? 0,
    );
  }

  factory AppPosition.fromJson(String source) =>
      AppPosition.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppPosition(address: $address, city: $city, state: $state, country: $country, zipcode: $zipcode)';
  }
}
