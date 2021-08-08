part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class GetWeatherOfCity extends WeatherEvent {
  final String cityName;

  GetWeatherOfCity(this.cityName);

  @override
  List<Object?> get props => [this.cityName];
}
