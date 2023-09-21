import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String weatherStateName;
  final String weatherStateAbbr;
  final String created;
  final double minTemp;
  final double maxTemp;
  final double theTemp;
  final String title;
  final int woeid;
  final DateTime lastUpdate;

  const Weather({
    required this.weatherStateName,
    required this.weatherStateAbbr,
    required this.created,
    required this.minTemp,
    required this.maxTemp,
    required this.theTemp,
    required this.title,
    required this.woeid,
    required this.lastUpdate,
  });

  @override
  List<Object?> get props => [
        weatherStateName,
        weatherStateAbbr,
        created,
        minTemp,
        maxTemp,
        title,
        woeid,
        lastUpdate,
      ];

  factory Weather.fromJson(Map<String, dynamic> json) {
    final consolidatedWeather = json['consolidated_weather'][0];

    return Weather(
      weatherStateName: consolidatedWeather['weather_state_name'],
      weatherStateAbbr: consolidatedWeather['weather_state_abbr'],
      created: consolidatedWeather['created'],
      minTemp: consolidatedWeather['min_temp'],
      maxTemp: consolidatedWeather['max_temp'],
      theTemp: consolidatedWeather['the_temp'],
      title: consolidatedWeather['title'],
      woeid: consolidatedWeather['woeid'],
      lastUpdate: DateTime.now(),
    );
  }

  factory Weather.initial() {
    return Weather(
      weatherStateName: '',
      weatherStateAbbr: '',
      created: '',
      minTemp: 100.0,
      maxTemp: 100.0,
      theTemp: 100.0,
      title: '',
      woeid: -1,
      lastUpdate: DateTime(1970),
    );
  }
}
