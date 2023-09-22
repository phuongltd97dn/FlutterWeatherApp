import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../exceptions/weather_exception.dart';
import '../models/geocoding.dart';
import '../models/weather.dart';
import '../models/weather_new.dart';
import 'http_error_handler.dart';

class WeatherApiServices {
  final http.Client httpClient;

  WeatherApiServices({required this.httpClient});

  Future<int> getWoeid(String city) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kHost,
      path: '/api/location/search/',
      queryParameters: {'query': city},
    );

    try {
      final http.Response response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      final responseBody = json.decode(response.body);
      if (responseBody.isEmpty) {
        throw WeatherException('Cannot get the woeid of $city');
      }

      if (responseBody.lenth > 1) {
        throw WeatherException(
            'There are multiple candidates for $city\nPlease specify furthur!');
      }

      return responseBody[0]['woeid'];
    } catch (e) {
      rethrow;
    }
  }

  Future<Weather> getWeather(int woeid) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kHost,
      path: '/api/location/$woeid',
    );

    try {
      final http.Response response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      final weatherJson = json.decode(response.body);
      final Weather weather = Weather.fromJson(weatherJson);

      return weather;
    } catch (e) {
      rethrow;
    }
  }

  Future<Geocoding> getGeoByName(String name) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kGeoHostNew,
      path: '/v1/search/',
      queryParameters: {'name': name, 'count': '1'},
    );
    final headers = {'Content-Type': 'application/json'};

    try {
      final http.Response response = await http.get(uri, headers: headers);

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      final responseBody = json.decode(response.body);
      final results = responseBody['results'];
      if (results == null || results.isEmpty) {
        throw WeatherException('Cannot get the geocoding of $name');
      }

      final Geocoding geocoding = Geocoding.fromJson(
        responseBody['results'][0],
      );

      return geocoding;
    } catch (e) {
      rethrow;
    }
  }

  Future<WeatherNew> getWeatherNew(
    double lat,
    double long,
    String timezone,
  ) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: kHostNew,
      path: '/v1/forecast/',
      queryParameters: {
        'latitude': jsonEncode(lat),
        'longitude': jsonEncode(long),
        'timezone': timezone,
        'current_weather': jsonEncode(true),
      },
    );

    try {
      final http.Response response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      final responseBody = json.decode(response.body);
      final weatherNewJson = responseBody['current_weather'];
      final WeatherNew weather = WeatherNew.fromJson(weatherNewJson);

      return weather;
    } catch (e) {
      rethrow;
    }
  }
}
