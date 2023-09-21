part of 'weather_cubit.dart';

enum WeatherStatus { initial, loading, loaded, error }

class WeatherState extends Equatable {
  final WeatherStatus status;
  final WeatherNew weather;
  final CustomError error;

  const WeatherState({
    required this.status,
    required this.weather,
    required this.error,
  });

  factory WeatherState.initial() {
    return WeatherState(
      status: WeatherStatus.initial,
      weather: WeatherNew.initial(),
      error: const CustomError(),
    );
  }

  WeatherState copyWith({
    WeatherStatus? status,
    WeatherNew? weather,
    CustomError? error,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, weather, error];

  @override
  String toString() {
    return 'WeatherState(status: $status, weather: $weather, error: $error)';
  }
}
