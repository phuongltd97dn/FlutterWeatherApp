part of 'weather_cubit.dart';

enum WeatherStatus { initial, loading, loaded, error }

class WeatherState extends Equatable {
  final WeatherStatus status;
  final Geocoding geocoding;
  final WeatherNew weather;
  final CustomError error;

  const WeatherState({
    required this.status,
    required this.geocoding,
    required this.weather,
    required this.error,
  });

  factory WeatherState.initial() {
    return WeatherState(
      status: WeatherStatus.initial,
      geocoding: Geocoding.initial(),
      weather: WeatherNew.initial(),
      error: const CustomError(),
    );
  }

  WeatherState copyWith({
    WeatherStatus? status,
    Geocoding? geocoding,
    WeatherNew? weather,
    CustomError? error,
  }) {
    return WeatherState(
      status: status ?? this.status,
      geocoding: geocoding ?? this.geocoding,
      weather: weather ?? this.weather,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, geocoding, weather, error];

  @override
  String toString() {
    return 'WeatherState(status: $status, geocoding: $geocoding, weather: $weather, error: $error)';
  }
}
