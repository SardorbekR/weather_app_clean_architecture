import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app_clean_architecture/src/core/error/exception.dart';
import 'package:weather_app_clean_architecture/src/data/model/weather_data_model.dart';

abstract class RemoteDataSourceInterface {
  Future<WeatherDataModel> getChosenCityWeather(String cityName);
}

class OpenWeatherApiDataSource implements RemoteDataSourceInterface {
  @override
  Future<WeatherDataModel> getChosenCityWeather(String cityName) async {
    final response = await http.Client().get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?appid=92dc32921afbad0e54d33284dca093a2&q=$cityName&units=metric'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return WeatherDataModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
