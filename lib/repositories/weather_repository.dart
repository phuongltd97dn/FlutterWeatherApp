import '../models/weather_new.dart';

import '../exceptions/weather_exception.dart';
import '../models/custom_error.dart';
import '../models/geocoding.dart';
import '../models/weather.dart';
import '../services/weather_api_services.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;

  WeatherRepository({required this.weatherApiServices});

  Future<Weather> fetchWeather(String city) async {
    try {
      final int woeid = await weatherApiServices.getWoeid(city);

      final Weather weather = await weatherApiServices.getWeather(woeid);

      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }

  Future<Geocoding> fetchGeocoding(String name) async {
    try {
      final Geocoding geocoding = await weatherApiServices.getGeoByName(name);

      return geocoding;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }

  Future<WeatherNew> fetchWeatherNew(
    double lat,
    double long,
    String timezone,
  ) async {
    try {
      final WeatherNew weather = await weatherApiServices.getWeatherNew(
        lat,
        long,
        timezone,
      );

      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
