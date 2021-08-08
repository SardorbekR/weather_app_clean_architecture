import 'package:dartz/dartz.dart';
import 'package:weather_app_clean_architecture/src/core/error/exception.dart';
import 'package:weather_app_clean_architecture/src/core/error/failure.dart';
import 'package:weather_app_clean_architecture/src/core/network_state/network_state.dart';
import 'package:weather_app_clean_architecture/src/data/data_sources/local_datasources.dart';
import 'package:weather_app_clean_architecture/src/data/data_sources/remote_datasources.dart';
import 'package:weather_app_clean_architecture/src/data/model/weather_data_model.dart';
import 'package:weather_app_clean_architecture/src/domain/entities/weather_data.dart';
import 'package:weather_app_clean_architecture/src/domain/repositories/weather_repository_interface.dart';

class WeatherRepository implements WeatherRepositoryInterface {
  final RemoteDataSourceInterface remoteDataSource;
  final LocalDataSourceInterface localDataSource;
  final NetworkState networkState;

  WeatherRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkState,
  });

  @override
  Future<Either<Failure, WeatherData>> getChosenCityWeather(
      String cityName) async {
    if (await networkState.isInternetConnected()) {
      try {
        final weatherData =
            await remoteDataSource.getChosenCityWeather(cityName);
        await localDataSource.cacheWeatherData(weatherData);

        return right(weatherData);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        final cachedData = await localDataSource.getLastCachedWeatherData();
        return right(cachedData);
      } on CacheException {
        return left(CacheFailure());
      }
    }
  }
}
