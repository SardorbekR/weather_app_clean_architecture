import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_clean_architecture/src/core/network_state/network_state.dart';
import 'package:weather_app_clean_architecture/src/data/bloc/weather_bloc.dart';
import 'package:weather_app_clean_architecture/src/data/data_sources/local_datasources.dart';
import 'package:weather_app_clean_architecture/src/data/data_sources/remote_datasources.dart';
import 'package:weather_app_clean_architecture/src/data/repositories/weather_repository.dart';

class DependencyProvider extends StatelessWidget {
  final Widget child;

  const DependencyProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(
        WeatherRepository(
            networkState: NetworkState(),
            localDataSource: HiveLocalDataSource(),
            remoteDataSource: OpenWeatherApiDataSource()),
      )..add(GetWeatherOfCity('Tashkent')),
      child: child,
    );
  }
}
