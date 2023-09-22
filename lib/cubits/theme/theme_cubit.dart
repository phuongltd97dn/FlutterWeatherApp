import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  // final WeatherCubit weatherCubit;

  // late final StreamSubscription weatherSubscription;

  ThemeCubit(
      // {required this.weatherCubit}
      )
      : super(ThemeState.initital());
  // {
  //   weatherSubscription = weatherCubit.stream.listen((weatherState) {
  //     if (weatherState.weather.isDay == 1) {
  //       emit(state.copyWith(theme: AppTheme.light));
  //     } else {
  //       emit(state.copyWith(theme: AppTheme.dark));
  //     }
  //   });
  // }

  void setTheme(int isDay) {
    if (isDay == 1) {
      emit(state.copyWith(theme: AppTheme.light));
    } else if (isDay == 0) {
      emit(state.copyWith(theme: AppTheme.dark));
    }
  }

  // @override
  // Future<void> close() {
  //   weatherSubscription.cancel();
  //   return super.close();
  // }
}
