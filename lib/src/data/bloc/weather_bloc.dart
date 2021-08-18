import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app_clean_architecture/src/data/repositories/weather_repository.dart';
import 'package:weather_app_clean_architecture/src/domain/entities/weather_data.dart';
import 'package:weather_app_clean_architecture/src/domain/repositories/weather_repository_interface.dart';
import 'package:weather_app_clean_architecture/src/domain/use_cases/get_chosen_city_weather.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetChosenCityWeather _getChosenCityWeather;

  WeatherBloc(this._getChosenCityWeather) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeatherOfCity) {
      yield WeatherLoading();

      final result =
          await _getChosenCityWeather(Params(cityName: event.cityName));

      yield result.fold(
        (failure) => WeatherFetchFailed(),
        (weatherData) => WeatherLoaded(weatherData),
      );
    }
  }
}
