class SelectedLocation {
  final String address;
  final double longitude;
  final double latitude;
  final String placeID;
  final String? duration;
  final String? distance;
  final String? city;
  final String? state;
  final String? country;
  final String? shortAddress;

  SelectedLocation({
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.placeID,
    this.city,
    this.state,
    this.country,
    this.shortAddress,
    this.duration,
    this.distance,
  });
}
