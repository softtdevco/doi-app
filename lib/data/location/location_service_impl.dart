import 'package:doi_mobile/core/utils/enums.dart';
import 'package:doi_mobile/data/location/location_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class LocationServiceImpl implements LocationService {
  final GeolocatorPlatform geolocator;

  LocationServiceImpl(
    this.geolocator,
  );
  @override
  Future<LocationPermissionStatus> checkPermission() async {
    try {
      final location = await geolocator.checkPermission();
      return _getPermission(location);
    } catch (e) {
      throw Future.error('Location permissions are denied');
    }
  }

  @override
  Future<AppPosition> getCurrentPosition() async {
    try {
      final location = await geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.best),
      );
      return AppPosition(
        longitude: location.longitude,
        latitude: location.latitude,
        timestamp: location.timestamp,
        accuracy: location.accuracy,
        altitude: location.altitude,
        heading: location.heading,
        speed: location.speed,
        speedAccuracy: location.speedAccuracy,
        address: "",
        city: "",
        country: "",
        state: "",
        zipcode: "",
        altitudeAccuracy: location.altitudeAccuracy,
        headingAccuracy: location.headingAccuracy,
      );
    } catch (e) {
      throw Future.error('Location permissions are denied');
    }
  }

  LocationPermissionStatus _getPermission(LocationPermission permissionstatus) {
    Map<LocationPermission, LocationPermissionStatus> permission = {
      LocationPermission.always: LocationPermissionStatus.always,
      LocationPermission.denied: LocationPermissionStatus.denied,
      LocationPermission.deniedForever: LocationPermissionStatus.deniedForever,
      LocationPermission.unableToDetermine:
          LocationPermissionStatus.unableToDetermine,
      LocationPermission.whileInUse: LocationPermissionStatus.whileInUse,
    };

    return permission[permissionstatus] as LocationPermissionStatus;
  }

  @override
  Future<LocationPermissionStatus> requestPermission() async {
    try {
      final location = await geolocator.requestPermission();
      return _getPermission(location);
    } catch (e) {
      throw Future.error('Location permissions are denied');
    }
  }

  @override
  Future<bool> openSettings() {
    return geolocator.openLocationSettings();
  }
}

final locator =
    Provider<GeolocatorPlatform>((ref) => GeolocatorPlatform.instance);
final locationService = Provider(
  (ref) => LocationServiceImpl(
    ref.read(locator),
  ),
);
