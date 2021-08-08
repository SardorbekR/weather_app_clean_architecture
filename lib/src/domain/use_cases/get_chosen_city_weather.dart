import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app_clean_architecture/src/core/error/failure.dart';
import 'package:weather_app_clean_architecture/src/core/usecase/usecase.dart';
import 'package:weather_app_clean_architecture/src/domain/entities/weather_data.dart';
import 'package:weather_app_clean_architecture/src/domain/repositories/weather_repository_interface.dart';

class GetChosenCityWeather extends UseCase<WeatherData, Params> {
  WeatherRepositoryInterface weatherRepository;

  GetChosenCityWeather(this.weatherRepository);

  @override
  Future<Either<Failure, WeatherData>> call(Params params) async =>
      weatherRepository.getChosenCityWeather(params.cityName);
}

class Params extends Equatable {
  final String cityName;

  Params({required this.cityName});

  @override
  List<Object?> get props => [this.cityName];
}
