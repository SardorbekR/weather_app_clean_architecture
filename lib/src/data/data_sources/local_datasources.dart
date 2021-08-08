import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:weather_app_clean_architecture/src/core/constants.dart';
import 'package:weather_app_clean_architecture/src/core/error/exception.dart';
import 'package:weather_app_clean_architecture/src/data/model/weather_data_model.dart';

abstract class LocalDataSourceInterface {
  Future<WeatherDataModel> getLastCachedWeatherData();

  Future<void> cacheWeatherData(WeatherDataModel weatherDataCache);
}

class HiveLocalDataSource implements LocalDataSourceInterface {
  @override
  Future<void> cacheWeatherData(WeatherDataModel weatherDataCache) async {
    final box = await Hive.openBox('cachedWeatherData');

    box.put(HiveKeys.cachedWeatherData, [
      weatherDataCache.cityName,
      weatherDataCache.temperature.temp.toString(),
      weatherDataCache.weather[0].description
    ]);
  }

  @override
  Future<WeatherDataModel> getLastCachedWeatherData() async {
    final box = await Hive.openBox('cachedWeatherData');
    final weatherData = box.get(HiveKeys.cachedWeatherData);

    if (weatherData == null) {
      throw CacheException();
    } else {
      return WeatherDataModel(
          weather: weatherData[0],
          name: weatherData[1],
          temperature: weatherData[2]);
    }
  }
}
