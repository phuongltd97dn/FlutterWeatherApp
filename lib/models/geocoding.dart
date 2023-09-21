import 'package:equatable/equatable.dart';

class Geocoding extends Equatable {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final String featureCode;
  final String countryCode;
  final int admin1Id;
  final String timezone;
  final int countryId;
  final String country;
  final String admin1;

  const Geocoding({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.featureCode,
    required this.countryCode,
    required this.admin1Id,
    required this.timezone,
    required this.countryId,
    required this.country,
    required this.admin1,
  });

  factory Geocoding.initial() {
    return Geocoding(
      id: -1,
      name: '',
      latitude: 0.0,
      longitude: 0.0,
      featureCode: '',
      countryCode: '',
      admin1Id: -1,
      timezone: '',
      countryId: -1,
      country: '',
      admin1: '',
    );
  }

  factory Geocoding.fromJson(Map<String, dynamic> json) {
    return Geocoding(
      id: json['id'],
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      featureCode: json['feature_code'],
      countryCode: json['country_code'],
      admin1Id: json['admin1_id'],
      timezone: json['timezone'],
      countryId: json['country_id'],
      country: json['country'],
      admin1: json['admin1'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        latitude,
        longitude,
        featureCode,
        countryCode,
        admin1Id,
        timezone,
        countryId,
        country,
        admin1,
      ];
}
