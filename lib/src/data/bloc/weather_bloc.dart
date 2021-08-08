import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app_clean_architecture/src/data/repositories/weather_repository.dart';
import 'package:weather_app_clean_architecture/src/domain/entities/weather_data.dart';
import 'package:weather_app_clean_architecture/src/domain/repositories/weather_repository_interface.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepositoryInterface _weatherRepository;

  WeatherBloc(this._weatherRepository) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeatherOfCity) {
      yield WeatherLoading();

      final result =
          await _weatherRepository.getChosenCityWeather(event.cityName);

      yield result.fold(
        (failure) => WeatherFetchFailed(),
        (weatherData) => WeatherLoaded(weatherData),
      );
    }
  }
}
