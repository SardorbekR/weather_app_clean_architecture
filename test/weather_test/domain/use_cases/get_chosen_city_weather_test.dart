import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app_clean_architecture/src/data/model/weather_data_model.dart';
import 'package:weather_app_clean_architecture/src/domain/entities/weather_data.dart';
import 'package:weather_app_clean_architecture/src/domain/repositories/weather_repository_interface.dart';
import 'package:weather_app_clean_architecture/src/domain/use_cases/get_chosen_city_weather.dart';

class MockWeatherRepository extends Mock implements WeatherRepositoryInterface {
}

void main() {
  late MockWeatherRepository mockWeatherRepository;
  late GetChosenCityWeather usecase;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetChosenCityWeather(mockWeatherRepository);
  });

  final String tCityName = "Tashkent";
  final weatherDescription = WeatherDescription(description: 'Cloudy');
  final tWeatherData = WeatherData(
    weather: [weatherDescription],
    cityName: tCityName,
    temperature: Temperature(temp: 22.0),
  );

  test("should get Weather for cityName from repository", () async {
    when(() => mockWeatherRepository.getChosenCityWeather(tCityName))
        .thenAnswer((_) async => Right(tWeatherData));

    final result = await usecase(Params(cityName: tCityName));

    verify(() => mockWeatherRepository.getChosenCityWeather(tCityName));
    expect(result, equals(Right(tWeatherData)));
    verifyNoMoreInteractions(mockWeatherRepository);
  });
}
