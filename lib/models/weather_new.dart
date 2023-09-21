import 'package:equatable/equatable.dart';

class WeatherNew extends Equatable {
  final double temperature;
  final double windspeed;
  final int windDirection;
  final int weatherCode;
  final int isDay;
  final String time;
  final DateTime lastUpdate;

  const WeatherNew({
    required this.temperature,
    required this.windspeed,
    required this.windDirection,
    required this.weatherCode,
    required this.isDay,
    required this.time,
    required this.lastUpdate,
  });

  factory WeatherNew.initial() {
    return WeatherNew(
      temperature: 100.0,
      windspeed: 0.0,
      windDirection: -1,
      weatherCode: -1,
      isDay: -1,
      time: '',
      lastUpdate: DateTime(1970),
    );
  }

  factory WeatherNew.fromJson(Map<String, dynamic> json) {
    return WeatherNew(
      temperature: json['temperature'],
      windspeed: json['windspeed'],
      windDirection: json['winddirection'],
      weatherCode: json['weathercode'],
      isDay: json['is_day'],
      time: json['time'],
      lastUpdate: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        temperature,
        windspeed,
        windDirection,
        weatherCode,
        isDay,
        time,
        lastUpdate,
      ];
}
