import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app_clean_architecture/src/core/error/exception.dart';
import 'package:weather_app_clean_architecture/src/core/error/failure.dart';
import 'package:weather_app_clean_architecture/src/core/network_state/network_state.dart';
import 'package:weather_app_clean_architecture/src/data/data_sources/local_datasources.dart';
import 'package:weather_app_clean_architecture/src/data/data_sources/remote_datasources.dart';
import 'package:weather_app_clean_architecture/src/data/model/weather_data_model.dart';
import 'package:weather_app_clean_architecture/src/data/repositories/weather_repository.dart';

class MockNetworkState extends Mock implements NetworkState {}

class MockLocalDataSource extends Mock implements LocalDataSourceInterface {}

class MockRemoteDataSource extends Mock implements RemoteDataSourceInterface {}

void main() {
  late WeatherRepository weatherRepository;
  late MockNetworkState networkState;
  late MockRemoteDataSource remoteDataSource;
  late MockLocalDataSource localDataSource;

  final tCityName = "Tashkent";
  final tWeatherDataModel = WeatherDataModel(
      weather: [WeatherDescription(description: 'clear sky')],
      name: "Tashkent",
      temperature: Temperature(temp: 28.97));

  setUpAll(() {
    networkState = MockNetworkState();
    remoteDataSource = MockRemoteDataSource();
    localDataSource = MockLocalDataSource();
    weatherRepository = WeatherRepository(
        networkState: networkState,
        remoteDataSource: remoteDataSource,
        localDataSource: localDataSource);
  });
  group('test when NO internet connection', () {
    setUp(() {
      when(() => networkState.isInternetConnected())
          .thenAnswer((_) async => false);
    });

    test('should return data from local storage when there\'s NO internet',
        () async {
      when(() => localDataSource.getLastCachedWeatherData())
          .thenAnswer((_) async => tWeatherDataModel);

      final result = await weatherRepository.getChosenCityWeather(tCityName);

      verifyZeroInteractions(remoteDataSource);
      expect(result, equals(right(tWeatherDataModel)));
    });

    test(
        'should return CacheFailure when the call local data source throws CacheException',
        () async {
      when(() => localDataSource.getLastCachedWeatherData())
          .thenThrow(CacheException());

      final result = await weatherRepository.getChosenCityWeather(tCityName);

      verifyZeroInteractions(remoteDataSource);
      expect(result, equals(Left(CacheFailure())));
    });
  });

  group('test when internet Connected', () {
    setUp(() {
      when(() => networkState.isInternetConnected())
          .thenAnswer((_) async => true);
    });

    test('should return data when the call remote data source was successful',
        () async {
      when(() => remoteDataSource.getChosenCityWeather(any()))
          .thenAnswer((_) async => tWeatherDataModel);
      when(() => localDataSource.cacheWeatherData(tWeatherDataModel))
          .thenAnswer((_) async {});

      final result = await weatherRepository.getChosenCityWeather(tCityName);

      verify(() => remoteDataSource.getChosenCityWeather(tCityName));
      verify(() => localDataSource.cacheWeatherData(tWeatherDataModel));
      expect(result, right(tWeatherDataModel));
    });

    test(
      'should cache the data to local storage when the call to remote data source is successful',
      () async {
        when(() => remoteDataSource.getChosenCityWeather(any()))
            .thenAnswer((_) async => tWeatherDataModel);

        await weatherRepository.getChosenCityWeather(tCityName);

        verify(() => remoteDataSource.getChosenCityWeather(tCityName));
        verify(() => localDataSource.cacheWeatherData(tWeatherDataModel));
      },
    );

    test(
        'should return ServerFailure when the call remote data source throws ServerException',
        () async {
      when(() => remoteDataSource.getChosenCityWeather(tCityName))
          .thenThrow(ServerException());

      final result = await weatherRepository.getChosenCityWeather(tCityName);

      expect(result, equals(Left(ServerFailure())));
    });
  });
}
