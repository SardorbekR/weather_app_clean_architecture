import 'package:equatable/equatable.dart';
import 'package:weather_app_clean_architecture/src/data/model/weather_data_model.dart';

class WeatherData extends Equatable {
  final List<WeatherDescription> weather;
  final String cityName;
  final Temperature temperature;

  WeatherData({
    required this.weather,
    required this.cityName,
    required this.temperature,
  });

  @override
  List<Object?> get props => [this.weather, this.cityName, this.temperature];
}
