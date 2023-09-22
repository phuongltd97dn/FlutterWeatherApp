import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/models/geocoding.dart';

import '../../models/custom_error.dart';
import '../../models/weather_new.dart';
import '../../repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherRepository weatherRepository;

  WeatherCubit({required this.weatherRepository})
      : super(WeatherState.initial());

  Future<void> fetchWeather(String name) async {
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final geocoding = await weatherRepository.fetchGeocoding(name);
      final weather = await weatherRepository.fetchWeatherNew(
        geocoding.latitude,
        geocoding.longitude,
        geocoding.timezone,
      );

      emit(state.copyWith(
        status: WeatherStatus.loaded,
        geocoding: geocoding,
        weather: weather,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(status: WeatherStatus.error, error: e));
    }
  }
}
