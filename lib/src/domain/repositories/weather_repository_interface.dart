import 'package:weather_app_clean_architecture/src/core/error/failure.dart';
import 'package:weather_app_clean_architecture/src/domain/entities/weather_data.dart';
import 'package:dartz/dartz.dart';

abstract class WeatherRepositoryInterface {
  Future<Either<Failure, WeatherData>> getChosenCityWeather(String city);
}
