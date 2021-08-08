import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app_clean_architecture/src/data/model/weather_data_model.dart';
import 'package:weather_app_clean_architecture/src/domain/entities/weather_data.dart';

import '../../../fixtures/json_reader.dart';

void main() {
  final weatherDataModel = WeatherDataModel(
      weather: [WeatherDescription(description: 'clear sky')],
      name: "Tashkent",
      temperature: Temperature(temp: 28.97));

  test('should be subclass of weatherData entity', () {
    expect(weatherDataModel, isA<WeatherData>());
  });

  group('fromJson Test', () {
    test("should return a valid model object after receiving Json", () {
      final Map<String, dynamic> jsonMap =
          jsonDecode(readFromJson('weather.json'));

      final result = WeatherDataModel.fromJson(jsonMap);

      expect(result, weatherDataModel);
    });
  });
}
